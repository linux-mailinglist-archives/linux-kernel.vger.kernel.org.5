Return-Path: <linux-kernel+bounces-132773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD028999F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096AC1F22D52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA716C68F;
	Fri,  5 Apr 2024 09:52:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9933161303
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310750; cv=none; b=dJryeR37TLU9SzoNTt3KQMMcDEXYPyYxNibdG/SRL0UYPX1y5v+zhmKeZ8k8DPlz+dBya4H/HFRFUhoO/LV42eocCrjaRQ5KF+pPwxQaOusRsDib+CDLzPKjRfsOi5sUfxdslYdO4Ak997SdahDvn1Xo04lfv4nDUcjjdmLPA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310750; c=relaxed/simple;
	bh=N1vfQtVqdEZLvE8Bx0YbG7jmexrDntzSCnSI0MJdxLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gciiImITuJAaUpeptJKIO7yEbcSDK8OcCuY9aR+xRWtXR5rdLGpTqnXvpn4/X9NT4KyszHjcm2EGyQTDtU3ZD4ttenmMGKb4ZJsMAD8vIzqtf4uIWZGB4mcOie5+gwTboyd5kQH8ECHGcauG2SR/WwnzPQaPz4LDh+w/Kna7gY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgFA-0005EA-SA; Fri, 05 Apr 2024 11:52:20 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-00AXqc-B2; Fri, 05 Apr 2024 11:52:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rsgF8-001U4s-0p;
	Fri, 05 Apr 2024 11:52:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v3 3/9] net: add IEEE 802.1q specific helpers
Date: Fri,  5 Apr 2024 11:52:10 +0200
Message-Id: <20240405095216.353829-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405095216.353829-1-o.rempel@pengutronix.de>
References: <20240405095216.353829-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

IEEE 802.1q specification provides recommendation and examples which can
be used as good default values for different drivers.

This patch implements mapping examples documented in IEEE 802.1Q-2022 in
Annex I "I.3 Traffic type to traffic class mapping" and IETF DSCP naming
and mapping DSCP to Traffic Type inspired by RFC8325.

This helpers will be used in followup patches for dsa/microchip DCB
implementation.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- properly export symbols with EXPORT_SYMBOL_GPL()
- return error if NET_IEEE8021Q_HELPERS is not enabled
---
 include/net/dscp.h           |  76 ++++++++++++++++
 include/net/ieee8021q.h      |  49 ++++++++++
 net/Kconfig                  |   4 +
 net/core/Makefile            |   1 +
 net/core/ieee8021q_helpers.c | 167 +++++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+)
 create mode 100644 include/net/dscp.h
 create mode 100644 include/net/ieee8021q.h
 create mode 100644 net/core/ieee8021q_helpers.c

