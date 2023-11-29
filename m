Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC77FE429
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjK2XWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK2XWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:22:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D91A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:22:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F35C433C7;
        Wed, 29 Nov 2023 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701300141;
        bh=0euqzIph0L67aoLFECRKJJGk+Cwo0OYK7duqaEhztvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kUHjbiYjoCXXjDtK4+6sAkFll8K8C0VugBxif088joxOVNumvw/414ipgLvmnDV5m
         HBofxkICxZVmf/07EC8Exs6qtzZUHwjclvn34xr2hLPoT2wZedNplYgA4Tpd5hKnUl
         cBtdbfgtZ4FD+6jwR5QnysRYqpLWL/w1ZITtcK3+SXGCnDPt1eRAir/ogA5g7V7Nly
         m15DUBveoyvEmcy1HtYve6yGRYHtjDBXSzOfxa22ejElrt/qf/n7Pb5TnfRP2tmDgb
         VwWH5CsGqjX2OqemGhzpohjCmMsvRZN3PTttJddrgYXkR/a+g0zKiFeWTzLChTF0Ce
         A025HHEXFFspA==
Date:   Wed, 29 Nov 2023 17:22:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Xie <kevin.xie@starfivetech.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mason.huo@starfivetech.com,
        leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Message-ID: <20231129232219.GA444277@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124014508.43358-1-kevin.xie@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
> time between sending the first configuration request to the device and
> exit from a conventional reset (or after link training completes).
> 
> As described in the conventional reset rules of PCI specifications,
> there are two different use cases of the value:
> 
>    - With a downstream port that supports link speeds <= 5.0 GT/s,
>      the waiting is following exit from a conventional reset.
> 
>    - With a downstream port that supports link speeds > 5.0 GT/s,
>      the waiting is after link training completes.
> 
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/pci/pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..4ca8766e546e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -22,6 +22,13 @@
>   */
>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>  
> +/*
> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
> + * Requires a minimum waiting of 100ms before sending a configuration
> + * request to the device.
> + */
> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100

Oh, and I think this name should include something about "reset"
because that's the common scenario and that's the spec section where
the value is mentioned.
