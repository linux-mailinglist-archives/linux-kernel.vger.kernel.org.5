Return-Path: <linux-kernel+bounces-79754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B864862641
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BAD1C2111A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262243ABE;
	Sat, 24 Feb 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecUldYwM"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D9481DA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794457; cv=none; b=YxAnIC7dK31+/zVdjxHSua7VVXkukKr1NaSbWWwTYcBWq1S7m9B/xQF/lsNPqOstyWgmRkdRRhJvi0hUE1teMEQR7sYoupvZjR1yngudXBYU6JDrJPhF3uisA+F2QEo+5+m6fAFveL8smu8wFtJ3+p8s2ciVM9Tg9ktJjB5USWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794457; c=relaxed/simple;
	bh=ozIDoFedItkmER/Orkt229o6FySIYQ15J2Qcqcu6KnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iESOQ1X4QoPhCsDaX+BeyE6T8JPuHTl+DB6XKJGKmpRqITIzs72TlyGeRIR9NCVGGPvQnTp3vHTfmZpS8MlNDUEUiSTj4CeXFE0fdS27pFkkpgsdHbtfv0PfVM8m2jNB1fNRL/vF5pQ0AObfMjL6TApHmpTYKBPDJrL0zIhmRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecUldYwM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68ff93c5a15so581216d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708794454; x=1709399254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkEL+dazk0pG/rsK4xpDTlcJ2SMxur3lfWU/aiLk45M=;
        b=ecUldYwM3/O6p70SFoLUhqjfgym57h3/MhjF/L3MXrq/M419tc558AeCQrAk/KqJdb
         CxNRvojUP66VIvaaLFoTr9LVRpDdm9wyMs5oaHuZyJaOeqHajKia86u8nV1OaI6+rK97
         TqduFNQ4+MUWH1VBT+XxFqt3ylpTuQ+MmCLpARRRmfg3t0hao7x90OLsJ5TXcSQkrwtN
         8Et7MzyXu/Dp3saeh2suDTsCXk9pQiOcC+oqHMP6uJiO2LzUptZ/S28PawRzzbyL+FtF
         r+Rr6dUWag6smXMfYP2E7zfKdYDHaH77u4ok1j20gfQhKKU2gKWQFSIS4T2xEjxz3Z3W
         IXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708794454; x=1709399254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkEL+dazk0pG/rsK4xpDTlcJ2SMxur3lfWU/aiLk45M=;
        b=SC7D5kU4P6O6jPaRBrOLJX1JnFmx2esbvW9vsrqnej0zEh7L28UAfAsQHf0VPPDQwZ
         LpD/0V9zYHwSkhZ8cwDH8Q2Ey5wOFxzZNaSPLQJCSz+y8dzkmMPVXx/lea24Lqa0Fart
         YBi95EAAeiWIpih/LevnoUO4HDdQ17KcHuIFvLO20mEv1HLV3O5jsryjY/MvjNm9wNXr
         cou11XYPSsDd7+yy6xMXc3NaIA6+FmrgOd8b+RsfGfzc0+HDvVVqVEHVCu4qZN77TBfX
         S+hPt2XHhqiuddjZNhzQtZy0LXVHkZbhaAotkafWnxoysGEmb/Au8m7apd7OMpw1CB5t
         tvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqbcD62ka4dHW5LBM0YdWoTfPl0oLA24g//xJjPu4hC5JRd84PfmBAeGfM49U4RHeiphqsjwRPUmqnERHINZXTxgoFbzARLvjahXYy
X-Gm-Message-State: AOJu0YyYnbFXqeB/UepC+mPG17+uE97gZYj/rF3qrpMYso/s+IgJgtsw
	hwWqewRH7D5uGNHkrdoOWmKY7WqkGvPVdXxX+t/3BhCzq4ajb5tXhP2nwr9c/ugasvtUPTMlGgf
	4afvl8tUTUNGTD/91Tkd2XOyCRLPmi/sUaD+b
X-Google-Smtp-Source: AGHT+IHmL4S1gR28xyNUSOfmm8J8cJvNswhZL87sTfb3FCUn/n4pp1DLBBQWWOfsN4nRQ0T4o6hB3IQAzHQ1UwdL1D8=
X-Received: by 2002:a05:6214:27ca:b0:68f:e43d:a253 with SMTP id
 ge10-20020a05621427ca00b0068fe43da253mr3689819qvb.2.1708794454214; Sat, 24
 Feb 2024 09:07:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
 <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com> <SN6PR02MB41575CFBC54C46701110703CD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41575CFBC54C46701110703CD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 24 Feb 2024 22:37:19 +0530
