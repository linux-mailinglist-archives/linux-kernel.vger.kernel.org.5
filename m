Return-Path: <linux-kernel+bounces-134460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB889B1C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FC1F2130A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351F12D1F9;
	Sun,  7 Apr 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0nkhvno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7C12BF11;
	Sun,  7 Apr 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495601; cv=none; b=S/Nknya6VE3R2fK5dEf3o+nENk4VXA576uDzCGHdXG9ez3W4qXvAvDGraADbAeBFUD93QrQJHTaGeFTpPunom5kvQZRIlrDqZ0xel+by0p9fbDQjwLRZrIIjo3HfgnCKLN9OrRtk2KMDj8QeKInrkyP60hRo32xiRQxqoGPL7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495601; c=relaxed/simple;
	bh=sCAocEeVB/pupRELB7GIZuUOhIU+wxbV116KBOaGYpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2V2YKvAakBLCBjlwCTH99kgmyy3PQFCRpIUD6PA/J24ZHBf6tj13pNy1VuxyEVCKbsG8yUpprO3t0xh0OZvfxPwVI98JhhmsgvW23gr4wFsNqlholRGkYlvT4BlM0n+ZPrr+YYRyHfe8P5mBcFXoFCSdoLA2vzaN906+BVtxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0nkhvno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2339EC43390;
	Sun,  7 Apr 2024 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495601;
	bh=sCAocEeVB/pupRELB7GIZuUOhIU+wxbV116KBOaGYpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0nkhvno9FaXOlWY4tH7mrAzhymrmpBDrm7lR6giCZrjYUDDpXoLhKfXZryrb29Hn
	 YIZJS3JkNwaOQSk/0CU1NtiOhk4Aur3E3oji/km/npN750J1x6voUJ9qEnwSDbBDFa
	 c+aNn1visTPfvVZT7OgKDAlzV1MlxsoqM9WKiI9FRWs/IyUBCdbO7RfpZmGXVxKNR2
	 DtxYxWgw4S1n2UmYaU+5+KeiB3UeQ79XglHTky8VcSNI8xUGVcV3Vn/u4PFmre76iX
	 NufEchF26qNuoVPZar9TYYB7Hv8DQocCwpQXK5SJ6DwiGeOLDDv4O3PtD256YsdzsW
	 r2HLUY7cZWZlg==
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
Subject: [PATCH AUTOSEL 6.1 03/13] scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
Date: Sun,  7 Apr 2024 09:13:02 -0400
Message-ID: <20240407131316.1052393-3-sashal@kernel.org>
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

[ Upstream commit d11272be497e48a8e8f980470eb6b70e92eed0ce ]

The ndlp object update in lpfc_nvme_unregister_port() should be protected
by the ndlp lock rather than hbalock.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-6-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 152245f7cacc7..7e9e0d969256a 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2621,9 +2621,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		/* No concern about the role change on the nvme remoteport.
 		 * The transport will update it.
 		 */
-		spin_lock_irq(&vport->phba->hbalock);
+		spin_lock_irq(&ndlp->lock);
 		ndlp->fc4_xpt_flags |= NVME_XPT_UNREG_WAIT;
-		spin_unlock_irq(&vport->phba->hbalock);
+		spin_unlock_irq(&ndlp->lock);
 
 		/* Don't let the host nvme transport keep sending keep-alives
 		 * on this remoteport. Vport is unloading, no recovery. The
-- 
2.43.0


