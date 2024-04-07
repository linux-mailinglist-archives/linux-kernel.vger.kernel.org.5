Return-Path: <linux-kernel+bounces-134411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BCE89B12B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6ACB215C0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463DE4D131;
	Sun,  7 Apr 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENXSKerz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF24AEE1;
	Sun,  7 Apr 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495494; cv=none; b=F2n1gEcPqKK20hxFBfQBRpujYH58MOM2oxMg9NcgZ14mO/l+DL0OISTx8EXu3ifft31Dv8ILFpHxZqriwJXJpWAPJyNiauuPbjwwvX0pxWP9mc7TH6IW18bGpDh5xVSwlKiwrrWlHAXRT78oc1vmuMtyje4jpf471/dqm7fW/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495494; c=relaxed/simple;
	bh=JjpRRG3PXe9lxL2lrfUPeO0PGBNzPIjjiZ54YmNqA+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn/XYX0p78LfKZNi6Y+EsFlp6jgsTH5bW3UxO84Ymckga3HWm93YFC9XpXoNsKaPI8XVrx8yz7S4WerkWxXO223u4XucdFvKEIxTgtC9/VGyNeBNu2jPiyZGFxetkV9EjV3+FWPoWoCjB8h2djwPlk82VcHqnHJ6WfFZt8dvInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENXSKerz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD71C433C7;
	Sun,  7 Apr 2024 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495494;
	bh=JjpRRG3PXe9lxL2lrfUPeO0PGBNzPIjjiZ54YmNqA+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENXSKerzgqMHBlCrbqOfKFVBLOAVCuAzK9AT0qJjWsOQe48aSalvQXRhcdD5VyjyX
	 NRYrawioJ7eClck3ZH5DLZb89hBVqqm8K1GcKjcPQdaWfSLksdBM1jCJGxprFDcAmU
	 TI543xMeHWQQgJNcuWOP5PAWNSBkc8RbPykPlORqDS8A/uo3d3NSEF/AyjPydAXtsq
	 Vnno5+0jZNJLYQaITQyTJWe0vyWEc0M3u+yMZEHazG7fhRfl8AZb+FBiZyZNIygDDb
	 6OQOOCvMK3OGBAvLICGEhdpBtbxf6Dgc/H8NRAPHF20td3Hvi2zlt/QKrDkneGDVpp
	 /eGnzqw/fK1Fw==
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
Subject: [PATCH AUTOSEL 6.8 02/25] scsi: lpfc: Move NPIV's transport unregistration to after resource clean up
Date: Sun,  7 Apr 2024 09:10:50 -0400
Message-ID: <20240407131130.1050321-2-sashal@kernel.org>
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
index 6c7559cf1a4b6..9e0e9e02d2c47 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -683,10 +683,6 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 	lpfc_free_sysfs_attr(vport);
 	lpfc_debugfs_terminate(vport);
 
-	/* Remove FC host to break driver binding. */
-	fc_remove_host(shost);
-	scsi_remove_host(shost);
-
 	/* Send the DA_ID and Fabric LOGO to cleanup Nameserver entries. */
 	ndlp = lpfc_findnode_did(vport, Fabric_DID);
 	if (!ndlp)
@@ -730,6 +726,10 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 skip_logo:
 
+	/* Remove FC host to break driver binding. */
+	fc_remove_host(shost);
+	scsi_remove_host(shost);
+
 	lpfc_cleanup(vport);
 
 	/* Remove scsi host now.  The nodes are cleaned up. */
-- 
2.43.0


