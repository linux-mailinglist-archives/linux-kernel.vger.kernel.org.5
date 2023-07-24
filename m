Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F975F308
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGXKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGXKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:24:35 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF55241
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dlyzpGUpyMPXTc27ZVb14kq0hZBF0Z31oD4WZBCGsyA=; b=UMAiMvARiHSaLlfXet0rsKJAbE
        88X2Zvqy/E5nwtFq8Dduc6BSIdA4Z/I7jq6ih508V2WqnSMTfA8s/liRg7DciJSbqVSxpFxVQkFpo
        Oc0B72XO05kHZwz5NFvi5GRj55y9ESq7iqvDqUHME01ineOo1EMBpC7xO/gAX9bfnPYqlof8v7Yjj
        rEe4Axwwsyd8G0Dkj0KtFeNIwLNkSsuRdNZfZqy8E8KPNvoVqRXz5httDE/Tu/katjEX0eJZZipCc
        iw6m6b0KkXbtQKAi5J9QytCJRC14ydU7GGKSUVmxAC0BTDyKrgBpP6KeCN1cgrgutJFf6kbMf/NbD
        /J+UmkJQ==;
Received: from [192.168.1.4] (port=9769 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qNseN-00081c-39;
        Mon, 24 Jul 2023 12:18:47 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 24 Jul 2023 12:18:47 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next] net: dsa: mv88e6xxx: enable automedia on 6190x and 6390x devices
Date:   Mon, 24 Jul 2023 12:18:29 +0200
Message-ID: <20230724101829.9431-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell 6190x and 6390x devices support using unusued lanes of
ports 9 and 10 as automedia PHY/SERDES ports. In order to be
able to use them as automedia ports, serdes lanes must be
properly initialized so we allow setting the desired cmode to
be later used by the phylink_pcs infrastructure.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/mv88e6xxx/port.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..060cbf8c703c 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -12,6 +12,7 @@
 #include <linux/if_bridge.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/of_net.h>
 
 #include "chip.h"
 #include "global2.h"
@@ -596,9 +597,42 @@ static int mv88e6xxx_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 	return 0;
 }
 
+static int mv88e6390x_port_automedia(struct mv88e6xxx_chip *chip, int port,
+				     phy_interface_t mode)
+{
+	phy_interface_t of_mode;
+	struct dsa_port *dp;
+	int err;
+
+	if (mode == PHY_INTERFACE_MODE_NA) {
+		dp = dsa_to_port(chip->ds, port);
+		err = of_get_phy_mode(dp->dn, &of_mode);
+		if (err)
+			return -EOPNOTSUPP;
+
+		if (of_mode != PHY_INTERFACE_MODE_1000BASEX)
+			return -EOPNOTSUPP;
+
+		/* Physical cmode value is writable only for ports 9 and 10
+		 * but we need the desired cmode in order to properly prepare
+		 * phylink infrastructure. The physical cmode value will be
+		 * updated by the switch itself once the automedia port is
+		 * linked.
+		 * Automedia ports support only 1000BASE-X cmode.
+		 */
+		chip->ports[port].cmode = MV88E6XXX_PORT_STS_CMODE_1000BASEX;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int mv88e6390x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			      phy_interface_t mode)
 {
+	if (port >= 2 && port <= 7)
+		return mv88e6390x_port_automedia(chip, port, mode);
+
 	if (port != 9 && port != 10)
 		return -EOPNOTSUPP;
 
-- 
2.11.0

