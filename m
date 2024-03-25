Return-Path: <linux-kernel+bounces-117983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB988B24F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB77BA4B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7371B50;
	Mon, 25 Mar 2024 20:46:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983C5D731
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399605; cv=none; b=HmUaLUrNM0UCk3nmZgqel/aY1HfkTFwi3PN3bsfZgJTr2mYTkf+p1I/E4z+5XACA53FepFThfjGXIVKJD4PojZQJ4xG6Lhl2f6H5gNVANQotzAB3LWqYW4TehvhXce009nUZEkoadzKWVczSGzFcseN72Ot7arZzDFzHoJkVvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399605; c=relaxed/simple;
	bh=E9VR4uFNct4R0/K6vDVJzOhucLGN0R2nVU29cih1sI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quy0xzWJOAB/C/+m9gVIwLznmilPiyqzxCC+Ay+K2maZtc2lTWDtjxFJ40gmHSsTwcu9HZDVk3sRqKzRKnHIz05ppEkAGyiI5lbTXSKT6aOHjYHH4J6cMJmIl4uewoyL07vUDLeJBF6g54Bc6X2YhPDORO1K4BwFEHPgTbc6Kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B81B13D5;
	Mon, 25 Mar 2024 13:47:16 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0A83F64C;
	Mon, 25 Mar 2024 13:46:41 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 2/5] firmware: arm_scmi: Add helper to trace bad messages
Date: Mon, 25 Mar 2024 20:46:17 +0000
Message-ID: <20240325204620.1437237-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325204620.1437237-1-cristian.marussi@arm.com>
References: <20240325204620.1437237-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon reception of malformed and unexpected timed-out SCMI messages, it is
not possible to trace those bad messages in their entirety, because usually
we cannot even retrieve the payload, or it is just not reliable.

Add a helper to trace at least the content of the header of the received
message while associating a meaningful tag and error code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 11 +++++++++
 drivers/firmware/arm_scmi/driver.c | 39 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6affbfdd1dec..b5ac25dbc1ca 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -301,6 +301,17 @@ extern const struct scmi_desc scmi_optee_desc;
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
+enum scmi_bad_msg {
+	MSG_UNEXPECTED = -1,
+	MSG_INVALID = -2,
+	MSG_UNKNOWN = -3,
+	MSG_NOMEM = -4,
+	MSG_MBOX_SPURIOUS = -5,
+};
+
+void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
+			    enum scmi_bad_msg err);
+
 /* shmem related declarations */
 struct scmi_shared_mem;
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2709598f3008..7fc1c5b1a2a4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -696,6 +696,45 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
 	return xfer ?: ERR_PTR(-EINVAL);
 }
 
+/**
+ * scmi_bad_message_trace  - A helper to trace weird messages
+ *
+ * @cinfo: A reference to the channel descriptor on which the message was
+ *	   received
+ * @msg_hdr: Message header to track
+ * @err: A specific error code used as a status value in traces.
+ *
+ * This helper can be used to trace any kind of weird, incomplete, unexpected,
+ * timed-out message that arrives and as such, can be traced only referring to
+ * the header content, since the payload is missing/unreliable.
+ */
+void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
+			    enum scmi_bad_msg err)
+{
+	char *tag;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+
+	switch (MSG_XTRACT_TYPE(msg_hdr)) {
+	case MSG_TYPE_COMMAND:
+		tag = "!RESP";
+		break;
+	case MSG_TYPE_DELAYED_RESP:
+		tag = "!DLYD";
+		break;
+	case MSG_TYPE_NOTIFICATION:
+		tag = "!NOTI";
+		break;
+	default:
+		tag = "!UNKN";
+		break;
+	}
+
+	trace_scmi_msg_dump(info->id, cinfo->id,
+			    MSG_XTRACT_PROT_ID(msg_hdr),
+			    MSG_XTRACT_ID(msg_hdr), tag,
+			    MSG_XTRACT_TOKEN(msg_hdr), err, NULL, 0);
+}
+
 /**
  * scmi_msg_response_validate  - Validate message type against state of related
  * xfer
-- 
2.44.0


