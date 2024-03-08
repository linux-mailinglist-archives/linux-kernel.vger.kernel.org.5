Return-Path: <linux-kernel+bounces-96834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08625876201
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7311C2107E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984054F96;
	Fri,  8 Mar 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndPF7/zD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6E54775
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893864; cv=none; b=WZpx3jb2CF+A+qbUU/1nzkeGomc8VkZV+d1eYCozsvWT8SlATEnacd5tpX13qavJkqCFHkeN+3KfQIKHKJ8bc50XjrmVLXWt+WKMLO4GUCLOUxhEA88NyD6VEhUQk/tVjwCLPDeT0C+IVp+VyIBeGL6QdXNxQV/h9WBSiVP4otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893864; c=relaxed/simple;
	bh=dAawQqpGMvOQdJTjveJ7dkTvcJEXVDv7YD2/kraSALc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgU4/6q+51CFHf+gcZnSrRKnZ6ry1g7i6HHtP1IHfWVDTgkhGVkcfm135u3VXXjycSEQuKAY4OyzWM8f7l7DFt5NBcP0a7VEhhhMZ2GE4CvtG84TggzQTh00Jwm/o2C2rGR4b1jJbSa1S1g2tc9mAjMYIS/achql4foj5KMDjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndPF7/zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D398C43390
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893864;
	bh=dAawQqpGMvOQdJTjveJ7dkTvcJEXVDv7YD2/kraSALc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ndPF7/zD/XR7b2zETk1TUVuHjyWyMjaVo5XqRnG4kCmVN7HK8Z7dH3sR75fQf27Wa
	 DERuPvG14a4w3aGB8WoEFmcfH1uqURpo6rwyTWbE4uEkgWsJTwXluGXoXmocY8w3ga
	 z+xBXqoYgaBLrmiZYTzBJsBm82NKGz5TnGu/TPtiGp4KK/O43GkmZ31AkzoqaUZ7DX
	 nd/B9m4EMQVy88fOS4qRyaI3syyO3TfSSQv0xqN4j3hj5jaG9Nn4SB2JonHNYcfpr6
	 yng2zcERxYXTM/3K1L6gc08HdQFjLrS0Rh/wD3LUcOhgdFE5rPH4FfxKh9iJ4YnA8+
	 7wwN2i+AOakyg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513298d6859so1798494e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc/XTszo1beFb9YD3MhhMWk+PXiWVEkcUNJisjlYN5n5ca5xickgvxvch95wd8rl4esesubhjVJ1vGtEWaPRn6zM23GM2pEnpHo0bg
X-Gm-Message-State: AOJu0Yy+ZTgTt/bCuovkCYPfWrD41zpljLAAP/6rzfnL6V5ZdUqYsiMk
	uhg7XyXP3ZnPOcTEEMnkzp4RMfmExymmk7yzOXBpvgR+XG+crcuUzDxisJvwuhI/z/YCi/zVi2o
	KQEyIlwq/HNKJ9Si0IcYGZix9kkU=
X-Google-Smtp-Source: AGHT+IEnsryAMn+JEcsRTFu1CcowWDNcAbYNNygFOSBWgmFM2OXBsNK1CIqiH5ssKNDqvchWwSL+8Ecft82zzNBeeAY=
X-Received: by 2002:a05:6512:4028:b0:512:f3e7:bcef with SMTP id
 br40-20020a056512402800b00512f3e7bcefmr3921856lfb.51.1709893862306; Fri, 08
 Mar 2024 02:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
In-Reply-To: <20240222202404.36206-1-kevinloughlin@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 8 Mar 2024 11:30:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
Message-ID: <CAMj1kXFsX1HZ3=x1cjN0-7i5EV9LXkSrAW22dc1wERUaTdAMaA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: acdunlap@google.com, alexander.shishkin@linux.intel.com, 
	andrisaar@google.com, bhe@redhat.com, bp@alien8.de, brijesh.singh@amd.com, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, grobler@google.com, 
	hpa@zytor.com, jacobhxu@google.com, jpoimboe@kernel.org, kai.huang@intel.com, 
	linux-kernel@vger.kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	peterz@infradead.org, pgonda@google.com, ross.lagerwall@citrix.com, 
	sidtelang@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org, ytcoode@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 21:25, Kevin Loughlin <kevinloughlin@google.com> wrote:
