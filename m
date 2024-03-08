Return-Path: <linux-kernel+bounces-96555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451B875E0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC8B22695
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DEA4EB29;
	Fri,  8 Mar 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9/TbEuY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A93441F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709880636; cv=none; b=ksIgdc62ZpKiVVRdYXND5+uH5flxnKv7CFYCARQk2dCDrnWMsJBJmH6Zi3cQj0Iip8Uf2yzd//LHbmow08uwaTOpmK6vdgWE0JJUarIa1GWqk+2Yp1tnQ568MWMAhwH6DKlqcHeIQaKO/xNrPuMl56aK57zW1efRUu33og7NUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709880636; c=relaxed/simple;
	bh=icevmjjQzy7T8gdOkFpqgnXBgi/VX04oIsM5bIcpiN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U27VY7NGC6H0Ag/hQyl+GXqbwwUzj0gCel5lU0GeSHDpnv9rm9wVILAl55BHAkqig1ttXjqDn6P0u3EWukAZ1nYjnq59FXtZoEkQYkcbyNFOWzjbNS8jvYcQ1Vg4TEPagrDj73DeuF8P2DgWggDuPXnkAthRMYNu9+SQEXSG/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9/TbEuY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709880633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epRg3dGewUcblPePlS+KzZdY/GgoToAmRabId8Bpp4I=;
	b=V9/TbEuYrZMfR05zpGMs6kOM93WEA9kdJDMKKbjRxJi8UOuzlft06EXzvMKJ7UTFAmNw+6
	pMl/V0Gnbvkl1Ra/NfzBUOBZyI8gWQfCcHA2CS+y+nqDLfnHyIEkxMuO7e8LxIum2845kz
	uaY7JGDe+1uPEZjD6Z1oPsHLTWzHbPY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-FxMdvHrzMCqKmKj-wGEaUg-1; Fri, 08 Mar 2024 01:50:31 -0500
X-MC-Unique: FxMdvHrzMCqKmKj-wGEaUg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-221994722b9so148915fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 22:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709880631; x=1710485431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epRg3dGewUcblPePlS+KzZdY/GgoToAmRabId8Bpp4I=;
        b=ieMNZ32hER/A96kVlPAsPt8Y1mrjiCUPvjz24QEGgzQZanIrRgqKdbGTZAjD6juvnU
         jpLeJHwCwMnNowRTgs2NygFddh891mc7eTWKXxcwqx8BOxLmIEA/Tsz8Oho99vYYU6UR
         y6pIEQHezyR3+9p65k+zvlox+SlnzTNmJsh5htncKpDnOarvxhjXKuBmIctCiVIRgCZc
         URzOHRTqAf2dAxVMMF0LpzBh0F0CnCWoaxEbezLPETHbLMh+OaYUCTOJswn3auiEl0Hx
         cKq7Ji7sfP/jF5Fr2nRJ+RCuYflHfZe+OTq07GYhCdTDBAxFxrycn5oMB4zWXqyGK9iW
         IOQg==
X-Forwarded-Encrypted: i=1; AJvYcCXupvbnC1eSm6DVQ4KDL+golZsbR8obGIXdASkZVH5xwFeU2mP4hQR2Ti0Lr7VdeyAeijN5VcbCVdekrwvdZy/ISm2Ou7E8KoVGGFzY
X-Gm-Message-State: AOJu0YxgBy/CnAof5N3tjyVk+RQyrqD3veyd+Kx23c3bnLQWCvcetcOw
	qefHFJ96KZaTBmW3lIuNfwh/OF7sGlpdW/whEkrTscXEqJCIxfgqdQX/pIeJjc8uuLGe6mC4X3C
	VE2Zl2GpBe2eZ4k9e/26DNvQrtHtmJiuX+jvZ5VWZUe7YGkD034MWCRSefr0hrw==
X-Received: by 2002:a05:6870:911f:b0:221:9798:22ce with SMTP id o31-20020a056870911f00b00221979822cemr1235676oae.5.1709880630970;
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5WJ4Hs7BOa4+cQmkVKBMn/KDqWDXIuEQmCh9SbFC/cz4o3SLGxNN1BrH2AJEolH8ck0I8Eg==
X-Received: by 2002:a05:6870:911f:b0:221:9798:22ce with SMTP id o31-20020a056870911f00b00221979822cemr1235655oae.5.1709880630429;
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r37-20020a632065000000b005dcc075d5edsm13621982pgm.60.2024.03.07.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
Date: Fri, 8 Mar 2024 14:50:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH RFC 01/13] mm/hmm: Process pud swap entry without
 pud_huge()
Message-ID: <Zeq1LNValPosuWgw@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-2-peterx@redhat.com>
 <20240307181233.GD9179@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307181233.GD9179@nvidia.com>

On Thu, Mar 07, 2024 at 02:12:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2024 at 06:41:35PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Swap pud entries do not always return true for pud_huge() for all archs.
> > x86 and sparc (so far) allow it, but all the rest do not accept a swap
> > entry to be reported as pud_huge().  So it's not safe to check swap entries
> > within pud_huge().  Check swap entries before pud_huge(), so it should be
> > always safe.
> > 
> > This is the only place in the kernel that (IMHO, wrongly) relies on
> > pud_huge() to return true on pud swap entries.  The plan is to cleanup
> > pXd_huge() to only report non-swap mappings for all archs.
> > 
> > Cc: Alistair Popple <apopple@nvidia.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hmm.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > @@ -424,7 +424,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >  	walk->action = ACTION_CONTINUE;
> >  
> >  	pud = READ_ONCE(*pudp);
> > -	if (pud_none(pud)) {
> > +	if (pud_none(pud) || !pud_present(pud)) {
> 
> Isn't this a tautology? pud_none always implies !present() ?

Hmm yes I think so, afact, it should be "all=none+swap+present". I still
remember I missed that once previously, it's not always obvious when
preparing such patches. :( I'll simplify this and also on patch 3.

Thanks,

-- 
Peter Xu


