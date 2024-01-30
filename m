Return-Path: <linux-kernel+bounces-44968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C690A8429C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E91F22BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069531272AE;
	Tue, 30 Jan 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MugvDlVl"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D376D1C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632992; cv=none; b=BXhF24Be/vlVyoGSUoxtvHgF9uUdPcf0JJ+Zrn5JIbicBqJ8ke3/L3m9QCV5i9z6X3MY4Xy/lZp/TvtbuzS7iaTUEDgiURijxaiIhHb6pEUkuOru5J8FtDicVrui8fc5zPCl/Dd34GJC7dy14u7pCZNfajkxfsL4hMFpz5jYBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632992; c=relaxed/simple;
	bh=Kb5PrKiPOgqplZ89pZOWEqk6h7d4LV1jujZTZpIvh4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMua9FcqTPvZHTQ5KMfG/35Ih1P0GMJq7ftjzxENLsfiSFYzW3Ut7OemX7RTTZqL+TLkyhSpp/S8sK/Ydwe6AL+Fum5pQm3lVS3Zo3CT/dQDuG/SspY7zBepzIyrgfKCmMHRVyqOqqh8bm7FHDV8rFIAHKs8jmYaHu0eLUgKdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MugvDlVl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783d8e09a1cso289692685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706632988; x=1707237788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afivU5ukzroUUjSv6dIA62TuQmhqdbJqObxkN1yxecQ=;
        b=MugvDlVlZLtW/G5tvOzPTEt9ykfYuWP4urDZ884dtqyo5JInFIAaDLiY2LWC63pTBR
         fQNXPcoZvCUYmhTuAt2KOgvPqBvq18uEGHAb1uck3cXHZNfoxIrVA7Y375TGN4/rWzD6
         aRC80FM2GJCPFYI+qFLLX8zraZBdjXSAGlEkk2reYzbGYFcFCyoJc8fdGppGm/Ryqh+x
         qfhxvrc5URf4f2hIxFIdTRcttwvqywJkM6YPbcH9HtZMEAD1ea6CKodkm3kxxAoW9mKR
         Y9HwJV2Erre4Gsm8nZqkO0NKzFTL/Nkg3C8D8+nEZ4nso7f0ATw6nVoX7ieEPYyhoDqA
         XdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632988; x=1707237788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afivU5ukzroUUjSv6dIA62TuQmhqdbJqObxkN1yxecQ=;
        b=WP5jaMoP6K1+NqmGkuGS5zaeqTCJ1OJ97nyqGwIBAp6eXHTo3Chp0sT35kyExmuQIc
         yUxnh8ttnVyVqdAaHOET/LzcsiPZjh6ZfwXpGuMKa1ooacZv6RQd92f03Tc2YSX77Cd8
         RjILAKQqnpDkDjpcCfigggUveP3OmnaIQy74GE1CG//hDz4SGsS9o/HdoDazB0X4ALbw
         TwGsoaaV84KE2z1ZOLyh88SDIkL37lEuaBnr7wSjq1wU4Mw0uhrk2UrawXFT2TFN2jY1
         Vv4PTUEak3bG5ITn130Buq0L77cxTqW0OPENqEueDUsTSlury01w1AeETfEc3DRpRpin
         08Mw==
X-Gm-Message-State: AOJu0YzC7FiW/KrHj3/2jHRBaKexwU55WyKRi1llNQWPOVAmnXDjEUds
	XFFULOOGS3RbGnqzoAcmuKtP3dA9HosvZTPH2MqpmnoSF2PtSxJlXwQYI/GpH/QnYYMwe343mzj
	f3jKTT/kdvxsbywT3RAW6N+tVDVnQtQfC55/0
X-Google-Smtp-Source: AGHT+IGCcD7PVaq/cz09ZQVjo9JbEtUXpAooRm0ZDYVkjI4/fdo/VvkMg1PDcsBy+2LIz+Ukv1U3YQPLDOpR5Jivfxc=
X-Received: by 2002:a05:6214:194e:b0:685:4bd7:8bb3 with SMTP id
 q14-20020a056214194e00b006854bd78bb3mr9344578qvk.2.1706632987877; Tue, 30 Jan
 2024 08:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 30 Jan 2024 22:12:54 +0530
Message-ID: <CAGtprH9FA3-RetE=6i7ezxfV0qEV-8z3HLgPEPY=pzuxSiOD+w@mail.gmail.com>
Subject: Re: [RFC V1 0/5] x86: CVMs: Align memory conversions to 2M granularity
To: x86@kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, 
	petrtesarik@huaweicloud.com, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: pbonzini@redhat.com, rientjes@google.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, peterx@redhat.com, vkuznets@redhat.com, 
	dmatlack@google.com, pgonda@google.com, michael.roth@amd.com, 
	kirill@shutemov.name, thomas.lendacky@amd.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:22=E2=80=AFAM Vishal Annapurve <vannapurve@googl=
e.com> wrote:
>
> Goal of this series is aligning memory conversion requests from CVMs to
> huge page sizes to allow better host side management of guest memory and
> optimized page table walks.
>
> This patch series is partially tested and needs more work, I am seeking
> feedback from wider community before making further progress.
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Confidential VMs(CVMs) support two types of guest memory ranges:
> 1) Private Memory: Intended to be consumed/modified only by the CVM.
> 2) Shared Memory: visible to both guest/host components, used for
> non-trusted IO.
>
> Guest memfd [1] support is set to be merged upstream to handle guest priv=
ate
> memory isolation from host usersapace. Guest memfd approach allows follow=
ing
> setup:
> * private memory backed using the guest memfd file which is not accessibl=
e
>   from host userspace.
> * Shared memory backed by tmpfs/hugetlbfs files that are accessible from
>   host userspace.
>
> Userspace VMM needs to register two backing stores for all of the guest
> memory ranges:
> * HVA for shared memory
> * Guest memfd ranges for private memory
>
> KVM keeps track of shared/private guest memory ranges that can be updated=
 at
