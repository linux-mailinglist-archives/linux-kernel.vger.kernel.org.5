Return-Path: <linux-kernel+bounces-82214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1678680A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCD1C28E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD817132C30;
	Mon, 26 Feb 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d/H/EtMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FC130AD5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974638; cv=none; b=iSvK0x2OAA5s0JlAdeqIvKlTaa8d7DiJY7IE7rQmld1+NOgWu+7wKJeJMaA8HfK2U7Hfh3A6ZyGL8pxazkmFJDrrfgP4UqGrb73ABItCDcdGQKQyj4GKU9rqi6yP5ZMEUilmpVP/lWbSVL6I7qTdBnJ/qV6HTfWoJKBHueHk2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974638; c=relaxed/simple;
	bh=Q8kPJtYHk31pouePvzRSVpdUlZrGVNhgF7qIYjO68v4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fqhQ0zmnwjvfMTNPHGATgHUzthJc+ZzodvENJ4YrGtJGx6mGKHx5bZdcpaZFnklVTROy7O8iWQMdh7KTrgb+DhBdHKd8tyoNESZTci1S4xAY5+hzKMTqgpc/5O+0mecGCtcE9E1DFIsmZ6B3Rp9iGTQJ5fBcC4s2I6tPo2Qcy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d/H/EtMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885DC433F1;
	Mon, 26 Feb 2024 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708974638;
	bh=Q8kPJtYHk31pouePvzRSVpdUlZrGVNhgF7qIYjO68v4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/H/EtMIF5j8Idssk8RxnYd22THuWd4EEoIOthl/LQv2e+rMTbCQg8TRIKqVNbSyp
	 P2bTi302j/4k3dle+SB6NnzxNHA4RDE/xC+3MxD/o8CtVaBxCuCr7VQyVkHjSBbfgF
	 +1pL4pm8YWk74NTf6HuTGHTXrcrV+fUMGB42LeQU=
Date: Mon, 26 Feb 2024 11:10:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: bhe@redhat.com, patches@amperecomputing.com, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 k-hagio-ab@nec.com, lijiang@redhat.com
Subject: Re: [PATCH RESEND] crash_core: export vmemmap when
 CONFIG_SPARSEMEM_VMEMMAP is enabled
Message-Id: <20240226111037.d76d299db1b26673b876e83a@linux-foundation.org>
In-Reply-To: <20240226020433.3353-1-shijie@os.amperecomputing.com>
References: <20240226020433.3353-1-shijie@os.amperecomputing.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 10:04:33 +0800 Huang Shijie <shijie@os.amperecomputing.com> wrote:

> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.

This is significantly out of sync with development trees.  Please take
a look at linux-next and redo the patch if still needed?

