Return-Path: <linux-kernel+bounces-49923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA0F84718E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8931B26281
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55313E214;
	Fri,  2 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Wb5YEzuU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66F5F484
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882385; cv=none; b=VuMgPhPPVlcmRzvi4TN/Pw8ZlZZjU/e9GoSAK1ka81GbTLKbbm6jt4gVF/E1UV9i2tkCDksEQErXyZ2PwCLiFb88nZE0JdZO5YAk2421NfeHCEXkBht1bfMC7NzcJ+E0Kthc8kge+Kw4TOZkSL6zPQBjZcED171KtexKH/E7gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882385; c=relaxed/simple;
	bh=nG2w+GdxxM5hnsgpMe1g1sWvqXa3ayNu93KD73uSF5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5Qf9t0HO3aGSFrSE09ly4XzxdW80pcATnb1BB+Te9bEUFiqceMGcQGUC8R4bUemr1DdYs2CnhkndBlOiJ3RqRDLYB8yKRY+mN/PWhwESCWqxEO8sdw9PcuMs5aow7DLjTCOFqHsuCp1x3Sm+LlAYXPb8ZBODMHXYtd1i+t5smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Wb5YEzuU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so264950066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706882381; x=1707487181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsd1oFRL/hQRfRRIZYMjRwiDevMfHf6kHBDWfg5SJq4=;
        b=Wb5YEzuUlhIhz1kjm4mpHbRukJhe3DnlQAuYRqvace71d46dkdp/+TV3cmLab47PCW
         ezRcrBCZ/15bIOETeFwvu/MVBX24q0Vnp2RR8Ia4p+zlLYAZqgFydXRHib5QxWPXwCiU
         FfOiTf55b3V4aMQl94YfrBa4Zze4tZ/smjRT124wcz/GMZHvBfcMHNXAAduk4gOT/430
         AEGq9Ryd7VkYdnSqYUK4PvGIIMppmqFkttXcel7U2DcGm7A1tBOIwsqFG4+C8YJxgmRW
         rmYIAa507DnyGcmWXhxT2oeNnI+CisnV+ZmEPNbmx32oLA5fQ22eWCMs3AYiJmIKkDg/
         64/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882381; x=1707487181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsd1oFRL/hQRfRRIZYMjRwiDevMfHf6kHBDWfg5SJq4=;
        b=doWjoBoatKlNma9zWAIJGXvqt+NRDpEgWpNfH3ia4yzib4f2BvoIGuT6j6GCCrNTqc
         3UkXsrLR+0zLkjvFDLjj9g5qTHRBBUDJL3ENJZwC72r598cx2FYu/WyTE5/jjHahcUFg
         3UKkIR2IZp8wvT+nsJSgSZVlo2HEaI06m3yHHGxtZSjGcggY5ng2YehjGY8TylSySmoH
         zCa3jFjBFt/KTc8yoLvL8rBVjZsU+cfVrmzaSOyqQJbrBq6VJl+LYnpoK1hIl687LnBX
         2JztgQSAimVG3B6Hc5Af9XkVcG00p/BHDTpKoS+L7uviIoGAwGjvYG5g3tLBZzO35gP0
         U7pQ==
X-Gm-Message-State: AOJu0Yw5veMbFD17US3wUXeZbplm5N05IwG27HhJs+ceOHAttwf1wDwx
	zjdcxhRZFkNVwoHIeqNrhvQJfUUuJ7SPKJ/TTJDC/jcEsop/o6mXIGvxgeGBC/+H81F1ZJ+dRUm
	lanLw2EN4X558JLUYwr7R8v5NPueaA8cmtPMx3A==
X-Google-Smtp-Source: AGHT+IEx6KwZdHeL4vfuml8EM/pMs5DP8BgF9ada7x/CUU4TshTl3s5cSoTdlMrfXhLTWts2TRMxqb5Ma/1X+QW9H2E=
X-Received: by 2002:a17:906:e48:b0:a35:7b14:dc50 with SMTP id
 q8-20020a1709060e4800b00a357b14dc50mr5508275eji.17.1706882381431; Fri, 02 Feb
 2024 05:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202135030.42265-1-csd4492@csd.uoc.gr>
In-Reply-To: <20240202135030.42265-1-csd4492@csd.uoc.gr>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 2 Feb 2024 14:59:30 +0100
Message-ID: <CAHVXubioUY=vvQrLrcb+5aWav5WUdpJ3i0fCKP_xx0ASU30g=A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sparsemem: warn on out-of-bounds initialization
To: Dimitris Vlachos <csd4492@csd.uoc.gr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org, arnd@arndb.de, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitris,

