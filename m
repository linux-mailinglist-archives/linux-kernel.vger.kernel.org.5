Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF62782DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjHUQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjHUQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:08:29 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E36E4;
        Mon, 21 Aug 2023 09:08:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1B1061C0004; Mon, 21 Aug 2023 18:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1692634105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3h+5K3nJFrTdEYrbKtvLLhmyVimLfcmMypOuvflm9I=;
        b=G0rEhsFGBHKL2nFBgNm+Rf8na9z+iQKQRMHPuzcaTtc2Khb7ceMeRn8flR9cImjCxb1Gl/
        AjZtb/QrqwzsonZ8PGWu5e/1T6FL8oQZFhFjdK2beISHkLub19hFD0o/hydgMYgqX6HqbS
        yHdpl9SYYeYl6QXgLtnkA6cAPfUlCic=
Date:   Mon, 21 Aug 2023 18:08:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH] arm64: dts: pinephone: Add pstore support for PinePhone
 A64
Message-ID: <20230821160817.GA2227@bug>
References: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724213457.24593-1-andrej.skvortzov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch reserves some memory in the DTS and sets up a
> pstore device tree node to enable pstore support.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> Gbp-Pq: Topic pinephone
> Gbp-Pq: Name 0161-arm64-dts-pinephone-Add-pstore-support-for-PinePhone.patch
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 87847116ab6d..84f9410b0b70 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -19,6 +19,22 @@ aliases {
>  		serial0 = &uart0;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pstore_mem: ramoops@61000000 {
> +			compatible = "ramoops";
> +			reg = <0x61000000 0x100000>;
> +			record-size = <0x20000>;
> +			console-size = <0x20000>;
> +			ftrace-size = <0x20000>;
> +			pmsg-size = <0x20000>;
> +			ecc-size = <16>;
> +		};
> +	};

dts is supposed to be for hardware description, but this is really policy decision.

Should we have something like "any dram is suitable for pstore"....?

Best regards,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
