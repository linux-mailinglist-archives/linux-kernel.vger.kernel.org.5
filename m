Return-Path: <linux-kernel+bounces-123803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1C890E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB73F1F248B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43F54FAC;
	Thu, 28 Mar 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuS5OM8u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BA657BC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667334; cv=none; b=oEiZZcHp1APt00ztvyJdur5zcCnEIUe3avQxHWAIUKwPsiJ81xf8cVbnDvnIN3BMnsWIi9U1JPhspe0IWsSny7/QStwgoryyH73nLv0g6IFviL0ylyePVYvggOsi15/n1VCzUsN233cJG9+K4GALU3GlQQgJpCr/RCrdyGHkOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667334; c=relaxed/simple;
	bh=O4rtQZGlV/wx6M+vu+AV+jxl5oNZk1HfuZuYghttxEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prctoaa/1qWim5T7Jn0NQ2/5kBLr8oiGds8yXDmN0C81+ZTKZO66pP1RryzDcyDktMpeMyj0wJ7nHFsCYVX/+9o5pEMD4rM14YmRn4+RAcO7aaAvyEhOgSv4WI0apC2Y33eMqI769kbLG3fLM1KomFgISfKHCtMRPBFHZHElm54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuS5OM8u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711667331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7NE4hNdw70IHlUQLVH8pzLazVAP9l2/O8oPbhQHcdo=;
	b=iuS5OM8u1TG9A7m9+AqOOsgrXHs5qCsyTyEzDugZKs/AZB7ja6TCDHZw6DziOc19Z2WuAY
	/P6NtNmOx6sE1FZs5yksORquNnfMlALKuI5bTFuHWfVzPw+mIDGawnsEgiourLLX4JV07Y
	FsIkwY/s8ApfVO3X/y+37tQEW5U72QM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-2nXZ72X_MPyapbrds-l9jg-1; Thu, 28 Mar 2024 19:08:50 -0400
X-MC-Unique: 2nXZ72X_MPyapbrds-l9jg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c3cfc89b23so1045768b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667329; x=1712272129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7NE4hNdw70IHlUQLVH8pzLazVAP9l2/O8oPbhQHcdo=;
        b=JExeqH7wARF+tcwcN6dtNaq/L6UtIPTZZ6Q9BnLxiPNafZ+62zUpoNCxZ5uN8hm2T3
         a8GpxgUcRMf/mcStuJnXgS3oOme2Em3u9DbFYh+JaWRX/4GSgdhmylmnzTuCpA/vqNdG
         0Z6yiHGYTKg0xokU83rSItpAEerNbFGOW9OaiDGU8v/cFu6agqcY/OGFA8Yu3+Pz8NED
         h4mUxF8ulhA2uK6f8eXUxUbC+hjazVddmOPcG5ijqpOyLBqjx72fdVv0kPqy2pqC4K2k
         0o5Q62X6GrRSKorMOS9GxR/szAcwCjEecNwAw/nyfyKZWAzPB7ffWStMyXi+hdUMq2hH
         BuwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDNNrXU5eFmRv7p+nKvX7oHMrlGuit+F4AjS1+w9Uj4eCyp6UDVUkjpQmLQC2A+T7455QEmcbsef/k+t7sLKHuine4LnPAPmowpYe1
X-Gm-Message-State: AOJu0YxLOJVOcCrC+88rEv8q/Vx9gA6bjKIVoDOWKlTb5Wp+mQB4IVdb
	kKt2B7jghbIfeiiZDuN7MPn3P+NbTYrolPKCTjRNBg3P7A/hbXhTZtYKcnCGWDls0QwA9dUMCKh
	lTCjic/cU6LnUsx7+NddMv0izz+3yzCUAsWLOIDvhxLX4CTMTB6P9gzQ0eB6S0i5OrZhT+A==
