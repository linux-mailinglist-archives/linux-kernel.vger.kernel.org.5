Return-Path: <linux-kernel+bounces-134439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301F689B182
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92C91F21108
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60777C0BA;
	Sun,  7 Apr 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw6d/Be7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F67CF0F;
	Sun,  7 Apr 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495558; cv=none; b=D0v2M6aQdQET897pfCAsmuXLgFH2+9hKelTWQGb2sRbrR+DW9Dawy3gqL/94Hr5zv9F3PIfTkBe6VPGDu5ZxTsa2UDcIuAuthbDoV2KTLXTxdr7+YVj5AkaLKUo/vx4zU8Ni8cm9QYHx2SMIIiYIXvzFPLe/7j00ejVbmGO4jEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495558; c=relaxed/simple;
	bh=Z3qs+jVDzbjy4F6F96Y6axrHvOpYUWjFxpb0JRDg0ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwG5e1q4RJBDw2VuyMFF0+pvJi/YZWfpve1JiiA+ZcWoVsoDDVZh2aHR1fqM8dD/FW70NMP1y9GIlN2ywJ8cymXUnZ4V+Cjd1PxZP3kPCFvx8HokAQhEOaWnEZA5vlwSVZP/ZuFt2Wl7LsiCXmy0QTS7NF9xipcX4fbN0DOzlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw6d/Be7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223EC433C7;
	Sun,  7 Apr 2024 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495557;
	bh=Z3qs+jVDzbjy4F6F96Y6axrHvOpYUWjFxpb0JRDg0ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gw6d/Be74ICTobznPPdSWCa01iQT2EJC+pwHJ2ejahXA2TH9avRluFfhEr4+gRIN0
	 saVFJc2nmwtI1kcguU5v85KeMMoPAraH/8UA8f2lt3Sf5QKaZOJMD4bgEk9GfBnbQ5
	 5kxt2JPjzO4oDZpnaMgg0pM0fawiiszgJDahYeaXopbvKNT43eAuG89A9qfpM2sXji
	 qwvJmhsEx1s1hZ9kvXTDgWJq+DsbDhlZrozCcWZHJjxAbZhEId0bmxzT77Uf7D7wVa
	 cNRTmJGYu7T7rPzRLe5/MWywWqGHI8msyofGiiYEwRpP3ITgav4CJDT6bdNCMuHWc9
	 NdUPikGzl5ONQ==
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
Subject: [PATCH AUTOSEL 6.6 04/22] scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
Date: Sun,  7 Apr 2024 09:12:03 -0400
Message-ID: <20240407131231.1051652-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index 04d608ea91060..be016732ab2ea 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1325,7 +1325,6 @@ struct lpfc_hba {
 	struct timer_list fabric_block_timer;
 	unsigned long bit_flags;
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index bf879d81846b6..cf506556f3b0b 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -167,11 +167,10 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
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
@@ -186,20 +185,16 @@ lpfc_ramp_down_queue_handler(struct lpfc_hba *phba)
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


