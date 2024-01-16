Return-Path: <linux-kernel+bounces-27983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E382F8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949CA1C23BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8D136E00;
	Tue, 16 Jan 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqKLjR6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DE1F600;
	Tue, 16 Jan 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434753; cv=none; b=dUuFqY0gNG5QPeTNFC9iwjJs+LT579nHgt4uMC4dHps7VxGdUl+iVFkpFx8bhwPCJHGca+Nvi5WkTHRLlyFOvQ3r94U8ysWZDe3CgkF4+Dh63X+r9iprdQOBuFyoihv1yo6pegf9CbPR/JDkdg0SPswlH6VWgtZhGFdeu4hYRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434753; c=relaxed/simple;
	bh=s7chUz4w57E0ijWxZFmYTjI2dgavwOZadAJkeOD5xhY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=DIOEAo9C9i2c50Qa9ml1FuvqRh70l7i/ZyXsh3JzgHReORb4LuQrBgqmKuBhx77LCc8pv1eTUEB4bEpUhpjyYANwSEXfoD5DZvWs9NNOgoMwTmXlf4GQPklp9m5btepmzhhMBKkTaOcOUHnhsfzu/Bwv0yPzz1DN2KieIvCVxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqKLjR6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E365C433F1;
	Tue, 16 Jan 2024 19:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434753;
	bh=s7chUz4w57E0ijWxZFmYTjI2dgavwOZadAJkeOD5xhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqKLjR6hl1yiXUAyDW7RtcjiEjahq8fujOPVq74bjd3kykWfKKuCnmjuF50xKEvY3
	 PV5Cgd8QVn8ZiXdSIiePuKXIl685olIyUwMN32RzQZ4v4yEAUoiXsE1LhsOs9eoHwF
	 DVgcGw3CpjgIvmns75yDcYj9xiXzyj0C4MdClbvikTuhGp8COsU0oUzUVYNcCJtmnU
	 dMRFFS/fk3cLJp8H4wHb7mbs3wrHe9ygvwEt+9WCUeqdjTVoeLIyuUobPUaeHqSd4E
	 jqLW0qJ6NX84RlDXxL7nqenHOb+Lz9IPdr1GRmOdM+/kiylQe6ZbO+lZhPhJ34/5Sf
	 633uWUdXfSsBw==
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
Subject: [PATCH AUTOSEL 6.6 072/104] scsi: lpfc: Move determination of vmid_flag after VMID reinitialization completes
Date: Tue, 16 Jan 2024 14:46:38 -0500
Message-ID: <20240116194908.253437-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 932d47951cf3..18b8325fd419 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1119,12 +1119,12 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
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


