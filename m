Return-Path: <linux-kernel+bounces-34431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7283788B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091F81F248CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D291292CB;
	Mon, 22 Jan 2024 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W8zg10XY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632811292C3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967848; cv=none; b=hIPe1Q++6CDIgVdWK/jEO3LLwqbO4lJCeXfFNfKa2QYMF4PiQtqYnWfRpX1WlP5dMPuhDC10SyNqICmFsB6PIAVMypQbnmnAHRMge6DTx7259MoAgOftNWtG9W+2rtQELNWW+M7Z3z447tL0LUPOepoLlO63dt1G1qJcsi2RNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967848; c=relaxed/simple;
	bh=k1TmPbPwU6yeDSqCOG4dxDOtGcazP+3v1K2l4T5Vv4o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IrITeC+/tH7Sk5FqO4Lxxrmv3tHo4Fapvlf9R+nzfgD6HXvwsZ1A54RJzXE5a7Qek/yYOtV5KneWyUHESBYTwkCxxA/OD8xYl95xRifn9wuX2V/7gazNH/oHFYcIAXM0dqH1qC9QAF/2YmPLYE2JK2IXh3chceqV553nS89mMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W8zg10XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73836C43390;
	Mon, 22 Jan 2024 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705967847;
	bh=k1TmPbPwU6yeDSqCOG4dxDOtGcazP+3v1K2l4T5Vv4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W8zg10XYmZrWD6rDIQR10e5E7FsGiKAcGYHluuUhIShwArN3LGVSIivHSEwa7oIOr
	 ys7O7tnIQ9SgyJliz/wCOu78XjKWkKAhhJX9igdJWSX8+o2wJ0fPtSZTgQ8IAfOByT
	 GDK9XLbif4Mf/TczJ+UfQpnxfXZ4ZBfG8Sww6wB4=
Date: Mon, 22 Jan 2024 15:57:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Dylan Hatch
 <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] getrusage: use sig->stats_lock rather than
 lock_task_sighand()
Message-Id: <20240122155723.149081552c9a9e122b1f783b@linux-foundation.org>
In-Reply-To: <20240122155053.GA26214@redhat.com>
References: <20240122155023.GA26169@redhat.com>
	<20240122155053.GA26214@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 16:50:53 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
> getrusage() at the same time and the process has NR_THREADS, spin_lock_irq
> will spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

It would be super interesting to see Dylan's original report.

Is it possible for carefully-crafted unprivileged userspace to
deliberately trigger this?

