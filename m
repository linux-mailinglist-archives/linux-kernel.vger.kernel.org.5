Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830178014C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379558AbjLAUoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:44:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB210C2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:44:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD9C433C7;
        Fri,  1 Dec 2023 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701463489;
        bh=R0KLOaBddoeXEw/EtG4OX2U5+CrTSAjm9fGyYL9KSqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OmCqXnAHiVuL9yQlbR2ds/qVSUIw9nC0VsUXeymmKDx5pmaN8Ehe5qLt+bRqvSANy
         +VBAJQZjGJWozu223P1INBj0XYjwPsCUlsbkx5dukIPV4V02FYjb68VClUs6dZjbIR
         PSwturEf88P9HidF7ldAlwikwepmVimtKbuNK/IuWLwcHOcblS5y3/M3I1vKb8+0eh
         i1pdMLjXebTwxni4wsWU7sBSfQEjmmyqpmIjRuJQSNx3OKxbc2tzcFwUblHmrY+Ux3
         UDHFjkYDbow5mzm48yMw/XrG/+2r/iVCsCNfXcgxqF8obcB1fDco37/reYksHvKxjv
         aydNrClft96bw==
Date:   Fri, 1 Dec 2023 14:44:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] x86: Use PCI_HEADER_TYPE_* instead of literals
Message-ID: <20231201204447.GA527927@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:09:13AM +0200, Ilpo Järvinen wrote:
> Replace 0x7f and 0x80 literals with PCI_HEADER_TYPE_* defines.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied entire series on the PCI "enumeration" branch for v6.8,
thanks!

If anybody wants to take pieces separately, let me know and I'll drop
from PCI.

> ---
>  arch/x86/kernel/aperture_64.c  | 3 +--
>  arch/x86/kernel/early-quirks.c | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> index 4feaa670d578..89c0c8a3fc7e 100644
> --- a/arch/x86/kernel/aperture_64.c
> +++ b/arch/x86/kernel/aperture_64.c
> @@ -259,10 +259,9 @@ static u32 __init search_agp_bridge(u32 *order, int *valid_agp)
>  							order);
>  				}
>  
> -				/* No multi-function device? */
>  				type = read_pci_config_byte(bus, slot, func,
>  							       PCI_HEADER_TYPE);
> -				if (!(type & 0x80))
> +				if (!(type & PCI_HEADER_TYPE_MFD))
>  					break;
>  			}
>  		}
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index a6c1867fc7aa..59f4aefc6bc1 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -779,13 +779,13 @@ static int __init check_dev_quirk(int num, int slot, int func)
>  	type = read_pci_config_byte(num, slot, func,
>  				    PCI_HEADER_TYPE);
>  
> -	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
> +	if ((type & PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
>  		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
>  		if (sec > num)
>  			early_pci_scan_bus(sec);
>  	}
>  
> -	if (!(type & 0x80))
> +	if (!(type & PCI_HEADER_TYPE_MFD))
>  		return -1;
>  
>  	return 0;
> -- 
> 2.30.2
> 
