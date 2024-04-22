Return-Path: <linux-kernel+bounces-153939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9C8AD520
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020241C208DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B3155348;
	Mon, 22 Apr 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Akxs0LOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA4153BFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815240; cv=none; b=HWueVhgE/SPiXYVCf9cl5UiPyEAc8Tm5qAewa1TJl8jr3tyW2xl9r/Kgv+0xW3m7vGobOhQVA6KQk9fsXm0pf+TzUo1fJfWbPC5A5MBsw1e3gJftqQZ0tRpQ7RRrbpkpg261q4vjLWIMSXCK3V2g5dUnCQr2xzmMoJRikOQVCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815240; c=relaxed/simple;
	bh=qTTNSuUYZaV5HVhMNgNjy/ynO2wqp8xqpRZXrz8vE5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hK8nF6om1hSQ4azoxk8TH5/20QwZzU+okLhlsaAQUk4SivdV4kY5u2pKPW5X/gHZQXj243UpJCWmrczYXt0AZ1CC8GXvLrX80SNpL76iGoWn0GEWwLE8tcQtkPiVfz60QyUHmEkI1wjND/nID6Cz7oMA1JfSBCq3sUsqUylrSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Akxs0LOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE1C113CC;
	Mon, 22 Apr 2024 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713815239;
	bh=qTTNSuUYZaV5HVhMNgNjy/ynO2wqp8xqpRZXrz8vE5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Akxs0LObreD8YPZWiUNU5y8ADrgheTp/brMABs0nGXP/9sHrBZFzfi2XvfiPMz2ww
	 7NAukUIItD1cv4JiM2iJkD/t/QzFl0vMR/i7KL7kDMRd3I1C8goNvhOH5wV2bBt4f1
	 3vEUt7Iu8LtGgxI9B5eiOYWqzENYkg8/mxKAAckU=
Date: Mon, 22 Apr 2024 12:47:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Nadav Amit
 <nadav.amit@gmail.com>, David Hildenbrand <david@redhat.com>,
 syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/userfaultfd: Reset ptes when close() for
 wr-protected ones
Message-Id: <20240422124719.5097e42a736403d306ba7cf0@linux-foundation.org>
In-Reply-To: <20240422133311.2987675-1-peterx@redhat.com>
References: <20240422133311.2987675-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 09:33:11 -0400 Peter Xu <peterx@redhat.com> wrote:

> Userfaultfd unregister includes a step to remove wr-protect bits from all
> the relevant pgtable entries, but that only covered an explicit
> UFFDIO_UNREGISTER ioctl, not a close() on the userfaultfd itself.  Cover
> that too.

We should include a description of the userspace-visible effects of the
bug, please.  Always.

I see it triggers a WARN, but so what - why ca't we simply delete the
WARN statement if that's the only effect?  Presumably there are other
consequences - what are they?

Also, a WARN-triggering bug should be fixed in -stable kernels so we'll
need a FIXES:, please?


