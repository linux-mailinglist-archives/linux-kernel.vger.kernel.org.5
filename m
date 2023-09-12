Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878C79D55C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjILPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813C10DE;
        Tue, 12 Sep 2023 08:54:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52c9be5e6f0so7009067a12.1;
        Tue, 12 Sep 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694534044; x=1695138844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMxqjxINpBKmoDA3h46D0q6wWk2nU0MFsPl5bWg4Cmg=;
        b=K+ea89xVeHGV+O70oWKW0jd7pGv8cM+iZRn+5JxxNqoBesQqEczyGQK8VwKnRhPNp8
         pctOvzA4xSWD7YS20zjv4GZCVJm6BYSqdiui5sLEUT6UaCcB5xvieqstjb63mvbEoHVE
         wKcVN0Fa52LaKEhi2AJ+T3hx7HzROXOXX0J2sm09l5JpZHEe0Kv9MojWxT+16SntWqrC
         17RQtiLQESXdOaIiKfG14F1tnZO5jLQAXJvwllpgXDynRQVbGy3W++j9JMDenr41SJrz
         vA5wUdFfQ1JnFUgG/dAJyxPLw75YthLW+Ja2rS7xa1S+Cb9Ro+7X2FcuX7bw1/jMWtZi
         PaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534044; x=1695138844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMxqjxINpBKmoDA3h46D0q6wWk2nU0MFsPl5bWg4Cmg=;
        b=hSMFPpZSAIKGifJMe74wWEUABmbn/FepME484PNzLEfUs3wXP+6/dcC935BLBT4u+y
         grc4INDJBK4gpTDWUGMyTff7XSSCgMO/XYAj2jt7vhbkAV9G0TxBCv9v/prhuQfWY9YY
         JEGIZGI2BtAE//040EJl5y7XV2/KwnVf2cbpKRelfnVDdiQBgTINFeaR6vDM9MNWKlAR
         vjKwqXAN62aXyJgRM2/U7FCrR8DTTi/cIVqFSRieB56qONdfgZ50hWUickkugaNdhvim
         +POieY/KL08VHCo5mOtTv8AtCBjtYGRHDZkVgP2nk3hxGKRUXQo6HpPlhinIjaF60w62
         pRrQ==
X-Gm-Message-State: AOJu0Yy4s99xogHUfQUi9QqaNrZSiQzyAeZ8uqFCfgepA2Bm+zJXicKd
        8dDt3WV32aj1+/R1AeVt4Spe+O+358UvbrqC
X-Google-Smtp-Source: AGHT+IFtlqJFjepBWnpt2aVpFMTJpzCouDuA9rqIlouy2f2Zvq4jrDKJs5qfWVg5IApWZhEf7i0+5g==
X-Received: by 2002:a05:6402:14c7:b0:52f:c073:9c37 with SMTP id f7-20020a05640214c700b0052fc0739c37mr55181edx.3.1694534044308;
        Tue, 12 Sep 2023 08:54:04 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7d684000000b0051dfa2e30b2sm6142713edr.9.2023.09.12.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:54:03 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
Date:   Tue, 12 Sep 2023 17:54:02 +0200
Message-ID: <3517711.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20230912-sid-h616-v3-1-ee18e1c5bbb5@somainline.org>
References: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
 <20230912-sid-h616-v3-1-ee18e1c5bbb5@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 12. september 2023 ob 14:25:12 CEST je Martin Botka napisal(a):
> Add binding for the SID controller found in H616 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml | 4
> +++- 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> index 296001e7f498..0928ec408170 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> @@ -23,7 +23,9 @@ properties:
>        - const: allwinner,sun20i-d1-sid
>        - const: allwinner,sun50i-a64-sid
>        - items:
> -          - const: allwinner,sun50i-a100-sid
> +          - enum:
> +              - allwinner,sun50i-a100-sid
> +              - allwinner,sun50i-h616-sid
>            - const: allwinner,sun50i-a64-sid
>        - const: allwinner,sun50i-h5-sid
>        - const: allwinner,sun50i-h6-sid




