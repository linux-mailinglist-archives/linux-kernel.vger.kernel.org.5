Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D207774BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjHJJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjHJJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:36:19 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD01D1;
        Thu, 10 Aug 2023 02:36:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04A59C000B;
        Thu, 10 Aug 2023 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691660177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3NrcZmj+FrNiMy+UF9UWgRSNLTLhtesLJKPB+kr/QU=;
        b=JRtIGm8xfvwQPZ7IemXHxgVhyqP2j/se21FuzMuMb2IzPhWYctUHiLcMpdNk7iRPHg5p6C
        l64xih4CmhP6chZYAbEd+DXrXChVEyZ5iXcRaRz62pyjo+sEWETcOsLSo1nk+cvoedYKq3
        L7VyArBQCPt//BRkB/A7MAN43SK5OM+qqeiU9uNwjWlYQUaRoTnEM7vhUIP6i8HpCeQanI
        KIcvXEqNmDJdieUzWW82eoDwlA9X8R/yRaBjwjPzccav3JLQfuOfazhdudnOOfPX4R6EtF
        KGTI6+Uf16JXYCdeh8ONh+0Z+zPH4kGlgxEOTT06mJ1/c0eq9uiRdApXHVsk9w==
From:   alexis.lothore@bootlin.com
To:     =?UTF-8?q?Cl=C3=A9ment=20Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v5 1/3] net: dsa: rzn1-a5psw: use a5psw_reg_rmw() to modify flooding resolution
Date:   Thu, 10 Aug 2023 11:36:49 +0200
Message-ID: <20230810093651.102509-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810093651.102509-1-alexis.lothore@bootlin.com>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Léger <clement.leger@bootlin.com>

.port_bridge_flags will be added and allows to modify the flood mask
independently for each port. Keeping the existing bridged_ports write
in a5psw_flooding_set_resolution() would potentially messed up this.
Use a read-modify-write to set that value and move bridged_ports
handling in bridge_port_join/leave.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index c37d2e537230..302529edb4e0 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -331,13 +331,9 @@ static void a5psw_flooding_set_resolution(struct a5psw *a5psw, int port,
 			A5PSW_MCAST_DEF_MASK};
 	int i;
 
-	if (set)
-		a5psw->bridged_ports |= BIT(port);
-	else
-		a5psw->bridged_ports &= ~BIT(port);
-
 	for (i = 0; i < ARRAY_SIZE(offsets); i++)
-		a5psw_reg_writel(a5psw, offsets[i], a5psw->bridged_ports);
+		a5psw_reg_rmw(a5psw, offsets[i], BIT(port),
+			      set ? BIT(port) : 0);
 }
 
 static void a5psw_port_set_standalone(struct a5psw *a5psw, int port,
@@ -365,6 +361,8 @@ static int a5psw_port_bridge_join(struct dsa_switch *ds, int port,
 	a5psw->br_dev = bridge.dev;
 	a5psw_port_set_standalone(a5psw, port, false);
 
+	a5psw->bridged_ports |= BIT(port);
+
 	return 0;
 }
 
@@ -373,6 +371,8 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct a5psw *a5psw = ds->priv;
 
+	a5psw->bridged_ports &= ~BIT(port);
+
 	a5psw_port_set_standalone(a5psw, port, true);
 
 	/* No more ports bridged */
@@ -992,6 +992,8 @@ static int a5psw_probe(struct platform_device *pdev)
 	if (IS_ERR(a5psw->base))
 		return PTR_ERR(a5psw->base);
 
+	a5psw->bridged_ports = BIT(A5PSW_CPU_PORT);
+
 	ret = a5psw_pcs_get(a5psw);
 	if (ret)
 		return ret;
-- 
2.41.0

