Return-Path: <linux-kernel+bounces-134482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0089B206
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D3D1F2173C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B313699A;
	Sun,  7 Apr 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSA8RN7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A17136669;
	Sun,  7 Apr 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495642; cv=none; b=BLLOOtcXLFjhJz3n0CnuUaP6AMsXKLh0T6YbzhAwQHM1b8Ys5nHqGIZCoHG2XTchbItGjoY34SCx1JpH3hLnGOITg0CFCtjXfy7LwBUoLAiufiVMXjQE8gM+hdb/4vjtR+72AFuMxIeUvQmyhClJYXqa28XZHeyMkKhRFXiOJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495642; c=relaxed/simple;
	bh=CdUc6oULQVk5AB1jSJiDmIkZ3bOshTCoXgCAFJX+yPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Z7F2V3907RjtyQR+jvsqyZ16pOe1zytuopJthYlazWV0qsrjGpMEpL+dMxTr+c4rX8iokn1FZUOk5EioW7MAwd1awPow+/gJ6KLObUtDglO/POXLnqKIccWL/vxloQmdoH4TjZELVSaI595dOecsmME+Q+bxRYuTGJq63f57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSA8RN7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACCEC43390;
	Sun,  7 Apr 2024 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495641;
	bh=CdUc6oULQVk5AB1jSJiDmIkZ3bOshTCoXgCAFJX+yPg=;
	h=From:To:Cc:Subject:Date:From;
	b=OSA8RN7KnZF3joPuccf3R6Z6zbJI38ZmgmIVjZ1Pv+9b43o9On/M1Yzfb6G03VIYE
	 K50qGwtM8cgyWW+wWw6jzqp3G74ZqedT7QWi1VObtpFgXHj6NwkNlOwvgP4MoB93Ot
	 Szyx/jxeeAUA/IYAe4OuqEs5lCp39Jg9fVm/q9C98fON/IAYr5f1usyAS9RiNU9fSy
	 ifhODTRPdSQGodfsT6KIlAcmxCb+IlHPCXaIF+CsbY/fbcW5JQUT7SAriACT1VnOu9
	 dZ4ucgzEjFxxrWYkOP3CEBywvImM8mRMJLmrhQnvLGO4/gyNoUpDwBCNaSWvHTnYhi
	 iRtPrOJLxQ9Cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/7] scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
Date: Sun,  7 Apr 2024 09:13:52 -0400
Message-ID: <20240407131400.1053377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit bb011631435c705cdeddca68d5c85fd40a4320f9 ]

Typically when an out of resource CQE status is detected, the
lpfc_ramp_down_queue_handler() logic is called to help reduce I/O load by
reducing an sdev's queue_depth.

However, the current lpfc_rampdown_queue_depth() logic does not help reduce
queue_depth.  num_cmd_success is never updated and is always zero, which
means new_queue_depth will always be set to sdev->queue_depth.  So,
new_queue_depth = sdev->queue_depth - new_queue_depth always sets
new_queue_depth to zero.  And, scsi_change_queue_depth(sdev, 0) is
essentially a no-op.

Change the lpfc_ramp_down_queue_handler() logic to set new_queue_depth
equal to sdev->queue_depth subtracted from number of times num_rsrc_err was
incremented.  If num_rsrc_err is >= sdev->queue_depth, then set
new_queue_depth equal to 1.  Eventually, the frequency of Good_Status
frames will signal SCSI upper layer to auto increase the queue_depth back
to the driver default of 64 via scsi_handle_queue_ramp_up().

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-5-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      |  1 -
 drivers/scsi/lpfc/lpfc_scsi.c | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index cf69f831a7253..8f1b5b0ee8cd8 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1065,7 +1065,6 @@ struct lpfc_hba {
 	unsigned long bit_flags;
 #define	FABRIC_COMANDS_BLOCKED	0
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b4b87e5d8b291..2121534838747 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -246,11 +246,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 	struct Scsi_Host  *shost;
 	struct scsi_device *sdev;
 	unsigned long new_queue_depth;
-	unsigned long num_rsrc_err, num_cmd_success;
+	unsigned long num_rsrc_err;
 	int i;
 
 	num_rsrc_err = atomic_read(&phba->num_rsrc_err);
-	num_cmd_success = atomic_read(&phba->num_cmd_success);
 
 	/*
 	 * The error and success command counters are global per
@@ -265,20 +264,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
 		for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 			shost = lpfc_shost_from_vport(vports[i]);
 			shost_for_each_device(sdev, shost) {
-				new_queue_depth =
-					sdev->queue_depth * num_rsrc_err /
-					(num_rsrc_err + num_cmd_success);
-				if (!new_queue_depth)
-					new_queue_depth = sdev->queue_depth - 1;
+				if (num_rsrc_err >= sdev->queue_depth)
+					new_queue_depth = 1;
 				else
 					new_queue_depth = sdev->queue_depth -
-								new_queue_depth;
+						num_rsrc_err;
 				scsi_change_queue_depth(sdev, new_queue_depth);
 			}
 		}
 	lpfc_destroy_vport_work_array(phba, vports);
 	atomic_set(&phba->num_rsrc_err, 0);
-	atomic_set(&phba->num_cmd_success, 0);
 }
 
 /**
-- 
2.43.0


