Return-Path: <linux-kernel+bounces-92753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AE872589
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0791C23398
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580514AB3;
	Tue,  5 Mar 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w61Gq8SY"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2D14016
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659156; cv=none; b=gHFwO7YK6o683ZpW1qMv42684FqClc/mDtbzCnXTdTd4FO+McQ2WTfPhyezZBV/pbi55jzw8yxG7G+lda6/QqctP0CI0n91G1LF4PMCndEuB+jQUXWPSnWGUeTzyCbwOK2NV/DoPY2okidskYQV9l3rU7iIs5+koDldm3/l4d7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659156; c=relaxed/simple;
	bh=35W0xkiyIW+h4I7uaqpD3yZaGe3eGIyUIL9pgPlFMFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neiiCQQM7IQVvRZK7x1FgOK96gO4qv2asx0EUf+9l5Gl+0/Tq81bS8U0crDwaRmm/D0V5VwyjoLNnEARTyXUJYrFGYLLr9+QaSBGw2Ryyc1lFXi17xr4wV1ivc17OmkrCZv3kQd+r9+LxPrGAumtKkteXVZqBhwWHu2NKqYGof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w61Gq8SY; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595aa5b1fe0so582977eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709659154; x=1710263954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QaobAGWVH6S5E9EJzoRHvFL79d1fgtq8p8ecN7tgGg=;
        b=w61Gq8SYwekNV3s7e1/U1haKUng++zjWK9U/CFAjZ6iILsVw52wGQ7YQjzGkPI7uzY
         JyMuscZvh7bWn6FI0b3IZoSBJyf5f/H2XqXAN3s1TBA19zA+/pT4RGcI1hoR0/ZUuFT1
         DH1ydMs0wyalk+3hoEaYfGOX0W7g4u41+R0mQE8ydTzJRqCmoORd9k9Ck5Iv/SPwn+T7
         +7ZPMNPOtwyCMvgoyQGIKUqt53fkwrwvmEXSfVdG2UAWwlIgjzHsjymx2gg/pL4VRwcl
         V1NDhZnpXPut5+E3E6mmM0+oKs7Y7SQFra6Jk/MTuLnQH1HVFUhjhf7eIL9vHlTe0S0a
         wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659154; x=1710263954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QaobAGWVH6S5E9EJzoRHvFL79d1fgtq8p8ecN7tgGg=;
        b=mq2dw03hI5popsDuOfBFbFZFetQAUf+87mPV4RlM74a4+p1zY1xqkWLtynU2uWU78G
         5YdNSojjJWf9RW+aWGIn/XVoLj9liMt/qQxvHi5AX6/+f1EOA5m1TbLT6SYZQml8tMA4
         79KiwSbxQycjJfMuixkWdhcXzn/K1Nr/nG5x49X8OFxtLUSMR1UUTQTGtMTK2PrHe0hk
         kzMwOrXagMant6jRP6PVqjNiSoxtYYUMbanDuIkN1CodDYP/g3K4n9+/TTps2W+TeL1+
         R/tan1lHPf1/i2Zuts34SCdK0SHoCt5yXfUaCNzwdFttbP0kcpJx/I3n5QvHeg7L0YOI
         Q04A==
X-Forwarded-Encrypted: i=1; AJvYcCV2gG/6fl7Q/azzkGLcKiutZdtX93R6jAA1Ucmqv3S8Vpwhx4xrxQtMTuVM7MhY6vd1Smr6MKXsndO1qSbBwKVsSz8BuFcq5K2kVUZk
X-Gm-Message-State: AOJu0YxVVF8z9oeslb4C1JHGrKUSUFdNbmkltqc1VaJJGAP83ET1Yzfu
	lthP3SKVXMiw8yg74S9VAmdCK/nOm8JRmcLRb7Q8NNITiNKLJGenhBhTBOOB8qQqyj8qjNS5Rtt
	BS7j7CQlngOQvBWyNQWNnvZrGD4A3pwOJJ5QF
X-Google-Smtp-Source: AGHT+IEFsxok2qYjPGM8WG7zzaRYUAHjkHuadWtw7qIkVbdF0GYy27xbG5BOekp2bznsc7bcEKBI8II7uSjtyoF/Gzc=
X-Received: by 2002:a05:6359:4103:b0:17a:d4c0:d59f with SMTP id
 kh3-20020a056359410300b0017ad4c0d59fmr2914394rwc.4.1709659153881; Tue, 05 Mar
 2024 09:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com> <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
In-Reply-To: <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 5 Mar 2024 09:19:00 -0800
Message-ID: <CAGtprH8LOgvtO_rjFzASbp240P=yBvODCBU22sN_+uhdumueiQ@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: Alexander Graf <graf@amazon.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, rientjes@google.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, peterx@redhat.com, vkuznets@redhat.com, 
	dmatlack@google.com, pgonda@google.com, michael.roth@amd.com, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:14=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
> > ...
> > The issue with aligning the pool areas to hugepages is that hugepage
> > allocation at runtime is not guaranteed. Guaranteeing the hugepage
> > allocation might need calculating the upper bound in advance, which
> > defeats the purpose of enabling dynamic SWIOTLB. I am open to
> > suggestions here.
>
>
> You could allocate a max bound at boot using CMA and then only fill into
> the CMA area when SWIOTLB size requirements increase? The CMA region
> will allow movable allocations as long as you don't require the CMA space=
.

Thanks Alex for the inputs, I wanted to understand CMA better before
responding here.

I am trying to get the following requirements satisfied:
1) SWIOTLB pools are aligned to hugepage sizes.
2) SWIOTLB pool areas can be scaled up dynamically on demand to avoid
pre-allocating large memory ranges.

Using CMA to back SWIOTLB pools for CoCo VMs as per this suggestion would n=
eed:
1) Pre-configuring CMA areas with a certain amount at boot either with,
   - command line argument to the kernel (tedious to specify with
different memory shapes) or
   - kernel init time hook called by architecture specific code to
setup CMA areas according to the amount of memory available (Possibly
a percentage of memory as done for SWIOTLB configuration)
2) SWIOTLB pool dynamic allocation logic can first scan for CMA areas
to find the hugepage aligned ranges,  and if not found, can fall back
to allocate the ranges using buddy allocator (which should ideally
happen after depleting the CMA area).
3) SWIOTLB pool regions would need to be allocatable from >4G ranges as wel=
l.

Setting up a suitable percentage of memory for CMA area in case of
CoCo VMs will allow larger SWIOTLB pool area additions, this should
help alleviate Michael Kelley's concern about spin lock contention due
to smaller pool areas. This will need some analysis of shared memory
usage with current devices in use with CoCo VMs, especially GPUs which
might need large amounts of shared memory.

>
>
> Alex

