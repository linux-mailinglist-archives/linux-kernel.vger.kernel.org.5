Return-Path: <linux-kernel+bounces-116347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721D889E67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5331F37865
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E87299193;
	Mon, 25 Mar 2024 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpwwHCz/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259B1856BD;
	Sun, 24 Mar 2024 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324364; cv=none; b=dzOMwXG151LXA3M/i4pSGvcN8X6Qfky55fk0v+I7a4HyeVWOvzBhHEVrh/5OEDdf1A0IYUEvDC4e1eR2/mCWGM4be4FQDKOSXaSxfiiJ4ipIhbfcwcZXqRZXu0Iyi8GEdtagyMa6SN7hdqpy/GmrquUPTfmBpiIAWhnXLIN15Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324364; c=relaxed/simple;
	bh=+eTRH49ETbASta4m11gcODFGG9ygmxuCFVXBDFrnhoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfS4kEQRhZgKk13Y5a9TFHv31B8X7cSek56ENgWyc45OivqhscB4h91eRc7IW6+fPQTXJXiuo+vP1sR09pnC8GR7bjW1RwsOY2VBQgQJ8AtN+0BOfNMZfHZpjw9aIqoleKbwSGHN7RG3k1GtTaitbE6fpb8hsca2rhZnGcVw57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpwwHCz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A65C433C7;
	Sun, 24 Mar 2024 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324363;
	bh=+eTRH49ETbASta4m11gcODFGG9ygmxuCFVXBDFrnhoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpwwHCz/mFXz8eLHnyNiijXYH+Hm0s6iAKVxT8w3n9OHnCgpPuq8fOac53QnY0CAm
	 0AFdaUt/SZWX9t65PC8fycR2Q2C9q4aI8aN9FJ6n6I6j2FZyhqDGl0FMQY9XEpIhvo
	 Nc0zQo22PB9dIVLroZXJLO7fekhemr3w/etvf4JcHYgmWFESn4rDwq+AheHyju/evx
	 MJg7hvXmf093XTNo2DBzWWn/sfX3kSKUHpPAVdA1f7qGD2F+6kCK3Ty4+FKdPf6ni3
	 susWdu6fPUMDZx6EgOLaN+6xY2OZze5/WvN9Mh6WGq06myzeez62hAveVmdEDImjWG
	 AI96XrZxZcb9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/148] scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn
Date: Sun, 24 Mar 2024 19:49:54 -0400
Message-ID: <20240324235012.1356413-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b69600231f751304db914c63b937f7098ed2895c ]

Some callback functions used here take a boolean argument, others take a
status argument. This breaks KCFI type checking, so clang now warns about
the function pointer cast:

drivers/scsi/bfa/bfad_bsg.c:2138:29: error: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Assuming the code is actually correct here and the callers always match the
argument types of the callee, rework this to replace the explicit cast with
a union of the two pointer types. This does not change the behavior of the
code, so if something is actually broken here, a larger rework may be
necessary.

Fixes: 37ea0558b87a ("[SCSI] bfa: Added support to collect and reset fcport stats")
Fixes: 3ec4f2c8bff2 ("[SCSI] bfa: Added support to configure QOS and collect stats.")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240222124433.2046570-1-arnd@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bfa/bfa.h      |  9 ++++++++-
 drivers/scsi/bfa/bfa_core.c |  4 +---
 drivers/scsi/bfa/bfa_ioc.h  |  8 ++++++--
 drivers/scsi/bfa/bfad_bsg.c | 11 ++++-------
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index 0e119d838e1b6..f312c356ffc4b 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -28,7 +28,6 @@
 struct bfa_s;
 
 typedef void (*bfa_isr_func_t) (struct bfa_s *bfa, struct bfi_msg_s *m);
-typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Interrupt message handlers
@@ -446,4 +445,12 @@ struct bfa_cb_pending_q_s {
 	(__qe)->data = (__data);				\
 } while (0)
 
+#define bfa_pending_q_init_status(__qe, __cbfn, __cbarg, __data) do {	\
+	bfa_q_qe_init(&((__qe)->hcb_qe.qe));			\
+	(__qe)->hcb_qe.cbfn_status = (__cbfn);			\
+	(__qe)->hcb_qe.cbarg = (__cbarg);			\
+	(__qe)->hcb_qe.pre_rmv = BFA_TRUE;			\
+	(__qe)->data = (__data);				\
+} while (0)
+
 #endif /* __BFA_H__ */
diff --git a/drivers/scsi/bfa/bfa_core.c b/drivers/scsi/bfa/bfa_core.c
index 10a63be925441..ada30a5cacc85 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1915,15 +1915,13 @@ bfa_comp_process(struct bfa_s *bfa, struct list_head *comp_q)
 	struct list_head		*qe;
 	struct list_head		*qen;
 	struct bfa_cb_qe_s	*hcb_qe;
-	bfa_cb_cbfn_status_t	cbfn;
 
 	list_for_each_safe(qe, qen, comp_q) {
 		hcb_qe = (struct bfa_cb_qe_s *) qe;
 		if (hcb_qe->pre_rmv) {
 			/* qe is invalid after return, dequeue before cbfn() */
 			list_del(qe);
-			cbfn = (bfa_cb_cbfn_status_t)(hcb_qe->cbfn);
-			cbfn(hcb_qe->cbarg, hcb_qe->fw_status);
+			hcb_qe->cbfn_status(hcb_qe->cbarg, hcb_qe->fw_status);
 		} else
 			hcb_qe->cbfn(hcb_qe->cbarg, BFA_TRUE);
 	}
diff --git a/drivers/scsi/bfa/bfa_ioc.h b/drivers/scsi/bfa/bfa_ioc.h
index 0f9fab770339a..179dd0416979d 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -369,14 +369,18 @@ struct bfa_reqq_wait_s {
 	void	*cbarg;
 };
 
-typedef void	(*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_t) (void *cbarg, bfa_boolean_t complete);
+typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Generic BFA callback element.
  */
 struct bfa_cb_qe_s {
 	struct list_head	qe;
-	bfa_cb_cbfn_t	cbfn;
+	union {
+		bfa_cb_cbfn_status_t	cbfn_status;
+		bfa_cb_cbfn_t		cbfn;
+	};
 	bfa_boolean_t	once;
 	bfa_boolean_t	pre_rmv;	/* set for stack based qe(s) */
 	bfa_status_t	fw_status;	/* to access fw status in comp proc */
diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 5d163ca1b3666..6735f61df191a 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -2143,8 +2143,7 @@ bfad_iocmd_fcport_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
@@ -2167,7 +2166,7 @@ bfad_iocmd_fcport_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
@@ -2451,8 +2450,7 @@ bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
@@ -2482,8 +2480,7 @@ bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
-- 
2.43.0


