Return-Path: <linux-kernel+bounces-166811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111BE8B9FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D801DB20BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21217107D;
	Thu,  2 May 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgVlICbS"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B1171066
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672486; cv=none; b=BMXi1ET9RS7nq93I+xqelXbOqj9HpFF3Dp+XwIFhGvQLEjtaiafMf/G/6olIB9e+SytkIoUvxVpTG2FCxJ9cccj+kTt5Tla6hL0ks6N60UhP2wBHAG5hfkNwJe90X0RmaInK5eczTUKV+pF645XMM9AZaH0wisukhQXX6ZPXf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672486; c=relaxed/simple;
	bh=ogZd0FRc82N0nj2WvY4uzGpHblO+NctTzdz8d8+QKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7dX3ZcG9t3vwk6kH2bwHeZ7eNn5UAxxSCKhETuWGGI/jZcRGIuLs2MzgF+aPZjqfelHk6eTHZVLur1g8mLGzmN3scpwyLb7APfjwBNAqfLievRNJ5JzwAkng0jBlgR9b9/gZd24kJY4ldiuOUPN/kmpI18Pl2vf21q3GhSCYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgVlICbS; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de603e3072dso4911263276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714672484; x=1715277284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP6MGByyG7+VK/zgP1Njy0ijgfu1MUzm+kYaZyW4en4=;
        b=PgVlICbSrXhQLrleYfw1CmnrPy4ILchpfQA23etham5Y0AB2Q9O63WxjxK8l//3zUu
         M/mibwsOFRMhpLij9r+c11SJGabkjw2G4v2dLGVGCA+vT2d4Oa5+BYiyeg3gHj6tDEjT
         tjjgniIypzWKCbIb2CmNsW7vBooVLdrFEMVrejvRPk+yTZsJ5Ng4IRRmaswDYIroklc3
         OmLdKUEq+QnuFqaiP5Th2tRraX4SC0vjnN2XCa2cDTitYGo6p0RWXRBAqkNAAJuVOLuo
         ga/3mbDyQ6KPqH2oHjW1hJjZFRL2K9gP/TSGOkUedegSuKqtaXZfxtLiiptM20HZDQJ5
         jkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672484; x=1715277284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP6MGByyG7+VK/zgP1Njy0ijgfu1MUzm+kYaZyW4en4=;
        b=EypKdGLDUsi30fnl3TfL0Jgg9khQ3ri1A1ZTILvTJu46O6XdbaWOBVTa4qJfhejKE8
         b2mr79skDCWzRwrkbFbwU8LOeuUlynMs0TPXKDCWfxq8LYp3pPcCBYh2IXYilSU2FQpz
         LRHXmVlz7+AJ0z06/Kyu86/9iNduqfhocGHuZNH1ahmbxKT1hWvTrBgDhBSrIhqPSk6b
         tbrWx+/jxqNXTcXFtCghu1LYQD/UplV5W1lIjR/1G/PySOP3KBhXTmIhsOaFsXS7g68C
         Lpbag2RoZSY+jkh7pUUJWmYME3BSu4xj1J8HMIAT5Bt0KWJluoi8ysnmggODY/LEoMS8
         kLVA==
X-Forwarded-Encrypted: i=1; AJvYcCUQoIm1ul2HqTTCfZGBLMtwI9tqOgy40PrfTC50FROn5jgaRJATZyB03YMTG3BgPwKO4kGFpMt5i/5ZQ9c/C9hFKHF4tHKtunT0LMlv
X-Gm-Message-State: AOJu0YyFU7pueoQVTitht0qMeR8lI/oi9+/010ix3XclnPZ33ggII48b
	8UwBs7+iwmEdAg80m5buQ19g0Zx2AvoMPdMjUofA+g0B2SxPk/yPV5AgUrETA935ucdveleow1j
	UY7lACU/EzmBfwvX/iK0zMJdA3qfdjt9CMP4s
X-Google-Smtp-Source: AGHT+IGgjgZKcpfdVpikqbevhWUfXhovR7ypGe+DVObEa/V8YqXCpYObxL8972JZ7bdk6TOSG601qmJCijpY8IP/rVg=
X-Received: by 2002:a05:6902:1828:b0:de5:9ec3:6475 with SMTP id
 cf40-20020a056902182800b00de59ec36475mr637569ybb.31.1714672483338; Thu, 02
 May 2024 10:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501201319.586289-1-tjmercier@google.com> <ZjMfl2G377qexhi-@infradead.org>
 <b4b11ebb-4e42-402c-8e9e-48eb57ef34d5@arm.com> <CABdmKX1+MyJCwgbpYaZn5uLdqgfJbv_5iCX_3cmpL1UaqeggEA@mail.gmail.com>
 <ccb525ff-d0d0-44b1-a210-14c7670b80f0@arm.com>
