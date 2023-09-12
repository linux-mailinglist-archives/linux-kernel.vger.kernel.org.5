Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004379D55E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjILPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3210EC;
        Tue, 12 Sep 2023 08:54:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52f31fb26e2so3956216a12.3;
        Tue, 12 Sep 2023 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694534054; x=1695138854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naPTFvozAWXUQ+jkhhTxqmTnrRwIprjMkqTTFQTivH8=;
        b=KwndC/FP298gd0UNffSVsT839746qCk2QGJvq+5MbaoiKyFdPz1HtV/NmsUNI3bA+S
         sc+53bfEe1ZtlYzFyDJxzmzaFX0hIcH07BF/0byEfoW9Gmiwpgb6aTHnMXvaZKWD/9ne
         ifT7vcTIHMfol0yoW0O4kYorVw8xr3OLQ2pwwcfKOWWH/DRkdq/Tb/prM8zSJW6PnqCf
         bE9SJH3nuDGiGFlXAKJ/eE8imqQZOvNPyVBp1JDuBnp/dOILvmAvSbd6WlCImdOCyWAf
         K2qDt9huy7NurXL4wvQlXlVauoEdshNhlwadzbdcWaddZr6Z0k4dBZErydPlyxqdV4KD
         CuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534054; x=1695138854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naPTFvozAWXUQ+jkhhTxqmTnrRwIprjMkqTTFQTivH8=;
        b=ww2+BYHIGLTgPRJljK01JOwjatfrb7bW4zKBl2zrK5C6Q8QInAUccCaea8f+u3CS79
         buTQCqRx503GNA/rrVkQpC9j3ftkJ4TPBnVcxkI19SUVFQrSkohpcFiQ4ZEtLqVw/vk+
         si+RPqgzHxgvQ0WKglsiHk8taG+wawCjG4lcBMRZKnOUQYLpMCyKS4gZqH+JQ6WES+pU
         pp8lNkyCV8mT0xX7hqoDhWIfv0rLbV3qAVwcLtLzqdzymL/n72wyKPr/NW1lvvx+OQkQ
         4YG5d/M9plXgGm8qRpbSdeu+f6/FJaR59CF6StWwmilMCHL1R724nFjWIFFloKgSP1eN
         G/gg==
X-Gm-Message-State: AOJu0YxmWgCZHKSNW8G7ShKT4t1VdhnQwlb0q0jU5x4XDuny1lqupFvE
        t9Rs2LXTLdR74cfImEqCfJM=
X-Google-Smtp-Source: AGHT+IGpuGAmmqRAkGB3XMTjinl3XRgL9kG9WDlXhj6mSNKbT2TUCt11mIr4e50oihi2f8L+s6Hu6A==
X-Received: by 2002:a05:6402:1843:b0:527:251e:1be7 with SMTP id v3-20020a056402184300b00527251e1be7mr45463edy.11.1694534053828;
        Tue, 12 Sep 2023 08:54:13 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id g2-20020a50ee02000000b0051e2670d599sm6134972eds.4.2023.09.12.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:54:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: allwinner: h616: Add SID controller node
Date:   Tue, 12 Sep 2023 17:54:12 +0200
Message-ID: <3181319.5fSG56mABF@jernej-laptop>
In-Reply-To: <20230912-sid-h616-v3-2-ee18e1c5bbb5@somainline.org>
References: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
 <20230912-sid-h616-v3-2-ee18e1c5bbb5@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 12. september 2023 ob 14:25:13 CEST je Martin Botka napisal(a):
> Add node for the H616 SID controller
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi index
> 74aed0d232a9..d549d277d972 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -133,6 +133,13 @@ ccu: clock@3001000 {
>  			#reset-cells = <1>;
>  		};
> 
> +		sid: efuse@3006000 {
> +			compatible = "allwinner,sun50i-h616-sid", 
"allwinner,sun50i-a64-sid";
> +			reg = <0x03006000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>  		watchdog: watchdog@30090a0 {
>  			compatible = "allwinner,sun50i-h616-wdt",
>  				     "allwinner,sun6i-a31-wdt";