Message-ID: <CAGtprH-7SYCBjrck2k7vTtHrWbkdhkOicuM9Yz900xuKHMh1vA@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: Michael Kelley <mhklinux@outlook.com>
Cc: Alexander Graf <graf@amazon.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"rientjes@google.com" <rientjes@google.com>, "seanjc@google.com" <seanjc@google.com>, 
	"erdemaktas@google.com" <erdemaktas@google.com>, "ackerleytng@google.com" <ackerleytng@google.com>, 
	"jxgao@google.com" <jxgao@google.com>, "sagis@google.com" <sagis@google.com>, 
	"oupton@google.com" <oupton@google.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"pgonda@google.com" <pgonda@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, "corbet@lwn.net" <corbet@lwn.net>, "hch@lst.de" <hch@lst.de>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:56=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Alexander Graf <graf@amazon.com> Sent: Thursday, February 15, 2024 =
1:44 AM
> >
> > On 15.02.24 04:33, Vishal Annapurve wrote:
> > > On Wed, Feb 14, 2024 at 8:20=E2=80=AFPM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > >> On Fri, Jan 12, 2024 at 05:52:47AM +0000, Vishal Annapurve wrote:
> > >>> Modify SWIOTLB framework to allocate DMA memory always from SWIOTLB=
.
> > >>>
> > >>> CVMs use SWIOTLB buffers for bouncing memory when using dma_map_* A=
PIs
> > >>> to setup memory for IO operations. SWIOTLB buffers are marked as sh=
ared
> > >>> once during early boot.
> > >>>
> > >>> Buffers allocated using dma_alloc_* APIs are allocated from kernel =
memory
> > >>> and then converted to shared during each API invocation. This patch=
 ensures
> > >>> that such buffers are also allocated from already shared SWIOTLB
> > >>> regions. This allows enforcing alignment requirements on regions ma=
rked
> > >>> as shared.
> > >> But does it work in practice?
> > >>
> > >> Some devices (like GPUs) require a lot of DMA memory. So with this a=
pproach
> > >> we would need to have huge SWIOTLB buffer that is unused in most VMs=
.
> > >>
> > > Current implementation limits the size of statically allocated SWIOTL=
B
> > > memory pool to 1G. I was proposing to enable dynamic SWIOTLB for CVMs
> > > in addition to aligning the memory allocations to hugepage sizes, so
> > > that the SWIOTLB pool can be scaled up on demand.
> > >
>
> Vishal --
>
> When the dynamic swiotlb mechanism tries to grow swiotlb space
> by adding another pool, it gets the additional memory as a single
> physically contiguous chunk using alloc_pages().   It starts by trying
> to allocate a chunk the size of the original swiotlb size, and if that
> fails, halves the size until it gets a size where the allocation succeeds=
.
> The minimum size is 1 Mbyte, and if that fails, the "grow" fails.
>

Thanks for pointing this out.

> So it seems like dynamic swiotlb is subject to the almost the same
> memory fragmentation limitations as trying to allocate huge pages.
> swiotlb needs a minimum of 1 Mbyte contiguous in order to grow,
> while huge pages need 2 Mbytes, but either is likely to be
> problematic in a VM that has been running a while.  With that
> in mind, I'm not clear on the benefit of enabling dynamic swiotlb.
> It seems like it just moves around the problem of needing high order
> contiguous memory allocations.  Or am I missing something?
>

Currently the SWIOTLB pool is limited to 1GB in size.  Kirill has
pointed out that devices like GPUs could need a significant amount of
memory to be allocated from the SWIOTLB pool. Without dynamic SWIOTLB,
such devices run the risk of memory exhaustion without any hope of
recovery.

In addition, I am proposing to have dma_alloc_* APIs to use the
SWIOTLB area as well, adding to the memory pressure. If there was a
way to calculate the maximum amount of memory needed for all dma
allocations for all possible devices used by CoCo VMs then one can use
that number to preallocate SWIOTLB pool. I am arguing that calculating
the maximum bound would be difficult and instead of trying to
calculate it, allowing SWIOTLB to scale dynamically would be better
since it provides better .

So if the above argument for enabling dynamic SWIOTLB makes sense then
it should be relatively easy to append hugepage alignment restrictions
for SWIOTLB pool increments (inline with the fact that 2MB vs 1MB size
allocations are nearly equally prone to failure due to memory
fragmentation).

> Michael
>
> > > The issue with aligning the pool areas to hugepages is that hugepage
> > > allocation at runtime is not guaranteed. Guaranteeing the hugepage
> > > allocation might need calculating the upper bound in advance, which
> > > defeats the purpose of enabling dynamic SWIOTLB. I am open to
> > > suggestions here.
> >
> >
> > You could allocate a max bound at boot using CMA and then only fill int=
o
> > the CMA area when SWIOTLB size requirements increase? The CMA region
> > will allow movable allocations as long as you don't require the CMA spa=
ce.
> >
> >
> > Alex
>

