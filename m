Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202B68014E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379635AbjLAVGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:06:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F2F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:06:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F421C433C7;
        Fri,  1 Dec 2023 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701464787;
        bh=hZxzO+oo9QuwDIeQJ/1Ud31M5z/ZmRdiUgqIznChQlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xn+i0op3l1j+L7YnEAAsB+dM2yZrK1yAWF66wwf8IQEEv4DCYOPXCOQd2qD4mDqG8
         7dt8QNb0GEebkin0FgydC9gWkR6GtqIL005D+IQHu4D8txknY3fh/VKUsrUuIfln/u
         D2bqMENKNDhw5ml7Z1NFOwFUjbMXd8ESs6p3GqR47yoW4+vMSAjcatGmjKkIif1h9C
         JbVoMGNQXTvDkhWeiwzXmSud+4wdPBFa730KMJn15fnOb/g57skHyVdtXHmuil2kCE
         LUY/vC9Owi/72WW/EETbr+/VSFQTrneHZinM3LZAdBrecNeGsdiUhEZjMq/hkGDJAD
         OU3dg03TMiwxQ==
Date:   Fri, 1 Dec 2023 15:06:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/PCI: Clean up open-coded return code mangling
Message-ID: <20231201210625.GA529122@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027093158.19171-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 12:31:58PM +0300, Ilpo Järvinen wrote:
> PCI BIOS gives a return code in 8 bits of eax register which is
> extracted by open-coded masks and shifting.
> 
> Name the return code bits with a define and introduce
> pcibios_get_return_code() helper to extract the return code to improve
> code readability. In addition, replace a zero test with
> PCIBIOS_SUCCESSFUL.
> 
> No function changes intended.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to the PCI "enumeration" branch for v6.8.  x86 folks, if you'd
prefer to take this, let me know.

> ---
> 
> v2:
> - Improve changelog
> - Add helper to avoid repeating FIELD_GET()
> - Reuse existing ret variable in pcibios_get_irq_routing_table()
> 
>  arch/x86/pci/pcbios.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/pcbios.c b/arch/x86/pci/pcbios.c
> index 4f15280732ed..01c94ac2fb70 100644
> --- a/arch/x86/pci/pcbios.c
> +++ b/arch/x86/pci/pcbios.c
> @@ -3,6 +3,8 @@
>   * BIOS32 and PCI BIOS handling.
>   */
>  
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -29,8 +31,19 @@
>  #define PCIBIOS_HW_TYPE1_SPEC		0x10
>  #define PCIBIOS_HW_TYPE2_SPEC		0x20
>  
> +/*
> + * Returned in EAX:
> + * - AH: return code
> + */
> +#define PCIBIOS_RETURN_CODE			GENMASK(15, 8)
> +
>  int pcibios_enabled;
>  
> +static u8 pcibios_get_return_code(u32 eax)
> +{
> +	return FIELD_GET(PCIBIOS_RETURN_CODE, eax);
> +}
> +
>  /* According to the BIOS specification at:
>   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
>   * restrict the x zone to some pages and make it ro. But this may be
> @@ -154,7 +167,7 @@ static int __init check_pcibios(void)
>  			: "memory");
>  		local_irq_restore(flags);
>  
> -		status = (eax >> 8) & 0xff;
> +		status = pcibios_get_return_code(eax);
>  		hw_mech = eax & 0xff;
>  		major_ver = (ebx >> 8) & 0xff;
>  		minor_ver = ebx & 0xff;
> @@ -227,7 +240,7 @@ static int pci_bios_read(unsigned int seg, unsigned int bus,
>  
>  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  
> -	return (int)((result & 0xff00) >> 8);
> +	return pcibios_get_return_code(result);
>  }
>  
>  static int pci_bios_write(unsigned int seg, unsigned int bus,
> @@ -269,7 +282,7 @@ static int pci_bios_write(unsigned int seg, unsigned int bus,
>  
>  	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>  
> -	return (int)((result & 0xff00) >> 8);
> +	return pcibios_get_return_code(result);
>  }
>  
>  
> @@ -385,8 +398,9 @@ struct irq_routing_table * pcibios_get_irq_routing_table(void)
>  		  "m" (opt)
>  		: "memory");
>  	DBG("OK  ret=%d, size=%d, map=%x\n", ret, opt.size, map);
> -	if (ret & 0xff00)
> -		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", (ret >> 8) & 0xff);
> +	ret = pcibios_get_return_code(ret);
> +	if (ret)
> +		printk(KERN_ERR "PCI: Error %02x when fetching IRQ routing table.\n", ret);
>  	else if (opt.size) {
>  		rt = kmalloc(sizeof(struct irq_routing_table) + opt.size, GFP_KERNEL);
>  		if (rt) {
> @@ -415,7 +429,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
>  		  "b" ((dev->bus->number << 8) | dev->devfn),
>  		  "c" ((irq << 8) | (pin + 10)),
>  		  "S" (&pci_indirect));
> -	return !(ret & 0xff00);
> +	return pcibios_get_return_code(ret) == PCIBIOS_SUCCESSFUL;
>  }
>  EXPORT_SYMBOL(pcibios_set_irq_routing);
>  
> -- 
> 2.30.2
> 