> runtime using IOCTLs. This allows KVM to back the guest memory using eith=
er HVA
> (shared) or guest memfd file offsets (private) based on the attributes of=
 the
> guest memory ranges.
>
> In this setup, there is possibility of "double allocation" i.e. scenarios=
 where
> both shared and private memory backing stores mapped to the same guest me=
mory
> ranges have memory allocated.
>
> Guest issues an hypercall to convert the memory types which is forwarded =
by KVM
> to the host userspace.
> Userspace VMM is supposed to handle conversion as follows:
> 1) Private to shared conversion:
>   * Update guest memory attributes for the range to be shared using KVM
>     supported IOCTLs.
>     - While handling this IOCTL, KVM will unmap EPT/NPT entries correspon=
ding
>       to the guest memory being converted.
>   * Unback the guest memfd range.
> 2) Shared to private conversion:
>   * Update guest memory attributes for the range to be private using KVM
>     supported IOCTLs.
>     - While handling this IOCTL, KVM will unmap EPT/NPT entries correspon=
ding
>       to the guest memory being converted.
>   * Unback the shared memory file.
>
> Note that unbacking needs to be done for both kinds of conversions in ord=
er to
> avoid double allocation.
>
> Problem
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> CVMs can convert memory between these two types at 4K granularity. Conver=
sion
> done at 4K granularity causes issues when using guest memfd support
> with hugetlb/Hugepage backed guest private memory:
> 1) Hugetlb fs doesn't allow freeing subpage ranges when punching holes,
> causing all the private to shared memory conversions to result in double
> allocation.
> 2) Even if a new fs is implemented for guest memfd that allows splitting
> hugepages, punching holes at 4K will cause:
>    - loss of vmemmmap optimization [2]
>    - more memory for EPT/NPT entries and extra pagetable walks for guest
>      side accesses.
>    - Shared memory mappings to consume more host pagetable entries and
>      extra pagetalble walks for host side access.
>    - Higher number of conversions with additional overhead of VM exits
>      serviced by host userspace.
>
> Memory conversion scenarios in the guest that are of major concern:
> - SWIOTLB area conversion early during boot.
>    * dma_map_* API invocations for CVMs result in using bounce buffers
>      from SWIOTLB region which is already marked as shared.
> - Device drivers allocating memory using dma_alloc_* APIs at runtime
>   that bypass SWIOTLB.
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> To counter above issues, this series proposes following:
> 1) Use boot time allocated SWIOTLB pools for all DMA memory allocated
> using dma_alloc_* APIs.
> 2) Increase memory allocated at boot for SWIOTLB from 6% to 8% for CVMs.
> 3) Enable dynamic SWIOTLB [4] by default for CVMs so that SWITLB can be
> scaled up as needed.
> 4) Ensure SWIOTLB pool is 2MB aligned so that all the conversions happen =
at
> 2M granularity once during boot.
> 5) Add a check to ensure all conversions happen at 2M granularity.
>
> ** This series leaves out some of the conversion sites which might not
> be 2M aligned but should be easy to fix once the approach is finalized. *=
*
>
> 1G alignment for conversion:
> * Using 1G alignment may cause over-allocated SWIOTLB buffers but might
>   be acceptable for CVMs depending on more considerations.
> * It might be challenging to use 1G aligned conversion in OVMF. 2M
>   alignment should be achievable with OVMF changes [3].
>
> Alternatives could be:
> 1) Separate hugepage aligned DMA pools setup by individual device drivers=
 in
> case of CVMs.
>
> [1] https://lore.kernel.org/linux-mips/20231105163040.14904-1-pbonzini@re=
dhat.com/
> [2] https://www.kernel.org/doc/html/next/mm/vmemmap_dedup.html
> [3] https://github.com/tianocore/edk2/pull/3784
> [4] https://lore.kernel.org/lkml/20230908080031.GA7848@lst.de/T/
>
> Vishal Annapurve (5):
>   swiotlb: Support allocating DMA memory from SWIOTLB
>   swiotlb: Allow setting up default alignment of SWIOTLB region
>   x86: CVMs: Enable dynamic swiotlb by default for CVMs
>   x86: CVMs: Allow allocating all DMA memory from SWIOTLB
>   x86: CVMs: Ensure that memory conversions happen at 2M alignment
>
>  arch/x86/Kconfig             |  2 ++
>  arch/x86/kernel/pci-dma.c    |  2 +-
>  arch/x86/mm/mem_encrypt.c    |  8 ++++++--
>  arch/x86/mm/pat/set_memory.c |  6 ++++--
>  include/linux/swiotlb.h      | 22 ++++++----------------
>  kernel/dma/direct.c          |  4 ++--
>  kernel/dma/swiotlb.c         | 17 ++++++++++++-----
>  7 files changed, 33 insertions(+), 28 deletions(-)
>
> --
> 2.43.0.275.g3460e3d667-goog
>

Ping for review of this series.

Thanks,
Vishal

