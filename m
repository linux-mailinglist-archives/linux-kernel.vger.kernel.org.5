Return-Path: <linux-kernel+bounces-34301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D647A8377CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D91F24C15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F574E1AD;
	Mon, 22 Jan 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nAr8c/6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD34B5A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966836; cv=none; b=Q7HP90B1XQtqYYfjfj6uT6uWvkcT1Iw78uAPrA8hIj98l7O9dfbqYpjnuRTYwBqdMK1fFBdIFfOQ3a+fujaObBipGnfIBeCi4rzIHzJvsM9JwWaT+DSwAvJWPP92Jt66QVn/wsPrrc7E4sP/I1+Yvpy0Mz3u8iKdLrjuXmr4/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966836; c=relaxed/simple;
	bh=0UEy2va11olg9s5mtm+VeIjV/EWP3UBwsC93Xz1hgKA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aVlvtv3BvgzXr1XPHP+3YpcuLFGSJT7hqiuG2px+76DsB5xdIRJThthHnk5gdJovA1MmbYGRz1ATRhmW4bmy2DLg6EveRHewzleZDgdQn/tsRjQ38CcyQ3tKvVTg7fVqyZHsoBcS3Wx5K1XBYxz38ylNfkTeXiPNEYv+MbLrjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nAr8c/6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB2BC43390;
	Mon, 22 Jan 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705966835;
	bh=0UEy2va11olg9s5mtm+VeIjV/EWP3UBwsC93Xz1hgKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nAr8c/6tRK+JsCr5vqpn2a/5cp6X59mrnA4Q7GQ2BB/eS3wT8ihgSZGGOS01OA1dv
	 ZtctHjbIEinh69W5JaSlIXMdgeP71/FkwrU8jfGICW0ebU8kddHHxlb56UM+fQWxat
	 0MSNT49MYgUAm4MSQZMGxwkgITXsArxZFb9e3Pqg=
Date: Mon, 22 Jan 2024 15:40:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: Yajun Deng <yajun.deng@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: introduce vma_range_init()
Message-Id: <20240122154031.b710f834b14d9027176f439a@linux-foundation.org>
In-Reply-To: <20240122220031.pwiravglee7o7k34@revolver>
References: <20240111021526.3461825-1-yajun.deng@linux.dev>
	<20240122220031.pwiravglee7o7k34@revolver>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 17:00:31 -0500 "Liam R. Howlett" <Liam.Howlett@Oracle.com> wrote:

> * Yajun Deng <yajun.deng@linux.dev> [240110 21:15]:
> > There is a lot of code needs to set the range of vma, introduce
> > vma_range_init() to initialize the range of vma.
> > 
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > ---
> >  include/linux/mm.h |  9 +++++++++
> >  mm/mmap.c          | 29 +++++++----------------------
> >  2 files changed, 16 insertions(+), 22 deletions(-)
> 
> This isn't a whole lot of code, are there others?  We're losing code
> clarity in favour of saving 6 lines?
> 

Oh.  I thought it was a nice cleanup which made things more clear.

> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f5a97dec5169..abb4534be3cc 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
> >  	return (vma && vma->vm_start <= start && end <= vma->vm_end);
> >  }
> >  
> > +static inline void vma_range_init(struct vm_area_struct *vma,
> 
> Any reason this can't be in mm/internal.h ?

That would be good.

> vma_range_set(), vma_set_range(), or just vma_range() might be a better
> name?  My thinking is that some of these are actually modifying the vma
> and not just initializing it, right?

I'd vote for vma_set_range().


