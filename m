Return-Path: <linux-kernel+bounces-27843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED0282F6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B11283B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19385024B;
	Tue, 16 Jan 2024 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/H1k8nE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA194F8A7;
	Tue, 16 Jan 2024 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434351; cv=none; b=np7Xmj/RePmxEc6cAx51n4aD01nFJsqhQgPq7c/W7rqM4Hi6gN/YAKmZeNmGQFa0uFpOqh4gWpRTU00Jd0543S5Sp0jemDl1kvd59IMnurADg1kxUka0/ec7hGlhQv3s3o4RHrJLJ9QkJXe4Q6WBM6gSqptinYrFH5FcZx1POdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434351; c=relaxed/simple;
	bh=CkIgFlWz4aAOoZ0mPFrP2OB5s1ZK7N6YOpZZaSHXLBo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Xi9mwh1wii6haLf95xWr+gbToSv9xoYX8dfzsL+s6zdHnXcO112wDEmRYpbpkV/Om11DLtXj/TX3RBi1ZovOuGR+jS/wmvq6lRyUPgYutw+pW/C/+4bWb1ZIBR4cXixTJor+J5hWEHQh49aJpranpHFmpw5Ng1LGGGw+TKW3s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/H1k8nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C62C43601;
	Tue, 16 Jan 2024 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434350;
	bh=CkIgFlWz4aAOoZ0mPFrP2OB5s1ZK7N6YOpZZaSHXLBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/H1k8nEvRAjHZegIQVFG+LE5P54+A9FZ2XyR4bBV6v/8BvSP2FwNON4+33swkdqK
	 9eivOBPQQufqFyas8wJT+9uGuGgKZ27SnfeZk4cdSLXMHRRlOhtSudNNPNz5qHPne2
	 ouDTRIDuEfm8lAZbVIGXWNSPLHXrernoB/ziZ5BIxXsnIFfBZnahE33AOv8S2aEZVB
	 UBeWV64c5PQdcVorrMB6BnNwCX9p3V4afaSNaYkYYff/uU3hmPTH4VQ569hziEQwdC
	 i72t+3wibrAt0Ia3nMbB6L9MqAx/Gjkjncywz2RG8EM+z/DRSWYpUEOLl+tNbx3BlD
	 Nwy4ZHjfg+C3Q==
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
Subject: [PATCH AUTOSEL 6.7 072/108] scsi: lpfc: Reinitialize an NPIV's VMID data structures after FDISC
Date: Tue, 16 Jan 2024 14:39:38 -0500
Message-ID: <20240116194225.250921-72-sashal@kernel.org>
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

[ Upstream commit 8dc8eb89f4df74593ba4bf30c3d31a0fc6d3ea47 ]

After a follow up FDISC cmpl, an NPIV's VMID data structures are not
updated.

Fix by calling lpfc_reinit_vmid and copying the physical port's vmid_flag
to the NPIV's vmid_flag in the NPIV registration cmpl code path.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20231207224039.35466-3-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f9627eddab08..699b2c500f7e 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -11130,6 +11130,14 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_nlp_put(ndlp);
 
 	mempool_free(pmb, phba->mbox_mem_pool);
+
+	/* reinitialize the VMID datastructure before returning.
+	 * this is specifically for vport
+	 */
+	if (lpfc_is_vmid_enabled(phba))
+		lpfc_reinit_vmid(vport);
+	vport->vmid_flag = vport->phba->pport->vmid_flag;
+
 	return;
 }
 
-- 
2.43.0


