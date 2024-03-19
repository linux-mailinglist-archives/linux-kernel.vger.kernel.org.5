Return-Path: <linux-kernel+bounces-106979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E387F63D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB11F22987
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5257BB1E;
	Tue, 19 Mar 2024 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnEEmKM3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE47BB12
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820839; cv=none; b=Do6xNKBzdlHGLhUVYTbXe46remRD+dcgx4D99L5lhy1GnmAMYAre1Ty1nMaUzJ6udvDC6CT098X+huRoA5jIBAHyiGqdZGlpygG9tC41OfJHhyNUVEFCnLbnToRHQcvndErnbvRuRBbJK7nnwbx8M47N7BY+CqOWLH+QSQhLC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820839; c=relaxed/simple;
	bh=em1tayWATecsjQCbVE06v1UJF8h/Yfzd2A6qPpmeTQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smqNUgwlSHEcimMbGeAIuQ9V/HkCeI7wvPt52B9k5Ex3wDiEDYTKEhXT6O5DO2FT8aLkjjiXCA72NcHf++Pv5Pirv+Sy9uJYjL5Amem4fpYslfb0rBw+XAkLDhKqCdG3e6NvlstbFgZ62KissDl6zVi11qNuCAS118Nx+jB1alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnEEmKM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710820836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCuT+KF0CFKXEteYACtgcd0bLY6/wFRR3VLA/HmQm5k=;
	b=TnEEmKM3BbG09jvLI6ExIqAMtyXcTx/Ha+OQZDrrcv7rZaZVWy9xq5lXjRLWegfAmZQNPf
	pu58GP3HWMYNxnMP1axjvbSlE2Eqooz6JvhidEKH3j8eynS0++FtywgN79CKcyhCwkJ8Sn
	cf2EHOCMtjn376BdRhHRJnZ2xTBeHdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-uhYCHd1lOYC1LAIgkUewmA-1; Tue, 19 Mar 2024 00:00:30 -0400
X-MC-Unique: uhYCHd1lOYC1LAIgkUewmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 565D3852002;
	Tue, 19 Mar 2024 04:00:28 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 859973C20;
	Tue, 19 Mar 2024 04:00:16 +0000 (UTC)
Date: Tue, 19 Mar 2024 12:00:15 +0800
From: Dave Young <dyoung@redhat.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	seanjc@google.com, michael.roth@amd.com, kai.huang@intel.com,
	bhe@redhat.com, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi,

Added Ard in cc.

On 03/18/24 at 07:02am, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.
> 
> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec. kexec_enter_virtual_mode() during
> late init will remap the efi_memmap physical pages allocated in
> efi_arch_mem_reserve() via memboot & then subsequently cause random
> EFI memmap corruption once memblock is freed/teared-down.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..d4562d074371 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,6 +258,16 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first
> +	 * kernel via setup data, so we need to skip this.
> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.

Can you elaborate a bit about the corruption, is it reproducible without
SNP?

> +	 */
> +	if (efi_setup)
> +		return;
> +

How about checking the md attribute instead of checking the efi_setup,
personally I feel it a bit better, something like below:

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..699332b075bb 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -255,15 +255,24 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	struct efi_memory_map_data data = { 0 };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
-	int num_entries;
+	int num_entries, ret;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	ret = efi_mem_desc_lookup(addr, &md);
+	if (ret) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skil reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the 1st kernel, thus skip the case. */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;


