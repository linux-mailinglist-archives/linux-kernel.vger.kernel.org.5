Return-Path: <linux-kernel+bounces-94293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC79873C98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF03B1F21DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92A13792C;
	Wed,  6 Mar 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6fZggiT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370360250
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743817; cv=none; b=iTpO36duFawqMuD5JMCxymeAgdAuHhzMn7uMVfWZ12ywhiBWThABBq2mEDJXZqU1ipHW08HjrQPaYIdqDOh4oFgk0czInUQTgZMUnTfCG0knN3BFtyPQradUj56z7DC1OJ8xHAxk69TmJp+cISN0Y3+3ngSKiy0o/Dd7yqzGIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743817; c=relaxed/simple;
	bh=qnFouHowiUboWqipiYqPdkjQZwx7iQMt65gPiFu8wRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmTQDEI/2FbT8oudeh4uG4dAmIHeGlT/RlUaYwFU4ArZkfIcyiaWgAT6oPZuESzUyafzHBKd5GvFG80O+UJEhQmvvbQL9Uqngf9FkUMHY5DUxZm7sFPssn8Jjte0jC3X8DIB7McwAwvGPWDK38eFO2aeEIzr6tvpcBbsRHHOvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6fZggiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709743814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFwqTj8WPf3w+Wcwvpf0C+CURfpIxKA1IeNu1cFxTn0=;
	b=S6fZggiTDJBLoyX1KwwEb9YqlRqbiLwADthoGuedlZIOtWdaPP/CRXP1yreDBkrDR19B0r
	n6r9I16x4rEo5ZXgZGBuHk1x97Xg1yo6gpMM/1ZCxLVrtVk8awsYRSDXQaxnHTi/6uWQeC
	SjCsfVyYRO6QlRyYksmrQ5KNFJa8C0k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-27EUneHUOaONty1FC1Wuyg-1; Wed, 06 Mar 2024 11:50:12 -0500
X-MC-Unique: 27EUneHUOaONty1FC1Wuyg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4129b426bdaso140555e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743811; x=1710348611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFwqTj8WPf3w+Wcwvpf0C+CURfpIxKA1IeNu1cFxTn0=;
        b=r9UkW/w7SYW3MUSVTrvQ5r+1DNZQCmvVUljI9/H1e0SW29TplQPlQogVFRZgvh3VVz
         n6YGqqOVpnnhzDf3GXunTq01wfIce9a7BVlLQ0IQzIXNpxFAaQLlXud12qO2w1mmEuxN
         LnNPCJa73muSpY1DV+Yv22ps5BmlCu08B+devPiHApOTQLV3MOHZsk8sDC8gWLHopxVm
         O2yMT0aiE5zaym3dn48kBkVfTq2iWYiE2Bi7qlGcGuc7lvsm4ZQextBlVUsnu+O3mUzj
         /i7Hn7oqBBEWh/yzc/47o6VGIgQqvzKg7HS9efAtkZ5fL2ENUAR110fMv4xEv1l3CHGS
         YMzg==
X-Forwarded-Encrypted: i=1; AJvYcCXQp52iq5Hw5S+Xps1xoIkOLH9M+v5YcMkJsszG5mCIVlTklg+E5KwJYww547kYTzKnyHO9KD18PxJiQNzBHLImaDquYqB79Yez49kR
X-Gm-Message-State: AOJu0YxOTRQFE2J9llmibBFU2/lCmyrgfz39nDVq8LpwMH8OXNXnlL/R
	AkAStbpkc6qXTHF2D/ejOqTRrzFMO42C+r15jztvyPR4/mWsfZUgtTdEA3Euv7uHUOoWJyAfWub
	+8tBBl6f0dnb8pnE7H057U73nVGFI04Yh+RR2B+ug9ukmXpztqRn9eqWi4rz1m1bkm2QGwg==
X-Received: by 2002:adf:f546:0:b0:33e:2993:7c81 with SMTP id j6-20020adff546000000b0033e29937c81mr8781292wrp.64.1709743811345;
        Wed, 06 Mar 2024 08:50:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdRUULTIbhrSNIe6MOucamjK8vl5VfdtAixAYikSlurVuxcc5MEnxymSBjgvP5vUB6/jsmGw==
X-Received: by 2002:adf:f546:0:b0:33e:2993:7c81 with SMTP id j6-20020adff546000000b0033e29937c81mr8781277wrp.64.1709743811003;
        Wed, 06 Mar 2024 08:50:11 -0800 (PST)
Received: from toolbox ([2001:9e8:89a4:b300:8654:3fb5:7140:1e06])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033e456848f4sm6522396wrf.82.2024.03.06.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:50:10 -0800 (PST)
Date: Wed, 6 Mar 2024 17:50:09 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Document requirements for driver-specific KMS props
 in new drivers
Message-ID: <20240306165009.GB11561@toolbox>
References: <20240229202833.198691-1-sebastian.wick@redhat.com>
 <20240306-hulking-funky-fox-b9581b@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-hulking-funky-fox-b9581b@houat>

On Wed, Mar 06, 2024 at 03:14:15PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Feb 29, 2024 at 09:28:31PM +0100, Sebastian Wick wrote:
> > When extending support for a driver-specific KMS property to additional
> > drivers, we should apply all the requirements for new properties and
> > make sure the semantics are the same and documented.
> > 
> > Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> > ---
> >  Documentation/gpu/drm-kms.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> > index 13d3627d8bc0..afa10a28035f 100644
> > --- a/Documentation/gpu/drm-kms.rst
> > +++ b/Documentation/gpu/drm-kms.rst
> > @@ -496,6 +496,11 @@ addition to the one mentioned above:
> >  
> >  * An IGT test must be submitted where reasonable.
> >  
> > +For historical reasons, non-standard, driver-specific properties exist. If a KMS
> > +driver wants to add support for one of those properties, the requirements for
> > +new properties apply where possible. Additionally, the documented behavior must
> > +match the de facto semantics of the existing property to ensure compatibility.
> > +
> 
> I'm conflicted about this one, really.
> 
> On one hand, yeah, it's definitely reasonable and something we would
> want on the long run.
> 
> But on the other hand, a driver getting its technical debt worked on for
> free by anyone but its developpers doesn't seem fair to me.

Most of the work would have to be done for a new property as well. The
only additional work is then documenting the de-facto semantics and
moving the existing driver-specific code to the core.

Would it help if we spell out that the developers of the driver-specific
property shall help with both tasks?

> Also, I assume this is in reaction to the discussion we had on the
> Broadcast RGB property. We used in vc4 precisely because there was some
> userspace code to deal with it and we could just reuse it, and it was
> documented. So the requirements were met already.

It was not in drm core and the behavior was not documented properly at
least.

Either way, with Broadcast RGB we were already in a bad situation
because it was implemented by 2 drivers independently. This is what I
want to avoid in the first place. The cleanup afterwards (thank you!)
just exposed the problem.

> Maxime



