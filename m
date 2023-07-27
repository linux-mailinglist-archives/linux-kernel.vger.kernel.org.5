Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F276568D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjG0O6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjG0O6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:58:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AAF4196;
        Thu, 27 Jul 2023 07:58:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1506CD75;
        Thu, 27 Jul 2023 07:58:54 -0700 (PDT)
Received: from [10.32.102.67] (e110479.arm.com [10.32.102.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9D33F5A1;
        Thu, 27 Jul 2023 07:58:07 -0700 (PDT)
Message-ID: <7f4a7739-cb03-bda8-df90-e8eb119b732b@arm.com>
Date:   Thu, 27 Jul 2023 15:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: pinephone: Add pstore support for PinePhone
 A64
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
Content-Language: en-US
From:   Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/07/2023 22:34, Andrey Skvortsov wrote:
> This patch reserves some memory in the DTS and sets up a
> pstore device tree node to enable pstore support.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> Gbp-Pq: Topic pinephone
> Gbp-Pq: Name 0161-arm64-dts-pinephone-Add-pstore-support-for-PinePhone.patch
> ---
>   .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 87847116ab6d..84f9410b0b70 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -19,6 +19,22 @@ aliases {
>   		serial0 = &uart0;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pstore_mem: ramoops@61000000 {
> +			compatible = "ramoops";
> +			reg = <0x61000000 0x100000>;

So what's the significance of this address? That's 528MB into DRAM, so 
somewhat in the middle of it, fragmenting the physical address space.
And is there any other firmware component that needs to know about this 
address?

Cheers,
Andre


> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			ecc-size = <16>;
> +		};
> +	};
> +
>   	backlight: backlight {
>   		compatible = "pwm-backlight";
>   		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
