Return-Path: <linux-kernel+bounces-82222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31478680B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691D729354A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F112FF81;
	Mon, 26 Feb 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sg9MaEmO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1312FF64
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974971; cv=none; b=c4s7JrHz5QIHx6CC5haQrR7NQJfMTdBN8pv69+S66MCJC0OQm2GunZz1WeMZ0h2JI1uezeIEq5x2zwoH0c+k7kCJhj7o+zHINCxokPyLby5ROuzEt/GF7mHKR2dWwJQ8Cr/gXf4aZR8fCOJ7A44/w0jhP2pQ/yolVeC+Y+qr/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974971; c=relaxed/simple;
	bh=cmYQX0WXe1R7g50QoJI94WraHqbUsK8xpEDc1+xbeIw=;
	h=Mime-Version:Subject:From:In-Reply-To:Date:Cc:Message-Id:
	 References:To:Content-Type; b=BsuFr/K1ZLAA7k6OupCGIJEREIo2/2QMfOUJ35YwaYTLk7ume0TSPiECvOccQLQjRUK6NT0g0JBkLXJUA/XpGbzJklhBF+IQH+Jd/HBBv0J2/kBbnuJgcQqPprFyFAf+MlN9mN+KqGD0P+YpPlnK/TP6bNGV/UR0w/2CLml8qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sg9MaEmO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de3141f041so2127172b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708974969; x=1709579769; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2z8HdzzlldrzSXWl18PQfTNGb5pbDqTGOGC99h1P6kk=;
        b=Sg9MaEmOkZuEYZoZC5hGYteAhvXRDI7X7AC36RUpMY3PRSB9rsRhPVTdIgpEPSX8Tu
         R+7Zff6EWJyH43Nj+hTbsnHDEuuWclUYy8Ki6fs9VAmYhyCcqIiEIA+Mo2N9Mzg1x0dD
         2gDVEDrPdPCdYRZE+aN57yxHyJ2iZTw7g40ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974969; x=1709579769;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2z8HdzzlldrzSXWl18PQfTNGb5pbDqTGOGC99h1P6kk=;
        b=esPEFPDrJppklzW5bIdKqfifHqNeEjXvnoReUb8Y5dOQ0egZIEx2znNlkRpkLQ2EQt
         ixRXu9tEdPp/KgDLMBpGF6BpgO6KTD921ydpk8I0LvN9q6qLTkJBxHMt46DN/kmcie++
         2eIvUtu39hcZsumg4HLKv6dNKT6K7CF+2FUiZeOtFqICYovQZk7OczmKx2sZ45+1XfiN
         e9U/E+wjrzgZCE0BfKqI2aD0YpSlSvJshbpFYzgnhuChJTYytuLbxWq8TubkmuP3/orK
         W8NLlox+8GQB5fM3g9zsXHy4yn2zgzrUBm1L4+otnnRIbaP7btSD5aDCyk4Y19V35KoP
         yAFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkhNnmQ0/FU/6JVdynUlBLS+couwJwnHwgtdUe27AbMqidvMgY8EdsmiXtMFwYIgZtJgDOfOLoHgGDn/v2Shmk9EHE5D0q3carXo7M
X-Gm-Message-State: AOJu0YwHSHcioewqbx3lKNGokpRb8E6AQZ8dlL4j8vlnH9Cnbw4e/kmu
	drFTXphJw/dXYS2wFky7ohZCGh3qP7Q84TtTLNDoGOpU9lWxu3jKimOIDqmLjrdE7ega4ywAjyM
	0lWdrYJPi9aXW9n/m5zS336qDqHVzAVlDkrnKLEOSIJ9dmU/PtbI=
X-Google-Smtp-Source: AGHT+IEC9JcNy1ADCfpu0I9QsDQVobDzbsCBdDLCxqHOFq5A/C9c5lpIZ4W48XqvV1fDuy5xvsauQw==
X-Received: by 2002:a05:6a00:4f96:b0:6e5:31f5:94cd with SMTP id ld22-20020a056a004f9600b006e531f594cdmr3600759pfb.0.1708974968720;
        Mon, 26 Feb 2024 11:16:08 -0800 (PST)
Received: from smtpclient.apple ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id r25-20020a62e419000000b006da96503d9fsm4386073pfh.109.2024.02.26.11.16.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2024 11:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.1\))
Subject: Re: [PATCH v2] x86/kernel: skip ROM range scans and validation for
 SEV-SNP guests
