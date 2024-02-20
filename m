Return-Path: <linux-kernel+bounces-72191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9347C85B09E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA24A284568
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0480374EE;
	Tue, 20 Feb 2024 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E5U0H4Vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDC12B76
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393969; cv=none; b=am8QexsybBnJWU3gEHkii6pbABTKgLlSn5QpQStWAJE/Wy8YoPV9WBBaYxx+hD4Vf+cDMU79ur0jNmssGk14dBd/f8ovQUkaZ1aDrwulbQWMrVzCxtW8+lX2HAtqUsI5JNu/O+twy0H+FmKNuu37dyK1k5FlVOQ7oG6XZlaMGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393969; c=relaxed/simple;
	bh=DvsroR4CVogEadvHGT6tZ/KiY5XSH4XgBmG24AenDes=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dA67aDbgrGA6f7RoC2hq5ipqW3iXEdheJWi778tJfQyxFhK+9J6DL2OG1tGoPmS7YRBCP9ThXJnw5djYmnCgT6Zqkx0sUUrzkrAQJqccFiO4fJbMGxGiSPpzJJPSgVlgoqU7Y3vUI4tBrXlXKUL1wMyZSiyYJYqb8NWSEEXCaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E5U0H4Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C74C433C7;
	Tue, 20 Feb 2024 01:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708393968;
	bh=DvsroR4CVogEadvHGT6tZ/KiY5XSH4XgBmG24AenDes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5U0H4VkRUHSfmZHaz4X0MdNium81DjQShT833QWQtqmHGNaFAbVuu9eNqQlgPAHX
	 gk2dkGjxxaRey7bmKnH724jyAXwzkQbacf0Qk6pv6EN2APybf1VUfga09LJpBy1Bos
	 v6CqDl9EmG2mdevZXg4qf1iCN7IO4itno004A98M=
Date: Mon, 19 Feb 2024 17:52:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gang Li <gang.li@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/2] hugetlb: two small improvements of hugetlb init
 parallelization
Message-Id: <20240219175248.bc70d8bddd28fced647eceb7@linux-foundation.org>
In-Reply-To: <66232486-12a9-4097-baad-fa20655194b1@linux.dev>
References: <20240213111347.3189206-1-gang.li@linux.dev>
	<66232486-12a9-4097-baad-fa20655194b1@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 11:03:29 +0800 Gang Li <gang.li@linux.dev> wrote:

> On 2024/2/13 19:13, Gang Li wrote:
> > This series includes two improvements: fixing the PADATA Kconfig warning
> > and a potential bug in gather_bootmem_prealloc_parallel. Please refer to
> > the specific commit message for details.
> > 
> > For Andrew:
> > If you want me to include these two fixes into the previous series[1], I
> > would be happy to send v6. Otherwise, you can directly apply these two
> > patches.
> > 
> > [1]. https://lore.kernel.org/lkml/20240126152411.1238072-1-gang.li@linux.dev/
> 
> Hi Andrew,
> A gentle ping here :).
> 
> Do you want to apply these two patches, or would you like me to
> include them into the original patch and send out v6?

The patchset is now rather a mess and I'm not confidently identifying
which issues remain open and which are addressed.

So yes, a full redo and resend would be preferred, please.

Links which I collected are:

https://lkml.kernel.org/r/202402020454.6EPkP1hi-lkp@intel.com
https://lkml.kernel.org/r/20240204072525.1986626-1-gang.li@linux.dev
https://lkml.kernel.org/r/6A148F29-68B2-4365-872C-E6AB599C55F6@linux.dev
https://lkml.kernel.org/r/j7xb7m5cy374ngbdm23rvryq6vy6jxtewtu3abjeidhho4bly7@t3aawaeybxlk

