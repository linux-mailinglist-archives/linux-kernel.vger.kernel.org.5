Return-Path: <linux-kernel+bounces-125029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F210A891EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD4728C5F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3931BC9CA;
	Fri, 29 Mar 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d47z49V9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A81BC156;
	Fri, 29 Mar 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716667; cv=none; b=PZanJUzBPDChwVLATLpZ0XujZNhHxArpTDqM2QqJH7x5X/BerbQqGXbIQRJDdaxz1BdE+LiLqtmQIq5J/MInpvMgawQA6VEQYwsYgNvTc/DhjuKp/gBwVCPsCcKV8ZvDS/iT2IMs0pUX5I7rIY0loxY1PqbhnGTbZ3PU3y+ufjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716667; c=relaxed/simple;
	bh=WITtngLLG38kILuuI51urHZWyDVZckECn0zeZ6vqb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn4Lg1J1Ne5HaRiDOCUliL8AIs/PFgzzB179sfv/GAQJg11udeMriEBHwPcc5Q8o9YsFFO6M6tJaN8iZOVovCVb0PAx1LVd8TANws9YAy5EGpAYj0oOlfDuHr5/N2eNZ9F6+lsz01SyqNfws2YbBynR2rqt7674RSm5nFfYJYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d47z49V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9EEC433A6;
	Fri, 29 Mar 2024 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716667;
	bh=WITtngLLG38kILuuI51urHZWyDVZckECn0zeZ6vqb8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d47z49V9nwITS5amyVHNiNiYEHNG6iXRnHRdr6DY/9M8IjvUi8E4Z5/nvzWPwdfK8
	 IkhRFPOjEHFxp+NISSSxic3twxO8fETKBKNL7GYosByiz5FOlVw3oX8ZC63fLOCcNn
	 3drnOh0jExZBVthRUtmFfuo9sRaKGLFB2NTvq6ZrrYb3U1R/qv6CygYh/LcEJPMFgs
	 ZwquNJoZR3tn2b7L4fHinrTfwHhu3uKI79Bvmj2PIJdS1Gsx/zsRh+RRwfyFDYip7Q
	 r8FTfpG+cg+MGQipEL8XmnMNDf6CHGTdFeDxPEqDgbUWBRChS7WWQmrHLi8qVeDTdi
	 LmSbdE1Qufrvw==
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
Subject: [PATCH AUTOSEL 4.19 04/19] scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
Date: Fri, 29 Mar 2024 08:50:36 -0400
Message-ID: <20240329125100.3094358-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index f666518d84b0a..0890c2e38eeca 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -601,8 +601,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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


