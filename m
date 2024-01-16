Return-Path: <linux-kernel+bounces-27982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256782F8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA1628D54F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D09136648;
	Tue, 16 Jan 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS7cXiH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99A136671;
	Tue, 16 Jan 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434748; cv=none; b=jQaX7T2E+WM8IjDD190mcUTDQu5OXTkpt6aIlnhepGLVR+Aw1VpVwfMaYyi+0IrGzhurz+x/NvmSrBUcMRlblR6N49zOFkRzhznES/Cms4Jm8gLr+AOjGubizPlqKMcnfQuLtFrXdENMFh1HW8wdteDjPAS9BVwm+QCQm0IhNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434748; c=relaxed/simple;
	bh=SxNxOYql0QsnW58lxtipZ+uF2pLKnGUKVYu3EhkL9d0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=sSOyNalUISkvvfliydXiE2u7t4ESIXPaNzF5DezQ/oEoH/FahPa8FQspNgPcTzzZpsAR4IvqhyC1w8/3OxK51NY1lI9lGdSKIYYRjKrx7fy5s+LvhVnlhEONKDr+3mm1e+dZ6lrguAL4LhdlloTWC3jA6/8dkgrWe/DG10btB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS7cXiH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A31C43399;
	Tue, 16 Jan 2024 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434748;
	bh=SxNxOYql0QsnW58lxtipZ+uF2pLKnGUKVYu3EhkL9d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IS7cXiH982nzFVFWMPez3l3VWNXgMGYngQdMNfnJ0kzmdFN98nfPbzULab1Grp/X9
	 +vbQ0aIf9QFDXERM+KyE8AJraFagk5Q/vsM1DWzP1MajHDxdKr0XtAACydcJBerve1
	 evDjpQWU1NgvrfSTEZ1043KHK1m4WXV+IQcpRgUQzVvdWbE+0ujKVNO9VxLru2AEtN
	 qnJXOvVBCh7BkV2LWcV9Dhvc/2ZLJaKTOIqyZqAQY71uqgo6/5ZRm2kPiqHYPQ0ZCD
	 SMDS3DfIzBT3ui5wst/q3WkpJSOQP4u92BQ9SGHiwzKvZt3tYVCCzQB/g3VkSEKqkZ
	 calEHOWGrheDQ==
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
Subject: [PATCH AUTOSEL 6.6 071/104] scsi: lpfc: Reinitialize an NPIV's VMID data structures after FDISC
Date: Tue, 16 Jan 2024 14:46:37 -0500
Message-ID: <20240116194908.253437-71-sashal@kernel.org>
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
index 54e47f268235..932d47951cf3 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -11110,6 +11110,14 @@ lpfc_cmpl_reg_new_vport(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
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


