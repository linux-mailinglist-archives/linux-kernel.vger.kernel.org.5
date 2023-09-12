Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65679D101
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjILM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjILM04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:26:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE551710;
        Tue, 12 Sep 2023 05:26:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so9182978e87.1;
        Tue, 12 Sep 2023 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521610; x=1695126410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANqMiomoxPmzQbiZ41qjsZJkA0fJxmIQflrdUDa6u/M=;
        b=VKzAREVVwo3lvhfM4Q4KkJQshJ/ooL+UmI5dgSZLamJVXPuEaIkknbISSvbJT//wio
         AM9QyckVzAuhmLDxlxamt3yoDU/UGO7lEhqaJPfycPf4MK0T+uPal+rUw49WVR/0B3tk
         OoALIztHJKAvDkz3QoF2hrmrigmA6bRMliA3CJ9oC2d/YShhDjbDAiT1V6QslXR0xkdR
         xZCAVe0dQGgo0ZEbGmnwzMmkVgOCgb7JJcCrvBq1+fV4r6tTO1jPPqVWEHN4a13kzZmp
         kQTZlilmIIQKYelyW+dESA1dNepuyKw317ItFTlY8Frlgg5LRPo5Am3tKiFpKGmdtguF
         0S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521610; x=1695126410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANqMiomoxPmzQbiZ41qjsZJkA0fJxmIQflrdUDa6u/M=;
        b=L3LIZ3JYR9JnQO4K9iWgYnW+mlQoOQ8A6MkziL3Kh2nHusI3UHUrrrQUiucunKv1QJ
         KDCRh3NGP173Q6O+y/8EvaeBqCnBEtOkudt9Qwjskjb6y3YLGvwrwNu0OVE/LqPmtVRW
         lbppXBQY+BjeAREIdz7qJVF97f5aiZJXL4UBOYmmdzuy0M21jV/Nqb5Hv7TqTQpo9OmY
         kDmPQfCySyFIm6sezY7buEjuOTcpZ2o/hAIL+E0RZLfHE2vcNYcIu3PkTl7vp4067zE0
         /zPU2hQqEi1l+ZUpxdBALBs1aN0h8DzPBPctWirKVt4UlEb5pN21uxcTJrpUInWKshKf
         p4sQ==
X-Gm-Message-State: AOJu0YxgdtG+/CgbTz63R55cPHIKnmMgouHtj9Yduzhl8uPEm7EhatYt
        tx2+y//RH7qJzJlbH1lHBb0A2vRDhh9gBQ==
X-Google-Smtp-Source: AGHT+IEc3v5kmgIV0Zs6/UvgDsZr26L4kpeMuzCLNfyi9gcjtFFaKgMyWqaOGJofQvVAJwQxoOeGfQ==
X-Received: by 2002:ac2:5b4d:0:b0:4fd:fd97:a77b with SMTP id i13-20020ac25b4d000000b004fdfd97a77bmr9214832lfp.50.1694521610361;
        Tue, 12 Sep 2023 05:26:50 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004fe333128c0sm1737327lfh.242.2023.09.12.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:26:50 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/8] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date:   Tue, 12 Sep 2023 14:22:00 +0200
Message-Id: <20230912122201.3752918-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912122201.3752918-1-paweldembicki@gmail.com>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new tagger based on 802.1q tagging.
It's designed for the vsc73xx driver. The VSC73xx family doesn't have
any tag support for the RGMII port, but it could be based on VLANs.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - Introduce a patch after the tagging patch split

 include/net/dsa.h           |  2 +
 net/dsa/Kconfig             |  6 +++
 net/dsa/Makefile            |  1 +
 net/dsa/tag_vsc73xx_8021q.c | 91 +++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 0b9c6aa27047..f83454d4ad02 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -56,6 +56,7 @@ struct phylink_link_state;
 #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
 #define DSA_TAG_PROTO_RZN1_A5PSW_VALUE		26
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
+#define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -86,6 +87,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
+	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8e698bea99a3..e59360071c67 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -166,6 +166,12 @@ config NET_DSA_TAG_TRAILER
 	  Say Y or M if you want to enable support for tagging frames at
 	  with a trailed. e.g. Marvell 88E6060.
 
+config NET_DSA_TAG_VSC73XX_8021Q
+	tristate "Tag driver for Microchip/Vitesse VSC73xx family of switches, using VLAN"
+	help
+	  Say Y or M if you want to enable support for tagging frames with a
+	  custom VLAN-based header.
+
 config NET_DSA_TAG_XRS700X
 	tristate "Tag driver for XRS700x switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 12e305824a96..bab8a933c514 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_NET_DSA_TAG_RTL8_4) += tag_rtl8_4.o
 obj-$(CONFIG_NET_DSA_TAG_RZN1_A5PSW) += tag_rzn1_a5psw.o
 obj-$(CONFIG_NET_DSA_TAG_SJA1105) += tag_sja1105.o
 obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
+obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
 obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
 
 # for tracing framework to find trace.h
diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
new file mode 100644
index 000000000000..9093a71e6eb0
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (C) 2022 Pawel Dembicki <paweldembicki@gmail.com>
+ * Based on tag_sja1105.c:
+ * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
+ */
+#include <linux/dsa/8021q.h>
+
+#include "tag.h"
+#include "tag_8021q.h"
+
+#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
+
+static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
+	u8 pcp;
+
+	if (skb->offload_fwd_mark) {
+		unsigned int bridge_num = dsa_port_bridge_num_get(dp);
+		struct net_device *br = dsa_port_bridge_dev_get(dp);
+
+		if (br_vlan_enabled(br))
+			return skb;
+
+		tx_vid = dsa_tag_8021q_bridge_vid(bridge_num);
+	}
+
+	pcp = netdev_txq_to_tc(netdev, queue_mapping);
+
+	return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
+			      ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
+}
+
+static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
+			     int *switch_id, int *vbid, u16 *vid)
+{
+	if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
+		return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
+
+	/* Try our best with imprecise RX */
+	*vid = skb_vlan_tag_get(skb) & VLAN_VID_MASK;
+}
+
+static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1;
+	u16 vid;
+
+	if (skb_vlan_tag_present(skb)) {
+		/* Normal traffic path. */
+		vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+	} else {
+		netdev_warn(netdev, "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	if (vbid >= 1)
+		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
+	else if (src_port == -1 || switch_id == -1)
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	else
+		skb->dev = dsa_master_find_slave(netdev, switch_id, src_port);
+	if (!skb->dev) {
+		netdev_warn(netdev, "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
+
+	if (dsa_port_is_vlan_filtering(dsa_slave_to_port(skb->dev)) &&
+	    eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
+		__vlan_hwaccel_clear_tag(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops vsc73xx_8021q_netdev_ops = {
+	.name			= VSC73XX_8021Q_NAME,
+	.proto			= DSA_TAG_PROTO_VSC73XX_8021Q,
+	.xmit			= vsc73xx_xmit,
+	.rcv			= vsc73xx_rcv,
+	.needed_headroom	= VLAN_HLEN,
+	.promisc_on_master	= true,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1

