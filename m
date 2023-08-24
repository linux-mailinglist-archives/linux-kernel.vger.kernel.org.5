Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA832787493
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbjHXPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242310AbjHXPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:48:56 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18411BCC;
        Thu, 24 Aug 2023 08:48:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1C433865A6;
        Thu, 24 Aug 2023 17:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1692892131;
        bh=gP8UNuwoakIxdCMV5z1WU/b9JBiDLXA9aRP8LRKsjdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glTtxJ2Y9ahB6VC8n56U4h8Yv4aLeK/VP4Rw7n4goI0S2/Y6mdUCcDl9iSXVtz59x
         7H9b6jAsKtUgsEiBx8o05Dqj1m4oSx1xug7/8uS6brEPLooU9o1rsy7xgtQ/M4HSjP
         6mRhvtAKXCsfVMZMIcqjokzlt2bfeaSm9PUsHc7YXGKctaBjiW4Tf2O6wfLBC9m+Yg
         3lMTfqY2nCT30CtqHfpAKsZ47QCBJo/+CYHwHxcJHthdZ3FAxJMXjnEcaljtWAjzT0
         fga4xmTmMKfLdJgdelyy1KST4kKyTKsrzfiSefOXszoVjNPRdgnETE+d3pY70/FaNk
         +tggM73F5UaUA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata (DS80000754C)
Date:   Thu, 24 Aug 2023 17:48:27 +0200
Message-Id: <20230824154827.166274-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824154827.166274-1-lukma@denx.de>
References: <20230824154827.166274-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ9477 errata points out the link up/down problem when EEE is enabled
in the device to which the KSZ9477 tries to auto negotiate.

The suggested workaround is to clear advertisement EEE registers
(accessed as per port MMD one).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/dsa/microchip/ksz9477.c | 40 ++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index cb6aa7c668a8..563f497ba656 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1128,6 +1128,44 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 	return 0;
 }
 
+static int ksz9477_errata(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 val;
+	int p;
+
+	/* KSZ9477 Errata DS80000754C
+	 *
+	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
+	 * manually disabled
+	 *   The EEE feature is enabled by default, but it is not fully
+	 *   operational. It must be manually disabled through register
+	 *   controls. If not disabled, the PHY ports can auto-negotiate
+	 *   to enable EEE, and this feature can cause link drops when linked
+	 *   to another device supporting EEE.
+	 *
+	 *   Only PHY ports (dsa user) [0-4] need to have the EEE advertisement
+	 *   bits cleared.
+	 */
+
+	for (p = 0; p < ds->num_ports; p++) {
+		if (!dsa_is_user_port(ds, p))
+			continue;
+
+		ksz9477_port_mmd_read(dev, p, MMD_DEVICE_ID_EEE_ADV,
+				      MMD_EEE_ADV, &val, 1);
+
+		pr_err("%s: PORT: %d val: 0x%x pc: %d\n", __func__, p, val,
+		       ds->num_ports);
+
+		val &= ~(EEE_ADV_100MBIT | EEE_ADV_1GBIT);
+		ksz9477_port_mmd_write(dev, p, MMD_DEVICE_ID_EEE_ADV,
+				       MMD_EEE_ADV, &val, 1);
+	}
+
+	return 0;
+}
+
 int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1157,7 +1195,7 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* enable global MIB counter freeze function */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
 
-	return 0;
+	return ksz9477_errata(ds);
 }
 
 u32 ksz9477_get_port_addr(int port, int offset)
-- 
2.20.1

