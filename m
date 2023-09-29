Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5B7B2EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjI2I55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjI2I5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:57:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F72CC5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:57:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1850077266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695977866; x=1696582666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsBQLJ6Ogoic+1/xmfT0u8ONBi3qeWxubxgbbL3TF8o=;
        b=sSKLG8DlJQkPzhZ3rUopVPn6OtPZvVVeFDV2Kfu6S5J4o7uX4CaShffB2DAtwYutch
         KpQCQ4Vy61zO2NC8vmc4nkE0E7Oz1u9wXM+YalPVaeKfq29B5NgyavQ4egg2PZBlnEMl
         a2e32vEBp3E+3/eCvjPeF/VUcqZOSFzfhpprQQAJvZZh2SQlBs4wpf6eA49QADEieBvV
         +Bdpk2e5VnLaYlaqxR+a8CBFn7wcgmWxG/YIAh4SX99pMclov7uBbEQ+aUuD62YU3fuW
         ZH7Xn4MqBM07CvXjMHRH0MNo/W06jDyKuFRwP+9FFwRgV/FJBRdO7cKGC1DG+9aBYCl8
         gjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695977866; x=1696582666;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsBQLJ6Ogoic+1/xmfT0u8ONBi3qeWxubxgbbL3TF8o=;
        b=vSSN5ZYLX7RgM/uaHkVNaBaPfKE+Ajad09P5OC4o9HRYm+/8z9mbSC/JYBRIe7msAA
         RcPwuEo23LwT53tYhLPwF2+wzIgY55BxFoPTsesMKtWpE1aj4bEM2ctqhonULOJrWT5K
         Gh/Ta3yuhIHGYlSdm2qW+Ov7dVCM/oxdbJjSSXUA9vcAw0mb4F0yRq/b3tgsQnw4BpTL
         FqcPzFR+gl9sFlFRYBbEcVvnb5j47KMp+f5gIMpPSQ1++6MRq4gD1msoYBdbZep5Jmf6
         nDpqh+hECqDfuAvlmZE4qWAqUXlYVIb8b6okpbgr85WWKcopqrtAaeVKBDnY56KZIPaw
         ypmg==
X-Gm-Message-State: AOJu0Yzp2VPZuf/B1IJDqhaBlClUnjW9LynIgzJd5jah8folfdunOfsH
        61NwVQuqctAVemcMK+dFmxZMuA==
X-Google-Smtp-Source: AGHT+IEsrmtSBffKc4/0WejFkmq1arFW3oxGMi3C1GOThUgoHMTSmFySeXvpixD0/kTwmWhaMqbTUQ==
X-Received: by 2002:a17:906:28e:b0:9b2:b749:ff93 with SMTP id 14-20020a170906028e00b009b2b749ff93mr2957352ejf.24.1695977866113;
        Fri, 29 Sep 2023 01:57:46 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w27-20020a17090633db00b009a2235ed496sm12339806eja.141.2023.09.29.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:57:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230927204446.4231-1-zajec5@gmail.com>
References: <20230927204446.4231-1-zajec5@gmail.com>
Subject: Re: [PATCH V5] nvmem: add explicit config option to read old
 syntax fixed OF cells
Message-Id: <169597786418.99756.8731565742524355843.b4-ty@linaro.org>
Date:   Fri, 29 Sep 2023 09:57:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 22:44:46 +0200, Rafał Miłecki wrote:
> Binding for fixed NVMEM cells defined directly as NVMEM device subnodes
> has been deprecated. It has been replaced by the "fixed-layout" NVMEM
> layout binding.
> 
> New syntax is meant to be clearer and should help avoiding imprecise
> bindings.
> 
> [...]

Applied, thanks!

[1/1] nvmem: add explicit config option to read old syntax fixed OF cells
      commit: ee73a9fae540adbb432bd2854a82409515c7c892

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

