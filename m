Return-Path: <linux-kernel+bounces-126318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0EC89352A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291A11C2390E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CC155A26;
	Sun, 31 Mar 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tK6CanBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558F15382B;
	Sun, 31 Mar 2024 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904083; cv=none; b=dQETvXBd2WWxgeAsPzBMQ2rSxPwdtzXokMfH+LUlVH3cFqol8gTUN/JLsmZR+PNmrK6jV2mZAVTLv64FrbUKtwJd7cFvs6p+e5jkhIxrDRNl7sg+c5H+EDFsrx1vHhhM5Aj7Z+Mm7aJ+h+g2oXgXL0/NbO0+X5icnVRobAFD9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904083; c=relaxed/simple;
	bh=s7RS9CLgfOYl44fC5tGC2rr2q02WhNnP4BvSdb44qh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xxf/KE11Xm9oczZdPLUfrRGv4WuENUpaqhvpMYW9RMdzVxOcIWNaWo00OYNDp0AlNUha9gatujxaiwSzzpFt7F0foBo+NEVSJnkrsaLvNFXnH/dJkXK8CzBwiUHvBz/AI8jD4GweJoomErK5kpYppZF4I9dDfn/gWG8SMq5LOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tK6CanBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41A4C43390;
	Sun, 31 Mar 2024 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711904082;
	bh=s7RS9CLgfOYl44fC5tGC2rr2q02WhNnP4BvSdb44qh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tK6CanBcNgxuju0hQvyE355ZTenttn+acrIgqciCS7PHPZSv2StdnV1SJh9g1acOA
	 YB8n/+KI+ZjCuUbwkSL3KSdN6LMztPNYMNGfOkguxm+22VeZ7q1HqNysrSjJoD3ZOa
	 J8A8M7e3n09zGhaX3fbA000C0SPTn4IEt/qm77Ew=
Date: Sun, 31 Mar 2024 18:54:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <2024033111-squeezing-linoleum-52a7@gregkh>
References: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2024033030-tutu-dynamite-47c9@gregkh>
 <ZgmETqQr7+W9XtWN@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgmETqQr7+W9XtWN@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Sun, Mar 31, 2024 at 09:12:06PM +0530, Ayush Tiwari wrote:
> Hello Greg. Thanks for the feedback.
> On Sat, Mar 30, 2024 at 05:12:18PM +0100, Greg KH wrote:
> > On Sat, Mar 30, 2024 at 07:24:19PM +0530, Ayush Tiwari wrote:
> > > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > > struct landlock_object and update the related dependencies to improve
> > > memory allocation and deallocation performance.
> > 
> > So it's faster?  Great, what are the measurements?
> > 
> Thank you for the feedback. Regarding the performance improvements, I
> realized I should have provided concrete measurements to support the
> claim. The intention behind switching to kmem_cache_zalloc() was to
> optimize memory management efficiency based on general principles.
> Could you suggest some way to get some measurements if possible?

If you can not measure the difference, why make the change at all?

Again, you need to prove the need for this change, so far I fail to see
a reason why.

> > > +static struct kmem_cache *landlock_object_cache;
> > > +
> > > +void __init landlock_object_cache_init(void)
> > > +{
> > > +	landlock_object_cache = kmem_cache_create(
> > > +		"landlock_object_cache", sizeof(struct landlock_object), 0,
> > > +		SLAB_PANIC, NULL);
> > 
> > You really want SLAB_PANIC?  Why?
> >
> The SLAB_PANIC flag used in kmem_cache_create indicates that if the
> kernel is unable to create the cache, it should panic. The use of
> SLAB_PANIC in the creation of the landlock_object_cache is due to the
> critical nature of this cache for the Landlock LSM's operation. I
> found it to be a good choice to be used. Should I use some other
> altrnative?

Is panicing really a good idea?  Why can't you properly recover from
allocation failures?

> > > +
> > >  struct landlock_object *
> > >  landlock_create_object(const struct landlock_object_underops *const underops,
> > >  		       void *const underobj)
> > > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> > >  
> > >  	if (WARN_ON_ONCE(!underops || !underobj))
> > >  		return ERR_PTR(-ENOENT);
> > > -	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > > +	new_object =
> > > +		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> > 
> > Odd indentation, why?
> > 
> This indentation is due to formatting introduced by running
> clang-format.

Why not keep it all on one line?

thanks,

greg k-h

