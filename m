Return-Path: <linux-kernel+bounces-84463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6386A713
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB861B2B188
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057121EA99;
	Wed, 28 Feb 2024 03:15:30 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B511D681
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090129; cv=none; b=uY8MOMmnpe3KmwnKg9B8UT/DGVXqIDi3vu1Ci8YgXJl/o/gRawzIunB7LIM+CzbKKqqbHpNsq2T0ojtELS0eJB3CeCr0JgfprCeNKXc514wGWaaWfWsrg3GIRIPp+rOBBg2VD82QpE4NO4F9W1ipNYZpzdlJepuuYmFcaXzVwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090129; c=relaxed/simple;
	bh=fwjCOVuAe1e0TdDrUgm6xmn/efGbI2EduGdh+QYbqnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UmcZmAMbc4B46TRVhmoC7GvUAiUkhge/PYCvWXIcW4QwM5KYV29ajEjHFm4id+HVbduPN89E6YCuTW+s0m35abbW65tXcYSCiwn958wl5jjkdxqqgKqPQ7njfaR99DB1mraOZcdiy9G1ryroTv5y4dGrrDBgqWXI7mimleSaMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709090121-1eb14e0c7f4b750001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id J4vELxcXT5Px1eGw (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Feb 2024 11:15:21 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Feb
 2024 11:15:21 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Feb
 2024 11:15:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>
CC: <WeitaoWang@zhaoxin.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with device not attached.
Date: Wed, 28 Feb 2024 19:15:21 +0800
X-ASG-Orig-Subj: [PATCH v2] USB:UAS:return ENODEV when submit urbs fail with device not attached.
Message-ID: <20240228111521.3864-1-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1709090121
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4337
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121424
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

In the scenario of entering hibernation with udisk in the system, if the
udisk was gone or resume fail in the thaw phase of hibernation. Its state
will be set to NOTATTACHED. At this point, usb_hub_wq was already freezed
and can't not handle disconnect event. Next, in the poweroff phase of
hibernation, SYNCHRONIZE_CACHE SCSI command will be sent to this udisk
when poweroff this scsi device, which will cause uas_submit_urbs to be
called to submit URB for sense/data/cmd pipe. However, these URBs will
submit fail as device was set to NOTATTACHED state. Then, uas_submit_urbs
will return a value SCSI_MLQUEUE_DEVICE_BUSY to the caller. That will lead
the SCSI layer go into an ugly loop and system fail to go into hibernation.

On the other hand, when we specially check for -ENODEV in function
uas_queuecommand_lck, returning DID_ERROR to SCSI layer will cause device
poweroff fail and system shutdown instead of entering hibernation.

To fix this issue, let uas_submit_urbs function to return a value -ENODEV
when submit URB fail with device in NOTATTACHED state. At the same time,
we need to translate -ENODEV to DID_NOT_CONNECT for the SCSI layer.

Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
v1->v2
 - Modify the description of this patch.

 drivers/usb/storage/uas.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 9707f53cfda9..967f18db525a 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -533,7 +533,7 @@ static struct urb *uas_alloc_cmd_urb(struct uas_dev_info *devinfo, gfp_t gfp,
  * daft to me.
  */
 
-static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
+static int uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 {
 	struct uas_dev_info *devinfo = cmnd->device->hostdata;
 	struct urb *urb;
@@ -541,16 +541,15 @@ static struct urb *uas_submit_sense_urb(struct scsi_cmnd *cmnd, gfp_t gfp)
 
 	urb = uas_alloc_sense_urb(devinfo, gfp, cmnd);
 	if (!urb)
-		return NULL;
+		return -ENOMEM;
 	usb_anchor_urb(urb, &devinfo->sense_urbs);
 	err = usb_submit_urb(urb, gfp);
 	if (err) {
 		usb_unanchor_urb(urb);
 		uas_log_cmd_state(cmnd, "sense submit err", err);
 		usb_free_urb(urb);
-		return NULL;
 	}
-	return urb;
+	return err;
 }
 
 static int uas_submit_urbs(struct scsi_cmnd *cmnd,
@@ -562,9 +561,9 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 
 	lockdep_assert_held(&devinfo->lock);
 	if (cmdinfo->state & SUBMIT_STATUS_URB) {
-		urb = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
-		if (!urb)
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+		err = uas_submit_sense_urb(cmnd, GFP_ATOMIC);
+		if (err)
+			return (err == -ENODEV) ? -ENODEV : SCSI_MLQUEUE_DEVICE_BUSY;
 		cmdinfo->state &= ~SUBMIT_STATUS_URB;
 	}
 
@@ -582,7 +581,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_in_urb);
 			uas_log_cmd_state(cmnd, "data in submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return (err == -ENODEV) ? -ENODEV : SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_IN_URB;
 		cmdinfo->state |= DATA_IN_URB_INFLIGHT;
@@ -602,7 +601,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->data_out_urb);
 			uas_log_cmd_state(cmnd, "data out submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return (err == -ENODEV) ? -ENODEV : SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 		cmdinfo->state &= ~SUBMIT_DATA_OUT_URB;
 		cmdinfo->state |= DATA_OUT_URB_INFLIGHT;
@@ -621,7 +620,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 		if (err) {
 			usb_unanchor_urb(cmdinfo->cmd_urb);
 			uas_log_cmd_state(cmnd, "cmd submit err", err);
-			return SCSI_MLQUEUE_DEVICE_BUSY;
+			return (err == -ENODEV) ? -ENODEV : SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 		cmdinfo->cmd_urb = NULL;
 		cmdinfo->state &= ~SUBMIT_CMD_URB;
@@ -698,7 +697,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
-		set_host_byte(cmnd, DID_ERROR);
+		set_host_byte(cmnd, DID_NO_CONNECT);
 		scsi_done(cmnd);
 		goto zombie;
 	}
-- 
2.32.0


