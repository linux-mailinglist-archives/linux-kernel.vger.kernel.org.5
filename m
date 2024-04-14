Return-Path: <linux-kernel+bounces-136440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1489D41B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8360F284881
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54A8528B;
	Tue,  9 Apr 2024 08:19:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198D7E574
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650742; cv=none; b=BgpZRq2EP5VNVMx5xIdMBBYBxkmLJ0iZortPqejCNbIlGpjsyoCNR865JLcK3IKbGQNDGcAkJF5xt9dG1u99XAIL2L4UQSX6TKu5WK9R9FQgXvTHNBK2cIrK3LxM8RgHOGqZ3pPmQxH9x+oxFCqxkLai0IWJvFQ0hO9hBXhEkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650742; c=relaxed/simple;
	bh=1knzds/bkhu8Rhxy8f+f57/uVYlC83ou4R+nh+qdcEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugkp/lmGGPFDG/KVqFmBlCfaW0c1ma56lSVsHiOXk+6vRvK3d4A55W5ziI6vi3N83vEeTQvSz7XzxFvhDyDIvnWtR+NDvrS3xVjF3NzKc9lwFIpL7x+z4JJsikqr1STY4BnKDnm+dk4z/yQAuq0YZgfFGJJ3A2tfvDASz0crbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gw-0006VK-Nk; Tue, 09 Apr 2024 10:18:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00BGpQ-OK; Tue, 09 Apr 2024 10:18:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ru6gu-00EoUu-25;
	Tue, 09 Apr 2024 10:18:52 +0200
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
Subject: [PATCH net-next v5 3/9] net: add IEEE 802.1q specific helpers
Date: Tue,  9 Apr 2024 10:18:45 +0200
Message-Id: <20240409081851.3530641-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409081851.3530641-1-o.rempel@pengutronix.de>
References: <20240409081851.3530641-1-o.rempel@pengutronix.de>
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
changes v4:
- use -EOPNOTSUPP instead of -ENOTSUP
- ieee8021q_tt_to_tc() return error if requested not supported amount
  of queues
changes v2:
- properly export symbols with EXPORT_SYMBOL_GPL()
- return error if NET_IEEE8021Q_HELPERS is not enabled
---
 include/net/dscp.h           |  76 ++++++++++++++++
 include/net/ieee8021q.h      |  51 +++++++++++
 net/Kconfig                  |   4 +
 net/core/Makefile            |   1 +
 net/core/ieee8021q_helpers.c | 171 +++++++++++++++++++++++++++++++++++
 5 files changed, 303 insertions(+)
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
index 0000000000000..08fb5a617c046
--- /dev/null
+++ b/include/net/ieee8021q.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Pengutronix, Oleksij Rempel <kernel@pengutronix.de> */
+
+#ifndef _NET_IEEE8021Q_H
+#define _NET_IEEE8021Q_H
+
+#include <linux/errno.h>
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
+	return -EOPNOTSUPP;
+}
+
+static inline int ieee8021q_tt_to_tc(int tt, int num_queues)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+#endif /* _NET_IEEE8021Q_H */
diff --git a/net/Kconfig b/net/Kconfig
index d5ab791f7afa2..b94ee06f28c18 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -452,6 +452,10 @@ config GRO_CELLS
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
index 0000000000000..3564dc83d1d3d
--- /dev/null
+++ b/net/core/ieee8021q_helpers.c
@@ -0,0 +1,171 @@
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
+ * Return: Traffic Class corresponding to the given Traffic Type or -EINVAL if
+ * the number of queues is not supported. -EINVAL is used to differentiate from
+ * -EOPNOTSUPP which is used to indicate that this library function is not
+ * compiled in.
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
+	pr_err("Invalid number of queues %d\n", num_queues);
+
+	return -EINVAL;
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


