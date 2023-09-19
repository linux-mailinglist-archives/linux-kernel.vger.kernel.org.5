Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169B7A5971
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjISFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjISFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:36:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1524C100;
        Mon, 18 Sep 2023 22:36:48 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 9601D212C48C; Mon, 18 Sep 2023 22:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9601D212C48C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695101807;
        bh=jWgBcIOxJ3FrN7d/mPVoXuLs+9BvgIwCpxmb2VKTvIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQmM9M/LuOBRiqUqUk4lA5U/BuZBOLfvt1PvHTZIRHQrG0rPQaOKRunK7pe7emi8+
         N6MxuLPhrSYtZE2G2R0uAItIEYcD0+s+6sK4jbOnYSr7RVeJFGcpcQYXtUVeIexnYg
         SGC07YNjEwDmGoJL76aKMRus2ZXx28kdpMypCfkg=
Date:   Mon, 18 Sep 2023 22:36:47 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-hyperv@vger.kernel.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a
 Gen2 VM
Message-ID: <20230919053647.GA23290@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230811053137.2789-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811053137.2789-1-decui@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:31:37PM -0700, Dexuan Cui wrote:
> A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
> raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
> doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
> as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
> the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
> and hence can't be detected by register_e820_pmem().
> 
> Fix this by directly calling e820__reserve_resources_late() in
> hv_pci_init(), which is called from arch_initcall(pci_arch_init).
> 
> It's ok to move a Gen2 VM's e820__reserve_resources_late() from
> subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
> the code in-between doesn't depend on the E820 resources.
> e820__reserve_resources_late() depends on e820__reserve_resources(),
> which has been called earlier from setup_arch().
> 
> For a Gen-2 VM, the new hv_pci_init() also adds any memory of
> E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
> acpi_nfit_insert_resource() -> region_intersects() returns
> REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.
> 
> Changed the local variable "int gen2vm" to "bool gen2vm".
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b004370d3b01..6b22d49aee7b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <asm/apic.h>
>  #include <asm/desc.h>
> +#include <asm/e820/api.h>
>  #include <asm/sev.h>
>  #include <asm/hypervisor.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -282,15 +283,31 @@ static int hv_cpu_die(unsigned int cpu)
>  
>  static int __init hv_pci_init(void)
>  {
> -	int gen2vm = efi_enabled(EFI_BOOT);
> +	bool gen2vm = efi_enabled(EFI_BOOT);
>  
>  	/*
> -	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
> -	 * The purpose is to suppress the harmless warning:
> +	 * A Generation-2 VM doesn't support legacy PCI/PCIe, so both
> +	 * raw_pci_ops and raw_pci_ext_ops are NULL, and pci_subsys_init() ->
> +	 * pcibios_init() doesn't call pcibios_resource_survey() ->
> +	 * e820__reserve_resources_late(); as a result, any emulated persistent
> +	 * memory of E820_TYPE_PRAM (12) via the kernel parameter
> +	 * memmap=nn[KMG]!ss is not added into iomem_resource and hence can't be
> +	 * detected by register_e820_pmem(). Fix this by directly calling
> +	 * e820__reserve_resources_late() here: e820__reserve_resources_late()
> +	 * depends on e820__reserve_resources(), which has been called earlier
> +	 * from setup_arch(). Note: e820__reserve_resources_late() also adds
> +	 * any memory of E820_TYPE_PMEM (7) into iomem_resource, and
> +	 * acpi_nfit_register_region() -> acpi_nfit_insert_resource() ->
> +	 * region_intersects() returns REGION_INTERSECTS, so the memory of
> +	 * E820_TYPE_PMEM won't get added twice.
> +	 *
> +	 * We return 0 here so that pci_arch_init() won't print the warning:
>  	 * "PCI: Fatal: No config space access function found"
>  	 */
> -	if (gen2vm)
> +	if (gen2vm) {
> +		e820__reserve_resources_late();
>  		return 0;
> +	}


Kind reminder to review this.

- Saurabh

>  
>  	/* For Generation-1 VM, we'll proceed in pci_arch_init().  */
>  	return 1;
> 
> -- 
> 2.25.1
> 
