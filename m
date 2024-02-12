Return-Path: <linux-kernel+bounces-61548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F6851395
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AE2B2425B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134F3A1B8;
	Mon, 12 Feb 2024 12:33:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FCC1E487
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741186; cv=none; b=ZvI7gIuPXNjZEdar2ryd23FEtmaW76xEMsX3MONAOdY9N7vq04lPsmC9TIqnFhvuOYOFrh/T7CSkCErCnh1p/vT/c/Oac5wvg+34MYwB/ifdvqX3ZtJoj7z4plJcZ8t67tDJnzY0nb+7yZdAxTT19aSunc/duhzazcwUny24YzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741186; c=relaxed/simple;
	bh=JlkQiW/QuL/OX9TPCicFNqlZdcMRLppLsC1w6NTqto0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6UhkiMppLK/uGb/oCUdlBBdvW9mTmGrk0IlZMqCj54Ov3guU3bs0R/kx+gNXZxGkkOU+s9JNNUStVbveUbnf+ezSj9kpfHFAqw7Ec7/euTrGm5QUk8UINa+XcIPe+2PdmzqFgRBLICNXXd8+K1PYwWg0WHlvsIxa9MPeXNAyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A3BAFEC;
	Mon, 12 Feb 2024 04:33:44 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3E03F7BD;
	Mon, 12 Feb 2024 04:33:01 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 01/11] firmware: arm_scmi: Check for notification support
Date: Mon, 12 Feb 2024 12:32:23 +0000
Message-ID: <20240212123233.1230090-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212123233.1230090-1-cristian.marussi@arm.com>
References: <20240212123233.1230090-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When registering protocol events, use the optional .is_notify_supported
callback provided by the protocol to check if that specific notification
type is available for that particular resource on the running system,
marking it as unsupported otherwise.

Then, when a notification enable request is received, return an error if
it was previously marked as unsuppported, so avoiding to send a needless
notification enable command and check the returned value for failure.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 17 ++++++++++++++++-
 drivers/firmware/arm_scmi/notify.h |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..27c52531194d 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -99,6 +99,7 @@
 #define PROTO_ID_MASK		GENMASK(31, 24)
 #define EVT_ID_MASK		GENMASK(23, 16)
 #define SRC_ID_MASK		GENMASK(15, 0)
+#define NOTIF_UNSUPP		-1
 
 /*
  * Builds an unsigned 32bit key from the given input tuple to be used
@@ -788,6 +789,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 
 	pd->ph = ph;
 	for (i = 0; i < ee->num_events; i++, evt++) {
+		int id;
 		struct scmi_registered_event *r_evt;
 
 		r_evt = devm_kzalloc(ni->handle->dev, sizeof(*r_evt),
@@ -809,6 +811,11 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 		if (!r_evt->report)
 			return -ENOMEM;
 
+		for (id = 0; id < r_evt->num_sources; id++)
+			if (ee->ops->is_notify_supported &&
+			    !ee->ops->is_notify_supported(ph, r_evt->evt->id, id))
+				refcount_set(&r_evt->sources[id], NOTIF_UNSUPP);
+
 		pd->registered_events[i] = r_evt;
 		/* Ensure events are updated */
 		smp_wmb();
@@ -1166,7 +1173,13 @@ static inline int __scmi_enable_evt(struct scmi_registered_event *r_evt,
 			int ret = 0;
 
 			sid = &r_evt->sources[src_id];
-			if (refcount_read(sid) == 0) {
+			if (refcount_read(sid) == NOTIF_UNSUPP) {
+				dev_dbg(r_evt->proto->ph->dev,
+					"Notification NOT supported - proto_id:%d  evt_id:%d  src_id:%d",
+					r_evt->proto->id, r_evt->evt->id,
+					src_id);
+				ret = -EOPNOTSUPP;
+			} else if (refcount_read(sid) == 0) {
 				ret = REVT_NOTIFY_ENABLE(r_evt, r_evt->evt->id,
 							 src_id);
 				if (!ret)
@@ -1179,6 +1192,8 @@ static inline int __scmi_enable_evt(struct scmi_registered_event *r_evt,
 	} else {
 		for (; num_sources; src_id++, num_sources--) {
 			sid = &r_evt->sources[src_id];
+			if (refcount_read(sid) == NOTIF_UNSUPP)
+				continue;
 			if (refcount_dec_and_test(sid))
 				REVT_NOTIFY_DISABLE(r_evt,
 						    r_evt->evt->id, src_id);
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 4e9b627edfef..76758a736cf4 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -35,6 +35,8 @@ struct scmi_protocol_handle;
 
 /**
  * struct scmi_event_ops  - Protocol helpers called by the notification core.
+ * @is_notify_supported: Return 0 if the specified notification for the
+ *			 specified resource (src_id) is supported.
  * @get_num_sources: Returns the number of possible events' sources for this
  *		     protocol
  * @set_notify_enabled: Enable/disable the required evt_id/src_id notifications
@@ -50,6 +52,8 @@ struct scmi_protocol_handle;
  *	    process context.
  */
 struct scmi_event_ops {
+	bool (*is_notify_supported)(const struct scmi_protocol_handle *ph,
+				    u8 evt_id, u32 src_id);
 	int (*get_num_sources)(const struct scmi_protocol_handle *ph);
 	int (*set_notify_enabled)(const struct scmi_protocol_handle *ph,
 				  u8 evt_id, u32 src_id, bool enabled);
-- 
2.43.0


