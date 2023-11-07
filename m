Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528307E45FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjKGQaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKGQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:30:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57BF83
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:30:03 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21AE3660746E;
        Tue,  7 Nov 2023 16:30:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699374602;
        bh=RHKkcTh5W8SNMFNToY6SNfNKENo7Fq1KXtu4W+ceTuE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LAf+hzM9mXiDoJToArNMavA1JgIt6kye5VZXmT3OvHSGeBG67O9MR+7rGDoCaCH6j
         gMWqoNuNwDQhrO4Eo6xgrLtlnXT4efBtHTpDZRcSuWmSigRZciginRoOJCKGz6ZicK
         SM8xl3EvAqBURHXnIbDVPDcF17bJZ6qIsOf6AdcyXlk3POaB2GunoYjxojA5wZgBtf
         PyCby+CaYh1i9gpXCQWpIyLqH1KXwIVPvqkNhjzrR4D4eAVMa96dFKDlItLVt2YvQu
         aPQ5AHQLrlgVWoIgXfezQ2BtN5gn7IryiF2Yv4g9XWTqU8eVa8pBWSUT6jX6r+n1g6
         09h8PECT66eUw==
Message-ID: <9b2e37a0-32ee-4aa4-99e8-d37103674847@collabora.com>
Date:   Tue, 7 Nov 2023 17:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from
 irqchip to core
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/11/23 16:26, Douglas Anderson ha scritto:
> In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
> Mediatek devices w/ firmware issues") we added a method for detecting
> Mediatek devices with broken firmware and disabled pseudo-NMI. While
> that worked, it didn't address the problem at a deep enough level.
> 
> The fundamental issue with this broken firmware is that it's not
> saving and restoring several important GICR registers. The current
> list is believed to be:
> * GICR_NUM_IPRIORITYR
> * GICR_CTLR
> * GICR_ISPENDR0
> * GICR_ISACTIVER0
> * GICR_NSACR
> 
> Pseudo-NMI didn't work because it was the only thing (currently) in
> the kernel that relied on the broken registers, so forcing pseudo-NMI
> off was an effective fix. However, it could be observed that calling
> system_uses_irq_prio_masking() on these systems still returned
> "true". That caused confusion and led to the need for
> commit a07a59415217 ("arm64: smp: avoid NMI IPIs with broken MediaTek
> FW"). It's worried that the incorrect value returned by
> system_uses_irq_prio_masking() on these systems will continue to
> confuse future developers.
> 
> Let's fix the issue a little more completely by disabling IRQ
> priorities at a deeper level in the kernel. Once we do this we can
> revert some of the other bits of code dealing with this quirk.
> 
> This includes a partial revert of commit 44bd78dd2b88
> ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware
> issues"). This isn't a full revert because it leaves some of the
> changes to the "quirks" structure around in case future code needs it.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Just detect the quirk once at init time.
> - Fixed typo in subject: s/GiC/GIC.
> - Squash in ("Remove Mediatek pseudo-NMI firmware quirk handling").
> 
>   arch/arm64/kernel/cpufeature.c | 46 ++++++++++++++++++++++++++++------
>   drivers/irqchip/irq-gic-v3.c   | 22 +---------------
>   2 files changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f6b2e2906fc9..928124ea2e96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -999,6 +999,37 @@ static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
>   	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
>   }
>   
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +static bool enable_pseudo_nmi;
> +
> +static int __init early_enable_pseudo_nmi(char *p)
> +{
> +	return kstrtobool(p, &enable_pseudo_nmi);
> +}
> +early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
> +
> +static __init void detect_system_supports_pseudo_nmi(void)
> +{
> +	struct device_node *np;
> +
> +	if (!enable_pseudo_nmi)
> +		return;
> +
> +	/*
> +	 * Detect broken Mediatek firmware that doesn't properly save and

s/Mediatek/MediaTek/g

Apart from that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195, MT8192, MT8186:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

