Return-Path: <linux-kernel+bounces-76534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA585F888
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC4A1F24714
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4C5B66E;
	Thu, 22 Feb 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpyDlNHV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8112E1C6;
	Thu, 22 Feb 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605880; cv=none; b=kFAg+yKIFxtKC4//3HOptN0AKAnpNfAIMHXYcC3ETx0JtYJa41Z3QmBJ7ov1Ar8BIqUCiefeX1slUvtgqUTRJ7I/MduUo4FLXEbzNDD8nOitR2DMpZRdRbFK+vtA7ECqlwNwIs47CtKVtuF+prafEk3fbgqliCUosWsoTJzoxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605880; c=relaxed/simple;
	bh=+mU2vYg3WiT6sgf4cTz+Iy31ncP+Ob7ckS0bqFuVFgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F+L+wbfLjOmOVctx8sGlZ5P25Vh6KIeOmBniEk/mih/s8C76EcbP5nS3FsRl2Ls7H/veg2KexKrX8mYLyuYv564SUY8z6ACibkLyhu0sDB2UHveutoHHDSPGe5KlmMhYuJCyXTsJyZZGrkPaxWHA/ChbDbM8DYD3ScaBBuTA8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpyDlNHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B23C433F1;
	Thu, 22 Feb 2024 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605880;
	bh=+mU2vYg3WiT6sgf4cTz+Iy31ncP+Ob7ckS0bqFuVFgU=;
	h=From:To:Cc:Subject:Date:From;
	b=fpyDlNHVHB4v6WjOS1p5drq0Lj/Y8HOhDGXeNqipZNhjpB/7RBGeNHOxir32klExN
	 /h1zqP1PqKXpji1/s6DOAgcLzUYk2AXmXySqCYFjEjHCqNzlbSXn+4+hU5VWaobApr
	 BM2kYIdbWaikt5Qt3iryigVIjqHB+j2Xtt6J969SMs2ENMqQ0X8lDCo00qWvfPw6cV
	 sSo0N5NfU7c0VWT2TZDn/y5fUtBnY040d1lOjJfx7XEtaMtqoZdZ6NqOGcMPPyPsVz
	 V0+k/a+xjNUhWuFuCldRutAh8xp1oXEGfro46EdFwEm/y5S43us+MdgAyfay0PZvWb
	 xTN/txg+w6yyA==
From: Arnd Bergmann <arnd@kernel.org>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	James Bottomley <JBottomley@Parallels.com>,
	Krishna Gudipati <kgudipat@brocade.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] [v2] scsi: bfa: fix function pointer type mismatch for hcb_qe->cbfn
Date: Thu, 22 Feb 2024 13:44:06 +0100
Message-Id: <20240222124433.2046570-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Some callback functions used here take a boolean argument, others
take a status argument. This breaks KCFI type checking, so clang
now warns about the function pointer cast:

drivers/scsi/bfa/bfad_bsg.c:2138:29: error: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Assuming the code is actually correct here and the callers always match
the argument types of the callee, rework this to replace the explicit
cast with a union of the two pointer types. This does not change the
behavior of the code, so if something is actually broken here, a larger
rework may be necessary.

Fixes: 37ea0558b87ab ("[SCSI] bfa: Added support to collect and reset fcport stats")
Fixes: 3ec4f2c8bff25 ("[SCSI] bfa: Added support to configure QOS and collect stats.")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: no changes, just rending after I noticed I forgot to follow up
after https://lore.kernel.org/all/336f2156-220f-47ff-be97-5a2a9c475372@app.fastmail.com/
---
 drivers/scsi/bfa/bfa.h      |  9 ++++++++-
 drivers/scsi/bfa/bfa_core.c |  4 +---
 drivers/scsi/bfa/bfa_ioc.h  |  8 ++++++--
 drivers/scsi/bfa/bfad_bsg.c | 11 ++++-------
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/bfa/bfa.h b/drivers/scsi/bfa/bfa.h
index 7bd2ba1ad4d1..f30fe324e6ec 100644
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
index 6846ca8f7313..3438d0b8ba06 100644
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
index 933a1c3890ff..5e568d6d7b26 100644
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
index d4ceca2d435e..54bd11e6d593 100644
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
2.39.2


