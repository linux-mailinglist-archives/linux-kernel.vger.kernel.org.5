Return-Path: <linux-kernel+bounces-134461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBF289B1C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290DA1C20E76
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E563F9F6;
	Sun,  7 Apr 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz+DGLNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4412D745;
	Sun,  7 Apr 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495602; cv=none; b=ctK8RIlEX0NOuTyJbotp6M/i1UkCPjyMsT/PrclnBf56kpcOyf6VGi38/WVMiaIeYrOchni1bdmexLIwJEpi+doSqqpkZkuh0Suh2iRCEWDrk/Byu42l1kE8kscb1WkdCfqNII9U6aSycajvsdikr7eiZ8gIpNAU0dzy2NdrpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495602; c=relaxed/simple;
	bh=XAle35rYzmrQ7SZ2cKgOj7vosUI8VAKHYwoDEMyNjMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVm4rO3ffvCS6/tWT8RqU6nI/0vbV7/pt7HlES/WYqp9+Xhh/rAYmwPJVcKEKyO3GygyUd/Gbnb2vBqOupVxPpa9NGGQfluiXXCT2Mpwg3Ttzc9gprXQZ8FQQkce/JjM2dfTVi4jiIeNLKPWL74mWroI0QO1bC9DcVEpfawbtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz+DGLNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967C8C433F1;
	Sun,  7 Apr 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495602;
	bh=XAle35rYzmrQ7SZ2cKgOj7vosUI8VAKHYwoDEMyNjMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lz+DGLNTT1/ZtSfH/T7KZwAk+wOZQkuMFgzoXXgxov7vX+8r94ahbWiV079NopLLp
	 IX4Irjh8ow1K0Ta3+pg4DmG5QVrUhrYriPd6hHBDGbznrb+p1N1/KRxMjn798Gn2pz
	 rFwVthVMZtve/BVTiMZjYbpg88pxIZ37gldnkZUFa+HgRYB9t3TqKn79RTSRkJ/+Ex
	 YdJvQxHFkRiwEB8pphjoW82v/o+uiKXXB18oQLbtq8uB5x5UsytKLBtiEttMOJxIpS
	 zwYDcki/brITk//UDrh1ljlCu6jtRMq8HXPkaZzMTy+swcfCfXTfyFhobk6Tx8h/ed
	 sgYSQ0KzPRM5Q==
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
Subject: [PATCH AUTOSEL 6.1 04/13] scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
Date: Sun,  7 Apr 2024 09:13:03 -0400
Message-ID: <20240407131316.1052393-4-sashal@kernel.org>
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

[ Upstream commit ded20192dff31c91cef2a04f7e20e60e9bb887d3 ]

lpfc_worker_wake_up() calls the lpfc_work_done() routine, which takes the
hbalock.  Thus, lpfc_worker_wake_up() should not be called while holding the
hbalock to avoid potential deadlock.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-7-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c     | 20 ++++++++++----------
 drivers/scsi/lpfc/lpfc_hbadisc.c |  5 ++---
 drivers/scsi/lpfc/lpfc_sli.c     | 14 +++++++-------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 6b5ce9869e6b4..05764008f6e70 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4384,23 +4384,23 @@ lpfc_els_retry_delay(struct timer_list *t)
 	unsigned long flags;
 	struct lpfc_work_evt  *evtp = &ndlp->els_retry_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, flags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, flags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* We need to hold the node by incrementing the reference
-	 * count until the queued work is done
-	 */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (evtp->evt_arg1) {
-		evtp->evt = LPFC_EVT_ELS_RETRY;
-		list_add_tail(&evtp->evt_listp, &phba->work_list);
-		lpfc_worker_wake_up(phba);
-	}
+	evtp->evt_arg1 = ndlp;
+	evtp->evt = LPFC_EVT_ELS_RETRY;
+	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, flags);
-	return;
+
+	lpfc_worker_wake_up(phba);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 549fa7d6c0f6f..aaa98a006fdcb 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -241,7 +241,9 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		if (evtp->evt_arg1) {
 			evtp->evt = LPFC_EVT_DEV_LOSS;
 			list_add_tail(&evtp->evt_listp, &phba->work_list);
+			spin_unlock_irqrestore(&phba->hbalock, iflags);
 			lpfc_worker_wake_up(phba);
+			return;
 		}
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
 	} else {
@@ -259,10 +261,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
-
 	}
-
-	return;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 427a6ac803e50..47b8102a7063a 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1217,9 +1217,9 @@ lpfc_set_rrq_active(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp,
 	empty = list_empty(&phba->active_rrq_list);
 	list_add_tail(&rrq->list, &phba->active_rrq_list);
 	phba->hba_flag |= HBA_RRQ_ACTIVE;
+	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	if (empty)
 		lpfc_worker_wake_up(phba);
-	spin_unlock_irqrestore(&phba->hbalock, iflags);
 	return 0;
 out:
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
@@ -11361,18 +11361,18 @@ lpfc_sli_post_recovery_event(struct lpfc_hba *phba,
 	unsigned long iflags;
 	struct lpfc_work_evt  *evtp = &ndlp->recovery_evt;
 
+	/* Hold a node reference for outstanding queued work */
+	if (!lpfc_nlp_get(ndlp))
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (!list_empty(&evtp->evt_listp)) {
 		spin_unlock_irqrestore(&phba->hbalock, iflags);
+		lpfc_nlp_put(ndlp);
 		return;
 	}
 
-	/* Incrementing the reference count until the queued work is done. */
-	evtp->evt_arg1  = lpfc_nlp_get(ndlp);
-	if (!evtp->evt_arg1) {
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-		return;
-	}
+	evtp->evt_arg1 = ndlp;
 	evtp->evt = LPFC_EVT_RECOVER_PORT;
 	list_add_tail(&evtp->evt_listp, &phba->work_list);
 	spin_unlock_irqrestore(&phba->hbalock, iflags);
-- 
2.43.0


