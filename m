Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FBC7BC6A6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbjJGKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:09:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B292
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:09:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50325ce89e9so3824131e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696673339; x=1697278139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWGnWC1nRItaPmklKxpuYvpPobvm6bbDsTmyxg2t6ZQ=;
        b=FB0urXCoJOUCihbq5Qa3FiZ2LBXgzEYnREC5SL9ujYOCl+XeI+v9UtS6uEvxThZlM6
         aSvkFFXQkq4YrEMce2n4g5vHBJnsKj7vjaE9SlIYe+b7MoCifM5Uy85RjR7kV7CFA6S3
         MNVuJ3VLl6kjpD6NrWUirMMk47zaDKK9frtknUNPP6v0CA4ezQi0x7ATVojfmZl2K32X
         1ybAcSiVKedbMkgXYaUWzetWsAzATLmLK4bgUgwfzWRBkn835xglqaDnTRzjilDQnUI3
         J44v6LFhjHhOuJiktw+zZ1bKT1e0txxgCJlzo5HVfqmUkK9rvydFODoXcSaMBrn4+Cem
         Doiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696673339; x=1697278139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWGnWC1nRItaPmklKxpuYvpPobvm6bbDsTmyxg2t6ZQ=;
        b=FGnS2S/nSgVmbM3r/343sG7JgQS7c0ixl/nxrUljyxba6bs0aCc7dwooQpO2B0OnNd
         Y8SoqAMd+0uje6o7TlDqIDR3SFJGKRdgDDrwP1ZNLSGwwXFs0AnhwqNJ/cyAYJKaJpsV
         b/MvYWvVpaNRBfcOl7z7+S/Gb/iZ7zcapTHIUlS53WQOAaIX7zu/CcMWEneguWHmbUSs
         4Ddfz9SX87aH84QTiSfTKU0RPptwViFsomxP/mkI+vwlrGkHvXmaHk35YI9GweZX3xK4
         hu9RAda3GQWIMeQG9ksi30LeZMepFgXuUPK09TdV5cGYNzRkiyU8k1A7m8EKWCjPS+pp
         ePeQ==
X-Gm-Message-State: AOJu0Ywn5nJwzp2I6TA2lIF/n0Mu0FF1Bq+Bw2C1B9DEl/wIze90aPUU
        PxPMIiZfRh/h8VF7R0BQ0Z0IZw==
X-Google-Smtp-Source: AGHT+IG0CVCgqlPv2wxsTilLt17MBMEobW1SOqaRN9HJEasIJ3z9GUosQp+zA7kkduMp8d0uOJsWaA==
X-Received: by 2002:ac2:5e33:0:b0:502:9c4e:d46a with SMTP id o19-20020ac25e33000000b005029c4ed46amr6837138lfg.32.1696673338827;
        Sat, 07 Oct 2023 03:08:58 -0700 (PDT)
Received: from [172.20.10.4] (82-132-213-54.dab.02.net. [82.132.213.54])
        by smtp.gmail.com with ESMTPSA id v7-20020adfedc7000000b003197efd1e7bsm3796811wro.114.2023.10.07.03.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:08:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Kumar Thella <sthella@codeaurora.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, asahi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20231003064018.7502-1-zajec5@gmail.com>
References: <20231003064018.7502-1-zajec5@gmail.com>
Subject: Re: [PATCH V2] dt-bindings: nvmem: move deprecated cells binding
 to its own file
Message-Id: <169667333484.74178.7121029453685069845.b4-ty@linaro.org>
Date:   Sat, 07 Oct 2023 11:08:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 08:40:18 +0200, Rafał Miłecki wrote:
> Support for old NVMEM fixed cells was deprecated in favour of
> "fixed-layout". It's still part of the nvmem.yaml though and may be
> unknowingly used by new bindings added without much of analyze.
> 
> To make it more difficult to accidentally support old syntax move its
> binding to separated file with "deprecated" in its name.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: nvmem: move deprecated cells binding to its own file
      commit: 6d25308bb9deb10ae62bdeefdf2362072a5a4836

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

