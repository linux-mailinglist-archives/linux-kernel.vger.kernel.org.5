Return-Path: <linux-kernel+bounces-117984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B688B663
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C5AB2CCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2A127B5C;
	Mon, 25 Mar 2024 20:46:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE86F51D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399606; cv=none; b=oJQPiAXPGx7xL6VBfNnkHFTgIxwKWed67Vsofah7M3RFB7gPjXjhXldzI1bEU+vfB6b4z7jx4gTSJma5I681N2jTU0PH47AxQrCDqEAjEsWwZJNJlKA9XKsAnpuxLLVNOqoLNMuwi6GoHl0TQQ5e9G3Q79F/T9iQlxBP7qwZfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399606; c=relaxed/simple;
	bh=8T5ZwzHm+pUzIreu235bdRVnTkVVGfB0nyqODE4kLr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK+U6oqqNBVrP7rOyFPpjmcDQ00OjQmRNF2uD/Ci9WDp7PkKIuQ2do7Kwp1mUWJFHGLfbajMi5J4JTVB9zbGGR/3wRvc9JkJDK9mTnjXTlEHdHcGu8tdoPpzcL/9ieL/YpyyktZoEiiBTvmUX2ljKfVEfsqngLjF7w8hWAOmDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45808153B;
	Mon, 25 Mar 2024 13:47:17 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2293F64C;
	Mon, 25 Mar 2024 13:46:42 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 3/5] firmware: arm_scmi: Add message dump traces for bad and unexpected replies
Date: Mon, 25 Mar 2024 20:46:18 +0000
Message-ID: <20240325204620.1437237-4-cristian.marussi@arm.com>
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

Trace also late-timed-out, out-of-order and unexpected/spurious messages.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c  | 10 ++++++++++
 drivers/firmware/arm_scmi/mailbox.c |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7fc1c5b1a2a4..207ed1a52d69 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -861,6 +861,9 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			"Message for %d type %d is not expected!\n",
 			xfer_id, msg_type);
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
+
 		return xfer;
 	}
 	refcount_inc(&xfer->users);
@@ -885,6 +888,9 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		dev_err(cinfo->dev,
 			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
 			msg_type, xfer_id, msg_hdr, xfer->state);
+
+		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
+
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
 		xfer = ERR_PTR(-EINVAL);
@@ -921,6 +927,9 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
+
+		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
+
 		scmi_clear_channel(info, cinfo);
 		return;
 	}
@@ -1040,6 +1049,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
+		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNKNOWN);
 		break;
 	}
 }
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index b8d470417e8f..fb0824af7180 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -56,7 +56,9 @@ static void rx_callback(struct mbox_client *cl, void *m)
 	 */
 	if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
 		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
-		return;
+		return scmi_bad_message_trace(smbox->cinfo,
+				     shmem_read_header(smbox->shmem),
+				     MSG_MBOX_SPURIOUS);
 	}
 
 	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
-- 
2.44.0


