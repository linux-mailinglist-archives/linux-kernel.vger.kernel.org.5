Return-Path: <linux-kernel+bounces-109226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F03881671
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA21285875
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942E6A8AE;
	Wed, 20 Mar 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i4SQz4g8"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48146A031;
	Wed, 20 Mar 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955245; cv=none; b=UIAmqAFu9nh1RrAwmGv+lhDdm19xgMesu/KRlrF7ulvoAEQj6EN3aTfb6WfGqaBem4LTkMvbnmHoitiFrdiotYBsgJAHxsHDUkmr4h6wUvAu4fVk86vW697kP8Ee1lKqqew85l4LyP3f06O5NvUJrVWkNyL0bGEm/bu5QKtyFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955245; c=relaxed/simple;
	bh=Lu3PAsV8idIwc1WpiGaF9N5iGw2xyESicAA7I+XC6Kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnPI9llzk3M1InH4CqILjISTJCMRmBrcAEmM7RhuyY/RxbOr9sZhQ/aWMMVNPH/JsY5LF3kRNaEbqvV2V8XsgBZJMcT2V1hbTWPPX2G7g2Vdq2niTqnAW6ky8j5V7nvxtOaUWXpDd2dGpqbq10IhLyJX9KIeW0bjYlr+be1LyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i4SQz4g8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KFJHDd003970;
	Wed, 20 Mar 2024 10:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	pfpt0220; bh=L951DHMxIyS3n0VafEIzeSBEdcc343kBJS7IpV0atm8=; b=i4S
	Qz4g8sjNpQhLutpN8UgOdcitpEaGx4wL4mObTqoX3w3yYxc7kn8f8NgJxWZnxAAr
	XiOTDm+MvHNmwcKoKdIe0lrIgW94Wxmff03AWRgdZZ/nwFaLNduo9ZdnV6L/N+f6
	Z0Eylcs2WwgdwZMjahdtHf7E9pEBrIjWkh88Xkgku5/XC4onSesr7QEWo/+djmEv
	XynBq1ZURFEToL8LIypf71EpCKrTiwaMcWQ31Rv5/tJRyJFpsSvhr2dRMH/Mn4aK
	fY2+czWy9aLnrc2rmg+EtNi0uRGF2bUKbNfmrLY1ZzeN7PM2FpI2IAs/doUfD9Sx
	eq8vERu6iG/6PZyORQw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka52e32-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:20:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Wed, 20 Mar 2024 10:20:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.32 via Frontend
 Transport; Wed, 20 Mar 2024 10:20:18 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 2E0073F705E;
	Wed, 20 Mar 2024 10:20:14 -0700 (PDT)
From: Elad Nachman <enachman@marvell.com>
To: <taras.chornyi@plvision.eu>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <kory.maincent@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <miquel.raynal@bootlin.com>, <przemyslaw.kitszel@intel.com>,
        <dkirjanov@suse.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 1/5] net: marvell: prestera: fix driver reload
Date: Wed, 20 Mar 2024 19:20:04 +0200
Message-ID: <20240320172008.2989693-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320172008.2989693-1-enachman@marvell.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _0HuwkLqTzIZVh0y6Nbj9GFNvDspLIym
X-Proofpoint-ORIG-GUID: _0HuwkLqTzIZVh0y6Nbj9GFNvDspLIym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Driver rmmod after insmod would fail because API call to reset the switch
HW and restart the firmware CPU code loading procedure was missing in
driver removal code handler.

Firmware reset and reload is needed as the firmware termination will make
the firmware loader change its state machine to the firmware loading state,
and thus will be able to load new firmware, which is done at the beginning
of the probing of the prestera_pci module.

Without this reset, the firmware loader will stay in the wrong state,
causing the next firmware loading phase in the probe to fail.

Fix by adding API call to reset the switch HW and restart the firmware CPU
firmware code loading when handling the driver removal procedure.

Reported-by: Köry Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/
Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Tested-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_hw.c   | 8 ++++++++
 drivers/net/ethernet/marvell/prestera/prestera_hw.h   | 1 +
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

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
 
-- 
2.25.1


