Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49380DB41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjLKUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjLKUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:07:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AFD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303FDC433CC;
        Mon, 11 Dec 2023 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702325242;
        bh=LKeHZBb6JKYAmHddd83S8bgUsHx/KGnr+Nj4UjhnTOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fKunPx2/y1lVcA5+0696r1ULEr8fkc8usfCXm6B2wFFt3P1g2pWlXA7p5YnY3lkTO
         Z9vlROguNMK6BCBlFEna8tZM9nkz3gADukNqc0rFB3zKF7YSIUHXouvm7hgEwpJOGS
         7CDlzSGYCF0LZLSeoN9m9vZCv2OABY9i+dgZqpAcJjmY5fekO8XrMrYGT+PXhm1taA
         eqS33bun+3bNCpBSczM/v3LFyDhhqOLzA6D4HKIIg0vBaRXBxDDGFiJrD33o5rRMru
         +H7hKxiMxLp9oDRkKOtdbpXaVyCDSDoVheo0Vur9YS0dLdpoHCKQjFfu0jA6ICK4hP
         9zhAgcCmSLnPw==
Date:   Mon, 11 Dec 2023 14:07:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TonyWWang@zhaoxin.com, YeeLi@zhaoxin.com, Leoliu@zhaoxin.com
Subject: Re: [PATCH v2] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
Message-ID: <20231211200719.GA964402@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211091543.735903-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 05:15:43PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Add more PCI root port device IDs to the
> pci_quirk_zhaoxin_pcie_ports_acs() for some new Zhaoxin platforms.
> 
> v1 -> v2:
> 1. Add a note to indicate future Zhaoxin devices will implement ACS
> Capability based on the PCIe Spec.
> 2. Includes DID of more Zhaoxin devices that have not yet implemented ACS
> Capability.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Applied as below to pci/virtualization for v6.8, thanks!

This extends 299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin
Root/Downstream Ports"), so I made the subject similar to that, added
a Fixes: line for it, and added a stable tag.

> ---
>  drivers/pci/quirks.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..f4546590d9e3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4706,10 +4706,14 @@ static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
>  		return -ENOTTY;
>  
> +	/*
> +	 * Future Zhaoxin Root Ports and Switch Downstream Ports will implement ACS
> +	 * capability in accordance with the PCIe Spec.
> +	 */
>  	switch (dev->device) {
>  	case 0x0710 ... 0x071e:
>  	case 0x0721:
> -	case 0x0723 ... 0x0732:
> +	case 0x0723 ... 0x0752:
>  		return pci_acs_ctrl_enabled(acs_flags,
>  			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  	}
> 

commit e367e3c765f5 ("PCI: Add ACS quirk for more Zhaoxin Root Ports")
Author: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Date:   Mon Dec 11 17:15:43 2023 +0800

    PCI: Add ACS quirk for more Zhaoxin Root Ports
    
    Add more Root Port Device IDs to pci_quirk_zhaoxin_pcie_ports_acs() for
    some new Zhaoxin platforms.
    
    Fixes: 299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
    Link: https://lore.kernel.org/r/20231211091543.735903-1-LeoLiu-oc@zhaoxin.com
    Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
    [bhelgaas: update subject, drop changelog, add Fixes, add stable tag, fix
    whitespace, wrap code comment]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: <stable@vger.kernel.org>	# 5.7


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..d55a3ffae4b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4699,17 +4699,21 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}
