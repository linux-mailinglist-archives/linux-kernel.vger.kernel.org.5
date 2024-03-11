Return-Path: <linux-kernel+bounces-99518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54E87898C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46EF1C20FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A9C41C71;
	Mon, 11 Mar 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq0UvV+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DE1DDFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189425; cv=none; b=FsbISpOhqTRGtFhOrwqGDz7lw6+I6hhpgfnZrWYysGpwVpcvA8vzeug4ybaMVbgv31TAbu0NKxxfx5HVSIv9sVxITF7pTYeRXS+yGQUZBUUTZ2Jffrvhk/K6LvWEBejFcyUAJzACumTcwkPXzQohYW51n9DcgfgAoOpF/0Kh5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189425; c=relaxed/simple;
	bh=p40CMsQzYqWdqXPJqvX5xweH+iWvW3fcgjpwVX0YcIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhc+rWfv4hhWccDXp8b5IpjKm2E0q+WxUTCEpTyIiq9mebErHpPVnuC84On6FOB7FilsrpdHHkC0+nPMgXnmnyp77NqvV5QHImQxrS2pNxUZbeXVNHozB4lKNdELsdbg9HJjAKqt44H/+n6iwEENBXcGv+651LtvuKVXKhwPYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq0UvV+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64348C433C7;
	Mon, 11 Mar 2024 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189425;
	bh=p40CMsQzYqWdqXPJqvX5xweH+iWvW3fcgjpwVX0YcIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq0UvV+DnaMfrkFiCDvshg0uUt2WjDP33BK0WMWjsxDBQtXlhF2DOPrqfKz33Z2ou
	 Cxqdb9NrOV8DmngHlfZ9QDLBQDcVnqrq1leODKsC7DGfiQ0uaTrQdogJonsKqgbgvm
	 f6bnvI0PQrSmT1cSI9p7+X8OpKD+7SGMbIxVcc54jdR5mqUwOd8ou7GvDASZT2zoOM
	 RvnHIk9btgd+yGGzSRMGGPjX5y0qQMra8eZbHhMOGYtCFKbm7wvN8EG3veEmgzxCR4
	 xvK/HCQvIwb5pkj5wx0uzZ9hs+SveyEv31T4F7kV07omN11vQ15JrRS5dDqjFs1BRN
	 t8+ArApkXZG9g==
Date: Mon, 11 Mar 2024 13:37:03 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Roman Smirnov' <r.smirnov@omp.ru>, Chao Yu <chao@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] f2fs: Cast expression type to unsigned long in
 __count_extent_cache()
Message-ID: <Ze9rb0dRKt98kK54@google.com>
References: <20240305080943.6922-1-r.smirnov@omp.ru>
 <b4f9780714e243a6af9f77ab00593ec1@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f9780714e243a6af9f77ab00593ec1@AcuMS.aculab.com>

On 03/10, David Laight wrote:
> From: Roman Smirnov
> > Sent: 05 March 2024 08:10
> > 
> > Cast expression type to unsigned long in __count_extent_cache()
> > to prevent integer overflow.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Another broken analysis tool :-)
> 
> > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> >  fs/f2fs/shrinker.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> > index 83d6fb97dcae..bb86a06c5d5e 100644
> > --- a/fs/f2fs/shrinker.c
> > +++ b/fs/f2fs/shrinker.c
> > @@ -33,7 +33,7 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
> >  {
> >  	struct extent_tree_info *eti = &sbi->extent_tree[type];
> > 
> > -	return atomic_read(&eti->total_zombie_tree) +
> > +	return (unsigned long)atomic_read(&eti->total_zombie_tree) +
> >  				atomic_read(&eti->total_ext_node);
> 
> Makes diddly-squit difference.
> 
> Both total_zombie_tree and totat_ext_node are 'int'.
> If they are large enough that their sum wraps then the values
> can individually wrap (to negative values).
> 
> You really don't want to cast 'int' to 'unsigned long' here
> at all - implicitly or explicitly.
> The cast will first promote 'int' to 'signed long'.
> So a negative value will get sign extended to a very big value.

I thought, since total_zombie_tree won't get overflowed theoritically, the first
cast to (unsigned long) could expand the space to cover the following
total_ext_node.

> 
> The best you can hope for is a 33bit result from wrapped 32bit
> signed counters.
> To get that you need to convert 'int' => 'unsigned int' => 'unsigned long'.
> One way would be:
> 	return (atomic_read(&eti->total_zombie_tree) + 0u + 0ul) +
> 		(atomic_read(&eti->total_ext_node) + 0u);
> 
> Although changing the return type to 'unsigned int' would probably
> be better.
> I don't know what the values are, but if they are stats counters
> then that would give a value that nicely wraps at 2^32 rather
> that the strange wrap that the sum of two wrapping 32bit counters
> has.
> 
> OTOH it may be that they are counts - and just can't get any where
> near that big.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

