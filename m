Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C449878DDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbjH3SyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbjH3SRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:17:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2C8A132;
        Wed, 30 Aug 2023 11:17:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26722F4;
        Wed, 30 Aug 2023 11:18:07 -0700 (PDT)
Received: from [10.57.4.99] (unknown [10.57.4.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1A3C3F64C;
        Wed, 30 Aug 2023 11:17:26 -0700 (PDT)
Message-ID: <101f3b88-7151-af5c-3bd4-feb13763228b@arm.com>
Date:   Wed, 30 Aug 2023 19:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 5/5] ARM: dts: rockchip: Disable non-required timers
 for RK3128
Content-Language: en-GB
To:     Alex Bee <knaerzche@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230829203721.281455-4-knaerzche@gmail.com>
 <20230829203721.281455-14-knaerzche@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230829203721.281455-14-knaerzche@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 21:37, Alex Bee wrote:
> The Rockchip timer linux driver can handle a maximum of 2 timers and will
> get confused if more of them exist.

Wouldn't it be better to fix that? It looks trivial to do, and frankly 
it's a behaviour that doesn't make sense anyway. Of course a system can 
have more hardware available than Linux wants to use; that's not an 
error, it's just Linux's choice to not use it! See commit a98399cbc1e0 
("clocksource/drivers/sp804: Avoid error on multiple instances") for 
example.

DTs shouldn't be treated like Linux board files, so curating them around 
Linux-specific driver behaviour is inappropriate; FreeBSD or U-Boot or 
whatever are perfectly entitled to make use of 5 timers at once if they can.

Thanks,
Robin.

> RK3128 only needs timer0, timer1 and timer5. The latter is the source
> for the arm-timer and it's clock is prevented from being disabled in the
> clock driver so it can get disabled in the device tree, too.
> 
> Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> index 88a4b0d6d928..f3f0788195d2 100644
> --- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
> +++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
> @@ -252,6 +252,7 @@ timer2: timer@20044040 {
>   		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER2>;
>   		clock-names = "pclk", "timer";
> +		status = "disabled";
>   	};
>   
>   	timer3: timer@20044060 {
> @@ -260,6 +261,7 @@ timer3: timer@20044060 {
>   		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER3>;
>   		clock-names = "pclk", "timer";
> +		status = "disabled";
>   	};
>   
>   	timer4: timer@20044080 {
> @@ -268,6 +270,7 @@ timer4: timer@20044080 {
>   		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER4>;
>   		clock-names = "pclk", "timer";
> +		status = "disabled";
>   	};
>   
>   	timer5: timer@200440a0 {
> @@ -276,6 +279,7 @@ timer5: timer@200440a0 {
>   		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER5>;
>   		clock-names = "pclk", "timer";
> +		status = "disabled";
>   	};
>   
>   	watchdog: watchdog@2004c000 {
