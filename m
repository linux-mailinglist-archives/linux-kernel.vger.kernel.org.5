Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2778CAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjH2RS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbjH2RSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FEBCE0;
        Tue, 29 Aug 2023 10:17:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so603840866b.2;
        Tue, 29 Aug 2023 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329455; x=1693934255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBQAx86WvaOm9XdYlFOZiKDZLABoSR2aNslGbzHlpgw=;
        b=YjhSA4kQm+ny80r016Dc472pNmS42pS1nmBOqM6oVPhNBKNJlGfLb1VzG6ozVtCF6x
         Mlyk33197iTKYGWOJtecIgwjpqlPxkQGfI/pRAOpXj485zDfiV/PQZgJDdgUDsifpH6W
         LVPXNmebt4tPML8gXvgpBgcI6wjLHgTdw+3WflobmCdqdL1TbtTLMeahRuWF8LxtlATr
         IKqdPLOqNzQALqccixO4n4ZLiVXScDyHxok1Foj+nS8E2ValnPtuN4jUWiEOK7qKTwIW
         2H4UL/qePX62A4CF+Z9Lw3aAxUzhqpesyFt7Q4G+715YvpCqNSDPku8LQs0jlfjZU5Cx
         fEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329455; x=1693934255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBQAx86WvaOm9XdYlFOZiKDZLABoSR2aNslGbzHlpgw=;
        b=ZFlmS2GygdBHdItRy8bLHa2Vo61gs3+De189HTwBb6LPtWHdtLPK9k24/lIGVKfNGV
         tjVeZ7wz+t6EUY1/BRVf1z347s5ZgWz+V0GFcAw80JKCLkkQgsm+rW60tggvTzN7GVLM
         0NbmBvWzH1r1LNs/f3inA3rXtwwCWGNDEa9ETZSZwUA/9z/Jj/eMmRiuhSL1wpc7wHhU
         Am4q4eW0WoKwj3jVNhwA+ZcP0/glDRmLOnno/IMwA/jocGM5k4EVZ39J0kPo0GBVMmKM
         mcjPOtisko06gXxKiweajD8bP9Mo5pDl4tJ7Rnz2fGbDgOfvhrIQLDcC/+DQhwbAO/0J
         S+2Q==
X-Gm-Message-State: AOJu0Yycqb9VtpHh59SVlcq8E6ZpwRtNDDYpGHCm1QZyGIkUQGUfhYrL
        5PEHSQzVzkSTxLO+lyy/BA==
X-Google-Smtp-Source: AGHT+IGriq1g6SBECfoMzn6NHKe8g9e4THTgJ8Zp6YWeIKJEJrAB+LeVhbZzVDvMc9306PK2d3bxNw==
X-Received: by 2002:a17:906:150:b0:9a1:d7cd:602d with SMTP id 16-20020a170906015000b009a1d7cd602dmr14195595ejh.45.1693329455250;
        Tue, 29 Aug 2023 10:17:35 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:34 -0700 (PDT)
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
Subject: [PATCH 11/31] ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
Date:   Tue, 29 Aug 2023 19:16:27 +0200
Message-ID: <20230829171647.187787-12-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A7 timer has 4 interrupts.
Add the mssing one.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 2e345097b9bd..bf55d4575311 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -64,7 +64,8 @@ timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		arm,cpu-registers-not-fw-configured;
 		clock-frequency = <24000000>;
 	};
-- 
2.42.0

