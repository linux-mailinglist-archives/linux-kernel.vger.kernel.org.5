Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724557F5D94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbjKWLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjKWLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:17:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7861B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:17:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115C1C433C7;
        Thu, 23 Nov 2023 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700738275;
        bh=hdAwY6pJUbNmsGng/6X59o3TnqEMtaCUWwJVzwuRFAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXEVV/29h0yxgU8l4GqCzQD4uVEesWb8rWIjccTKfaaaVMTIeXqAbC8aTYrKgegmd
         U2AKWY4wpwM93aI+dKVOVG9Hzfk6OeealrymJLOdGRMyTudTGtF26UcwFytbLLdvXx
         cGfWE1TeSkvTq5EpT95/tOr1I5Ocz5RQpmG1OqcddAFnwJIbcB8ps2gCWDcZsE7G4J
         4+a0ccFnyavo+nKN6zWxdeojBsiOItL0R9ER4jS4t/tPJtgr9+LkHoUygB08LDc5Zs
         4Qxrk1zWGpENX0SMcJLhA06J5ezKsnx+pG3p6ljqP7pBX0rYIxsBHoJffHJCR76ajg
         ZrogX4UcHiw7Q==
Date:   Thu, 23 Nov 2023 11:17:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mfd: intel-lpss: Use PCI APIs instead of
 derefereincing
Message-ID: <20231123111751.GB1243364@google.com>
References: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
 <20231106184052.1166579-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106184052.1166579-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023, Andy Shevchenko wrote:

> We have a few PCI APIs that may be used instead of direct dereferencibg,
> Using them will also provide better error codes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Please use spell-check on your commit messages.

Let's not get complacent.

> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index ae5759200622..cf56cd3a40ee 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -37,13 +37,17 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> +	if (ret)
> +		return ret;
> +
>  	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
>  			    GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> -	info->mem = &pdev->resource[0];
> -	info->irq = pdev->irq;
> +	info->mem = pci_resource_n(pdev, 0);
> +	info->irq = pci_irq_vector(pdev, 0);
>  
>  	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
>  		info->ignore_resource_conflicts = true;
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Lee Jones [李琼斯]
