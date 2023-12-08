Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607780A9C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjLHQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbjLHQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:50:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2B19A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:50:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4EDC433C8;
        Fri,  8 Dec 2023 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702054241;
        bh=wlUXwlsUbGMtEcjVD5Tfu+HjZX3PCSQZUuI9/7Iqr1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BOCmgHjq9geZadOhgdjEmm/gLlEoc7P8m9wwz3PAXNl9ACl2u+7Msp41vwIdzW/Nv
         Mp6bOHVRDwVUScivRBMmlqKtLxsgkodvUR7cfXuKgspRMz++vreENJjgqU15gGaEVa
         TKcjvej3ywn56kfq4LrzQj+LF3/bDdO01eoyqWvPK1V41Cb8L29EPOpKqMtx4mVi/2
         v1hWbPq7+8ztBoS70I8XQlBL7DG1QTbhXfTFd73MY4ZL4RTsFCrnyAXBYvRWlm2Y7D
         e87GXnpOAEdOreASny4i5cq9BillFMiY8J/ZYPpufp8Rsb1pO1R7LYM8PF/QSv82WP
         DKIRZ4R4bEzlw==
Date:   Fri, 8 Dec 2023 10:50:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20231208165039.GA796094@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201115028.84351-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:50:28AM +0000, Jiaxun Yang wrote:
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
> 
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
> 
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
> 
> It must be done at device enablement stage because MRRS setting
> may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
> we are only sure parent bridge is enabled at this point.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to for-linus for v6.7, thanks!

> ---
> v4: Improve commit message
> v5:
> 	- Improve commit message and comments.
> 	- Style fix from Huacai's off-list input.
> v6: Fix a typo
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index d45e7b8dc530..e181d99decf1 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, system_bus_quirk);
>  
> +/*
> + * Some Loongson PCIe ports have h/w limitations of maximum read
> + * request size. They can't handle anything larger than this.
> + * Sane firmware will set proper MRRS at boot, so we only need
> + * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
> + * won't set MRRS properly, and we have to enforce maximum safe
> + * MRRS, which is 256 bytes.
> + */
> +#ifdef CONFIG_MIPS
> +static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = pdev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(pdev) > 256) {
> +				pci_info(pdev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(pdev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
> +#endif
> +
>  static void loongson_mrrs_quirk(struct pci_dev *pdev)
>  {
> -	/*
> -	 * Some Loongson PCIe ports have h/w limitations of maximum read
> -	 * request size. They can't handle anything larger than this. So
> -	 * force this limit on any devices attached under these ports.
> -	 */
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>  
>  	bridge->no_inc_mrrs = 1;
> -- 
> 2.34.1
> 