In-Reply-To: <ccb525ff-d0d0-44b1-a210-14c7670b80f0@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 2 May 2024 10:54:31 -0700
Message-ID: <CABdmKX1HdXccWp9chz-Y_-Hh5TPry-4WRcVf4fUXKV=Og3dVTg@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:54=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 02/05/2024 5:02 pm, T.J. Mercier wrote:
> > On Thu, May 2, 2024 at 5:50=E2=80=AFAM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >>
> >> On 02/05/2024 6:07 am, Christoph Hellwig wrote:
> >>> On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
> >>>> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, b=
ut
> >>>> checking if force_bounce is set for the device is not part of that
> >>>> condition. Check if devices have requested to force SWIOTLB use as p=
art
> >>>> of deciding to take the existing SWIOTLB paths.
> >>>
> >>> This fails to explain why you'd want this somewhat surprising behavio=
r,
> >>> and why you consider it a bug fix.
> >>
> >> Indeed, it's rather intentional that the "swiotlb=3Dforce" argument
> >> doesn't affect iommu-dma, since that's primarily for weeding out drive=
rs
> >> making dodgy assumptions about DMA addresses, and iommu-dma is
> >> inherently even better at that already.
> >>
> >> Beyond that I think this change also seems likely to interact badly wi=
th
> >> CC_ATTR_GUEST_MEM_ENCRYPT on x86, where we invoke the SWIOTLB_FORCE fl=
ag
> >> for dma-direct, but expect that an IOMMU can provide a decrypted view
> >> in-place, thus bouncing in that path would be unnecessarily detrimenta=
l.
> >>
> >> Thanks,
> >> Robin.
> >
> > I encountered this while testing a change to DMA direct which makes
> > sure that sg_dma_mark_swiotlb is called there like it is here. (Right
> > now the SG_DMA_SWIOTLB flag is set only if dma_map_sgtable takes the
> > IOMMU path, but not if SWIOTLB is used on the direct path.) While I
> > agree IOMMU + force_bounce is an unusual config, I found it equally
> > surprising that swiotlb=3Dforce wasn't doing what is advertised, or eve=
n
> > giving a warning/error. Since the iommu-dma code is already set up for
> > conditionally bouncing through SWIOTLB, it looked straightforward to
> > give what's asked for in the case of swiotlb=3Dforce. If it's
> > intentional that SWIOTLB options don't affect IOMMU code, then should
> > we just warn about it here when it's ignored? The presence of a
> > warning like that would also be a suggestion of, "you probably don't
> > actually want what you're asking for with this configuration you've
> > specified".
>
> Traditionally, user-facing "SWIOTLB" refers to what is now dma-direct,
> in its context of bouncing to make DMA mappings accessible to devices
> with memory access limitations. The fact that the IOMMU implementations
> (originally Intel, now iommu-dma) also co-opted some of the SWIOTLB
> machinery for the very different purpose of isolation of memory
> *outside* non-page-aligned DMA mappings was always more of an internal
> implementation detail.
>
> The newest use for enforcing non-coherent cacheline alignment blurs the
> boundary a little since its purpose is again largely orthogonal to those
> cases, however it's also one to which "swiotlb=3Dforce" is semantically
> kind of meaningless once you think about it (how does one forcibly align
> a buffer which is already suitably aligned?)
>
> If there's any issue here I'd say it's only that the description in
> kernel-parameters.txt still hasn't been updated since "automatically
> used by the kernel" *did* solely imply a device DMA mask limitation.

Ok I think clarifying SWIOTLB as it applies to dma-direct (and not any
of the other uses you've mentioned above) would do it. This?

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index 213d0719e2b7..84c582ac246c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6486,6 +6486,7 @@
                                 to a power of 2.
                        force -- force using of bounce buffers even if they
                                 wouldn't be automatically used by the kern=
el
+                                where a hardware IOMMU is not involved
                        noforce -- Never use bounce buffers (for debugging)

        switches=3D       [HW,M68k,EARLY]
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst
b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..066b4bc81583 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardware IO=
MMU:
       Always panic when IOMMU overflows.

 iommu options only relevant to the software bounce buffering (SWIOTLB) IOM=
MU
-implementation:
+implementation where a hardware IOMMU is not involved:

     swiotlb=3D<slots>[,force,noforce]
       <slots>

