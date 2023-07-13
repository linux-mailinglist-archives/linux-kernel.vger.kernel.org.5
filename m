Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AA751EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjGMKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjGMKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A432711;
        Thu, 13 Jul 2023 03:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77EDA60B63;
        Thu, 13 Jul 2023 10:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778B0C433C7;
        Thu, 13 Jul 2023 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689243532;
        bh=1GbxYx/CZktSh2mOgXWwsxM2Jwmmh5UkY3gUfBTSD1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpPkEf+CJTjlAuYQbmdVdEbBeMM3gNzFmV61fO5Vr/Lg8RVwx9Y1gVJMvr0V4ZRnq
         1nufVJC5Q7o9f3hNp0t8HwvIk5AnqMh+RFu9inclmIuJ/zEpq4CVtgoRRD61gPjzr0
         +A4yMoY6spCdIccN2Ox1E4K4pjt2P0xeVa+HKLkKNkpcmc0k3WCEfsM67nnQIQYyEi
         P6yO8pfXNbqzDx1khjDRuYtwH6Cb+CpwV+eCaOj1S46Vn1mo8Ky665EnEDg6jVP8LN
         DE87obeGat5nmupF61nGOrJkri+GOpYYGiLAHYiO/HzvMxehz9VonqTLKOexY1VzcN
         Z032XKfPArTzA==
Date:   Thu, 13 Jul 2023 11:18:48 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on
 &chip->pm_irq_lock
Message-ID: <20230713101848.GM10768@google.com>
References: <20230628072840.28587-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628072840.28587-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like some additional eyes-on please.

This is very old code that you're changing and some of the people who
made the largest contributions are not on Cc.

On Wed, 28 Jun 2023, Chengfeng Ye wrote:
> As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
> context, other process context code should disable irq before acquiring
> the lock.
> 
> I think .irq_set_type and .irq_get_irqchip_state callbacks should be
> executed from process context without irq disabled by default. Thus the
> same lock acquision should disable irq.
> 
> Possible deadlock scenario
> pm8xxx_irq_set_type()
>     -> pm8xxx_config_irq()
>     -> spin_lock(&chip->pm_irq_lock)
>         <irq interrupt>
>         -> pm8xxx_irq_handler()
>         -> pm8xxx_irq_master_handler()
>         -> pm8xxx_irq_block_handler()
>         -> pm8xxx_read_block_irq()
>         -> spin_lock(&chip->pm_irq_lock) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/mfd/qcom-pm8xxx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 9a948df8c28d..07c531bd1236 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -103,8 +103,9 @@ static int
>  pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
>  {
>  	int	rc;
> +	unsigned long flags;
>  
> -	spin_lock(&chip->pm_irq_lock);
> +	spin_lock_irqsave(&chip->pm_irq_lock, flags);
>  	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
>  	if (rc) {
>  		pr_err("Failed Selecting Block %d rc=%d\n", bp, rc);
> @@ -116,7 +117,7 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
>  	if (rc)
>  		pr_err("Failed Configuring IRQ rc=%d\n", rc);
>  bail:
> -	spin_unlock(&chip->pm_irq_lock);
> +	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
>  	return rc;
>  }
>  
> @@ -321,6 +322,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
>  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
>  	unsigned int pmirq = irqd_to_hwirq(d);
>  	unsigned int bits;
> +	unsigned long flags;
>  	int irq_bit;
>  	u8 block;
>  	int rc;
> @@ -331,7 +333,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
>  	block = pmirq / 8;
>  	irq_bit = pmirq % 8;
>  
> -	spin_lock(&chip->pm_irq_lock);
> +	spin_lock_irqsave(&chip->pm_irq_lock, flags);
>  	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, block);
>  	if (rc) {
>  		pr_err("Failed Selecting Block %d rc=%d\n", block, rc);
> @@ -346,7 +348,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
>  
>  	*state = !!(bits & BIT(irq_bit));
>  bail:
> -	spin_unlock(&chip->pm_irq_lock);
> +	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
>  
>  	return rc;
>  }
> -- 
> 2.17.1
> 

-- 
Lee Jones [李琼斯]
