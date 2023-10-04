Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7C7B7FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbjJDMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbjJDMuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:50:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858BDB0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:50:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so3476359a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696423832; x=1697028632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8103+2DoeKFEqiX+fTMq3nBm5GXXZ0NmtyT1CO5doI=;
        b=meEhAth+VwC6qwtzJ90LzxWJ8pG76D7UE3Q64qp9vif3DSSWIIRuquEig5QVx7EXZs
         QUG8+dtXh+VyLXQwExnRdcEbG27e+kzrJVH1jfXRYGRs5o/0jwJRTW/EbURnkLCW8YNZ
         UEnhCiVQczs+QmR4K2Ws8F4slNRfXl/ddyNNs1T0SLASZSGe+glvDY8iZ/X9hVvdkd/l
         mRlK3RSxfNW4njJdPs/V7kFkfl9Zl/mjear1Sy8VlErB7TBQWYUIZ5ges+WMBShSAJ0e
         gUjjk1gLGCRrtrWuyjEbEDiXFGl79eAOYSxalPYKIhih8k0XAyB/xGBSCEItNcDG+RGW
         K77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696423832; x=1697028632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8103+2DoeKFEqiX+fTMq3nBm5GXXZ0NmtyT1CO5doI=;
        b=LgbtQPxLL1qauL572SSlQixE82Aboph+BLVRhXW4hvFonRUWwNeTykabFq0wYoujG4
         RXrmPzinJ1Cz0F20eH1aI/x7x7aVvLqWMB8vVEKcZZFhgU3bYMeEuSzwIa+97kld8YmM
         W4IcBKpFTRzGCAM70626nzfq7z2nAsM78d2/qtnUnkeSUXa06r1EQRRBf1OTPa8QMkX2
         wKZHlH5hNOS/Y/l/lDFZpNySXlPnLZTgioAI8fEgo9V1Tsy1I2nr12oMrcUT7OgT/nl0
         PLzgHOpdAeUd9AbbChxecwjS8ytxByyViP64OZw6Uyv96Czuu2J4jzVzzW1RcBIESACX
         6vrg==
X-Gm-Message-State: AOJu0YzoziOlvRgv8wi8HIIdCh4g7eua8ei6zReFR1dZrCfETqxQAT1l
        xOTfp5WOpint2X0M6+kazjCRgQ==
X-Google-Smtp-Source: AGHT+IHBvFKSR1pr+MiEPqf3ArkWFdSnA/IbeXZ32rRS6n2xDUcqWsCH7R5q0f4o2DCdkDZm+j9DBg==
X-Received: by 2002:a17:906:51d6:b0:9b8:a6aa:a1ba with SMTP id v22-20020a17090651d600b009b8a6aaa1bamr1459153ejk.39.1696423831906;
        Wed, 04 Oct 2023 05:50:31 -0700 (PDT)
Received: from hackbox.lan ([86.123.99.172])
        by smtp.gmail.com with ESMTPSA id pk13-20020a170906d7ad00b0099bc08862b6sm2806580ejb.171.2023.10.04.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:50:31 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH 0/7] clk: imx: misc update/fix for i.MX8
Date:   Wed,  4 Oct 2023 15:50:10 +0300
Message-Id: <169642357601.745453.7013282402695515733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Sep 2023 17:18:58 +0800, Peng Fan (OSS) wrote:
> The patchset is to upstream NXP downstream i.MX8 clk misc patches which
> has been stayed in NXP LTS release for quite some time.
> 
> There are a few fixes, but should be fine to put in next tree.
> 

Applied, thanks!

[1/7] clk: imx: imx8dxl-rsrc: keep sorted in the ascending order
      commit: ab2c30f6bbe34dbf13ff2cc0cf7bc237de2df013
[2/7] clk: imx: imx8qxp: Fix elcdif_pll clock
      commit: 15cee75dacb82ade710d61bfd536011933ef9bf2
[3/7] clk: imx: imx8qxp: correct the enet clocks for i.MX8DXL
      commit: 8568b3c499268456b76cdc2e9e1b9d86d8b08837
[4/7] clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
      commit: 4fcb51fb0e3084ee81edaf8aea98ac01e456a871
[5/7] clk: imx8: remove MLB support
      commit: a699148b8704aa11600321b9f6b6b21f09418c42
[6/7] clk: imx: scu: ignore clks not owned by Cortex-A partition
      commit: eaefd1cf36a6507ff7dd2d30f68201de259eec63
[7/7] clk: imx: imx8qm/qxp: add more resources to whitelist
      commit: 2838820800dcaa60f32bef715c7e2e87e049aebc

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
