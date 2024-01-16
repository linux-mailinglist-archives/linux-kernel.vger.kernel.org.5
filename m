Return-Path: <linux-kernel+bounces-28092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DE82FA19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B41228A911
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56014F55B;
	Tue, 16 Jan 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW7Oavu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938B14F546;
	Tue, 16 Jan 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435128; cv=none; b=POeVI/oQcQoriW+nBnHexNGXD44Y1QpU2liv3h7QNlGjBCRuL8vUZe/uFG6M5p6rKIhOGjyGKALqsYdMbyKWx/mDzM+AZXtOfzT3BiuWTSgkXuhMjPdI5eA+RrdUXkxX9LpeU7YqKMEDoAuSWqOI9+oyKwuvf4AEkqpnjuWxLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435128; c=relaxed/simple;
	bh=CZhK604jlH4UEVG183xJrm/cPY1ZrUQxQIoT0mD2zlo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=IJTJ4z+jG3n7DPmbF6MwNG5S24zGaGSLQfjrBRA2MOGXH9gA7qil2stlyc8SH7LGPDzL86RVxogaOxK3k3ofe4k8UphfSXov0tuu1GDhoDsY2/VcT2Xeew4pDLVAYn3J5BWnf6Cgi8tTgF0EzY9jCQYHGDH5yxU+fEiEUb7D8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW7Oavu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D186BC43394;
	Tue, 16 Jan 2024 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435127;
	bh=CZhK604jlH4UEVG183xJrm/cPY1ZrUQxQIoT0mD2zlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW7Oavu/PMCaNOYUNbzFUkTFah55/VVjU5arXvzGkoVH0/KWwnTkZ+dQz7+8+qlOS
	 nkjq/qC8ZmZiPIxQo3e0d/mLS2LyWhABcmQRJHcWa9URJuJJamQ42NgSbos4L5ZDBh
	 btQpCQdQ0iBHNmCnD8d8Va3Y8HET3bf8vCNhuPWseDRJFjkGHPiTkaymEeMv9fD6Pj
	 RBU8ZoILfYMAtYfOQ8qovrjbVu81bQapGv2jVgBmKy82/NsWykdocXOjwY0ewMWOUV
	 JRsJCnRfp+FhOB8ycUjysX9UAHxy7f04W8S0/6PtF0O0B2wTOUA5fBG7gLvLERM5ZM
	 Czf+R9epFc7Yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/47] scsi: lpfc: Fix possible file string name overflow when updating firmware
Date: Tue, 16 Jan 2024 14:57:08 -0500
Message-ID: <20240116195834.257313-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit f5779b529240b715f0e358489ad0ed933bf77c97 ]

Because file_name and phba->ModelName are both declared a size 80 bytes,
the extra ".grp" file extension could cause an overflow into file_name.

Define a ELX_FW_NAME_SIZE macro with value 84.  84 incorporates the 4 extra
characters from ".grp".  file_name is changed to be declared as a char and
initialized to zeros i.e. null chars.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20231031191224.150862-3-justintee8345@gmail.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      | 1 +
 drivers/scsi/lpfc/lpfc_init.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 457ff86e02b3..65ac952b767f 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -32,6 +32,7 @@
 struct lpfc_sli2_slim;
 
 #define ELX_MODEL_NAME_SIZE	80
+#define ELX_FW_NAME_SIZE	84
 
 #define LPFC_PCI_DEV_LP		0x1
 #define LPFC_PCI_DEV_OC		0x2
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 2ca4cf1b58c4..bba51ce4276a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -14516,7 +14516,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 int
 lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 {
-	uint8_t file_name[ELX_MODEL_NAME_SIZE];
+	char file_name[ELX_FW_NAME_SIZE] = {0};
 	int ret;
 	const struct firmware *fw;
 
@@ -14525,7 +14525,7 @@ lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 	    LPFC_SLI_INTF_IF_TYPE_2)
 		return -EPERM;
 
-	snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
+	scnprintf(file_name, sizeof(file_name), "%s.grp", phba->ModelName);
 
 	if (fw_upgrade == INT_FW_UPGRADE) {
 		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
-- 
2.43.0


