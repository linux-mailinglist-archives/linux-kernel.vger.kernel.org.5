Return-Path: <linux-kernel+bounces-49228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9870846768
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53620286146
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE9F9D8;
	Fri,  2 Feb 2024 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="1b4yfjEI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA26F9C6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850558; cv=none; b=D7YK0gA5XmEzx2So85KHvAHfSRABEVtNBfgU+CCLe660I3p4zKgfQC8eeN8FJyTpZTrC88C8yp2viooMI7KRpSMHSPkXpziRyzAq5TkvJVQcavB0dVllvS70N65Xugz/c3rsrWUKuzUZfHfwfD+4HsjGxQIwNZhiGnpQgIMjKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850558; c=relaxed/simple;
	bh=IwSPoXQuyxe1M4mU3zWrlMIYo0JqJj3p+K+iNyeCeec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWsJ8nll1z/4hDr0hgj2lnUAH/1xSC0vgn+yiQrGGlYagA0X8N23GBUVhiUUsmfS00eRppQGvTc42NqrtvpzxhRJR+XKnZdjEJ/D36F19C2XA9DapJ6z8MQOdaLZQ2KHNr7P+j/iGtR6WTLX1/Sot0Jlx0EJk8/Aw1BzP0Edbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1b4yfjEI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30f7c9574eso238427566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 21:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706850554; x=1707455354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtiSDr91nHjFx+mbNBiaNG8pmkuLga0XeArA/qq1CH0=;
        b=1b4yfjEIP+eRH6XCpklnZWQusQ11iel6ld8TwZp4vCQ9TT7bUPO6+92kJrmX7Pc9SH
         2aI7rj/0ntcXlQBBE4lgK8FVeiQsJ4Jk+wO9X7PKElAC7BdzefmleYueEbiTIQgrf0HE
         pTA3vdJUXV1Ahlr8yGEfDsd/WEYnBi4ZkSniqjd2JLyiMR9eRZzQuSUHBVIxju0lwBQ4
         NTDtkcFoyJSoOX5QCIUjHtdMO/Znxf8pVmhPyqdCv3PWrzF3m4HR4JBTPbohMK200dfr
         D6a8YFLIeWXYnMKZQjgTWAwiz7TH8FgbZvnyN6qXYICMDMG2L5PNVn9Fprb9EUV67BzG
         /Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706850554; x=1707455354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtiSDr91nHjFx+mbNBiaNG8pmkuLga0XeArA/qq1CH0=;
        b=MCigbAhg/u1P5jbGKGU5ux09opN5NnEZv8sBtZRbUFkfm1+wz/7In31j3/8qzm8i1r
         gv3EjQhEZCfeSwRCtBkZkbQRhbbR/UfRaK0/aVdyUhewkH65jOlRcf/iaRWqGSroPnvA
         6y/IZSKrBmB0EqtFzNUL2K1Vo2vhm71URdxw4UbrCtADpvcujHtP9u0ITA0rU1T9lyin
         VPTy4zizCsPN7vHK2i4BM/GZ4j4OveqmE7+2T9GZLJPiU0wVvt30usdTE+foQ0r0PdUY
         oTNS860lJUtS4dFViMZjuip7/reJUwD1Hz/Dd0Qpt13NVfaT20O5tDe5bvt7HZktUz24
         eeNw==
X-Gm-Message-State: AOJu0Yw8MmWz5OkTgQUGKz5DJYeTfBY3r/2VOHBrjGg4g/Q2QIHlJ67E
	51li5TjEECw9sDkNqMTt55AcwbVleh/LtVzDIqBUoEKnHJC83NKHJ/Qa3erAp5x0dbSq6yjr7X2
	/p2MHiPAf8y1T7L0cNzy43ZuUdawhKQQqbKC+
