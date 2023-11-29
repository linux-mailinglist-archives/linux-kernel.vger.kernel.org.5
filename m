Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD97FE431
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjK2Xi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2XiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:38:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B238D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:38:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D0C433C7;
        Wed, 29 Nov 2023 23:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701301108;
        bh=UuAe5E2gYe6tWeYVM+NbO91LQq7MdsluQ0lAhxbAHcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qq3gGhSSfOYJw7os6lAJ1rNSOmIowKfDUaSmvVB4ZxCr0A884muIxuunyDHgYFqks
         aDTl5PR4+djQlr5Jqv267EzhATzaLy7Ov8/JBnruxpEKrHAzIJNV7O9m2JEUrhq8gK
         ZFb4k9oaT9I/rjo4eoqut+XlPHpL2RcVyxaP0HXeTTaobkyDh3zyUyXV0oLPAxsECP
         ZlULOQ1nBJw8ZhNhXT6gK1/XoGfBX1C4nXChDL4o2yqDwFzHvaI2f8uNIUQ+EtxEWR
         +7ceEWfIgL+1EUIxfAb6T3CR9PlSvM+a/+MWvppLTNI+lxoENYIGrMi34WMrFcurz1
         /rcaFFkW/XXTg==
Date:   Wed, 29 Nov 2023 17:38:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231129233827.GA444332@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Greg because these mergers & spinoffs happen all the time, and
pci_ids.h doesn't necessarily need to keep up, so maybe there's
precedent for what to do here]

On Wed, Nov 22, 2023 at 05:42:41PM +0200, Vladimir Oltean wrote:
> What is today NXP is the result of some mergers (with Freescale) and
> spin-offs (from Philips).
> 
> New NXP hardware (for example NETC version 4.1 of the NXP i.MX95
> SoC) uses PCI_VENDOR_ID_PHILIPS. And some older hardware uses
> PCI_VENDOR_ID_FREESCALE.
> 
> If we have PCI_VENDOR_ID_NXP as an alias for PCI_VENDOR_ID_FREESCALE,
> we end up needing something like a PCI_VENDOR_ID_NXP2 alias for
> PCI_VENDOR_ID_PHILIPS. I think this is more confusing than just spelling
> out the vendor ID of the original company that claimed it.
> 
> FWIW, the pci.ids repository as of today has:
> 1131  Philips Semiconductors
> 1957  Freescale Semiconductor Inc
> 
> so this makes the kernel code consistent with that, and with what
> "lspci" prints.

Hmm.  I can't find the 0x1957 Vendor ID here:
https://pcisig.com/membership/member-companies, which is supposed to
be the authoritative source AFAICS.

Also, that page lists 0x1131 as "NXP Semiconductors".

There's a contact email on that page if it needs updates.

I don't quite understand the goal here.  The company is now called
"NXP", and this patch removes PCI_VENDOR_ID_NXP (the only instance of
"NXP" in pci_ids.h) and uses PCI_VENDOR_ID_FREESCALE (which apparently
does not exist any more)?

Why would we remove name of the current company and use the name of a
company that doesn't exist any more?

> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/pci/quirks.c    | 50 ++++++++++++++++++++---------------------
>  include/linux/pci_ids.h |  1 -
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d208047d1b8f..c95701e36d58 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5092,39 +5092,39 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
> -	/* NXP root ports, xx=16, 12, or 08 cores */
> +	/* Freescale/NXP root ports, xx=16, 12, or 08 cores */
>  	/* LX2xx0A : without security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d81, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d83, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0C : security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d80, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d82, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0E : security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d90, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db0, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d92, pci_quirk_nxp_rp_acs },
>  	/* LX2xx0N : without security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d91, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db1, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d93, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2A : without security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d89, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d8b, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2C : security features + CAN-FD */
> -	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d88, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8da8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d8a, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2E : security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d98, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db8, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d9a, pci_quirk_nxp_rp_acs },
>  	/* LX2xx2N : without security features + CAN */
> -	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> -	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d99, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8db9, pci_quirk_nxp_rp_acs },
> +	{ PCI_VENDOR_ID_FREESCALE, 0x8d9b, pci_quirk_nxp_rp_acs },
>  	/* Zhaoxin Root/Downstream Ports */
>  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
>  	/* Wangxun nics */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 275799b5f535..f837ff427b85 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2469,7 +2469,6 @@
>  #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>  
>  #define PCI_VENDOR_ID_FREESCALE		0x1957	/* duplicate: NXP */
> -#define PCI_VENDOR_ID_NXP		0x1957	/* duplicate: FREESCALE */
>  #define PCI_DEVICE_ID_MPC8308		0xc006
>  #define PCI_DEVICE_ID_MPC8315E		0x00b4
>  #define PCI_DEVICE_ID_MPC8315		0x00b5
> -- 
> 2.34.1
> 
