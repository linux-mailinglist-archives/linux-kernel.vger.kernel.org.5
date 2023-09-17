Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36B7A35F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjIQOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjIQOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:44:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2712D;
        Sun, 17 Sep 2023 07:44:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9d6b98845so1046227066b.0;
        Sun, 17 Sep 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694961856; x=1695566656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76MVv177zY9dsxPsQgQCgjtWxWwiLSVOTVF9dOpujsM=;
        b=WL3BRlfIKnIeIfKqYwZ7AjUBFqfzH4+pqQcZRrucX5Tr63MltQ7MjNkqQ/aoNd9XeG
         Xam++R8jTxWdDig+2fQO2PSp3JQkrBuNpX6kjE8etwsSZI2FiPoPUG0LJ33HiCmC0WLj
         aQr8cen8oScLhMFhmi4+oOS8TSBSTlOsWAJd0BuCLW18SF85KfXwAv9tOkPnZ5cBBBIw
         8fo6LOv0nFuvrO+4RMdbLpvrKCKZKueoRxScI7XqZfFCY98EqhdcDzJm3e6hMbpXq4Hw
         pEO4THXtUUMuW+LclwO7b6ceC00UbRiE9mMdtdIsMr95NuBqMAw0rxAOSwVhd5c3Ew6g
         pYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694961856; x=1695566656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76MVv177zY9dsxPsQgQCgjtWxWwiLSVOTVF9dOpujsM=;
        b=cvHtzCiqzMgfSv1keEPmXrNEMR/PHU1sMkTLnhY6DU/dUyNZ4iStjwhkrIq+ktxzoq
         7qwwXsraL8zHI5G/OJw1rqWXbS+fM4ic/eMso3pdIAV1y7PFptGDFrG968jP3jI8JEN0
         LqPR3EaznE/QFlrh8wxrIZlpKSu6J3MM8S8D0HV9HSSAVpg45Fn5oDRgSovmHi2y8Bgi
         g37BkuswCaEhjW79xeRzaw+u2ruSTPgbHEgnrdoSbdf2OZ7b5+sDzcTetwV2qKoRlH37
         GjmJ09vj3okhUrA0mwRojPQnHfnq9MUashir32i8lopvvuXzhHxbzdme2K2PeSDC6dvw
         GMPA==
X-Gm-Message-State: AOJu0YzvC4U+VjPsHOOQbduQ6QZtjzbt/MXdeeDV+e1Kl0pigcPXikCs
        y3wa/l0XrZYmbOIU46JJoSU=
X-Google-Smtp-Source: AGHT+IG10fQvNKmNWOCHHO3EJrMAN6SKA+/1Io0nXHROE7X4TQTiZl1pdzhSV1Hr6ZXK4WLsYWLxDQ==
X-Received: by 2002:a17:907:728e:b0:9a1:c69c:9388 with SMTP id dt14-20020a170907728e00b009a1c69c9388mr10830626ejc.37.1694961855448;
        Sun, 17 Sep 2023 07:44:15 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-246-155-gprs.simobil.net. [46.123.246.155])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b009a2235ed496sm5176569ejx.141.2023.09.17.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 07:44:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: allwinner: remove address-cells from intc node
Date:   Sun, 17 Sep 2023 16:44:12 +0200
Message-ID: <4863891.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230916-saddling-dastardly-8cf6d1263c24@spud>
References: <20230916-saddling-dastardly-8cf6d1263c24@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 16. september 2023 ob 11:14:00 CEST je Conor Dooley napisal(a):
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A recent submission [1] from Rob has added additionalProperties: false
> to the interrupt-controller child node of RISC-V cpus, highlighting that
> the D1 DT has been incorrectly using #address-cells since its
> introduction. It has no child nodes, so #address-cells is not needed.
> Remove it.
> 
> Fixes: 077e5f4f5528 ("riscv: dts: allwinner: Add the D1/D1s SoC devicetree")
> Link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.41844
> 68-1-robh@kernel.org/ [1] Signed-off-by: Conor Dooley
> <conor.dooley@microchip.com>
> ---
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Chen-Yu Tsai <wens@csie.org>
> CC: Jernej Skrabec <jernej.skrabec@gmail.com>
> CC: Samuel Holland <samuel@sholland.org>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-sunxi@lists.linux.dev
> CC: linux-kernel@vger.kernel.org

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi index
> 8275630af977..b8684312593e 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -30,7 +30,6 @@ cpu0: cpu@0 {
>  			cpu0_intc: interrupt-controller {
>  				compatible = "riscv,cpu-intc";
>  				interrupt-controller;
> -				#address-cells = <0>;
>  				#interrupt-cells = <1>;
>  			};
>  		};




