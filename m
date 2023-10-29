Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA817DAAD8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJ2E2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 00:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJ2E2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 00:28:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80193171E;
        Sat, 28 Oct 2023 21:27:55 -0700 (PDT)
Received: from localhost (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21E036607340;
        Sun, 29 Oct 2023 04:27:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698553673;
        bh=AC+Ls3ytNnSvtsq4GFfS8dc+BFMLEfoCVREKO8KW7lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBPXQz2GQGNqffqr51uwLxSOhlWrlkDw3YEFs3NbSf/nxgGJOX1fcRb6/DIhxT13w
         gNjyWhoEGy6ckmKdXx87Nqn6KdlEUhVgboS5Gy40r6ymqy5eYtuWeajVDgkqWHVOJg
         I9Eq0d8Wil0pk8/ZKzljUpTNKrufiMAVWlMujcY4jig24W4WVWezOr+TOm0ymEetan
         +wqbErUZw9mkSdnV7eMBlLLnQohAi+RhCwneJRwQUHnmc2A1YWDiyDF/Dz2EApxyW0
         gE2lcXa3TgbG+ktNl+mvhxtR5uG5p7bAN6zMkjQ4hj6Sc9sw7PqWb6bzfFLk0r7nza
         Our6kpSl5wJ0Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable gmac and setup phy
Date:   Sun, 29 Oct 2023 06:27:11 +0200
Message-ID: <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
RGMII-ID, but requires manual adjustment of the RX internal delay to
work properly.

The default RX delay provided by the driver is 1.95 ns, which proves to
be too high. Applying a 50% reduction seems to mitigate the issue.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../starfive/jh7100-starfive-visionfive-v1.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
index e82af72f1aaf..e043a27f7612 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
@@ -18,3 +18,20 @@ gpio-restart {
 		priority = <224>;
 	};
 };
+
+&gmac {
+	phy-handle = <&phy>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy: ethernet-phy@0 {
+			reg = <0>;
+			rx-internal-delay-ps = <900>;
+		};
+	};
+};
-- 
2.42.0

