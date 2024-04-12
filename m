Return-Path: <linux-kernel+bounces-142664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363588A2E87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596B11C225CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB74205E2B;
	Fri, 12 Apr 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnLnJnwC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4F5914B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925546; cv=none; b=odREJ6aaNws1SFy8Lac+sOajIsFtokZ8vTJhdfbI2uJySglOBlZaiiP1fCB9OP4k1xGJjVkREx+ZFMUP7j4PhNqFbYUA/ZvfadHI2FSko9NsPtjEh83UC5Zx0AjXr031ViI15VsaEv5sLVKREe2ZHylOe/MuZSMSI1YaFW3Cw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925546; c=relaxed/simple;
	bh=USUFhPdHsEeP0gGiz8EnyD3iVzrLpXTAMLVGITI3K6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mipNV/HLFUI1r4BL6yk+nUahARUwVDb7KGoTLm3oFh/4o2Hk7EcrJ5ZHA1SQlCBe4/1lXVuU65E/F7KMleo3G4pVNCagSw2DpKXv8fI9JXFVFBYDWpDNi06qhcltvDwFOHKc4j7iLMoDNuNfN8+i/zpBzWsU7uhlaz/zwmn2sAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnLnJnwC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712925544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsC1auUUKTeMEPNRcjF9vosQb+zXYGMKbKRowFQ0VRU=;
	b=PnLnJnwCLgFCm+FZaxYDLjTkjIMWMY77s3f3F+LFU19wGgnpQugG3iI+1506SEFgx1EwS6
	JtClN+kreN5Z2P5mSVr0wmzl3G/nr6fIj3EJnVYOPzqEXltBgxeVO3S5gga/t7mqn31MLj
	VaNiSgWueTsvv0dc0pxlEOfKRXcZQcM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-pLGVM9IvNnGr4w6LJkSjsQ-1; Fri, 12 Apr 2024 08:39:02 -0400
X-MC-Unique: pLGVM9IvNnGr4w6LJkSjsQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69945bfdbfdso630666d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712925542; x=1713530342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsC1auUUKTeMEPNRcjF9vosQb+zXYGMKbKRowFQ0VRU=;
        b=ON8zAUqF2bpJWQzzr5oZ6K8OXTkd43Ho1uDGHmtkca0ZyiKP7SHt2ldDNVYnNoJbEP
         oUbukhgdmbKOyPMd5H3M+tIpDMSdKFzLkSgzNYwqwxe/4qaivWoHhBPOphNq9mbgbj1R
         NJlhs/pnH0ygHjYXC5yNlIutTRJF8xxx8qgctopnr4FAEwP85mk+4UNC9TkKb2V85yfR
         Q1B4fuCv+Nu8fiuFTjMw8WEosaNiSeF8GyXMKS3lFOeSEId5jNbKTqJaFPgtUfaTPBxA
         wS9PSObjRwPRT1fkXwA4aQjwjJCLkl83NOzU2HIujDjufBrlegT0k7YmHB27k2cBCCOT
         XQNA==
X-Forwarded-Encrypted: i=1; AJvYcCXsPQEWbcukXXOmv9f/SK524snD/xaJnphuTH12IRsl4FxErUJ88S/G3WkY3IDRlVaEv1stqCijlaF7pN72t++IeY9csH+JdYt4/sLi
X-Gm-Message-State: AOJu0YzPREiHlncgcqWlivkQiHIsraHjSS+tBCwx2rftTl9BGQvFR8R7
	yGIFgcfCF8CDHvJoM57ebCDAm3b51F1dk34Ikgtn4Xjf85umliWJyaMVpPXpN6V8jjUq/e4WkBv
	38i5Uigfs+0iYtjf2NmMSpk7cuBQ6PSApMDUeCLDCGTt0kFT8uflM6OO7VQwrzA==
X-Received: by 2002:a05:6214:230c:b0:69b:ce6:271b with SMTP id gc12-20020a056214230c00b0069b0ce6271bmr2767638qvb.2.1712925542048;
        Fri, 12 Apr 2024 05:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfD1xZ5z/cTBIdsqmi9jotZa3qa+LzP4dmFWH+zJg3Qz57yLpIAPqOXHLjdTArqmRO/gjQKQ==
X-Received: by 2002:a05:6214:230c:b0:69b:ce6:271b with SMTP id gc12-20020a056214230c00b0069b0ce6271bmr2767605qvb.2.1712925541419;
        Fri, 12 Apr 2024 05:39:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ej6-20020ad45a46000000b00696b1050be8sm2281738qvb.133.2024.04.12.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:39:01 -0700 (PDT)
Date: Fri, 12 Apr 2024 08:38:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhkrY5tkxgAsL1GF@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhinCD-PoblxGFm0@casper.infradead.org>

On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> On Thu, Apr 11, 2024 at 11:02:32PM +0100, Matthew Wilcox wrote:
> > > How many instructions it takes for a late RETRY for WRITEs to private file
> > > mappings, fallback to mmap_sem?
> > 
> > Doesn't matter.  That happens _once_ per VMA, and it's dwarfed by the
> > cost of allocating and initialising the COWed page.  You're adding
> > instructions to every single page fault.  I'm not happy that we had to
> > add extra instructions to the fault path for single-threaded programs,
> > but we at least had the justification that we were improving scalability
> > on large systems.  Your excuse is "it makes the code cleaner".  And
> > honestly, I don't think it even does that.
> 
> Suren, what would you think to this?
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6e2fe960473d..e495adcbe968 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>         if (!vma_start_read(vma))
>                 goto inval;
> 
> -       /*
> -        * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> -        * This check must happen after vma_start_read(); otherwise, a
> -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> -        * from its anon_vma.
> -        */
> -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> -               goto inval_end_read;
> -
>         /* Check since vm_start/vm_end might change before we lock the VMA */
>         if (unlikely(address < vma->vm_start || address >= vma->vm_end))
>                 goto inval_end_read;
> 
> That takes a few insns out of the page fault path (good!) at the cost
> of one extra trip around the fault handler for the first fault on an
> anon vma.  It makes the file & anon paths more similar to each other
> (good!)
> 
> We'd need some data to be sure it's really a win, but less code is
> always good.

You at least need two things:

  (1) don't throw away Jann's comment so easily

  (2) have a look on whether anon memory has the fallback yet, at all

Maybe someone can already comment in a harsh way on this one, but no, I'm
not going to be like that.

I still don't understand why you don't like so much to not fallback at all
if we could, the flags I checked was all in hot cache I think anyway.

And since I'm also enough on how you comment in your previous replies, I'll
leave the rest comments for others.

-- 
Peter Xu


