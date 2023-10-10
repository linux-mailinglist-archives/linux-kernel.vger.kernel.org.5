Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95C7BFD44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjJJNWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjJJNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:48 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FEAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QR9Uy3YjqvDZP4x3C/UunGthWTuIw3tiQVWbEJjGiKc=; b=sQPA6k9Ubjy06NrLTV7Zu4T7k7
        mtvEwNZJDLsF4G9mPI/9I09CKUv7689Uo9gDd+Koid7snNbkuzV4vIKtbFcb/KD0XXLJrCjIzYspn
        1ZhetdqXKC46+Qq2/K+KmxwqV7pupHb67W3tW1EB/zHP8/pumsoYkOXZ1EhBuBCKAdH9QKKi8iAwP
        2DEviXuGa6adOXRPy1X+G8y5m/WSNIqcZRPowkulvqhrrDVigVz2Z6MUB8Lo4VJeSQqeAh0BEaZtZ
        vWy9irru0d68OwQeN8XDMzcC/JxFEle5pg7MeOn/qhveoSf3qbYMO0gICsSIrbxQ4QhuvgQJTR2s4
        whbjGNBA==;
Received: from [192.168.1.4] (port=20315 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqCdX-0001j2-1h;
        Tue, 10 Oct 2023 15:18:59 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 10 Oct 2023 15:18:58 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next 1/2] net:dsa:microchip: add property to select internal RMII reference clock
Date:   Tue, 10 Oct 2023 15:18:53 +0200
Message-ID: <c1f36ea96ba703540a6ba63abee29242d64daeca.1693482665.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1693482665.git.ante.knezic@helmholz.de>
References: <cover.1693482665.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip KSZ8863/KSZ8873 have the ability to select between internal
and external RMII reference clock. By default, reference clock
needs to be provided via REFCLKI_3 pin. If required, device can be
setup to provide RMII clock internally so that REFCLKI_3 pin can be
left unconnected.
Add a new "microchip,rmii-clk-internal" property which will set
RMII clock reference to internal.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 4 ++++
 drivers/net/dsa/microchip/ksz8795_reg.h | 3 +++
 drivers/net/dsa/microchip/ksz_common.c  | 3 +++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 91aba470fb2f..c5df571153ab 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1434,6 +1434,10 @@ int ksz8_setup(struct dsa_switch *ds)
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
 		ksz8_r_vlan_entries(dev, i);
 
+	if (ksz_is_ksz88x3(dev) && dev->rmii_clk_internal)
+		ksz_cfg(dev, KSZ8863_REG_FVID_AND_HOST_MODE,
+			KSZ8863_PORT3_RMII_CLK_INTERNAL, true);
+
 	return ksz8_handle_global_errata(ds);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 7a57c6088f80..0a3fff7d6d32 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -22,6 +22,9 @@
 #define KSZ8863_GLOBAL_SOFTWARE_RESET	BIT(4)
 #define KSZ8863_PCS_RESET		BIT(0)
 
+#define KSZ8863_REG_FVID_AND_HOST_MODE  0xC6
+#define KSZ8863_PORT3_RMII_CLK_INTERNAL BIT(3)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6673122266b7..dc8cf59c6dd9 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3631,6 +3631,9 @@ int ksz_switch_register(struct ksz_device *dev)
 		}
 	}
 
+	dev->rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
+						       "microchip,rmii-clk-internal");
+
 	ret = dsa_register_switch(dev->ds);
 	if (ret) {
 		dev->dev_ops->exit(dev);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a4de58847dea..54589736398a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -157,6 +157,7 @@ struct ksz_device {
 	phy_interface_t compat_interface;
 	bool synclko_125;
 	bool synclko_disable;
+	bool rmii_clk_internal;
 
 	struct vlan_table *vlan_cache;
 
-- 
2.11.0

