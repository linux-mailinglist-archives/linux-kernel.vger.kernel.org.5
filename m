Return-Path: <linux-kernel+bounces-47591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5E844FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C981F232CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E13AC08;
	Thu,  1 Feb 2024 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMZWz6nC"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0503B182
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 03:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759179; cv=none; b=ixvw3A5gdVNoPBfXdcA4K1VontvQTcObVfiHXYHm8jpl9OHpHhFvZuO04hTlUwOjbT2lJKQHwWmujz2cuvZXe1x/KIbIGx7FHaY7rlgkkDS59Lqy33fAcFq1MGdBBTuoixVlG3nNOFiSvtcKMVbzUcBu7JPMgA2XYg3aswhSlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759179; c=relaxed/simple;
	bh=jLZl2svZauxC4ea4Z0jDZi5dNNmdxwWEhOWyRJ7STJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD2BYCdRPDLj9yO5tLtcUE0X3PSLLJYECf0ptvuGySIROrbVdnR7wlg6kKmi3HK1DeIi3IYIVMF69GaMISe/hz1PXlbEX85FuLONOTIvC0AOhw1HxAsCFKeVRVAiH0UrvJvfY796sFFCa//zjegZILLFgRHfsnW3rpFFDCBLR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMZWz6nC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6861538916cso2756866d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706759175; x=1707363975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFF8rhKxfnZfXzZDWT495muOJWGnqIPs5LoDZ1rl5gE=;
        b=UMZWz6nCc5ZxcDG7yvHZnGQIfOxDmTnCMSEQWod0Pq7Ts8cp9a861RkVYMoMLZuyA8
         lgd8XtoRUbVTs03N22RZMnQax65KkaL3ysW9JK3dlYAvYs9O+/JIlVNN0cD4+7oE3u2F
         ZD21wEEgF58Q01b0HluOA0rHTGTpJjpiniDpmRwYUSFPwjmco2vO+TGVTx0wwa2P+ZMJ
         OVN7aaztnEdBJIr6lYrTIMyHlVPREESkbpPZuPFECmbOJ/8zBiv/Ks+63ShdjBlGr0g8
         IvjcFRIFPsB569GziR5Ga8Bf9XXWWHkBos9RgxEWG674U0de9QqhaN9GbwvmEbpvttKs
         XOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759175; x=1707363975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFF8rhKxfnZfXzZDWT495muOJWGnqIPs5LoDZ1rl5gE=;
        b=IlSwgv2ZUyzSj/bFSevFEfm+iN8vJPEIelCqfeHU3X1bjZmSxKQ6O3lUBa5tuAGxMt
         9HYvvUvPOdt3e1QuQ27j1elq1WNS3zG8NfVeWSYF3+neuP4m1WRPqUp8hv60mY/LXwiC
         DwwYC7Zn1/jkZPJsJCme9zVzl9YN4Hp2UrQhlvhdROcdqEEJKoSGSQT9PDrNrALhNMPr
         7rJOdMQFUn4A5ZdxAtWey6k0RJleev0xkVy+tWKAEysSOfcoy2TXGKPvZY8xMip+Fb1R
         y+2jSCue+gZCerphvf4q78ZgW9G697+PIbXl0oWFmlNrOuwVyhqMuDSMUGy5ZaAiSaJY
         iD5w==
X-Gm-Message-State: AOJu0YzmWl5chMFGk+1/p9DeklSqIqrAv4lY9jPYRNILCimlzifi6WDV
	Eo2JNiRfYjzlo5aPFaCfLyKyLy3tHXKPmwMLKAnUMETf5CR8VTjKifjQRnBSTj0PJgbjK+kSNwL
	NMslGtmWy7iLExAqSCzZ7zzz06hmOL4ZDRkSO
X-Google-Smtp-Source: AGHT+IGl3N0KrMo4pI0gs+wWPmLLPDTG5QuX4lcGW2kiKQyFlHOmi4pC0Z0bfHJbRXQX44gvJC50zjr6/z8SDinOs0E=
X-Received: by 2002:a05:6214:21eb:b0:686:aaad:e36d with SMTP id
 p11-20020a05621421eb00b00686aaade36dmr3110186qvj.2.1706759174991; Wed, 31 Jan
 2024 19:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
In-Reply-To: <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 09:16:03 +0530
Message-ID: <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:03=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 1/11/24 21:52, Vishal Annapurve wrote:
> > @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned lon=
g addr, int numpages, bool enc)
> >       int ret;
> >
> >       /* Should not be working on unaligned addresses */
> > -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", ad=
dr))
> > -             addr &=3D PAGE_MASK;
> > +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", a=
ddr)
> > +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
> > +                     "misaligned numpages: %#lx\n", numpages))
> > +             return -EINVAL;
>
> This series is talking about swiotlb and DMA, then this applies a
> restriction to what I *thought* was a much more generic function:
> __set_memory_enc_pgtable().  What prevents this function from getting
> used on 4k mappings?
>
>

The end goal here is to limit the conversion granularity to hugepage
sizes. SWIOTLB allocations are the major source of unaligned
allocations(and so the conversions) that need to be fixed before
achieving this goal.

This change will ensure that conversion fails for unaligned ranges, as
I don't foresee the need for 4K aligned conversions apart from DMA
allocations.

