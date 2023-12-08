Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92D80A7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574426AbjLHPlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574416AbjLHPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:41:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D69FB;
        Fri,  8 Dec 2023 07:41:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702050072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0pEnoL/Gff0b7iShI70ys3jq+wUbtxEI57WVAKBvbY=;
        b=oWIePqJ8rLv6IqfuQBwmciWl8+bdrvJChn9XZBRwjfn2R+UWGhM9FBfTaNFrvOeTbj+ZiR
        NtNBvtlFwrJF+x1yyx0T/OegnmxhLYqsNWa2O/yhcAEBqMPhRWAFrmLeaLWH00+f4eDNvW
        934LKyPiPipJr89Wkm8/GQ9S7pB3ji0rvjTHyAatGBIPZQK2AqqHOOMll1AEyRlXE8+sWT
        /FuY01A+R4czn/mAhyyCCrxSc1g+4akz3IijWSSX3fFMf8iHAfj03ZUHDTLrqrURDyPfSe
        0YGNg2GuKZ8s5MMbKKi2AQpC2Oy8LVXITVWCk7YDPrbMiw92DDJKfp0RlVLmBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702050072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0pEnoL/Gff0b7iShI70ys3jq+wUbtxEI57WVAKBvbY=;
        b=Sg/seOJdGSBSS6Nb6kY1FKuVmTB578w4HPATOkDjs5zwTeMdY/8r8MszTIuJ6wOf0gdakt
        6hK4QS4r6hfVeADw==
To:     James Tai <james.tai@realtek.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 6/6] irqchip: Introduce RTD1619B support using the
 Realtek common interrupt controller driver
In-Reply-To: <20231129054339.3054202-7-james.tai@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-7-james.tai@realtek.com>
Date:   Fri, 08 Dec 2023 16:41:11 +0100
Message-ID: <877closnvs.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2023 at 13:43, James Tai wrote:
> +static int realtek_intc_rtd1619b_suspend(struct device *dev)
> +{
> +	struct realtek_intc_data *data = dev_get_drvdata(dev);
> +	const struct realtek_intc_info *info = data->info;
> +
> +	data->saved_en = readl(data->base + info->scpu_int_en_offset);
> +
> +	writel(DISABLE_INTC, data->base + info->scpu_int_en_offset);
> +	writel(CLEAN_INTC_STATUS, data->base + info->umsk_isr_offset);
> +	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
> +
> +	return 0;
> +}
> +
> +static int realtek_intc_rtd1619b_resume(struct device *dev)
> +{
> +	struct realtek_intc_data *data = dev_get_drvdata(dev);
> +	const struct realtek_intc_info *info = data->info;
> +
> +	writel(CLEAN_INTC_STATUS, data->base + info->umsk_isr_offset);
> +	writel(CLEAN_INTC_STATUS, data->base + info->isr_offset);
> +	writel(data->saved_en, data->base + info->scpu_int_en_offset);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops realtek_intc_rtd1619b_pm_ops = {
> +	.suspend_noirq = realtek_intc_rtd1619b_suspend,
> +	.resume_noirq  = realtek_intc_rtd1619b_resume,
> +};

So this is the 4th copy of the same code, really? Why is this not part
of the common code?

Thanks,

        tglx
