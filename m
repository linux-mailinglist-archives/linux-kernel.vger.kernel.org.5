Return-Path: <linux-kernel+bounces-124821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757DC891CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B51F1F2607D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D21A4363;
	Fri, 29 Mar 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNEQ1J4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B3149C64;
	Fri, 29 Mar 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716232; cv=none; b=Qe71O8b7KQrJH0EsnR78kTNU0oEdNogWTHkNKjzM9m+c4PMVTKPfmmNeQwtA6J9N6faYHTjjCMLoxogZ7Soi1u8GfFHnZUsxOlufp36msJyAf41jgjM5SaZrBD+dh0hiygGSGX4ZXdyAn9YoTieNS2DQvPUMsztR8zULK7wVHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716232; c=relaxed/simple;
	bh=25NwrlW9wJBmS7B8MQmIf+TIdf1c0YdUF6F81GDMEjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRcYhaeBPszbMi9PrbxL3vgrpA7hBksdlx3Q8OlOgzLwd0QeI073sjvTMOiVwfucC8TaKmIULzAppbrR7vX34S4kquHeARSDlQCFiJaFLm5JRUpV/4TwvKOysk93zOqH4ioSZTZsJ8qA2DVdYPK0quN3imJDwhrCIi6xhHh6Lls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNEQ1J4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE62C433C7;
	Fri, 29 Mar 2024 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716232;
	bh=25NwrlW9wJBmS7B8MQmIf+TIdf1c0YdUF6F81GDMEjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNEQ1J4qC1BxaKp0buBhPHIExbaK5oeRy2iUYBO7Dz2T+DMWVgMsExDP2kQET6AQw
	 DBliOboZEgG5Uy6PX3A6/kw8widHBYvXjy39wP/ZcWbLJMFXGe32+Pxf/2ncbrodwZ
	 1FUSzkDuloMsplFO3y1iun6NYrBJR4rlvXK7A6VjKj/Ehs7uib40GKJMIgatDm6MNf
	 LgqQ23vbYt13aUI197sQNsaCH1NQViaMHVbhFotNtjYFEdqm+JIwEg7EbkdhH86Ztq
	 E/NW8kIomv2P3BrYyaIm1qN4PfTxGoYrIfu4FyfujA6ucyP4mKMO9VBhVm1mFXzkCl
	 VDg8TevZrmBog==
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
Subject: [PATCH AUTOSEL 6.6 12/75] scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
Date: Fri, 29 Mar 2024 08:41:53 -0400
Message-ID: <20240329124330.3089520-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 1eb7f7e60bba5..3ed211d093dd1 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -748,8 +748,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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


