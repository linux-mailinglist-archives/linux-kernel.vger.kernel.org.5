Return-Path: <linux-kernel+bounces-114897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C9889284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD4429B837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2F2D02F3;
	Mon, 25 Mar 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/sE8YFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB51788A6;
	Sun, 24 Mar 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323560; cv=none; b=c8/0+IBS87wQK2NiRTMo+d35IeByJWJDdzzmAq/CCQ3Oszoyf8pAszq43/2cDk9wS9mIc7pqUp4jTBT+U6vHLdDCXfwsrD1Djd6lByagpvSN2L26nODmIJZ5/OJ1Tj2n9wNh713NtBNXaC/MDTemWae6tSrLBiAbveG+Wm9YcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323560; c=relaxed/simple;
	bh=u09IWd1qZVsAZyxzHseF9kFtpoNg9X/fMsPqkG48VTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjPqCUiHs13K+nlG/FPuzhOI0RXoALnsAS8qjw4jp4PoB8BSeNrE5UP9xzrRCA+ptzJc7F9A88BJkmeZNmk6r6bjmlQQyRNy2HkyqBJkpYcqPznZLjWAngr0lZczhWzKqT4d5xI5MDgztrBq0lq6dEFDna3nEsWuXHFoNdT06F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/sE8YFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC5C433F1;
	Sun, 24 Mar 2024 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323559;
	bh=u09IWd1qZVsAZyxzHseF9kFtpoNg9X/fMsPqkG48VTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/sE8YFh69OnSs35bf4q9bsFgxGVXbTM25nCkcJ4pfQU73EQQA3KtRnHhF5Wthm5v
	 LD/67DMIMMxfzSxH0cXDzqOwaHrYFloup37oWbWr2O8Wyb2X6pZj34iL5BGttjlxvA
	 bCrOTMOv9+ln0/YIbLKu0Yo388RUQAAzpej9l5/SFEAGtC/UDSVTulv0sDeldlLC0S
	 3fLJyi49Goh4Mdnly9lhd7StVtyYA2e2irolM4xSqm4/fZghy5U0ufJMmJP7CJjZzm
	 5D/UN3PF9s2KunxID+RPU/6JbUQ699yCgNUaUUDXhtWc6keNINWp5yS1kN3M8FjYTN
	 DyNNgB9vYW0Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/317] scsi: bfa: Fix function pointer type mismatch for hcb_qe->cbfn
Date: Sun, 24 Mar 2024 19:34:06 -0400
Message-ID: <20240324233458.1352854-267-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 7bd2ba1ad4d11..f30fe324e6ecc 100644
--- a/drivers/scsi/bfa/bfa.h
+++ b/drivers/scsi/bfa/bfa.h
@@ -20,7 +20,6 @@
 struct bfa_s;
 
 typedef void (*bfa_isr_func_t) (struct bfa_s *bfa, struct bfi_msg_s *m);
-typedef void (*bfa_cb_cbfn_status_t) (void *cbarg, bfa_status_t status);
 
 /*
  * Interrupt message handlers
@@ -437,4 +436,12 @@ struct bfa_cb_pending_q_s {
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
index 6846ca8f7313c..3438d0b8ba062 100644
--- a/drivers/scsi/bfa/bfa_core.c
+++ b/drivers/scsi/bfa/bfa_core.c
@@ -1907,15 +1907,13 @@ bfa_comp_process(struct bfa_s *bfa, struct list_head *comp_q)
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
index 933a1c3890ff5..5e568d6d7b261 100644
--- a/drivers/scsi/bfa/bfa_ioc.h
+++ b/drivers/scsi/bfa/bfa_ioc.h
@@ -361,14 +361,18 @@ struct bfa_reqq_wait_s {
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
index be8dfbe13e904..524e4e6979c9f 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -2135,8 +2135,7 @@ bfad_iocmd_fcport_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
@@ -2159,7 +2158,7 @@ bfad_iocmd_fcport_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_cb_pending_q_s cb_qe;
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp, &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
@@ -2443,8 +2442,7 @@ bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, &iocmd->stats);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, &iocmd->stats);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
@@ -2474,8 +2472,7 @@ bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
 	struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
 
 	init_completion(&fcomp.comp);
-	bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
-			   &fcomp, NULL);
+	bfa_pending_q_init_status(&cb_qe, bfad_hcb_comp, &fcomp, NULL);
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
-- 
2.43.0


