Return-Path: <linux-kernel+bounces-134473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD389B1EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DF22815CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE38130E5C;
	Sun,  7 Apr 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlqFBSMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C463130E32;
	Sun,  7 Apr 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495626; cv=none; b=qyWpmKzIWdsNIehSREV3SCmTssdzGG31f7kidXIUFux3tkiGjj5ttuymCzA0rvvTIc3cSG8dnxTmT6q9m+Y2+8qtJS7TVplwAttfxmet4gE0BrIMGEaW/IaYa/K6noku8NTBF+2ECww95Vkw65sZf/knulikhbgnL0Rxj1YJ+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495626; c=relaxed/simple;
	bh=ozAxrHNB+AyrTotSuIZ3fzVusxVVJHmLw6bQmMx2YmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQpGZaY/36NOrWuJmO+OrtY97BkBctxHMLhrny8w1xV8Z3fyO2DBvbG4PnvvvAhw0lj15RPdux3XBUlfgZwT0lSTZ6UURIEbIiVtpVn4ZuoAhPpwobsqAgrj0DF+cmAdI4/hCJa+A5agN7vxbC/wsnNgo9Exi+QK8oLgEB0TKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlqFBSMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CD3C433F1;
	Sun,  7 Apr 2024 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495626;
	bh=ozAxrHNB+AyrTotSuIZ3fzVusxVVJHmLw6bQmMx2YmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlqFBSMGT6mIh6aZ2MDzG2qGB3loWB8d6EPF09n+Xl0YuTc9OCVDW9ERdzR71JFTl
	 bX/JNhgAOKr63rhCA5LYnsiDHyNM2KtO6gzkIn/ntw7cRdV1AGW2/E2drWKnmqidxq
	 4bN506NtFqDqYHMYMm7Qq6SLLOjim12ZcxEmuXHSAtwfdU/9CuM2CT9OU2qP+OWTG2
	 2iZiWVNfS0PYwu0JgVJz73UrBrmZ91y/RatJFSRoRHDfhlxovt2TMWK2fiK7+xd/ho
	 MhqhdLkGMWQjU/VYFb31ewS0A9gH0rv4MhxfmbqCxMikgsRz29USMT7vq1IqO/6ool
	 TAb6/LKfBZmxQ==
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
Subject: [PATCH AUTOSEL 5.15 03/10] scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
Date: Sun,  7 Apr 2024 09:13:33 -0400
Message-ID: <20240407131341.1052960-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131341.1052960-1-sashal@kernel.org>
References: <20240407131341.1052960-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 4e0c0b273e5fe..2ff8ace6f78f2 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2539,9 +2539,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
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


