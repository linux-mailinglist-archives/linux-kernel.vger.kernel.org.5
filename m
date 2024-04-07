Return-Path: <linux-kernel+bounces-134471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB71B89B1E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6372B1F21629
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF2130A7D;
	Sun,  7 Apr 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7pKy/Lx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDB3FE20;
	Sun,  7 Apr 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495623; cv=none; b=mFu92Moa7Gy3QR3mvaludMNabRiSaBz2BwcPV2SIoWSeh59KNUsYwsshaqk0TJIzyydPhXZASCVcGNKVxHPplZ9xfqwfh0+FY/DE6zB/cZhtTT6Js19a0SdRr+u6G7snKY6/nmQyYROzyYnUvkn8CqU2VToTrfYzTCNf49BUDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495623; c=relaxed/simple;
	bh=aObqfTNmfY83Uo1sPA7j8Zs18jXKEZDCwEnqN8dEgPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8y4EBpwW6jasZzIoDExiCi4GPSdwi60DglpYIxCTAEVLu8Tmf5tW+0Oa0ixoCWaRJ69haz4NluebKmZsWe6TReCMOMcreoJTjCy4BesB5PvekGEW4LXiMm3tmTCu8q6QqfElJzxmx4+X92Drs2hWUlZWUP2Rciy9fkRrYbLxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7pKy/Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3781CC433F1;
	Sun,  7 Apr 2024 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495623;
	bh=aObqfTNmfY83Uo1sPA7j8Zs18jXKEZDCwEnqN8dEgPI=;
	h=From:To:Cc:Subject:Date:From;
	b=d7pKy/Lx2s8UCudnxUAF2cA6A0K2OLwji+xtPF+AIIaO3b6GdGEH/Eps8BRMIr8hd
	 EvWepiAGgE1MwZSuKwvlCSVZR3O0Tqu+lBPjfYKNLIdv00qJrXIyLx9gdFEXTco+71
	 FjyZN1gszc0pdiwIR0aA0h9RqNreRlRPwNxMgJX/kiT+FiT76032ShCu+gKZ4ifdhj
	 J/Liw+Wdf+sbg6HSP/7HnvZuh06/JlJvtVuzPe+fizhTRoBOTNRu+I94xKlo5Z5uNN
	 41KoGB5+zouTpTdUMRkF8KhrHW5zMOPkSkFe93JLccWsU5/lmI2nz5XKAvMMjDQ39T
	 Dj20sC/ixxBbg==
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
Subject: [PATCH AUTOSEL 5.15 01/10] scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
Date: Sun,  7 Apr 2024 09:13:31 -0400
Message-ID: <20240407131341.1052960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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
index da9a1f72d9383..b1071226e27fb 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -651,10 +651,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -700,6 +696,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
-- 
2.43.0


