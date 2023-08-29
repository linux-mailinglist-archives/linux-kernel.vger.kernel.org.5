Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE378CAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbjH2RTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjH2RSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F390E55;
        Tue, 29 Aug 2023 10:17:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso597778066b.3;
        Tue, 29 Aug 2023 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329464; x=1693934264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TRUGa9PL5nV/dnusn+UwSq4N+QNad+BtpjMEE4na6E=;
        b=OZFbsoxBYbtJUhBBQxapgnMGaORPO11QLmwTffX0UwxhOO9s9i5coEpHA085+055+k
         x2iktQWtW72gYg3DJirC4o0W9QCuzVCpCgg1Gq9TYwIcuteNM07twA6BYqfOYdEpO9Io
         alnN55qzVOZz3qYGtXBRHU8IXdI9kiNllXn0qe8Y0YmWO55RgH6+pi4F+ol+JqpXg43t
         LKv+EOx4qMMSIL6Xux72JFIbrawAGnf7QkvbIwIxHzzB57j5vsQdqpoYujPoP79jWn5/
         5gq/p4lZFDf/SOPeI1jh1UaDWIfFIPHyi7l56l85xK4fnVcmf0s7N1wZqxOpeqdKWFO4
         ra7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329464; x=1693934264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TRUGa9PL5nV/dnusn+UwSq4N+QNad+BtpjMEE4na6E=;
        b=IlYVZ8uMClgejL5qtNzNJWXb1ZrxjFdM9wsRBjAY5ECIK3IJf9qceu5Z3IdTQ3pJcm
         5fQHDKC7YJWcuXzpAvo03v6o4PlbNjt/xCHsU2NEFuqh4lQPsw4Ex8c7KnTO0Oa1+GGo
         ZmTfpO92/4mWeeN6XHttRyrUk+UW74/wl5XY431kWwAFH7qEcN1cYePW72zYD4KonPTn
         NjkycT0MZBhLvyRpgthK8EfGdRyP4sFoTOj03c80Uo8Kr9IsbAfXvo2i2Je/YtFhCCIY
         qg0STcsrtI4llca4M8VTtj2dYi8LhhCXzxxExy2eH8p1mnwSYPMcTcpqLXKg4ooARAV/
         Qs+g==
X-Gm-Message-State: AOJu0Ywzeb0Gf9hCUunjHIOWwDB5SDMdS8i/Gk0v5UkpvdtPQyKbUYeL
        ZIxEXBSczpegYq7w9/wHCw==
X-Google-Smtp-Source: AGHT+IHSs6leoLR21rpe27haxf2M/3AjrTL1AjjD92jIJAICN7I5rW7t/aMEMKebF0K+otgr7qN1Ig==
X-Received: by 2002:a17:906:5346:b0:9a2:1ce5:1243 with SMTP id j6-20020a170906534600b009a21ce51243mr12595166ejo.60.1693329464222;
        Tue, 29 Aug 2023 10:17:44 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:43 -0700 (PDT)
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
Subject: [PATCH 20/31] ARM: dts: rockchip: Add extra CPU voltages for RK3126
Date:   Tue, 29 Aug 2023 19:16:36 +0200
Message-ID: <20230829171647.187787-21-knaerzche@gmail.com>
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

While RK3126's CPU cores can operate at the same frequencies as RK3128, but
it needs higher voltages.
The values have been taken from vendor's downstream kernel.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3126.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3126.dtsi b/arch/arm/boot/dts/rockchip/rk3126.dtsi
index 7345bd95d29d..09c40f3d69a8 100644
--- a/arch/arm/boot/dts/rockchip/rk3126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3126.dtsi
@@ -7,3 +7,30 @@
 / {
 	compatible = "rockchip,rk3126";
 };
+
+&cpu_opp_table {
+	opp-216000000 {
+		opp-microvolt = <1000000 1000000 1425000>;
+	};
+	opp-408000000 {
+		opp-microvolt = <1150000 1150000 1425000>;
+	};
+	opp-600000000 {
+		opp-microvolt = <1150000 1150000 1425000>;
+	};
+	opp-696000000 {
+		opp-microvolt = <1150000 1150000 1425000>;
+	};
+	opp-816000000 {
+		opp-microvolt = <1200000 1200000 1425000>;
+	};
+	opp-816000000 {
+		opp-microvolt = <1200000 1200000 1425000>;
+	};
+	opp-1008000000 {
+		opp-microvolt = <1350000 1350000 1425000>;
+	};
+	opp-1200000000 {
+		opp-microvolt = <1425000 1425000 1425000>;
+	};
+};
-- 
2.42.0

