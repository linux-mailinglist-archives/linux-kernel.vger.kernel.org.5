Return-Path: <linux-kernel+bounces-27844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170B82F6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF082B249D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6A54746;
	Tue, 16 Jan 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ6BkWgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1751C2A;
	Tue, 16 Jan 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434352; cv=none; b=N5ln7D+Z1yKj6k4yrGrD/25uqhzT4eAhsaFsUzB/9f8JnaISkhRJXGhrr4vzgsZDHk7kcnEt0dorwjAeLkM49+JUqfcouFLMZjfN+klnkgYYs50fzMsxGlqZ93r5ApA1HzUUuAuJAwv/N33e+Eewv8QNaN/AnL8s/udH/LSy49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434352; c=relaxed/simple;
	bh=Li17lTuvuX4yTuUPXE/iV11w4ygsCZYMsAK0KuWRapE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=axBYYlbg5KVbCNwX3qmusPecRMP1L/COxLPH3EsKnmuhEPkFnAmZeDrZ3N+BWl0ryuV6bWOJkLdCCYf3WdBR/wnI9w6VX83yn9vJuLetu10nQUV6fsZWJxTthgDPAuXfJB5eXTH4hsRYKHmcegK+yP5Atjdkfw5CbtJPRWeRm5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ6BkWgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CEAC43390;
	Tue, 16 Jan 2024 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434352;
	bh=Li17lTuvuX4yTuUPXE/iV11w4ygsCZYMsAK0KuWRapE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQ6BkWgrGrhhC0fAckJWkinLmqfnZmpPKuDi3EZCYQuBdGdFxTFFITaoQmVKOk6xo
	 fjc9e6m+Ut0UW0ws9GxrWMvXbKH3d1qBND3ZViTy8kzk+MS7AKk8mmQ+Ra5X6Z3Frs
	 phE2ocvwYv5fTT/PIwEw1wM41Ydh8sXGyhZO6G8rDDVi6tPRq4BnadPj2J1ga2cP+2
	 i+KGV2O9Xlx+xWUmhGok+ohFVMfq3f43CQE5cZzCn7wEny5vcOGYbeM6R9PNz1TdVm
	 0miufsPws/JVM127QTvUoUhgP+WSWAGUH6LsZfpeBrCZb9ODwcXNvJOaOxE5xU+vlD
	 rHG/bh17NKWFQ==
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
Subject: [PATCH AUTOSEL 6.7 073/108] scsi: lpfc: Move determination of vmid_flag after VMID reinitialization completes
Date: Tue, 16 Jan 2024 14:39:39 -0500
Message-ID: <20240116194225.250921-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit aba0fb0ef607a71511d23a07406f11130c1a54c5 ]

If priority tagging is set in the service parameters of a FLOGI cmpl, then
we update the vmid_flag.  In the current logic, if a follow up FLOGI cmpl
updates its service parameters such that priority tagging is no longer set,
then the vmid_flag ends up keeping stale data.

Fix by ensuring we clear the vmid_flag member during lpfc_reinit_vmid, and
check the priority tagging service parameter after reinitialization of the
vmid data structures.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20231207224039.35466-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c  | 6 +++---
 drivers/scsi/lpfc/lpfc_vmid.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 699b2c500f7e..e53c1f3dd23a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1130,12 +1130,12 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 vport->port_state, vport->fc_flag,
 			 sp->cmn.priority_tagging, kref_read(&ndlp->kref));
 
-	if (sp->cmn.priority_tagging)
-		vport->phba->pport->vmid_flag |= (LPFC_VMID_ISSUE_QFPA |
-						  LPFC_VMID_TYPE_PRIO);
 	/* reinitialize the VMID datastructure before returning */
 	if (lpfc_is_vmid_enabled(phba))
 		lpfc_reinit_vmid(vport);
+	if (sp->cmn.priority_tagging)
+		vport->phba->pport->vmid_flag |= (LPFC_VMID_ISSUE_QFPA |
+						  LPFC_VMID_TYPE_PRIO);
 
 	/*
 	 * Address a timing race with dev_loss.  If dev_loss is active on
diff --git a/drivers/scsi/lpfc/lpfc_vmid.c b/drivers/scsi/lpfc/lpfc_vmid.c
index cf8ba840d0ea..773e02ae20c3 100644
--- a/drivers/scsi/lpfc/lpfc_vmid.c
+++ b/drivers/scsi/lpfc/lpfc_vmid.c
@@ -321,5 +321,6 @@ lpfc_reinit_vmid(struct lpfc_vport *vport)
 	if (!hash_empty(vport->hash_table))
 		hash_for_each_safe(vport->hash_table, bucket, tmp, cur, hnode)
 			hash_del(&cur->hnode);
+	vport->vmid_flag = 0;
 	write_unlock(&vport->vmid_lock);
 }
-- 
2.43.0


