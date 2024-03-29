Return-Path: <linux-kernel+bounces-125007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C52891EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46906288929
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D511B450E;
	Fri, 29 Mar 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ9fdp5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03DFBF3;
	Fri, 29 Mar 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716617; cv=none; b=dpDKtXUa9x9aN+Ictvd1p0V+nrYmg7BTFKf+A9vMCOEhOoTJP+OjlEHWD/1+QvExeid4ML2dq1/lUIXjBNVe1p68sP6Vr4uvaap/dhcMjsK7ALSfJSfO8fcm0iy/+swwEhnN4vhAjEgwQfrqia/TQPwZONvyRJIOTt1GC0P8Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716617; c=relaxed/simple;
	bh=RjwteC0Nxfpz34RGHKSiWhHY5QMrYVvsPuLjeFuD2W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIwiD5CxeRA0OFWgVlG/yD/7u+MDZd0c0rNfkXv4NtIsgdgycqN8tKn/HSOSlgUsljxj0nfDuZvYr5p129aQGZlL2CXIupFUt2PasGtubCX5Ewgz88fxrQ84rBJK4IMjWSzL8bcpnmuXXZNKp9SnaTmehTfDUb675kHeIDTcZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ9fdp5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DE8C433C7;
	Fri, 29 Mar 2024 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716617;
	bh=RjwteC0Nxfpz34RGHKSiWhHY5QMrYVvsPuLjeFuD2W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ9fdp5EueqXSWMBKfbJk10GGOPE1Kki7N3K8YZk8dcNl0m1vPiRckr9oxxHW/Wqq
	 tDexYrbzhaYN3MzNrqMIcNU0oKyfOcGe1uN8wG4z3+UvyV6jWpI7ubZugMjijdf/db
	 TTzW4e9iKGl1MBSPNfoKVxi7fnq5k8cFgBVv8JuNvwcAoCZfcbw4m7wNfGKTCpRkDW
	 pYYZo2hGnUhB+sQIKjWYkR0JwEmAN8F128cT9/Ugvyz24FBRgcYnbznNoJWaCa02B9
	 Ka/ugEhE9bAlKW3sVFapX9HDOEqg2xgT+m29C2g766eM7b5fIbGs/GLvFcJ7YkFxnU
	 0hb6Wth8U97WA==
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
Subject: [PATCH AUTOSEL 5.4 05/23] scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()
Date: Fri, 29 Mar 2024 08:49:38 -0400
Message-ID: <20240329125009.3093845-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index e6a94f550a572..1ca3179444d23 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -781,8 +781,10 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
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


