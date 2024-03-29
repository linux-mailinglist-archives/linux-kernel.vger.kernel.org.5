Return-Path: <linux-kernel+bounces-124976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C228891E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCEE2880CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178911AD985;
	Fri, 29 Mar 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC5LrH9Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30B4B5DA;
	Fri, 29 Mar 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716552; cv=none; b=prSwGtC4z8kUXaEJyT+bprInPQqrY5pFoe3SXY+GyEWEiCHU9twsqKjWn05me8cWsms2diHpHDij5ng/NTXEZQucyrysQPDZ/zP9/n37uLLQbZIxJoKzrt8wmvfBvqZ6YAd1AsuajYLbxuQ5eJH5zuQYLCsMcLvKAirnPINIhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716552; c=relaxed/simple;
	bh=zbfG8Y7YfdH65hGwwCRSp1aDrIKpzwitTrDpe3/Gw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ9qHnqEh8qXRNxq5aTHpDGFtHGyHrhtnLuri23KSXaGJepMoa04K9Zm0Sbb4Vz1zOpFy8IJqM524YfduEB8xWnudwE8mwZ/7mviM/B7P8uUW/+fetafVRuHn5l18zbkYzTGkXJk2B5sl6YUEgNC3RDL62uvfM8zhAUCoeZStW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC5LrH9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45FAC43399;
	Fri, 29 Mar 2024 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716551;
	bh=zbfG8Y7YfdH65hGwwCRSp1aDrIKpzwitTrDpe3/Gw5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JC5LrH9YEAOoPue/TvWM5Mm2MGFgALYi7oLVzpaoo2jcgvwQZT+1q4GnyJfoMJ0WM
	 PS0r7W99PDrgSfJW8odSXpnUly/J4Ro6rEF8HVpIypntIgx8Goxymk8mL+CXTJFUh3
	 NMuU9HbWq5cnaP4u92QjeJJbkyPPQVwb4v6pRJeFYk5UzFX9X4AZhq6LMjyZp64b/1
	 oxrYkPkF34H0TdqH9zRolTvd42/3KJYZ8glqwJVgTR1mCAETaYAnbOM/uTrQKbwCJz
	 Rpj+2gzfvYNoWacgnT1fT04d8l8m+eNmHFGNr22SnX9TyKn4+1PmewIcSYu3Uxpy68
	 Rocr23CTU6WdQ==
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
Subject: [PATCH AUTOSEL 5.10 06/31] scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
Date: Fri, 29 Mar 2024 08:48:23 -0400
Message-ID: <20240329124903.3093161-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 1e22364a31fcf..d6287c58d5045 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -784,8 +784,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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


