Return-Path: <linux-kernel+bounces-134440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B95789B185
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7D9280D0E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466947D3F8;
	Sun,  7 Apr 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM1eiqSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832897D08D;
	Sun,  7 Apr 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495559; cv=none; b=HUEpkDbJrynDrpwx/8hiWDNJnez0xNhSAJU/HDf1wee/+b2gG6QxWOckEUHzXRLKxTtMgCwt3WvBftyvw3Py8be2os5+xnlYji/qdNEgsBzxmb66QDgQ/ns4cEuWqQ7mpIJmXp1Xov9EXJC8YWzvqJ9utZPGZQhMJXcEymlzJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495559; c=relaxed/simple;
	bh=NFEolUfxk0K/xj5e0W1r3o6ohopS9Qkjrz7tlWs3TAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diCjdQbQi/RuJmMsrPW0kP6liKz9r6oOpelAXiTw292LPqrCbyvAZARvsPbgihH+Y/25E/sk7K5BN6RP8A4cxV+koQm3bnXjnRaLSaM5R26EOI/UREyMelwJkvQN9G5yanv69zgoS5K+pmY+/bzFC6M7D4msGwUzNkss6fsCVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM1eiqSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190EEC433F1;
	Sun,  7 Apr 2024 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495559;
	bh=NFEolUfxk0K/xj5e0W1r3o6ohopS9Qkjrz7tlWs3TAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM1eiqSkCtbVnZXif0Wv3ccy2sVIcbNek2GI/BQZcmiGsZmU1SbJu5MYzD2F2SlmV
	 qFRMAG9wRAo1Net4ds2oqtJtowU/BT3Pk5ndbZNJM52P/6AxrqCypczTMRfl2f99rf
	 z7WbS8j9jLCWISVWxseVbV/GNihk8IIcEtPdnzid/12XDDwK/ga8qFhyAM2C9AeLrH
	 8MYlmU61gtQwctfnB3qf7YHcU+aen00o4jWXw8Yq9YSyUJXZ/gD7z9dwxN1O+1wHWp
	 Ixkvt51dKUuQawQUPikYW0Qoe+41kTkoe056Joe4uEqD7Tm+o7/EREqTQT7NTSgO9H
	 AD8nJdqZjnecQ==
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
Subject: [PATCH AUTOSEL 6.6 05/22] scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_port()
Date: Sun,  7 Apr 2024 09:12:04 -0400
Message-ID: <20240407131231.1051652-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
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
index 96e11a26c297e..a7479258e8055 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2614,9 +2614,9 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
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