X-Google-Smtp-Source: AGHT+IFAhP4nbEq6f4+/HS+4EkFhW0QtP4rSe2IhTkJPqr2Q/GBWsEgKmLELHG5FfY19HZmO1FSjSEU7RWGS2yriM+s=
X-Received: by 2002:a17:906:4890:b0:a35:4a82:2046 with SMTP id
 v16-20020a170906489000b00a354a822046mr2819813ejq.24.1706850553602; Thu, 01
 Feb 2024 21:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com> <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
 <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
In-Reply-To: <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 2 Feb 2024 10:38:58 +0530
Message-ID: <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com>
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, rientjes@google.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, peterx@redhat.com, vkuznets@redhat.com, 
	dmatlack@google.com, pgonda@google.com, michael.roth@amd.com, 
	kirill@shutemov.name, thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:32=E2=80=AFPM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> On 01/02/2024 04:46, Vishal Annapurve wrote:
> > On Wed, Jan 31, 2024 at 10:03=E2=80=AFPM Dave Hansen <dave.hansen@intel=
com> wrote:
> >>
> >> On 1/11/24 21:52, Vishal Annapurve wrote:
> >>> @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned l=
ong addr, int numpages, bool enc)
> >>>       int ret;
> >>>
> >>>       /* Should not be working on unaligned addresses */
> >>> -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", =
addr))
> >>> -             addr &=3D PAGE_MASK;
> >>> +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n",=
 addr)
> >>> +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
> >>> +                     "misaligned numpages: %#lx\n", numpages))
> >>> +             return -EINVAL;
> >>
> >> This series is talking about swiotlb and DMA, then this applies a
> >> restriction to what I *thought* was a much more generic function:
> >> __set_memory_enc_pgtable().  What prevents this function from getting
> >> used on 4k mappings?
> >>
> >>
> >
> > The end goal here is to limit the conversion granularity to hugepage
> > sizes. SWIOTLB allocations are the major source of unaligned
> > allocations(and so the conversions) that need to be fixed before
> > achieving this goal.
> >
> > This change will ensure that conversion fails for unaligned ranges, as
> > I don't foresee the need for 4K aligned conversions apart from DMA
> > allocations.
>
> Hi Vishal,
>
> This assumption is wrong. set_memory_decrypted is called from various
> parts of the kernel: kexec, sev-guest, kvmclock, hyperv code. These conve=
rsions
> are for non-DMA allocations that need to be done at 4KB granularity
> because the data structures in question are page sized.
>
> Thanks,
> Jeremi

Thanks Jeremi for pointing out these usecases.

My brief analysis for these call sites:
1) machine_kexec_64.c, realmode/init.c, kvm/mmu/mmu.c - shared memory
allocation/conversion happens when host side memory encryption
(CC_ATTR_HOST_MEM_ENCRYPT) is enabled.
2) kernel/kvmclock.c -  Shared memory allocation can be made to align
2M even if the memory needed is lesser.
3) drivers/virt/coco/sev-guest/sev-guest.c,
drivers/virt/coco/tdx-guest/tdx-guest.c - Shared memory allocation can
be made to align 2M even if the memory needed is lesser.

I admit I haven't analyzed hyperv code in context of these changes,
but will take a better look to see if the calls for memory conversion
here can fit the category of "Shared memory allocation can be made to
align 2M even if the memory needed is lesser".

Agree that this patch should be modified to look something like
(subject to more changes on the call sites):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e9b448d1b1b7..8c608d6913c4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2132,10 +2132,15 @@ static int __set_memory_enc_pgtable(unsigned
long addr, int numpages, bool enc)
        struct cpa_data cpa;
        int ret;

        /* Should not be working on unaligned addresses */
        if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr=
))
                addr &=3D PAGE_MASK;

+       if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+               (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address:
%#lx\n", addr)
+                       || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK=
,
+                               "misaligned numpages: %#lx\n", numpages)))
+               return -EINVAL;
+
        memset(&cpa, 0, sizeof(cpa));
        cpa.vaddr =3D &addr;
        cpa.numpages =3D numpages;

