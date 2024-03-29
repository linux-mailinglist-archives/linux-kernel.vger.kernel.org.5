Return-Path: <linux-kernel+bounces-124942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2C891E13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FA1286DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3D1A6D1D;
	Fri, 29 Mar 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3UlcC79"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527261A6D01;
	Fri, 29 Mar 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716479; cv=none; b=EYfCLs7W0GpNnnPAxn0qQItS4jJUymkU1Dyo6TB5v9e3UI9mLIiCcyz4GYGQm9a2Es9IS/BMVGR09/JbBeAKIAJozMwnsv4cZsFnZJT+dJRTHNLJa4/gubh8v39ti5VlWal1LQOxYSl20xacWLKAWVC87wST8mSdVuppJ97uA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716479; c=relaxed/simple;
	bh=0wAhSurDvrkS7sS7HCp4satg5frJrKfG7SxBG1rPTms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnqMoCIDoGI2hSy7vvfF8gaMlcrxwKZqspQD/pCBKkRih/zyG2lOE4b/90kyfbQdQI08baHpJBj3ENsH8oKCzOMLYrdpoby0+6nvkONWODrGpi60AcYhFJknMoo6pzhsnvuvlm1+OcbagMTjX7PJu1FE/aT+55WiJf9hUyZ9GrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3UlcC79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FE4C433C7;
	Fri, 29 Mar 2024 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716479;
	bh=0wAhSurDvrkS7sS7HCp4satg5frJrKfG7SxBG1rPTms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3UlcC796yMPJsUhLfqs6PvSsZAZsDHRK2+3hUzedGXqmSrNwctkflTr1qENKQf5d
	 EzTZp8yekrM7Wydg4rd15GNPwoFwKGtQNG69iR3PShNzlWmFCFARcdwFHuCr7DZK1s
	 ccpTCQKNi1wz4ycXUy07LlVmuJ3/n3zMqLv/trQeg4ytifzZK8zCOvXHQTAU8sLpTO
	 FiLZ0ryHwl+6cLv+HlMyNrRXvH8j8luLSbegSYtuV0Fv7o9cSe7ofzGk8cggIEZ24z
	 73OJU4E92ExW1v4hkyrL7XfZr/Nbqyk11dwawR5YL/vBWficisX/RZ+d05sVb1eytH
	 cTaGTJRnwNdKg==
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
Subject: [PATCH AUTOSEL 5.15 06/34] scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
Date: Fri, 29 Mar 2024 08:47:07 -0400
Message-ID: <20240329124750.3092394-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
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

[ Upstream commit 2ae917d4bcab80ab304b774d492e2fcd6c52c06b ]

The call to lpfc_sli4_resume_rpi() in lpfc_rcv_padisc() may return an
unsuccessful status.  In such cases, the elsiocb is not issued, the
completion is not called, and thus the elsiocb resource is leaked.

Check return value after calling lpfc_sli4_resume_rpi() and conditionally
release the elsiocb resource.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240131185112.149731-3-justintee8345@gmail.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 2bd35a7424c25..9b862f1254a42 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -724,8 +724,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				/* Save the ELS cmd */
 				elsiocb->drvrTimeout = cmd;
 
-				lpfc_sli4_resume_rpi(ndlp,
-					lpfc_mbx_cmpl_resume_rpi, elsiocb);
+				if (lpfc_sli4_resume_rpi(ndlp,
+						lpfc_mbx_cmpl_resume_rpi,
+						elsiocb))
+					kfree(elsiocb);
 				goto out;
 			}
 		}
-- 
2.43.0


