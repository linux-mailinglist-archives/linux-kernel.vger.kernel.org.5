Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78B7F5D99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345007AbjKWLST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjKWLSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:18:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575381AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:18:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A37C433C7;
        Thu, 23 Nov 2023 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700738304;
        bh=+x/URQgVb4SiWXQmWUgGkAjGeRrBtfsrwcdrEF0IBtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjSMQj7nZ67/7+0ThgmDgmc3tUqTfqdRB342jny9HKMGkPLRX4vUAP879qF2AF8EN
         P8oc7u+xBMczUlMmm0Udx6R6SkOISrJIyd/3RByDdvuIslzDn4xQ32ydSPtpRb33YI
         H9KwBuRHABJm1rOGUiD3UhdUaB3Q1wyEqMb4225yoTUa3hnycji7X0Fh0WnF6RpJ2J
         rBrEjZ5kE4cebOntOaSXOV4hjt+mcy3054yFaLk1qBDlC8OPJCjP2/DXObkQIxChRZ
         ITYn+wgllCDtIWvE/Rn46DoTYOPmNaIsD9iJVJBRrxA1hLVwXnfENOi18ImS87mSFV
         YEMFV9wIZbN1Q==
Date:   Thu, 23 Nov 2023 11:18:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: intel-lpss: Amend IRQ check
Message-ID: <20231123111820.GC1243364@google.com>
References: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
 <20231106184052.1166579-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106184052.1166579-3-andriy.shevchenko@linux.intel.com>
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

> From: Chen Ni <nichen@iscas.ac.cn>
> 
> platform_get_irq() returns a negative error code to indicating an
> error. All the same does pci_alloc_irq_vectors() and pci_irq_vector().
> So in intel_lpss_probe() the erroneous IRQ should be better returned
> as is.
> 
> The pci_alloc_irq_vectors() call and platform_get_irq() guarantee
> that IRQ won't be 0, hence drop that check.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> [andy: updated commit message]

I reworded it further.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 9591b354072a..4c9d0222751a 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -378,9 +378,12 @@ int intel_lpss_probe(struct device *dev,
>  	struct intel_lpss *lpss;
>  	int ret;
>  
> -	if (!info || !info->mem || info->irq <= 0)
> +	if (!info || !info->mem)
>  		return -EINVAL;
>  
> +	if (info->irq < 0)
> +		return info->irq;
> +
>  	lpss = devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
>  	if (!lpss)
>  		return -ENOMEM;
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Lee Jones [李琼斯]
