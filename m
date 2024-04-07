Return-Path: <linux-kernel+bounces-134458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AA89B1BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AF1F219F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330C12A171;
	Sun,  7 Apr 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fleP0lTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A33BBE7;
	Sun,  7 Apr 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495598; cv=none; b=o5OQpi3jLjtnIpaZmcj7niJ9EcoijiPjWrDqXgvinmD4zRPUv3wBPES2+/AclaDRMoaFFiqAjYx5B9N0WubdlEfN5BY2aIPVpIxSRE0HV3Dph4RWJRQmVZMJ5IXHfoJNyoXwueH6Q1yliOodKGf8zsWuvlzduC9dk68jj0NgIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495598; c=relaxed/simple;
	bh=ZX2tDRlsDhuPaGi25+P+0gJ4ulMyTfJmvuW/6OBG4w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T47M1MM8uWjS5wAFK5YuBbgUrHEBvfxc8EaDEXgt58C0p6A8kJ5VH7j9z4DLT2seXKJsvYX3PqkXkgxBeu5lhRjWQfsam133IUWYhK8Yyko5acWVdYU1QygXqmrni1rR1qVuLAQxcAbxW27gA5mTXGgukz0Y7hgyR8ouCmoaE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fleP0lTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7ECC433F1;
	Sun,  7 Apr 2024 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495598;
	bh=ZX2tDRlsDhuPaGi25+P+0gJ4ulMyTfJmvuW/6OBG4w4=;
	h=From:To:Cc:Subject:Date:From;
	b=fleP0lTa4WyiZYbFFx6xxubtZJaVLQyXDYtaypIfnA1wuiF/lXG5DHebKY/cyoh6L
	 MJ/S0HK0o4M4+9L6OJjPdCKVvU+LsfLqux5F1s+eduzm+qircMxz67JFk0OD2U/mfr
	 tqwVwVyQePqL7anxvTtR7eApwyDt2T7MoyQh6UgBOw36ypBKdirbeMYwiAnqMQHJ6b
	 5sas/2Im9qy511LkY7WITcWlxyydYGLytrnXc6nOLLbUi7HJejI5PBp70Q0bSdZWyD
	 i/vLCIFMr+qHKCwb3m9deJD7rVVDDv3Mm3S82qiwJx0BSM8uBt3zv7ygMXzHedvKaK
	 LgIlm/eKoYx7Q==
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
Subject: [PATCH AUTOSEL 6.1 01/13] scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
Date: Sun,  7 Apr 2024 09:13:00 -0400
Message-ID: <20240407131316.1052393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

[ Upstream commit 4ddf01f2f1504fa08b766e8cfeec558e9f8eef6c ]

There are cases after NPIV deletion where the fabric switch still believes
the NPIV is logged into the fabric.  This occurs when a vport is
unregistered before the Remove All DA_ID CT and LOGO ELS are sent to the
fabric.

Currently fc_remove_host(), which calls dev_loss_tmo for all D_IDs including
the fabric D_ID, removes the last ndlp reference and frees the ndlp rport
object.  This sometimes causes the race condition where the final DA_ID and
LOGO are skipped from being sent to the fabric switch.

Fix by moving the fc_remove_host() and scsi_remove_host() calls after DA_ID
and LOGO are sent.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-3-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_vport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 4d171f5c213f7..6b4259894584f 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -693,10 +693,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -740,6 +736,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
-- 
2.43.0


