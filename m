Return-Path: <linux-kernel+bounces-89256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EBA86ED48
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F05328163B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8151877;
	Sat,  2 Mar 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gOkPtCKn"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B010E6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338490; cv=none; b=Wb6zDeOj7tzxFmyrFXxq+b9nNm8k/jGGcntpDNLQlPo9VwWulEHanvMjiEung8MHrR0HCDVe6ve/EV01mtmxtDeVsKI18BGQo4WAMxM+kG5LA0HP+AuVNgaFBRoJpj0VPJHhexaB7/nioi+j+5g8e/Xb9JHMFbVFYONeHwrg668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338490; c=relaxed/simple;
	bh=J9RecM11zoh+0vCDfzEiQKHVBWqECX6ysWPdITOtwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ubKgqnH15s27loEP0dtxVAyHGaK8LainqeffrS0sl6II7zBtqocfdjJnVrc25BiUMtDX7zGzvTLvw6kfX5YegFSipC7rVAezutgzicgOjcad2fjw2s1r2zfv63vgOOf7+gpu5eBRbBp4pe2e9ryI5xFCE/bjSUWXfuqu7Y6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gOkPtCKn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5760eeb7aso2370592b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709338488; x=1709943288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FF4IiXm7A+T8Frcn1xhwOocDaZJ/4WKQwj1y8lgr4F8=;
        b=gOkPtCKnpB1O7rMJ+Q7MkzCYfrC0Wn69S0rpH6FJKIwtblME4dUFVbWIl4EddOq/dh
         3CdOIeZ0NkfIpc89Q2u4BDeZ2B9azSNDl9OOPCoeLU/qTTvQTHj8X0O1nn40rqm8n7um
         p9oXDZuOFCJDgP0i/u1VtIg4d6ymgM4cN5AnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338488; x=1709943288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF4IiXm7A+T8Frcn1xhwOocDaZJ/4WKQwj1y8lgr4F8=;
        b=GyR4QGDJr55CiU7d0P+ls9dblc2x2EiHMd0y9tY/uuoTI2j0V7Hetkw2ptyrTgeEiJ
         ZoipsbFilUPrJVurcuietz0vyvVB/jm/9AyjJaYCeG2n+GFF61qNDIXXTQaAcGJJzcfi
         9bvL03+XfrCwk1WVDIKwanroIJGi9jUrBTQ0pnOgt+IaQ/wyq4Thqf95rcRptzdC0Qbd
         812ly9/Cj3zKMa+jnrR3eIihen4ja8wzKKKSuLA7isiZdv6/DpaCQlwutN36sUNhMvM3
         uaHpX4/U4Z1BT5sDWabABfN3eoZcmYd7sxSv/hc5MKCjBta79f2MX6430JWWYKX0o6JK
         prNw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBZtMsjwXGtaGZsQdrmqgOtK616SPZnrw15j/mRGjgltHefIRdNN6C0T0hzCAJUDfxBpke3zvpmaONP181NDq1JF/TcAdLs4vgcuO
X-Gm-Message-State: AOJu0Yz6eKSBrqoQZUMaX+mKHxSxt9Nr6h/1ErE/hRcfKlKbqHx1jO/m
	s0wLkOJXC5fOYvdANf9KUVPgOlKLklPSAFcM2G/DtEXX2d2NdEr4ouKpCRrjlQ==
X-Google-Smtp-Source: AGHT+IEQo2qIPhB9LTmigxSPC/z8GP5w2KmXdHPe4k2dtlqi/60ZWzje2+zCus9dKjUyCYKc5QJ4pA==
X-Received: by 2002:a05:6a00:1916:b0:6e5:e8ee:38f2 with SMTP id y22-20020a056a00191600b006e5e8ee38f2mr628578pfi.23.1709338488017;
        Fri, 01 Mar 2024 16:14:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b006e592a2d073sm3423740pfl.161.2024.03.01.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:14:47 -0800 (PST)
Date: Fri, 1 Mar 2024 16:14:46 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/uverbs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202403011613.BB548211F3@keescook>
References: <ZeIgeZ5Sb0IZTOyt@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIgeZ5Sb0IZTOyt@neat>

On Fri, Mar 01, 2024 at 12:37:45PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There are currently a couple of objects (`alloc_head` and `bundle`) in
> `struct bundle_priv` that contain a couple of flexible structures:
> 
> struct bundle_priv {
>         /* Must be first */
>         struct bundle_alloc_head alloc_head;
> 
> 	...
> 
>         /*
>          * Must be last. bundle ends in a flex array which overlaps
>          * internal_buffer.
>          */
>         struct uverbs_attr_bundle bundle;
>         u64 internal_buffer[32];
> };
> 
> So, in order to avoid ending up with a couple of flexible-array members
> in the middle of a struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structures:
> 
> struct uverbs_attr_bundle {
>         struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
> 		... the rest of the members
>         );
>         struct uverbs_attr attrs[];
> };
> 
> With the change described above, we now declare objects of the type of
> the tagged struct without embedding flexible arrays in the middle of
> another struct:
> 
> struct bundle_priv {
>         /* Must be first */
>         struct bundle_alloc_head_hdr alloc_head;
> 
>         ...
> 
>         struct uverbs_attr_bundle_hdr bundle;
>         u64 internal_buffer[32];
> };
> 
> We also use `container_of()` whenever we need to retrieve a pointer
> to the flexible structures.
> 
> Notice that the `bundle_size` computed in `uapi_compute_bundle_size()`
> remains the same.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/infiniband/core/uverbs_ioctl.c:45:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>    45 |         struct bundle_alloc_head alloc_head;
>       |                                  ^~~~~~~~~~
> drivers/infiniband/core/uverbs_ioctl.c:67:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>    67 |         struct uverbs_attr_bundle bundle;
>       |                                   ^~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This looks complex, but I think it's simpler that other changes that
would have much more collateral impact. Thanks for figuring out a
workable solution!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

