Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310C7684AB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjG3JkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjG3Jj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:39:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4791BDF;
        Sun, 30 Jul 2023 02:39:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso33243725e9.1;
        Sun, 30 Jul 2023 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690709996; x=1691314796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfBFXLrOBDfsMdVxv/cKnvMiArytdOBrw7zZET7q5qM=;
        b=C7czUkMxxa8NUewFli3hgwg9AMhey5n+tjTIhq9QOmXrA1EB0FOi1uG/AoMutOvUja
         oK3aAnKLZnfKt9zZkA7FHSFmw1a+rErLpA4qROO9ib4CXnMhF1GLu1346+W39QRaMAe5
         oMFeXKCGGbSmBE2RWrHlEtt1xCXHIZ7nv5EFFQg6R7aiRmKFE6u+q6JN/qm3LDqcSH9k
         sPDUPVTtngAfi5vEpkPCnkc1ML06Ll9/xYe097rPvdMbf7nUv7CY3vCBgSAIn6iiOpP6
         iYKpGiCvTbo8feQEsyvecw1i6kIDCx5FH60QfRpKTUaHZmfvEye0XjomO/wD8Uz+KRCm
         0z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690709996; x=1691314796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfBFXLrOBDfsMdVxv/cKnvMiArytdOBrw7zZET7q5qM=;
        b=N84Q7OL08MuSm+5PKdzYOIQCDTOiQ5qyBtm2CmNYSyP1oaIiJeQp4fCY1mprGwpD2b
         d9OukV6zVpvoNhmOG6xfY4/HOoR2CJxdxKlNWsGlsBX42Q51IK1ghlusNmcz6MqO0LuW
         odd+HGKCWreU3AMdiRAvU6Xx2N0Vi6u83rCs/0gBWhW5hQM2qFBzXG+a3O1+p6oMEEjE
         yc54+Ko1wkW/wwdZUCHJI1f1UNvbhtgJDsvFpgNcKDS9nWfBelZSDuWOj9gCuRlQidkT
         nCx1VFx579/OvO9QFLngBYPbcwSGwp1VYEZDEGUNjIi3jY/JuK6qhO9qskQqh4gXd9u2
         Bz1A==
X-Gm-Message-State: ABy/qLb74FjJ4k9T+6NLBGw25PRUYYJzhKg3QePKBVbS8Mp8lba7jkwe
        w01DAZXsCQQUI+ivKKcK2h8=
X-Google-Smtp-Source: APBJJlE9t94FPGbGkkqZmJ+JSMOguYO/WAvVNCrSRtCDl9qdozUJrVWJRt9uyTESn5JIHmBs2WV9qw==
X-Received: by 2002:a7b:c453:0:b0:3fb:f926:4937 with SMTP id l19-20020a7bc453000000b003fbf9264937mr4280394wmi.31.1690709995979;
        Sun, 30 Jul 2023 02:39:55 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm9574599wrr.56.2023.07.30.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 02:39:55 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>,
        Michal Kubiak <michal.kubiak@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v3 4/5] net: dsa: qca8k: move qca8xxx hol fixup to separate function
Date:   Sun, 30 Jul 2023 09:41:12 +0200
Message-Id: <20230730074113.21889-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230730074113.21889-1-ansuelsmth@gmail.com>
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move qca8xxx hol fixup to separate function to tidy things up and to
permit using a more efficent loop in future patch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 78 +++++++++++++++++---------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 6286a64a2fe3..81c6fab0a01b 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1756,6 +1756,46 @@ static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
 	return 0;
 }
 
+static void qca8k_setup_hol_fixup(struct qca8k_priv *priv, int port)
+{
+	u32 mask;
+
+	switch (port) {
+	/* The 2 CPU port and port 5 requires some different
+	 * priority than any other ports.
+	 */
+	case 0:
+	case 5:
+	case 6:
+		mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI4(0x6) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI5(0x8) |
+			QCA8K_PORT_HOL_CTRL0_EG_PORT(0x1e);
+		break;
+	default:
+		mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x6) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x8) |
+			QCA8K_PORT_HOL_CTRL0_EG_PORT(0x19);
+	}
+	regmap_write(priv->regmap, QCA8K_REG_PORT_HOL_CTRL0(port), mask);
+
+	mask = QCA8K_PORT_HOL_CTRL1_ING(0x6) |
+	       QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
+	       QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
+	       QCA8K_PORT_HOL_CTRL1_WRED_EN;
+	regmap_update_bits(priv->regmap, QCA8K_REG_PORT_HOL_CTRL1(port),
+			   QCA8K_PORT_HOL_CTRL1_ING_BUF_MASK |
+			   QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
+			   QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
+			   QCA8K_PORT_HOL_CTRL1_WRED_EN,
+			   mask);
+}
+
 static int
 qca8k_setup(struct dsa_switch *ds)
 {
@@ -1895,42 +1935,8 @@ qca8k_setup(struct dsa_switch *ds)
 		 * missing settings to improve switch stability under load condition.
 		 * This problem is limited to qca8337 and other qca8k switch are not affected.
 		 */
-		if (priv->switch_id == QCA8K_ID_QCA8337) {
-			switch (i) {
-			/* The 2 CPU port and port 5 requires some different
-			 * priority than any other ports.
-			 */
-			case 0:
-			case 5:
-			case 6:
-				mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI4(0x6) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI5(0x8) |
-					QCA8K_PORT_HOL_CTRL0_EG_PORT(0x1e);
-				break;
-			default:
-				mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x6) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x8) |
-					QCA8K_PORT_HOL_CTRL0_EG_PORT(0x19);
-			}
-			qca8k_write(priv, QCA8K_REG_PORT_HOL_CTRL0(i), mask);
-
-			mask = QCA8K_PORT_HOL_CTRL1_ING(0x6) |
-			QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
-			QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
-			QCA8K_PORT_HOL_CTRL1_WRED_EN;
-			qca8k_rmw(priv, QCA8K_REG_PORT_HOL_CTRL1(i),
-				  QCA8K_PORT_HOL_CTRL1_ING_BUF_MASK |
-				  QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
-				  QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
-				  QCA8K_PORT_HOL_CTRL1_WRED_EN,
-				  mask);
-		}
+		if (priv->switch_id == QCA8K_ID_QCA8337)
+			qca8k_setup_hol_fixup(priv, i);
 	}
 
 	/* Special GLOBAL_FC_THRESH value are needed for ar8327 switch */
-- 
2.40.1

