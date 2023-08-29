Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842C78CB09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjH2RTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjH2RS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A2CD8;
        Tue, 29 Aug 2023 10:18:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99df431d4bfso614833566b.1;
        Tue, 29 Aug 2023 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329474; x=1693934274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWLxgtqau2yJo36SsneTQsDsVw22iqHp96edYBnf0k4=;
        b=DYqQwQyTYCKikxyb60b1L/cidyYBoJlyYx7DxCxp/DB+czy+oU22765aVqWMq9gChN
         hzGEHV6Ukz3+gA74rYbufEwC2om/X8PtXxXA3N4xznw7V3cK6OUceS64tiUtUh4lQPuZ
         qvxPqnf3hK4BA3whTsYfsEi6LxYF3o5Zmt46/Dv4v/PQEoWAF/mUpr/tVxZ7VVCfDarZ
         mLrYEkTYyOAS4e9Z4fXdLaY72iT9bCF1mJiIdDpUW5Iw6c1lmIe3+MiIWrm9ATp5bMj7
         ZuPqabLS7qMEYqkgArtWxlTFln3aqUH+fMUcDuldrO9akccaSGMeHmH6Nx3uouf7wLBI
         xCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329474; x=1693934274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWLxgtqau2yJo36SsneTQsDsVw22iqHp96edYBnf0k4=;
        b=ghg7oPYK+cKs8T6ZeFYF27ZLOr+4O0YOoOczlo99LreXsM5Rjzq1Q2ikpy1k+3MuXz
         vSYCDCUwHukaHD0ehp9jXFCnC4F43bdQoDMX2FGp2mgXkHYE4v9BFyhamF2rRygu82Zz
         9UGeFiZ/LObvPiRsTz7+IY6cj25J0nnCgS9w7xhC2Csv8TAga1yZK1HAqjRzsuLfwcQ4
         3b4b3UM05QicwdmALDn4D1AEgu3tw+I6HS2My6L/uu5x/EoGCbnxm2C8w9/SjUbFaYzj
         KW7sVJAJILOVqfrnyr5z7fdjVrsY/9eXVV0biSrGwe2gJ5eXgQCpmn9ZXBZdPq7nEyie
         g0rA==
X-Gm-Message-State: AOJu0Yzoq5IYmxiyss58tAGKNUIF81OshpFD5tcQSso9KrUiEPXaVuK0
        nTpjTsCEzSj15dmmmBAjOQ==
X-Google-Smtp-Source: AGHT+IHXNp8WBS05GZKX2uNVCiNbXcRpufiupVelX14WxEIUnMHV/eQymrQIzu4L1T4F5np5oSoR4g==
X-Received: by 2002:a17:906:13:b0:9a2:19ea:88fc with SMTP id 19-20020a170906001300b009a219ea88fcmr13209839eja.71.1693329474462;
        Tue, 29 Aug 2023 10:17:54 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:53 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 30/31] ARM: dts: rockchip: Add sdmmc_det pinctrl for RK312x
Date:   Tue, 29 Aug 2023 19:16:46 +0200
Message-ID: <20230829171647.187787-31-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pincontrol for sd card detection is currently missing.
Add it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 19bd6448d122..5388264b54f6 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -969,6 +969,10 @@ sdmmc_cmd: sdmmc-cmd {
 				rockchip,pins = <1 RK_PB7 1 &pcfg_pull_default>;
 			};
 
+			sdmmc_det: sdmmc-det {
+				rockchip,pins = <1 RK_PC1 1 &pcfg_pull_default>;
+			};
+
 			sdmmc_wp: sdmmc-wp {
 				rockchip,pins = <1 RK_PA7 1 &pcfg_pull_default>;
 			};
-- 
2.42.0

