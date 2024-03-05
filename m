Return-Path: <linux-kernel+bounces-91610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6586871436
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814601F22FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBD38385;
	Tue,  5 Mar 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6KKfWDG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FF1E4A2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609123; cv=none; b=BnPXonXIr9gLnD4rZ27CHsAQ2JANIMqPdvCR8P5vzNkBAVr1ESKN9ON9S3J2aPMUuXHzsDhInWiJvfnqYSmO7b50tT6qX3iNHf67vkYdTxF5e+IZ/d9WXMXrYDJKG40LMgYxRiAQCw5TV3mZIPIIBZ9E5unlftBdVmZzQV4lXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609123; c=relaxed/simple;
	bh=6gaG3vKE9K4IwIi1DYqnKh0f6u04wOJtCoeYP4lkSJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUjiVtVxH9xbo2OHqJc0xfYdbF+h0Ubh5eJGY1/iLT4oSEWGTbrqig/tXdEZUCZC7AhV5o+KgMhaa6/FEG/qsDyfAGlIKKBPThW1YUeSBDQg8Jpw81OHx9GXx1KvgoiX/FYpwJYa1b544J0OmzTCSfbSM5vcVblWPjhKd8/fj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6KKfWDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709609120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXTTezTItt5z2XMw6Q17X/iZd/LoWGe+NHrzVPyEt0Q=;
	b=K6KKfWDGkKObITOikS/Ah9Kfh6yBUb3ZhIW0v7QAhLuEYrAgS3IvnwjM1YClzkLS2su/S7
	cDe9chR/WXmss0pVMIJ5eBz/81qC1wAjxphW3a6gnAHZBekd+cXpu0EE+pnCRE+JEuv0KP
	/H2bz1QdxGHzZbMmFm0RGGRQk4qBEjk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-9CmTsiJaNvWM6H8dh_CMdA-1; Mon, 04 Mar 2024 22:25:18 -0500
X-MC-Unique: 9CmTsiJaNvWM6H8dh_CMdA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc2d4c7310so10424205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609118; x=1710213918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXTTezTItt5z2XMw6Q17X/iZd/LoWGe+NHrzVPyEt0Q=;
        b=NjNpYyYUnxdpDNstE4DNsx1aFR235BNVVNfJqNuZgEfY4+VTW+lrVDvnGpkSaUWR7l
         Sbh5Hfye6RtwEbnqunLV1XHRyzzMCd33owrgJ10BF5JapAOHx2nN+RRRqoGh2b6Iwype
         ySq8WUCZKrRHPotqgjQbIhA72cmajShH16X05rM7frwYmwFiPkK2LNhMN0YsHIrlvQG2
         WdOv3CSjTWzKjH7/42uZjiwIrIyzpnnemw33V4fL386WX3Kh/oV7B4pIy0c5ynaOD5CW
         PWhGXh1xivArkZMK8DuCTpeGMcGewJudLtqZos01Pa7MA6udRi+9F9vZjgYkKS0ADymG
         OfJA==
X-Forwarded-Encrypted: i=1; AJvYcCUxORy3RJMiUrqqh8INmvcDwOD1upBhWPBOIODwYczlRYP3PLV231AuvcEecjwslgZuk8tsY3o3w3p6h7Etq7p4bHHHu+qJf2BRL5f2
X-Gm-Message-State: AOJu0YzqwrmfkJqGSS96RlexxSy73CkWXXNJVIx5YulxNX+Ve2llsEsy
	8Bnsz+Xk5z/kOyGY9u2MV76qqgvcoJnch0w/fut1/cUEDQaRwpx73kBVbNlCvbKGIrrrtO1TOaD
	hPB4xp+zKrcE+Tp7rzlhMV3wqzaiyF2amcHpzyfPMUO2vzL7jpMCkiYCywg+iQg==
X-Received: by 2002:a17:902:c246:b0:1db:94a9:f9f0 with SMTP id 6-20020a170902c24600b001db94a9f9f0mr11472354plg.2.1709609117816;
        Mon, 04 Mar 2024 19:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIT6J3aH98CJa99vypNuCkuIr31GHtAWR9nzM3gesoAnf9BMJ50CuNlEcikNQPLHQwQIsAoQ==
X-Received: by 2002:a17:902:c246:b0:1db:94a9:f9f0 with SMTP id 6-20020a170902c24600b001db94a9f9f0mr11472335plg.2.1709609117503;
        Mon, 04 Mar 2024 19:25:17 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001dd0a41447fsm3620111plf.233.2024.03.04.19.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 19:25:17 -0800 (PST)
Date: Tue, 5 Mar 2024 11:25:08 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 4/7] mm/x86: Drop two unnecessary pud_leaf()
 definitions
Message-ID: <ZeaQlORIX26dRQuF@x1n>
References: <20240229084258.599774-1-peterx@redhat.com>
 <20240229084258.599774-5-peterx@redhat.com>
 <20240304130334.GR9179@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304130334.GR9179@nvidia.com>

On Mon, Mar 04, 2024 at 09:03:34AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 29, 2024 at 04:42:55PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > pud_leaf() has a fallback macro defined in include/linux/pgtable.h already.
> > Drop the extra two for x86.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/include/asm/pgtable.h      | 1 -
> >  include/asm-generic/pgtable-nopmd.h | 1 -
> >  2 files changed, 2 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > @@ -31,7 +31,6 @@ static inline int pud_none(pud_t pud)		{ return 0; }
> >  static inline int pud_bad(pud_t pud)		{ return 0; }
> >  static inline int pud_present(pud_t pud)	{ return 1; }
> >  static inline int pud_user(pud_t pud)		{ return 0; }
> > -static inline int pud_leaf(pud_t pud)		{ return 0; }
> 
> It would be nice to have a final patch making the signatures
> consistent on all the arch inlines, it should return bool not int.

Makes sense, will do, thanks.

-- 
Peter Xu


