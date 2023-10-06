Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890A7BB70D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjJFL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjJFL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:58:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63914CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:58:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qojTN-0006LK-O7; Fri, 06 Oct 2023 13:58:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qojTL-00BVN8-M8; Fri, 06 Oct 2023 13:58:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qojTL-000bVL-1y;
        Fri, 06 Oct 2023 13:58:23 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: Fix uninitialized var in ksz9477_acl_move_entries()
Date:   Fri,  6 Oct 2023 13:58:22 +0200
Message-Id: <20231006115822.144152-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address an issue in ksz9477_acl_move_entries() where, in the scenario
(src_idx == dst_idx), ksz9477_validate_and_get_src_count() returns 0,
leading to usage of uninitialized src_count and dst_count variables,
which causes undesired behavior as it attempts to move ACL entries
around.

Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ksz9477 switches")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz9477_acl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/microchip/ksz9477_acl.c
index 06d74c19eb94..7ba778df63ac 100644
--- a/drivers/net/dsa/microchip/ksz9477_acl.c
+++ b/drivers/net/dsa/microchip/ksz9477_acl.c
@@ -420,10 +420,6 @@ static int ksz9477_validate_and_get_src_count(struct ksz_device *dev, int port,
 		return -EINVAL;
 	}
 
-	/* Nothing to do */
-	if (src_idx == dst_idx)
-		return 0;
-
 	/* Validate if the source entries are contiguous */
 	ret = ksz9477_acl_get_cont_entr(dev, port, src_idx);
 	if (ret < 0)
@@ -556,6 +552,10 @@ static int ksz9477_acl_move_entries(struct ksz_device *dev, int port,
 	struct ksz9477_acl_entries *acles = &acl->acles;
 	int src_count, ret, dst_count;
 
+	/* Nothing to do */
+	if (src_idx == dst_idx)
+		return 0;
+
 	ret = ksz9477_validate_and_get_src_count(dev, port, src_idx, dst_idx,
 						 &src_count, &dst_count);
 	if (ret)
-- 
2.39.2

