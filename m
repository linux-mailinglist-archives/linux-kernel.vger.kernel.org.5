Return-Path: <linux-kernel+bounces-98906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3308780E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C10283FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A473FBAC;
	Mon, 11 Mar 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GHxOO/kw"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3E3FB93;
	Mon, 11 Mar 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165100; cv=none; b=XbN9dzEre09d4HCfownM35s/4eluJC92HQ1j6sso11NtburaJw5TArZGNfT+Y7pdgISH4WdOjaxfyj3RE3KSJpPcTpxAREerKwMZ8XjSdZXwKL13WEgNDMrYm0gOKYQ7enPctnPSeXFDMPX6ODGNYAeAnMa1RbMNUsVWVZ9cglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165100; c=relaxed/simple;
	bh=jIvXgTVERW9CaTKVGFWK56Sf/4a1N9B1WtixmIi5Psw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFTo4oOsWojhhznnJyuetoqRzv+uY/Y/GeI+feg+4UwDbS1jXeQ7zSUzbQpIibMosSgfy5SC1VdgkvjkVeCIUHxEzlt+TntLQ3kXB7BbeWlJaod5jBMEzBvGaQNPYhVsNmwemSlncgzuZqS9bZpjzmQbzByKIC29QLcitIrWCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GHxOO/kw; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B7FYFD019486;
	Mon, 11 Mar 2024 06:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	pfpt0220; bh=qqv6s1uHynI5uyK+i77N2z44izpumiOywvM8AV4dU60=; b=GHx
	OO/kwzIkXq+nVBUaWiZmOclLP3DtosHmeSMkLawZf33OnjbRUOlmmXZ2B6UF60Py
	Zc3GNzz944naAVkGpEostIFSGrz6r8dTCUHdDjAkjXIB4xuAv9uc5V33cMzzkWb4
	uvjJaG5MFodYXjWbTGsgmXVhO/EBB6b6xfazEVoEdApwuqCbTysR7TbqHumrUPFN
	9ANlVdhUV3Nw8Gt1COoGxNbJGyVpOMze8hHyi7o0ZPhd0071sA+UELQGkX1eOlOs
	J3yYSoGBXp0tUfYahCZryOVAzOtaaFGiT/CEEmkGPQU3bySf/ogjlARFaYdNCS+a
	R859Ynx0v7VBFLSAqmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wswdcs2dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:51:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 06:51:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 06:51:21 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 49E7C3F7051;
	Mon, 11 Mar 2024 06:51:19 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH 1/3] net: marvell: prestera: fix driver reload
Date: Mon, 11 Mar 2024 15:51:10 +0200
Message-ID: <20240311135112.2642491-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311135112.2642491-1-enachman@marvell.com>
References: <20240311135112.2642491-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7OHnlc4gS-M_iqFxc07GZjgAIKAwSx55
X-Proofpoint-GUID: 7OHnlc4gS-M_iqFxc07GZjgAIKAwSx55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Driver rmmod after insmod would fail because of
the following issues:

1. API call to reset the switch HW and restart the
   firmware CPU firmware code loading was missing in
   driver removal code handler.
2. Timeout waiting for the firmware CPU firmware
   loader code to start was too small.

Fix by adding API call to reset the switch HW and
restart the firmware CPU firmware code loading when
handling the driver removal procedure,
increase the timeout waiting for this restart operation
from 5 to 30 seconds.

Reported-by: Köry Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_hw.c   | 8 ++++++++
 drivers/net/ethernet/marvell/prestera/prestera_hw.h   | 1 +
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 3 ++-
 drivers/net/ethernet/marvell/prestera/prestera_pci.c  | 7 ++++++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
index fc6f7d2746e8..08de8b498e0a 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
@@ -21,6 +21,7 @@
 enum prestera_cmd_type_t {
 	PRESTERA_CMD_TYPE_SWITCH_INIT = 0x1,
 	PRESTERA_CMD_TYPE_SWITCH_ATTR_SET = 0x2,
+	PRESTERA_CMD_TYPE_SWITCH_RESET = 0x4,
 
 	PRESTERA_CMD_TYPE_PORT_ATTR_SET = 0x100,
 	PRESTERA_CMD_TYPE_PORT_ATTR_GET = 0x101,
@@ -1087,6 +1088,13 @@ void prestera_hw_switch_fini(struct prestera_switch *sw)
 	WARN_ON(!list_empty(&sw->event_handlers));
 }
 
+int prestera_hw_switch_reset(struct prestera_switch *sw)
+{
+	struct prestera_msg_common_req req;
+
+	return prestera_cmd(sw, PRESTERA_CMD_TYPE_SWITCH_RESET, &req.cmd, sizeof(req));
+}
+
 int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms)
 {
 	struct prestera_msg_switch_attr_req req = {
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.h b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
index 0a929279e1ce..86217bea2ca0 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_hw.h
+++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.h
@@ -150,6 +150,7 @@ struct prestera_neigh_info;
 
 /* Switch API */
 int prestera_hw_switch_init(struct prestera_switch *sw);
+int prestera_hw_switch_reset(struct prestera_switch *sw);
 void prestera_hw_switch_fini(struct prestera_switch *sw);
 int prestera_hw_switch_ageing_set(struct prestera_switch *sw, u32 ageing_ms);
 int prestera_hw_switch_mac_set(struct prestera_switch *sw, const char *mac);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 4fb886c57cd7..bcaa8ea27b49 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -1444,7 +1444,7 @@ static int prestera_switch_init(struct prestera_switch *sw)
 err_router_init:
 	prestera_netdev_event_handler_unregister(sw);
 	prestera_hw_switch_fini(sw);
-
+	prestera_hw_switch_reset(sw);
 	return err;
 }
 
@@ -1463,6 +1463,7 @@ static void prestera_switch_fini(struct prestera_switch *sw)
 	prestera_router_fini(sw);
 	prestera_netdev_event_handler_unregister(sw);
 	prestera_hw_switch_fini(sw);
+	prestera_hw_switch_reset(sw);
 	of_node_put(sw->np);
 }
 
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 35857dc19542..b75a263ad8cb 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -24,6 +24,11 @@
 #define PRESTERA_FW_ARM64_PATH_FMT "mrvl/prestera/mvsw_prestera_fw_arm64-v%u.%u.img"
 
 #define PRESTERA_FW_HDR_MAGIC		0x351D9D06
+/* Timeout waiting for prestera firmware CPU to reboot and
+ * restart the firmware loading software layer, hence becoming
+ * ready for the next firmware downloading phase:
+ */
+#define PRESTERA_FW_READY_TIMEOUT_SECS	30
 #define PRESTERA_FW_DL_TIMEOUT_MS	50000
 #define PRESTERA_FW_BLK_SZ		1024
 
@@ -765,7 +770,7 @@ static int prestera_fw_load(struct prestera_fw *fw)
 
 	err = prestera_ldr_wait_reg32(fw, PRESTERA_LDR_READY_REG,
 				      PRESTERA_LDR_READY_MAGIC,
-				      5 * MSEC_PER_SEC);
+				      PRESTERA_FW_READY_TIMEOUT_SECS * MSEC_PER_SEC);
 	if (err) {
 		dev_err(fw->dev.dev, "waiting for FW loader is timed out");
 		return err;
-- 
2.25.1