From: Mike Stunes <mike.stunes@broadcom.com>
In-Reply-To: <20240222202404.36206-1-kevinloughlin@google.com>
Date: Mon, 26 Feb 2024 11:15:54 -0800
Cc: acdunlap@google.com,
 alexander.shishkin@linux.intel.com,
 andrisaar@google.com,
 ardb@kernel.org,
 bhe@redhat.com,
 Borislav Petkov <bp@alien8.de>,
 Brijesh Singh <brijesh.singh@amd.com>,
 dave.hansen@linux.intel.com,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 grobler@google.com,
 hpa@zytor.com,
 jacobhxu@google.com,
 jpoimboe@kernel.org,
 "Huang, Kai" <kai.huang@intel.com>,
 linux-kernel@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,
 mingo@redhat.com,
 peterz@infradead.org,
 Peter Gonda <pgonda@google.com>,
 ross.lagerwall@citrix.com,
 sidtelang@google.com,
 tglx@linutronix.de,
 Thomas Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org,
 ytcoode@gmail.com
Message-Id: <4463AFB9-58AC-4E65-BB04-EB2C9F2D9301@broadcom.com>
References: <CAGdbjmK9WoOQSbKUvcTdLJDW-RB=qe2tHFDZ-MeD266xZOxh7w@mail.gmail.com>
 <20240222202404.36206-1-kevinloughlin@google.com>
To: Kevin Loughlin <kevinloughlin@google.com>
X-Mailer: Apple Mail (2.3731.700.6.1.1)
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

> On Feb 22, 2024, at 12:24 PM, Kevin Loughlin <kevinloughlin@google.com> wrote:
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
> arch/x86/include/asm/sev.h   |  2 --
> arch/x86/kernel/mpparse.c    |  7 +++++++
> arch/x86/kernel/probe_roms.c | 11 ++++-------
> arch/x86/kernel/sev.c        | 15 ---------------
> drivers/firmware/dmi_scan.c  |  7 ++++++-
> 5 files changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 5b4a1ce3d368..474c24ba0f6f 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -203,7 +203,6 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
> unsigned long npages);
> void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
> unsigned long npages);
> -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
> void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
> void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
> void snp_set_wakeup_secondary_cpu(void);
> @@ -227,7 +226,6 @@ static inline void __init
> early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> static inline void __init
> early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
> -static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
> static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
> static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
> static inline void snp_set_wakeup_secondary_cpu(void) { }
> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index b223922248e9..39ea771e2d4c 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -553,6 +553,13 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
>    base, base + length - 1);
> BUILD_BUG_ON(sizeof(*mpf) != 16);
> 
> + /*
> + * Skip scan in SEV-SNP guest if it would touch the legacy ROM region,
> + * as this memory is not pre-validated and would thus cause a crash.
> + */
> + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && base < 0x100000 && base + length >= 0xC0000)
> + return 0;
> +
> while (length > 0) {
> bp = early_memremap(base, length);
> mpf = (struct mpf_intel *)bp;
> diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> index 319fef37d9dc..84ff4b052fc1 100644
> --- a/arch/x86/kernel/probe_roms.c
> +++ b/arch/x86/kernel/probe_roms.c
> @@ -204,14 +204,11 @@ void __init probe_roms(void)
> int i;
> 
> /*
> - * The ROM memory range is not part of the e820 table and is therefore not
> - * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
> - * memory, and SNP requires encrypted memory to be validated before access.
> - * Do that here.
> + * These probes are skipped in SEV-SNP guests because the ROM range
> + * is not pre-validated, meaning access would cause a crash.
> */
> - snp_prep_memory(video_rom_resource.start,
> - ((system_rom_resource.end + 1) - video_rom_resource.start),
> - SNP_PAGE_STATE_PRIVATE);
> + if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> + return;
> 
> /* video rom */
> upper = adapter_rom_resources[0].start;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c67285824e82..d2362631da91 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -774,21 +774,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
> early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
> }
> 
> -void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
> -{
> - unsigned long vaddr, npages;
> -
> - vaddr = (unsigned long)__va(paddr);
> - npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
> -
> - if (op == SNP_PAGE_STATE_PRIVATE)
> - early_snp_set_memory_private(vaddr, paddr, npages);
> - else if (op == SNP_PAGE_STATE_SHARED)
> - early_snp_set_memory_shared(vaddr, paddr, npages);
> - else
> - WARN(1, "invalid memory op %d\n", op);
> -}
> -
> static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
>       unsigned long vaddr_end, int op)
> {
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 015c95a825d3..22e27087eb5b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -703,7 +703,12 @@ static void __init dmi_scan_machine(void)
> dmi_available = 1;
> return;
> }
> - } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
> + } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK) &&
> + !cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> + /*
> + * This scan is skipped in SEV-SNP guests because the ROM range
> + * is not pre-validated, meaning access would cause a crash.
> + */
> p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
> if (p == NULL)
> goto error;
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 
> 

In addition to these changes, I also had to skip pirq_find_routing_table if SEV-SNP is active.

Thanks!
Mike


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

