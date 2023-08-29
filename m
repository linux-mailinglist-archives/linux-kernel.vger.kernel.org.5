Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0C78CB05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjH2RTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbjH2RSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E091B7;
        Tue, 29 Aug 2023 10:18:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so71471001fa.1;
        Tue, 29 Aug 2023 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329471; x=1693934271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4PHXGicMxBk+MJKalmg1iNAvJdEv1pEopykpBO9nUE=;
        b=EShIb7E+Z3Us6tkTRIUmptYNcn1c25vEpCspbQxGLoL+VKjAo/XzXV/t/I+jrto2Lx
         gVt5UeRIM1WKSIll76L1JN3B79kBVT0lfFGsZnECJ+uNIBuxz1f7TJblkBfZMrSiQIGT
         /0z+a+iJBak/4doNX0w1w3AVduVoXz63YzJV0i4k16xgEWkLoxvOSrJX0wFxYJv9WUY1
         Rjb/7WG9lvaXaAj6RvmuX6qBaDS2uP3leouUnNxofbkxuT0zXGRF2JJDC72nriYF029x
         j27ZDobOtTmUm6vnZjKJWnpQrz5BBImekLEhx/6psHKvowGH9bJ2vhLR1YW4bkq4R6lN
         XaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329471; x=1693934271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4PHXGicMxBk+MJKalmg1iNAvJdEv1pEopykpBO9nUE=;
        b=hM6QDBlKUZatpz0UEUsDuMZbSZWn1AQky/y9OBmt7aHiwR9WeE9gQICIws42+f0rUo
         TOa34pGMRiSlLCXC3pRb6sBQrQ/s3o+d1XHuMGboFII7k08bTcu+X3OkxGvpwBuYNV6L
         7RBvpsvpgSgu96lNoGwLiVjJDi2vXSoSziWlxGSKntRncwrBLcN55TxsOR6JmU7N59dV
         Q/ynbu3PFSikCifkxKfgGlqg2YWe9JfLFBoON8spLwjCRb7p1dgH4GiXTGlwdyABqSfM
         Bi7Iw/Zqk0fkd9A3+kzObEVl0WB95RYTl4jiEYnwVXBm1egwnHuduKFVAFEPzk32fK3g
         zE7w==
X-Gm-Message-State: AOJu0YzkUmtgpDgBD0LivQ/oVhkWvSlSedBvr7UbXwbBB5iTP6a0fpMX
        cy3a/A3dZI+fGDH2rJh37Q==
X-Google-Smtp-Source: AGHT+IEQB3R89Y565RxZaGfUe+xAj9rNo4DRqqtlbGvy1GBw6QhT8IIxT0/e3EW2cHJ2YckOECQ8ww==
X-Received: by 2002:a2e:9084:0:b0:2b9:f007:9910 with SMTP id l4-20020a2e9084000000b002b9f0079910mr20989559ljg.53.1693329471278;
        Tue, 29 Aug 2023 10:17:51 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:50 -0700 (PDT)
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
Subject: [PATCH 27/31] ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK312x
Date:   Tue, 29 Aug 2023 19:16:43 +0200
Message-ID: <20230829171647.187787-28-knaerzche@gmail.com>
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

The driver currently won't probe correctly if those values are missing.
They have been taken from dowstream kernel and match those of other
Rockchip SoCs.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index ce3f03c3532e..019aa92c0cfa 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -280,6 +280,9 @@ usb_otg: usb@10180000 {
 		clocks = <&cru HCLK_OTG>;
 		clock-names = "otg";
 		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
 		phys = <&usb2phy_otg>;
 		phy-names = "usb2-phy";
 		status = "disabled";
-- 
2.42.0