On Fri, Feb 2, 2024 at 2:50=E2=80=AFPM Dimitris Vlachos <csd4492@csd.uoc.gr=
> wrote:
>
> From: Dimitris Vlachos <dvlachos@ics.forth.gr>
>
> Hello all
>
> I am sending this email with regards to a bug that I discovered in the Sp=
arse Memory Model configuration and more specifically, the Virtual Memory M=
ap optimization. Moreover, I would like to inquire about possible ways of f=
ixing it.
>
> I work as a pre-graduate research assistant at ICS-FORTH in the Computer =
Architecture and VLSI Systems laboratory.
> We were running some tests in our prototype hardware (RISC-V), where we n=
oticed that the Kernel crashes early in the boot process with the following=
 setup:
>
> We are using the default Kconfig configurations (defconfig) that includes=
 Sparse Memory + Virtual Memory Map.
> The DRAM base address of our system is : 0x800000000000
> A 3-level page table is used (Sv39).
>
> When the vmemmap optimization is enabled the macro pfn_to_page() is calle=
d, which offsets the vmemmap with the pfn argument to acquire a struct page=
 pointer.
>
> As our DRAM starts at 0x800000000000, the initial pfn will be 0x800000000=
000 divided by PAGE_SIZE. The calculation result will be:
> 0xffffffcf00000000 (vmemmap start) +  (0x800000000 (pfn) * 64 (sizeof(str=
uct page))
>
> This causes an overflow as the number is very large, the resulting addres=
s is 0x1c700000000 which is not a valid Sv39 address (all bits above bit 38=
 should be set) and does not belong to the kernel=E2=80=99s virtual address=
 space.
>
> The same will happen with all valid pfns as the memory is being initializ=
ed. When the Kernel will try to access a page using pfn_to_page, a page fau=
lt will occur crashing the system.
> It should be noted that when the vmemmap is disabled the system boots nor=
mally.
>
> However, I would like to emphasize another important detail. When the DRA=
M base is small enough to avoid an overflow, the virtual memory map mapping=
s will be initialized out of bounds with regard to the vmemmap address spac=
e which is 4GiB in Sv39.
> The system will not crash, but the address space used for this purpose wi=
ll be outside of the designated range.
>
> Everything mentioned above holds true when Sv48 is used as well. Given a =
high enough DRAM base the system will either crash or perform false initial=
izations. Given the fact that virtual memory map is not only used by RISC-V=
 systems, this could be an issue for other architectures as well.
>
> The kernel already contains mminit_validate_memmodel_limits() that checks=
 memory limits.
> However, it only checks physical memory ranges. I added a few checks, pro=
vided that virtual memory map is enabled, to determine whether offset start=
 and offset end fall inside the range of virtual memory map. Otherwise, a w=
arning will be printed.
>
> Finally, I would like to ask you for any information/advice that could he=
lp me fix/prevent the issues that I mentioned (if it=E2=80=99s possible) or=
 recover from them at runtime by disabling the optimization and reverting b=
ack to the non-vmemmap mappings.
>
> Thank you in advance.
> Best regards,
> Dimitris Vlachos
> ---
>  mm/sparse.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 338cf946d..33b57758e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -149,6 +149,26 @@ static void __meminit mminit_validate_memmodel_limit=
s(unsigned long *start_pfn,
>                 WARN_ON_ONCE(1);
>                 *end_pfn =3D max_sparsemem_pfn;
>         }
> +
> +       /*check vmemmap limits*/
> +       #ifdef CONFIG_SPARSEMEM_VMEMMAP
> +
> +       unsigned long vmemmap_offset_start =3D (unsigned long) pfn_to_pag=
e(*start_pfn);
> +       unsigned long vmemmap_offset_end   =3D (unsigned long) pfn_to_pag=
e(*end_pfn);
> +
> +       if (vmemmap_offset_start < VMEMMAP_START) {
> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> +                       "Start of range %lu -> %lu exceeds bounds of SPAR=
SEMEM virtual memory map address range %lu -> %lu\n",
> +                       vmemmap_offset_start, vmemmap_offset_end, VMEMMAP=
_START,VMEMMAP_END);
> +               WARN_ON_ONCE(1);
> +
> +       } else if (vmemmap_offset_end > VMEMMAP_END ) {
> +               mminit_dprintk(MMINIT_WARNING, "pfnvalidation",
> +                       "End of range %lu -> %lu exceeds bounds of SPARSE=
MEM virtual memory map address range %lu -> %lu\n",
> +                       vmemmap_offset_start, vmemmap_offset_end, VMEMMAP=
_START,VMEMMAP_END);
> +               WARN_ON_ONCE(1);
> +       }
> +       #endif
>  }
>
>  /*
> --
> 2.39.2
>

Since struct pages are only available for memory,  we could offset
vmemmap so that VMEMMAP_START actually points to the first pfn?

