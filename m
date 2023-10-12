Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9C7C6BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377960AbjJLK5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjJLK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:57:36 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85211C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W6plsMgI7pFZJCkL2mweUmcnjvQTbEecJRGjwd0y4cU=; b=fRZ4z50tdppvr4wVGOH0Cwp5Z1
        lJ74teyAbcDhdshVa5KjroJd/M/tONNV8HqR4jHbORrEI0RfVhL6RON/qR9EsbhU8o6Qxl/x6jXif
        lgzIBYZD54oBxR2KSQCxvB0XYRzc7fqLXgX6P2v9cJeqI2VVWLOOEb311tAEAi9v2O+NeUqoxEp9C
        IKn78SMJSoUal3ZC1hgZ+d0hixFHbyG9Ijy+Z3ffWPF/Gz1Z1Bp+QV6Ig+IpJUggQx38hHvDCCOwP
        vJ3XDDLtdLEmaXB3GzJ5k3wHxsOqTrLxlobbmcW/wvc/9pk4Li7ZneoyA7JUFN90q6ZRdgSkW8ORU
        V8/6/2iA==;
Received: from [192.168.1.4] (port=44479 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqtMN-0005Tl-16;
        Thu, 12 Oct 2023 12:56:07 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 12 Oct 2023 12:56:06 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v2 1/2] net:dsa:microchip: add property to select internal RMII reference clock
Date:   Thu, 12 Oct 2023 12:55:55 +0200
Message-ID: <c8bb7002e6d81a661c853dd21e0fe18e95887609.1697107915.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1697107915.git.ante.knezic@helmholz.de>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
RMII clock reference to internal. If property is not set, reference
clock needs to be provided externally.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/microchip/ksz8795.c     | 5 +++++
 drivers/net/dsa/microchip/ksz8795_reg.h | 3 +++
 drivers/net/dsa/microchip/ksz_common.c  | 3 +++
 drivers/net/dsa/microchip/ksz_common.h  | 1 +
 4 files changed, 12 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 91aba470fb2f..78f3a668aa99 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1434,6 +1434,11 @@ int ksz8_setup(struct dsa_switch *ds)
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
 		ksz8_r_vlan_entries(dev, i);
 
+	if (ksz_is_ksz88x3(dev))
+		ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
+			KSZ88X3_PORT3_RMII_CLK_INTERNAL,
+			dev->rmii_clk_internal);
+
 	return ksz8_handle_global_errata(ds);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 3c9dae53e4d8..beca974e0171 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -22,6 +22,9 @@
 #define KSZ8863_GLOBAL_SOFTWARE_RESET	BIT(4)
 #define KSZ8863_PCS_RESET		BIT(0)
 
+#define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
+#define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b800ace40ce1..0a0a53ce5b1b 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4160,6 +4160,9 @@ int ksz_switch_register(struct ksz_device *dev)
 		}
 	}
 
+	dev->rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
+						       "microchip,rmii-clk-internal");
+
 	ret = dsa_register_switch(dev->ds);
 	if (ret) {
 		dev->dev_ops->exit(dev);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 8842efca0871..e5b0445fe2ca 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -163,6 +163,7 @@ struct ksz_device {
 	phy_interface_t compat_interface;
 	bool synclko_125;
 	bool synclko_disable;
+	bool rmii_clk_internal;
 
 	struct vlan_table *vlan_cache;
 
-- 
2.11.0

