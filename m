Return-Path: <linux-kernel+bounces-134415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1289B137
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E911C21341
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE35103C;
	Sun,  7 Apr 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD5yiOI2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83350A62;
	Sun,  7 Apr 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495498; cv=none; b=N2MbI/jOkN0m3BIWVnGpBN/4K/iPwrYfLgyPZCGLY76OujX5PxpK7sMjAlRVWTVUEpsBpjIRUoRi4DaWffvxenXV8gkGaa2ZaD8qnLlWuDdWZ2kPid30kLxQiesc9eVqT87jhDUQYRvV1kvR2bi5l/VzgHEvAbYP7z0wR5RXiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495498; c=relaxed/simple;
	bh=R7C+y/crnvg9U7/Q71ERzJxax+fduD/CNGaZq/fgP1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvG/0bYpgRSxxfKYYtANa/6zA/XhUk4rWU+qK72mPsRRHO9LWUXOITJ6dl3KrVFe11wtiIKnH4X+dCeqvhQRobqBVNL0aK88T9f7BpCY8mxak3aiMk0M0CyJbzujvdLvlwZisbCBegydV+l1kzMuFfHFJcsjYLnuJu0eYX4fO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD5yiOI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4539FC433A6;
	Sun,  7 Apr 2024 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495498;
	bh=R7C+y/crnvg9U7/Q71ERzJxax+fduD/CNGaZq/fgP1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OD5yiOI2cH5SDMEIulfYVpDjA6TKT2FHXRAA5pCDdFTYEKnqa0h9q/yK894YmBPOE
	 ieMS+YtmAwF/Mf3wqu1sjgrFOIAOgiEfsNYyHq4vXfNvnlB2nzHTK/FPYFmbpSLYB2
	 WXz9M9LbUsU+ZAqlV/m4Bur516O8FDZsH6KO8gRGz++ectHyIXyzqMC/78yDTN5+HN
	 O+3MccpKZG9TINJTnnXKF4OfptmzO/Lc34d8SqSV054s1vyCqxXvcFcVfupMyDiVF1
	 PLJj3dWMlOb3x1020Kd0OCFJIDmhPx/y7+lC0MTaSsrfS5gmiOVUCv8o0BxPA4wmBs
	 Vf8oBaiZ3mhcw==
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
Subject: [PATCH AUTOSEL 6.8 05/25] scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
Date: Sun,  7 Apr 2024 09:10:53 -0400
Message-ID: <20240407131130.1050321-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 128fc1bab5865..47218cf4d110d 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2616,9 +2616,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
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


