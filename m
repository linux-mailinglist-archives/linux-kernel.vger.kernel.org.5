Return-Path: <linux-kernel+bounces-134459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7389B1BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C97AB218E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8F3F9CF;
	Sun,  7 Apr 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAlJZacw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7538398;
	Sun,  7 Apr 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495599; cv=none; b=plB8Cv9QWgjkrmkYbNbZMXrSmJkLJWCiW9ovj1iMaFfNJiw1DVq8aQFtLHi3ATrc03JLxB/kILcoV7RQu8okhqUbQ1w41jrGLDaVQFEF/XrzykIPcNaT9NkTLCZiqE1+gpe1mv6bs7aEkOhKRCTMSTpafcMLkgcSrXQLyCShbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495599; c=relaxed/simple;
	bh=gAHFSPpN7axUvPzb2qmZO7FelRSfZSBz7XDCLoGY23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8rO7SJ8teBCodJ2mfkApxeF/O08KtHw53A3yB4gpHdAYdZVRZvQBrK41d4FE/5a9bzGWI3zKcc6n8sqH3Mnz7Z4ADgEHEPpnSXxmQ0Jg7bpIvwJp55Z54GqEW6BDX05y/rLZBDh5ByN1Y20EBtLqEMSeIc/5IvIUOdAQ8N7Bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAlJZacw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B616FC433C7;
	Sun,  7 Apr 2024 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495599;
	bh=gAHFSPpN7axUvPzb2qmZO7FelRSfZSBz7XDCLoGY23Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAlJZacwEzdJgep/rFCKDHcBH+zslW6+BQCZ5o4U/Chi9zHzWgNDEmj1Fz8NlUf14
	 0dBB7L/Ncf3qYHM48SlEdkm4Y2nHURjuKZ0vJlVksfoTPMC0TmXLhqchMkHIi6lYtQ
	 AlG4PIDQiYcfwH1sb0F0d7CVzmVQ1vP2/PvjyXbC8hgdGflfV1ofnLZwS6no++7rVQ
	 jvhTwAJFbw4AYucrpfhWgkTmAutOkLpaPd990kwfECcPYK2pN1ZJl3zBjNZYyu79Xt
	 IQUHIVZe44PiyxUfs7iVgeqiS3czGkavgKmGK9kY+/GwH/qRYyMuGCWfUvwiHfkdhS
	 atr0j1My2VMPA==
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
Subject: [PATCH AUTOSEL 6.1 02/13] scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
Date: Sun,  7 Apr 2024 09:13:01 -0400
Message-ID: <20240407131316.1052393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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
index dc5ac3cc70f6d..6f08fbe103cb9 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1355,7 +1355,6 @@ struct lpfc_hba {
 	struct timer_list fabric_block_timer;
 	unsigned long bit_flags;
 	atomic_t num_rsrc_err;
-	atomic_t num_cmd_success;
 	unsigned long last_rsrc_error_time;
 	unsigned long last_ramp_down_time;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 0bb7e164b525f..2a81a42de5c14 100644
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


