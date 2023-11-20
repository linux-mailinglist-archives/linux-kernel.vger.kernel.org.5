Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A27F0DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjKTIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjKTIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224CA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507962561adso5979874e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469982; x=1701074782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaLlJ6X3V1xHNer/E9XxQegzqXLhmCjDZ2XDUDwECf0=;
        b=hFF9v8vxRv3WzQLLMENRefHc3LQUaAWnQkMYDw1qFjrHNM0+9LgFNwfIp34rX0G1bU
         Jynegwftr7oKGKrl/gsv5U3Isj19tQHrzyCmmFrO42K36hK9iKYBFfWIvzpovU4OUowl
         GzLwnBmOGorEbRCaHvAIkNE97Hu1TqX08Sm00Dus7e/fJllQjP/hNe29oc5OLzR4hsSj
         gRFPXvs6+pBVsbI6tjgyjHio3FC4hy0lBbIkdnT9whjZ9YsKEhogGh1y8uhjtng/NvzP
         Tf9dtG4SKZyfathYIbTijyIMrWgoU7gjDMUUsIsgDibyoF85lJE45aJdO/glM0undr5J
         EWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469982; x=1701074782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaLlJ6X3V1xHNer/E9XxQegzqXLhmCjDZ2XDUDwECf0=;
        b=Khov6c9s6eSfrT66Xk/gn1ZZfVkWGcFg1wqTg5Cw9KB7K51nrn3ubJQrIb+/fy/vr1
         ASau8ZHh8G26Jk458DL/ySGH0c/zqqPIdtBTmm5EduIjpeQ/Dpz+4XrlqtfCTW9h9Nud
         vc8Y+xNs7PBfltYCMSXHQT97JXK536joQXpbFLGRyrE0Pnvb+t/4GtdsrZJc0whynUQI
         pjEYeX6ovHT+xOAb4T1OGoPgj3pidND9QfaADgE3HxfISblT+XgSwapPPqISwJ5yMNjs
         N0u7KulBYOGO2qgg+hzBB0lH63ppvlx74k0cNi3NYTCjgu46lnOPIv7+Fupaex/12GVJ
         Av4w==
X-Gm-Message-State: AOJu0YwCthdZry3tcpMn4ryapekiPU4imj6MKmBvr2FoctwkEBNhjfLE
        IKnqHxX/tGwa0tiMO0BVJgv0PA==
X-Google-Smtp-Source: AGHT+IEf8vUgakOaNbWbAB6YxeQiP2RuYbpQL+g5e2su4/B8sSFdfMT3asP/LNDHBhO+rU+q30rUUQ==
X-Received: by 2002:ac2:5297:0:b0:507:c871:7888 with SMTP id q23-20020ac25297000000b00507c8717888mr4574449lfm.9.1700469982498;
        Mon, 20 Nov 2023 00:46:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:22 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 03/13] net: ravb: Make write access to CXR35 first before accessing other EMAC registers
Date:   Mon, 20 Nov 2023 10:45:56 +0200
Message-Id: <20231120084606.4083194-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hardware manual of RZ/G3S (and RZ/G2L) specifies the following on the
description of CXR35 register (chapter "PHY interface select register
(CXR35)"): "After release reset, make write-access to this register before
making write-access to other registers (except MDIOMOD). Even if not need
to change the value of this register, make write-access to this register
at least one time. Because RGMII/MII MODE is recognized by accessing this
register".

The setup procedure for EMAC module (chapter "Setup procedure" of RZ/G3S,
RZ/G2L manuals) specifies the E-MAC.CXR35 register is the first EMAC
register that is to be configured.

Note [A] from chapter "PHY interface select register (CXR35)" specifies
the following:
[A] The case which CXR35 SEL_XMII is used for the selection of RGMII/MII
in APB Clock 100 MHz.
(1) To use RGMII interface, Set ‘H’03E8_0000’ to this register.
(2) To use MII interface, Set ‘H’03E8_0002’ to this register.

Take into account these indication.

Fixes: 1089877ada8d ("ravb: Add RZ/G2L MII interface support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0486add302b3..d798a7109a09 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -515,6 +515,15 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 
+	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
+	} else {
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_RGMII, CXR35);
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
+			    CXR31_SEL_LINK0);
+	}
+
 	/* Receive frame limit set register */
 	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
 
@@ -537,14 +546,6 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
-
-	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
-		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
-	} else {
-		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
-			    CXR31_SEL_LINK0);
-	}
 }
 
 static void ravb_emac_init_rcar(struct net_device *ndev)
-- 
2.39.2

