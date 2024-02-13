Return-Path: <linux-kernel+bounces-64434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5945853E44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3A71C2287A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050C77629;
	Tue, 13 Feb 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB6Cvi0J"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E30768FB;
	Tue, 13 Feb 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861975; cv=none; b=Dcieq+NpNxDezJK+Y71anhgt+bqTBE9reRlTKS0kO2z12e6I0+MiPduiP44jPM1aZOoI1lpTPjdL39fb3MouyGe3V9pXl1r0mPxky/ukba869O4Vsx+glvtnLN29t0m8HtlEueuKMEIIQ9MehqC7m6QSNd6NkeT1lIsvvaco/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861975; c=relaxed/simple;
	bh=BcCICgTKVZ2L1mhpJOxhdMkT8Ko96qUkVtelruR9JTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7Aa73XuvKvV1HCUzl49ix5sxlC+tTeyvdu3j1BOPAXXncJBCPjjN/SF0D5cedfyEVABwsnsqvZax/WInY6fGq0a3vinTIZ5hyr+QZMPoFXk/ruBSMw5VtkgXaIVMu1tp5nbrNS6yTDBOmgepMfXmFv8e9Y+SjpOMSGUx+1L2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB6Cvi0J; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso421985766b.3;
        Tue, 13 Feb 2024 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861972; x=1708466772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zhwy6nnxrLoJfssOqtXSEBpoc3WQJYfaNJ+nAZBweg=;
        b=PB6Cvi0JvhJWsEei7cgZ9eN0Oxjed+vO9xs0VWJ2gZVwtH/IJ8VdUHkz8wDR3pnL+K
         eQ0mP9T7LZ7Xq0/5a7YdmDOU839rSXnG8vSNLB1m0VKKCvzdXC82KsanF0DakZ95BnSF
         KDXulcX40xr8bKSyHz2Jm1NeOhFzyC7UcbfVBisi8VMoi/V+HKpcAd6MeIeFzj3DweCN
         fABT5RJAgCK5j2aQBA2V4q3h2oZljJc49vzcU+DEttzlunPEb0zgt0AdUMh7WFeM/P6F
         0a0O9Vi8yXmPanHIATh9BFRgPsn+XYwGVOwpaMCp9PraAs+SUHpMZPE5KpjQL8Wt7AmL
         wRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861972; x=1708466772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zhwy6nnxrLoJfssOqtXSEBpoc3WQJYfaNJ+nAZBweg=;
        b=qpYb2G/R4l8rk1kb5fiQ67Ty5qIAHE/t9aw2yD9FhHg/FY2EFpQnt+i+pwKkfV8bLX
         ivMWg3JdLTuvmIBoDk7CoQ6zsIMCrUHZcxRFh8Wv2Rr5Sl21jPNRPchcZA/5NDfpm8co
         mZdSwSYquXhUDP4m/rOdojNtKvqc6f+RNXeEfoJKbHhSvMkqjJPaMxejTcxj1okW5SSN
         pq59jNZv/dMVwsu0ls3jrRpas7BfBBtUFMe+/qfhl6tBpCv1c2S8jQ4Z719/TKBikTok
         I+orp75IOgtLZh87v+D/TxZlOp+3AhR5CJD2rz84J3X84U2VdzRk78IJ4GVGItOyFfmI
         iJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWasYGg17bnwB3Ik5uvffAtcZYYcIogwBBM98Pniczgno4E4/znlcMkOctxa16ZsKjlhSDXWK+YOG1nvmK6/SkN6EafGZB+pF3JCNB
X-Gm-Message-State: AOJu0YyRGSE/l7vL+++WRQSo3JZ3e7DA7x2mHIsoojWrGcKsDWkBZdwk
	5dWzOA7Q5qwb1SgpVAxCUMnZN13TMSCSGmNtuYSMgZVrkT45SQxClsRpm2q8RAU=
X-Google-Smtp-Source: AGHT+IE1XY2ma3EOWQeH4tJiv0tWMUYK+zqgoJNdZT4vqJefcmDRHp7UdEF8KsK0v7dfB0oWDW7ckg==
X-Received: by 2002:a17:906:5589:b0:a3c:10a4:7a91 with SMTP id y9-20020a170906558900b00a3c10a47a91mr547728ejp.13.1707861971934;
        Tue, 13 Feb 2024 14:06:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKRiR8sP59UO8EWHPP+/EBMRqEq6NFe3XE/hZAAghvCLSYCCtyN4lqBrrbOtkf50wGPZ4pO88D4vkD4NlLiYIZ0svDcMpWIZ7t5OtdiSV6p7X3lTWFMdLejjjme3+ux2XS/nB2M7wttJCUP387Wc77foUp5+cNyrcMAgSogTfuOq9ga44O0xGQvImvbE7t5VqJDhgUGgYeBKjKhDxUIuajWWcbFZvCBFRlyW41R/gxcuimFKgESZFwBM5dkkrm2Mm3iuXjPtXuWC4ADjXOW5pLnWf/xaIecwPlmwhp8ip2LmRo/RX87Kb/P68kcAUYfeXhXDxDH2Z2Te6ewPhmQKv6kYpQ5whrFtusL+6qYYdy6TOpGzUi2cOaTcvXnu5CLxVWiPJOAVlT7WwDDzNo5FjRzSgRZdQuOYT8aOc8DG2a/y2MIY7cMyRgXyj12Pzu0TFIsi6TW2qcZw==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:06:11 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/15] net: dsa: vsc73xx: introduce tag 8021q for vsc73xx
Date: Tue, 13 Feb 2024 23:03:25 +0100
Message-Id: <20240213220331.239031-13-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces a new tagger based on 802.1q tagging.
It's designed for the vsc73xx driver. The VSC73xx family doesn't have
any tag support for the RGMII port, but it could be based on VLANs.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - rebase to net-next/main
v3:
  - Introduce a patch after the tagging patch split

 include/net/dsa.h           |  2 ++
 net/dsa/Kconfig             |  6 ++++
 net/dsa/Makefile            |  1 +
 net/dsa/tag_vsc73xx_8021q.c | 69 +++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..b79e136e4c41 100644
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
index 8a1894a42552..555c07cfeb71 100644
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
index 000000000000..0bf150a10576
--- /dev/null
+++ b/net/dsa/tag_vsc73xx_8021q.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (C) 2023 Pawel Dembicki <paweldembicki@gmail.com>
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
+	struct dsa_port *dp = dsa_user_to_port(netdev);
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
+static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb, struct net_device *netdev)
+{
+	int src_port = -1, switch_id = -1, vbid = -1, vid = -1;
+
+	if (skb_vlan_tag_present(skb)) {
+		/* Normal traffic path. */
+		dsa_8021q_rcv(skb, &src_port, &switch_id, &vbid, &vid);
+	} else {
+		netdev_warn(netdev, "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	skb->dev = dsa_tag_8021q_find_user(netdev, src_port, switch_id, vid, vbid);
+	if (!skb->dev) {
+		netdev_warn(netdev, "Couldn't decode source port\n");
+		return NULL;
+	}
+
+	dsa_default_offload_fwd_mark(skb);
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
+	.promisc_on_conduit	= true,
+};
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_VSC73XX_8021Q, VSC73XX_8021Q_NAME);
+
+module_dsa_tag_driver(vsc73xx_8021q_netdev_ops);
-- 
2.34.1