diff --git a/include/net/dscp.h b/include/net/dscp.h
new file mode 100644
index 0000000000000..ba40540868c9c
--- /dev/null
+++ b/include/net/dscp.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
+
+#ifndef __DSCP_H__
+#define __DSCP_H__
+
+/*
+ * DSCP Pools and Codepoint Space Division:
+ *
+ * The Differentiated Services (Diffserv) architecture defines a method for
+ * classifying and managing network traffic using the DS field in IPv4 and IPv6
+ * packet headers. This field can carry one of 64 distinct DSCP (Differentiated
+ * Services Code Point) values, which are divided into three pools based on
+ * their Least Significant Bits (LSB) patterns and intended usage. Each pool has
+ * a specific registration procedure for assigning DSCP values:
+ *
+ * Pool 1 (Standards Action Pool):
+ * - Codepoint Space: xxxxx0
+ *   This pool includes DSCP values ending in '0' (binary), allocated via
+ *   Standards Action. It is intended for globally recognized traffic classes,
+ *   ensuring interoperability across the internet. This pool encompasses
+ *   well-known DSCP values such as CS0-CS7, AFxx, EF, and VOICE-ADMIT.
+ *
+ * Pool 2 (Experimental/Local Use Pool):
+ * - Codepoint Space: xxxx11
+ *   Reserved for DSCP values ending in '11' (binary), this pool is designated
+ *   for Experimental or Local Use. It allows for private or temporary traffic
+ *   marking schemes not intended for standardized global use, facilitating
+ *   testing and network-specific configurations without impacting
+ *   interoperability.
+ *
+ * Pool 3 (Preferential Standardization Pool):
+ * - Codepoint Space: xxxx01
+ *   Initially reserved for experimental or local use, this pool now serves as
+ *   a secondary standardization resource should Pool 1 become exhausted. DSCP
+ *   values ending in '01' (binary) are assigned via Standards Action, with a
+ *   focus on adopting new, standardized traffic classes as the need arises.
+ *
+ * For pool updates see:
+ * https://www.iana.org/assignments/dscp-registry/dscp-registry.xhtml
+ */
+
+/* Pool 1: Standardized DSCP values as per [RFC8126] */
+#define DSCP_CS0 0		/* 000000, [RFC2474] */
+/* CS0 is some times called default (DF) */
+#define DSCP_DF 0		/* 000000, [RFC2474] */
+#define DSCP_CS1 8		/* 001000, [RFC2474] */
+#define DSCP_CS2 16		/* 010000, [RFC2474] */
+#define DSCP_CS3 24		/* 011000, [RFC2474] */
+#define DSCP_CS4 32		/* 100000, [RFC2474] */
+#define DSCP_CS5 40		/* 101000, [RFC2474] */
+#define DSCP_CS6 48		/* 110000, [RFC2474] */
+#define DSCP_CS7 56		/* 111000, [RFC2474] */
+#define DSCP_AF11 10		/* 001010, [RFC2597] */
+#define DSCP_AF12 12		/* 001100, [RFC2597] */
+#define DSCP_AF13 14		/* 001110, [RFC2597] */
+#define DSCP_AF21 18		/* 010010, [RFC2597] */
+#define DSCP_AF22 20		/* 010100, [RFC2597] */
+#define DSCP_AF23 22		/* 010110, [RFC2597] */
+#define DSCP_AF31 26		/* 011010, [RFC2597] */
+#define DSCP_AF32 28		/* 011100, [RFC2597] */
+#define DSCP_AF33 30		/* 011110, [RFC2597] */
+#define DSCP_AF41 34		/* 100010, [RFC2597] */
+#define DSCP_AF42 36		/* 100100, [RFC2597] */
+#define DSCP_AF43 38		/* 100110, [RFC2597] */
+#define DSCP_EF 46		/* 101110, [RFC3246] */
+#define DSCP_VOICE_ADMIT 44	/* 101100, [RFC5865] */
+
+/* Pool 3: Standardized assignments, previously available for experimental/local
+ * use
+ */
+#define DSCP_LE 1		/* 000001, [RFC8622] */
+
+#define DSCP_MAX 64
+
+#endif /* __DSCP_H__ */
diff --git a/include/net/ieee8021q.h b/include/net/ieee8021q.h
new file mode 100644
index 0000000000000..da1e4db7e3db6
--- /dev/null
+++ b/include/net/ieee8021q.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
+
+#ifndef _NET_IEEE8021Q_H
+#define _NET_IEEE8021Q_H
+
+/**
+ * enum ieee8021q_traffic_type - 802.1Q traffic type priority values (802.1Q-2022)
+ *
+ * @IEEE8021Q_TT_BK: Background
+ * @IEEE8021Q_TT_BE: Best Effort (default). According to 802.1Q-2022, BE is 0
+ * but has higher priority than BK which is 1.
+ * @IEEE8021Q_TT_EE: Excellent Effort
+ * @IEEE8021Q_TT_CA: Critical Applications
+ * @IEEE8021Q_TT_VI: Video, < 100 ms latency and jitter
+ * @IEEE8021Q_TT_VO: Voice, < 10 ms latency and jitter
+ * @IEEE8021Q_TT_IC: Internetwork Control
+ * @IEEE8021Q_TT_NC: Network Control
+ */
+enum ieee8021q_traffic_type {
+	IEEE8021Q_TT_BK = 0,
+	IEEE8021Q_TT_BE = 1,
+	IEEE8021Q_TT_EE = 2,
+	IEEE8021Q_TT_CA = 3,
+	IEEE8021Q_TT_VI = 4,
+	IEEE8021Q_TT_VO = 5,
+	IEEE8021Q_TT_IC = 6,
+	IEEE8021Q_TT_NC = 7,
+};
+
+#if IS_ENABLED(CONFIG_NET_IEEE8021Q_HELPERS)
+
+int ietf_dscp_to_ieee8021q_tt(int dscp);
+int ieee8021q_tt_to_tc(int tt, int num_queues);
+
+#else
+
+static inline int ietf_dscp_to_ieee8021q_tt(int dscp)
+{
+	return -ENOTSUPP;
+}
+
+static inline int ieee8021q_tt_to_tc(int tt, int num_queues)
+{
+	return -ENOTSUPP;
+}
+
+#endif
+#endif /* _NET_IEEE8021Q_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da279..2da4e6639527a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -449,6 +449,10 @@ config GRO_CELLS
 config SOCK_VALIDATE_XMIT
 	bool
 
