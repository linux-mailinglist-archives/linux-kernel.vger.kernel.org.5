Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B479C01F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbjIKVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbjIKOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:54:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D669BE40;
        Mon, 11 Sep 2023 07:54:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA080D75;
        Mon, 11 Sep 2023 07:54:58 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DF563F5A1;
        Mon, 11 Sep 2023 07:54:20 -0700 (PDT)
Date:   Mon, 11 Sep 2023 15:54:18 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     longqi <longqi90@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] fixes the pin settings of two LEDs on board nanopi neo
 plus2
Message-ID: <20230911155418.330e2334@donnerap.manchester.arm.com>
In-Reply-To: <20230911140959.2046340-1-longqi90@gmail.com>
References: <20230911140959.2046340-1-longqi90@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 22:09:59 +0800
longqi <longqi90@gmail.com> wrote:

Hi,

please add a few lines here saying why you fix this: it looks like the red
LED wasn't working at all, because of the wrong GPIO, and the colours were
actually swapped? This would be good to know for everyone reading this
patch.

In general this is a good catch, so thanks for sending this!
More below:

> Signed-off-by: longqi <longqi90@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> index 4c3921ac236c..0cb7a07ab1de 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> @@ -26,14 +26,15 @@ leds {
>  		compatible = "gpio-leds";
>  
>  		led-0 {
> -			label = "nanopi:green:pwr";
> -			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> -			default-state = "on";
> +			label = "nanopi:red:pwr";

label is now a deprecated property. That's fine for existing DTs, but I
guess touching this node means you should update this, by using "function"
and "color", as described in:
Documentation/devicetree/bindings/leds/common.yaml

> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
> +			linux,default-trigger = "default-on";
>  		};
>  
>  		led-1 {
> -			label = "nanopi:red:status";
> -			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
> +			label = "nanopi:green:status";

Same thing with label here, please use "function" and "color".

> +			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
> +			linux,default-trigger = "heartbeat";

I don't think we assign default triggers for LED merely labelled "status",
as people might have different use cases for this. For instance I'd find
a USB or eMMC trigger more useful. So you can just drop that line.

Cheers,
Andre
