Return-Path: <linux-kernel+bounces-85602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF1586B831
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF361F24AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2015E5CE;
	Wed, 28 Feb 2024 19:33:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E67D406
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148793; cv=none; b=D8EZ3tyXQhQEOn/LOYdjvlmONhwjZ9uiQjqYh9qCS63XN7eyVw5Px7e20L/ilEksLAqCYXZk23ME/aZmV9Qbi5okmcM8lKjm2YA7j2+jda8WxChEcqOolWe9yeT19ZOui9ZSup246vIlaflnRtHKfk7kuJXMuTTr2zUnUGq08RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148793; c=relaxed/simple;
	bh=AoB8v9iRXv+R1wRD6aDoHrJAOehVSVKk6EBz1WgbNTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKHezASKmKfZhfXMeYTkj0jYsBnjZuNMaw0dSaaS9XCVf8bfjYJZN1vhZ/esJ13vWg6Emj452j10ly5uQXfAv56oEac96YDUzSbAMYHQ9Ot1kM0E5Egmujxz07G60TXCsWyMI5cHCUOM0+P6FH9X41ZPpV5piR0ddsUHwSSL4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4801007;
	Wed, 28 Feb 2024 11:33:48 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8933F73F;
	Wed, 28 Feb 2024 11:33:07 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/4] firmware: arm_scmi: Add message dump traces for bad and unexpected replies
Date: Wed, 28 Feb 2024 19:32:36 +0000
Message-ID: <20240228193238.2102157-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228193238.2102157-1-cristian.marussi@arm.com>
References: <20240228193238.2102157-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use trace_scmi_msg_dump also to account for late-timed-out, out-of-order
and unexpected replies.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 36 +++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 34d77802c990..a3182199f123 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -822,6 +822,13 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			"Message for %d type %d is not expected!\n",
 			xfer_id, msg_type);
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+		trace_scmi_msg_dump(info->id, cinfo->id,
+				    MSG_XTRACT_PROT_ID(msg_hdr),
+				    MSG_XTRACT_ID(msg_hdr),
+				    !msg_type ? "_!RESP" : "_!DLYD",
+				    xfer_id, 0, NULL, 0);
+
 		return xfer;
 	}
 	refcount_inc(&xfer->users);
@@ -846,6 +853,13 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		dev_err(cinfo->dev,
 			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
 			msg_type, xfer_id, msg_hdr, xfer->state);
+
+		trace_scmi_msg_dump(info->id, cinfo->id,
+				    MSG_XTRACT_PROT_ID(msg_hdr),
+				    MSG_XTRACT_ID(msg_hdr),
+				    !msg_type ? "_!RESP" : "_!DLYD",
+				    xfer_id, 0, NULL, 0);
+
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
 		xfer = ERR_PTR(-EINVAL);
@@ -882,6 +896,12 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
+
+		trace_scmi_msg_dump(info->id, cinfo->id,
+				    MSG_XTRACT_PROT_ID(msg_hdr),
+				    MSG_XTRACT_ID(msg_hdr), "_!NOTI",
+				    MSG_XTRACT_TOKEN(msg_hdr), 0, NULL, 0);
+
 		scmi_clear_channel(info, cinfo);
 		return;
 	}
@@ -923,10 +943,18 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
+		u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
+
+		trace_scmi_msg_dump(info->id, cinfo->id,
+				    MSG_XTRACT_PROT_ID(msg_hdr),
+				    MSG_XTRACT_ID(msg_hdr),
+				    !msg_type ? "_!RESP" : "_!DLYD",
+				    MSG_XTRACT_TOKEN(msg_hdr), 0, NULL, 0);
+
 		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT))
 			scmi_raw_error_report(info->raw, cinfo, msg_hdr, priv);
 
-		if (MSG_XTRACT_TYPE(msg_hdr) == MSG_TYPE_DELAYED_RESP)
+		if (msg_type == MSG_TYPE_DELAYED_RESP)
 			scmi_clear_channel(info, cinfo);
 		return;
 	}
@@ -990,6 +1018,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
 {
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
 	switch (msg_type) {
 	case MSG_TYPE_NOTIFICATION:
@@ -1001,6 +1030,11 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
+		trace_scmi_msg_dump(info->id, cinfo->id,
+				    MSG_XTRACT_PROT_ID(msg_hdr),
+				    MSG_XTRACT_ID(msg_hdr), "_!UNKN",
+				    MSG_XTRACT_TOKEN(msg_hdr), 0, NULL, 0);
+
 		break;
 	}
 }
-- 
2.43.0


