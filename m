Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B55800F93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379496AbjLAPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379471AbjLAPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:53:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00419E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:53:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D5C433C7;
        Fri,  1 Dec 2023 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701446004;
        bh=Z0b5BVslyfrqgtbZ4YRuZ38WQuFzRRb7gFv+mS/ELXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Of7zrhHZR3zdxbtwFj8w34us/XZGonkVZ/fs9bneTntO9uhsXiCFrRvxdW/Rg5s03
         GOo5jrIiVMBqPXHNhL6acynkOhY5UcwdFkn+DZM+fADd70DPOhi3ptTbRF6rJQ1VMD
         ge/NiHq+q1zm2REY4ynj2v8//wjdsIZJiXoYwkDKZZfWgmG+eJGfWc937bbhpP73dH
         83T0HaWcXr0paSmHw5rv03VsTRcWA3+4me/W1Z132BiR9abcAEoHjP/OAMmCBF+Eqq
         fyX2H72S63kQvmHc/rIVlpUBkQQXx5UhaGPMHBxqWOVD3gtTU5gCiXb8KLH3LaJYwR
         a7OXWIciSztsw==
Date:   Fri, 1 Dec 2023 09:53:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TonyWWang@zhaoxin.com, YeeLi@zhaoxin.com, Leoliu@zhaoxin.com
Subject: Re: [PATCH] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
Message-ID: <20231201155320.GA518898@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201120942.680075-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:09:42PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Add more PCI root port device IDs to the
> pci_quirk_zhaoxin_pcie_ports_acs() for some new Zhaoxin platforms.

Can you please add a note about the plan to deal with this for future
devices, e.g., something like "future Zhaoxin devices now in
development will advertise an ACS Capability as described in the
PCIe spec"?

The point of quirks is to work around hardware that is broken or
doesn't conform to the spec in some way.  We have to add quirks when
broken hardware is already in the field, but we should have a plan to
fix newer devices so they don't require quirks.

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..db74f8f07096 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4709,7 +4709,7 @@ static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
>  	switch (dev->device) {
>  	case 0x0710 ... 0x071e:
>  	case 0x0721:
> -	case 0x0723 ... 0x0732:
> +	case 0x0723 ... 0x073b:
>  		return pci_acs_ctrl_enabled(acs_flags,
>  			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  	}
> -- 
> 2.34.1
> 