X-Received: by 2002:a05:6808:2190:b0:3c3:d84d:57e8 with SMTP id be16-20020a056808219000b003c3d84d57e8mr876887oib.12.1711667328954;
        Thu, 28 Mar 2024 16:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKZnccDiZUdMQffUr0xP433TBZBYIUWQatnRWhKhMSiHtFKV2ddEcbBUxykmIDeers9Ty4oA==
X-Received: by 2002:a05:6808:2190:b0:3c3:d84d:57e8 with SMTP id be16-20020a056808219000b003c3d84d57e8mr876863oib.12.1711667328390;
        Thu, 28 Mar 2024 16:08:48 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id js3-20020a0562142aa300b006961cc3f91asm1064646qvb.20.2024.03.28.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:08:47 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:08:47 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
Message-ID: <lgyiy6z7rss6t3ytmcg2ofcfzpxg5nw6mbbc2evnshhw7xls4i@vfnbqiyabmi2>
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <ec1d0885-9cda-496c-870c-fa8e1dcab974@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1d0885-9cda-496c-870c-fa8e1dcab974@arm.com>

On Wed, Mar 27, 2024 at 07:12:06PM +0000, Ryan Roberts wrote:
> On 26/03/2024 10:14, Ryan Roberts wrote:
> > Hi All,
> > 
> > It turns out that creating the linear map can take a significant proportion of
> > the total boot time, especially when rodata=full. And a large portion of the
> > time it takes to create the linear map is issuing TLBIs. This series reworks the
> > kernel pgtable generation code to significantly reduce the number of TLBIs. See
> > each patch for details.
> > 
> > The below shows the execution time of map_mem() across a couple of different
> > systems with different RAM configurations. We measure after applying each patch
> > and show the improvement relative to base (v6.9-rc1):
> > 
> >                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
> >                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> > ---------------|-------------|-------------|-------------|-------------
> >                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> > ---------------|-------------|-------------|-------------|-------------
> > base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> > no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> > no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> > lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
> 
> I've just appended an additional patch to this series. This takes us to a ~95%
> reduction overall:
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
> batch-barriers |   11 (-93%) |   61 (-97%) |  261 (-97%) |   837 (-95%)
> 
> Don't believe the intermediate block-based pgtable idea will now be neccessary
> so I don't intend to persue that. It might be that we choose to drop the middle
> two patchs; I'm keen to hear opinions.
> 

Applied on v6.9-rc1, I have much shorter base timing on a similar
machine (Ampere HR350A). no-alloc-remap didn't show much difference
either.

               | SA8775p-ride | Ampere HR350A|
               | VM, 36G      | Metal, 256G  |
---------------|--------------|--------------|
               |   ms     (%) |   ms     (%) |
---------------|--------------|--------------|
base           |  358    (0%) | 2213    (0%) |
no-cont-remap  |  232  (-35%) | 1283  (-42%) |
no-alloc-remap |  228  (-36%) | 1282  (-42%) |
lazy-unmap     |  231  (-35%) | 1248  (-44%) |
batch-barriers |   25  (-93%) |  204  (-91%) |

Tested-By: Eric Chanudet <echanude@redhat.com>


> > This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
> > tested all VA size configs (although I don't anticipate any issues); I'll do
> > this as part of followup.
> > 
> > Thanks,
> > Ryan
> > 
> > 
> > Ryan Roberts (3):
> >   arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
> >   arm64: mm: Don't remap pgtables for allocate vs populate
> >   arm64: mm: Lazily clear pte table mappings from fixmap
> > 
> >  arch/arm64/include/asm/fixmap.h  |   5 +-
> >  arch/arm64/include/asm/mmu.h     |   8 +
> >  arch/arm64/include/asm/pgtable.h |   4 -
> >  arch/arm64/kernel/cpufeature.c   |  10 +-
> >  arch/arm64/mm/fixmap.c           |  11 +
> >  arch/arm64/mm/mmu.c              | 364 +++++++++++++++++++++++--------
> >  include/linux/pgtable.h          |   8 +
> >  7 files changed, 307 insertions(+), 103 deletions(-)
> > 
> > --
> > 2.25.1
> > 
> 

-- 
Eric Chanudet