+config NET_IEEE8021Q_HELPERS
+	bool
+	default n
+
 config NET_SELFTESTS
 	def_tristate PHYLIB
 	depends on PHYLIB && INET
diff --git a/net/core/Makefile b/net/core/Makefile
index 21d6fbc7e884c..62be9aef25285 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_NETPOLL) += netpoll.o
 obj-$(CONFIG_FIB_RULES) += fib_rules.o
 obj-$(CONFIG_TRACEPOINTS) += net-traces.o
 obj-$(CONFIG_NET_DROP_MONITOR) += drop_monitor.o
+obj-$(CONFIG_NET_IEEE8021Q_HELPERS) += ieee8021q_helpers.o
 obj-$(CONFIG_NET_SELFTESTS) += selftests.o
 obj-$(CONFIG_NETWORK_PHY_TIMESTAMPING) += timestamping.o
 obj-$(CONFIG_NET_PTP_CLASSIFY) += ptp_classifier.o
diff --git a/net/core/ieee8021q_helpers.c b/net/core/ieee8021q_helpers.c
new file mode 100644
index 0000000000000..61db84419f7a8
--- /dev/null
+++ b/net/core/ieee8021q_helpers.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+
+#include <linux/printk.h>
+#include <linux/types.h>
+#include <net/dscp.h>
+#include <net/ieee8021q.h>
+
+/* Following arrays map Traffic Types (TT) to traffic classes (TC) for different
+ * number of queues as shown in the example provided by  IEEE 802.1Q-2022 in
+ * Annex I "I.3 Traffic type to traffic class mapping" and Table I-1 "Traffic
+ * type to traffic class mapping".
+ */
+static const u8 ieee8021q_8queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0,
+	[IEEE8021Q_TT_BE] = 1,
+	[IEEE8021Q_TT_EE] = 2,
+	[IEEE8021Q_TT_CA] = 3,
+	[IEEE8021Q_TT_VI] = 4,
+	[IEEE8021Q_TT_VO] = 5,
+	[IEEE8021Q_TT_IC] = 6,
+	[IEEE8021Q_TT_NC] = 7,
+};
+
+static const u8 ieee8021q_7queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0,
+	[IEEE8021Q_TT_BE] = 1,
+	[IEEE8021Q_TT_EE] = 2,
+	[IEEE8021Q_TT_CA] = 3,
+	[IEEE8021Q_TT_VI] = 4,	[IEEE8021Q_TT_VO] = 4,
+	[IEEE8021Q_TT_IC] = 5,
+	[IEEE8021Q_TT_NC] = 6,
+};
+
+static const u8 ieee8021q_6queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0,
+	[IEEE8021Q_TT_BE] = 1,
+	[IEEE8021Q_TT_EE] = 2,	[IEEE8021Q_TT_CA] = 2,
+	[IEEE8021Q_TT_VI] = 3,	[IEEE8021Q_TT_VO] = 3,
+	[IEEE8021Q_TT_IC] = 4,
+	[IEEE8021Q_TT_NC] = 5,
+};
+
+static const u8 ieee8021q_5queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
+	[IEEE8021Q_TT_EE] = 1, [IEEE8021Q_TT_CA] = 1,
+	[IEEE8021Q_TT_VI] = 2, [IEEE8021Q_TT_VO] = 2,
+	[IEEE8021Q_TT_IC] = 3,
+	[IEEE8021Q_TT_NC] = 4,
+};
+
+static const u8 ieee8021q_4queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
+	[IEEE8021Q_TT_EE] = 1, [IEEE8021Q_TT_CA] = 1,
+	[IEEE8021Q_TT_VI] = 2, [IEEE8021Q_TT_VO] = 2,
+	[IEEE8021Q_TT_IC] = 3, [IEEE8021Q_TT_NC] = 3,
+};
+
+static const u8 ieee8021q_3queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
+	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
+	[IEEE8021Q_TT_VI] = 1, [IEEE8021Q_TT_VO] = 1,
+	[IEEE8021Q_TT_IC] = 2, [IEEE8021Q_TT_NC] = 2,
+};
+
+static const u8 ieee8021q_2queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
+	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
+	[IEEE8021Q_TT_VI] = 1, [IEEE8021Q_TT_VO] = 1,
+	[IEEE8021Q_TT_IC] = 1, [IEEE8021Q_TT_NC] = 1,
+};
+
+static const u8 ieee8021q_1queue_tt_tc_map[] = {
+	[IEEE8021Q_TT_BK] = 0, [IEEE8021Q_TT_BE] = 0,
+	[IEEE8021Q_TT_EE] = 0, [IEEE8021Q_TT_CA] = 0,
+	[IEEE8021Q_TT_VI] = 0, [IEEE8021Q_TT_VO] = 0,
+	[IEEE8021Q_TT_IC] = 0, [IEEE8021Q_TT_NC] = 0,
+};
+
+/**
+ * ieee8021q_tt_to_tc - Map IEEE 802.1Q Traffic Type to Traffic Class
+ * @tt: IEEE 802.1Q Traffic Type
+ * @num_queues: Number of queues
+ *
+ * This function maps an IEEE 802.1Q Traffic Type to a Traffic Class (TC) based
+ * on the number of queues configured on the switch. The mapping is based on the
+ * example provided by IEEE 802.1Q-2022 in Annex I "I.3 Traffic type to traffic
+ * class mapping" and Table I-1 "Traffic type to traffic class mapping".
+ *
+ * Return: Traffic Class corresponding to the given Traffic Type.
+ */
+int ieee8021q_tt_to_tc(int tt, int num_queues)
+{
+	switch (num_queues) {
+	case 8:
+		return ieee8021q_8queue_tt_tc_map[tt];
+	case 7:
+		return ieee8021q_7queue_tt_tc_map[tt];
+	case 6:
+		return ieee8021q_6queue_tt_tc_map[tt];
+	case 5:
+		return ieee8021q_5queue_tt_tc_map[tt];
+	case 4:
+		return ieee8021q_4queue_tt_tc_map[tt];
+	case 3:
+		return ieee8021q_3queue_tt_tc_map[tt];
+	case 2:
+		return ieee8021q_2queue_tt_tc_map[tt];
+	case 1:
+		return ieee8021q_1queue_tt_tc_map[tt];
+	}
+
+	pr_warn("Invalid number of queues %d\n", num_queues);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ieee8021q_tt_to_tc);
+
+/**
+ * ietf_dscp_to_ieee8021q_tt - Map IETF DSCP to IEEE 802.1Q Traffic Type
+ * @dscp: IETF DSCP value
+ *
+ * This function maps an IETF DSCP value to an IEEE 802.1Q Traffic Type (TT).
+ * Since there is no corresponding mapping between DSCP and IEEE 802.1Q Traffic
+ * Type, this function is inspired by the RFC8325 documentation which describe
+ * the mapping between DSCP and 802.11 User Priority (UP) values.
+ *
+ * Return: IEEE 802.1Q Traffic Type corresponding to the given DSCP value
+ */
+
+int ietf_dscp_to_ieee8021q_tt(int dscp)
+{
+	switch (dscp) {
+	case DSCP_CS0:
+	case DSCP_AF11:
+	case DSCP_AF12:
+	case DSCP_AF13:
+		return IEEE8021Q_TT_BE;
+	case DSCP_CS1:
+		return IEEE8021Q_TT_BK;
+	case DSCP_CS2:
+	case DSCP_AF21:
+	case DSCP_AF22:
+	case DSCP_AF23:
+		return IEEE8021Q_TT_EE;
+	case DSCP_CS3:
+	case DSCP_AF31:
+	case DSCP_AF32:
+	case DSCP_AF33:
+		return IEEE8021Q_TT_CA;
+	case DSCP_CS4:
+	case DSCP_AF41:
+	case DSCP_AF42:
+	case DSCP_AF43:
+		return IEEE8021Q_TT_VI;
+	case DSCP_CS5:
+	case DSCP_EF:
+	case DSCP_VOICE_ADMIT:
+		return IEEE8021Q_TT_VO;
+	case DSCP_CS6:
+		return IEEE8021Q_TT_IC;
+	case DSCP_CS7:
+		return IEEE8021Q_TT_NC;
+	}
+
+	return (dscp >> 3) & 0x7;
+}
+EXPORT_SYMBOL_GPL(ietf_dscp_to_ieee8021q_tt);
-- 
2.39.2