>
> SEV-SNP requires encrypted memory to be validated before access.
> Because the ROM memory range is not part of the e820 table, it is not
> pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
> to access this range, the guest must first validate the range.
>
> The current SEV-SNP code does indeed scan the ROM range during early
> boot and thus attempts to validate the ROM range in probe_roms().
> However, this behavior is neither necessary nor sufficient.
>
> With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
> attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
> falls in the ROM range) prior to validation. The specific problematic
> call chain occurs during dmi_setup() -> dmi_scan_machine() and results
> in a crash during boot if SEV-SNP is enabled under these conditions.
>
> With regards to necessity, SEV-SNP guests currently read garbage (which
> changes across boots) from the ROM range, meaning these scans are
> unnecessary. The guest reads garbage because the legacy ROM range
> is unencrypted data but is accessed via an encrypted PMD during early
> boot (where the PMD is marked as encrypted due to potentially mapping
> actually-encrypted data in other PMD-contained ranges).
>
> While one solution would be to overhaul the early PMD mapping to treat
> the ROM region of the PMD as unencrypted, SEV-SNP guests do not rely on
> data from the legacy ROM region during early boot (nor can they
> currently, since the data would be garbage that changes across boots).
> As such, this patch opts for the simpler approach of skipping the ROM
> range scans (and the otherwise-necessary range validation) during
> SEV-SNP guest early boot.
>
> Ultimatly, the potential SEV-SNP guest crash due to lack of ROM range
> validation is avoided by simply not accessing the ROM range.
>
> Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
>  arch/x86/include/asm/sev.h   |  2 --
>  arch/x86/kernel/mpparse.c    |  7 +++++++
>  arch/x86/kernel/probe_roms.c | 11 ++++-------
>  arch/x86/kernel/sev.c        | 15 ---------------
>  drivers/firmware/dmi_scan.c  |  7 ++++++-
>  5 files changed, 17 insertions(+), 25 deletions(-)
>

Agree with the analysis and the conclusion. However, this will need to
be split into generic and x86 specific changes, given that the DMI
code is shared between all architectures, and explicitly checking for
SEV-SNP support in generic code is not appropriate.

So what we will need is:
- a generic change that implements a static inline wrapper around
IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK), and wires it up
in  drivers/firmware/dmi_scan.c;
- a x86 specific change that overrides this DMI helper in terms of
cc_platform_has(CC_ATTR_GUEST_SEV_SNP);
- x86 specific changes that deal with the other scanning

Note that this means that Oak based platforms will lose DMI reporting
and DMI-based quirks, but I think this is reasonable.

More feedback below.


> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 5b4a1ce3d368..474c24ba0f6f 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
>                                          unsigned long npages);
>  void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
>                                         unsigned long npages);
> -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
>  void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
>  void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
>  void snp_set_wakeup_secondary_cpu(void);
> @@ -227,7 +226,6 @@ static inline void __init
>  early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
>  static inline void __init
>  early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> -static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
>  static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
>  static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
>  static inline void snp_set_wakeup_secondary_cpu(void) { }
> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index b223922248e9..39ea771e2d4c 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
>                     base, base + length - 1);
>         BUILD_BUG_ON(sizeof(*mpf) != 16);
>
> +       /*
> +        * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> +        * as this memory is not pre-validated and would thus cause a crash.
> +        */
> +       if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
> +               return 0;
> +

Please don't use magic numbers like this, and use memory_intersects()
[unless there is a reason to avoid it which I missed]

Also, really?!? Does modern x86 still rely on scanning arbitrary
regions of memory for magic numbers? Or is this only for those who
prefer vintage boot protocols?

If so, I suppose we might need a generic helper

static inline bool platform_allows_memory_probing(void)

[modulo bikeshedding over the name] where the generic implementation
returns false, and the x86 implementation could take
cc_platform_has(CC_ATTR_GUEST_SEV_SNP) into account, and return true
otherwise.

(On ARM based systems, memory probing is never ok, because the memory
map is not architected, and so probing random addresses might bring
down the machine)

>         while (length > 0) {
>                 bp = early_memremap(base, length);
>                 mpf = (struct mpf_intel *)bp;
> diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> index 319fef37d9dc..84ff4b052fc1 100644
> --- a/arch/x86/kernel/probe_roms.c
> +++ b/arch/x86/kernel/probe_roms.c
> @@ -204,14 +204,11 @@ void __init probe_roms(void)
>         int i;
>
>         /*
> -        * The ROM memory range is not part of the e820 table and is therefore not
> -        * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
> -        * memory, and SNP requires encrypted memory to be validated before access.
> -        * Do that here.
> +        * These probes are skipped in SEV-SNP guests because the ROM range
> +        * is not pre-validated, meaning access would cause a crash.
>          */
> -       snp_prep_memory(video_rom_resource.start,
> -                       ((system_rom_resource.end + 1) - video_rom_resource.start),
> -                       SNP_PAGE_STATE_PRIVATE);
> +       if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +               return;
>
>         /* video rom */
>         upper = adapter_rom_resources[0].start;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..d2362631da91 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
>         early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
>  }
>
> -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
> -{
> -       unsigned long vaddr, npages;
> -
> -       vaddr = (unsigned long)__va(paddr);
> -       npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> -
> -       if (op == SNP_PAGE_STATE_PRIVATE)
> -               early_snp_set_memory_private(vaddr, paddr, npages);
> -       else if (op == SNP_PAGE_STATE_SHARED)
> -               early_snp_set_memory_shared(vaddr, paddr, npages);
> -       else
> -               WARN(1, "invalid memory op %d\n", op);
> -}
> -
>  static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>                                        unsigned long vaddr_end, int op)
>  {
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 015c95a825d3..22e27087eb5b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
>                         dmi_available = 1;
>                         return;
>                 }
> -       } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> +       } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> +               !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +               /*
> +                * This scan is skipped in SEV-SNP guests because the ROM range
> +                * is not pre-validated, meaning access would cause a crash.
> +                */
>                 p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
>                 if (p == NULL)
>                         goto error;
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

