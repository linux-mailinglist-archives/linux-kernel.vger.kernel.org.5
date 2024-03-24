Return-Path: <linux-kernel+bounces-114940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79B888C19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18075B2EFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6AC1BE813;
	Mon, 25 Mar 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOoEruAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC621EB7B;
	Sun, 24 Mar 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323649; cv=none; b=LeR0NSFqI66IFw1x9yxmWY366y2DhLOKJR/GR+t/M0DOQufiMIzdYZV97VxDqpGVqoXzp6nLsVF4/kIyrQ1ZVEDpmMVRATcyxZIgvZMDey+XWsO3Ef8R7iGamr4D9g7qFiFMkUXuLGs3EUEd8i9MwvJEdcxa7i4tUJxydKX1aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323649; c=relaxed/simple;
	bh=f2qTjhmMz1jFyOTLwRJOYcWLeZ31+lsP1caQS8kVENw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o76yP33KF/Kx2/doHwzX4zpcEyGOY3w1tb82nW503VUQx6zgm9KMxao37nPFdMAGeH4cL8sot0O+EM/MYfGGiNamoBDmvS7IvMQHnyrKG8aH6RYxs4Tybr7i3qZCsbHy1L0K49eiFlzC2LIxNO+7b5viP/PQ5T3I0mg26LtkRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOoEruAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2260EC43394;
	Sun, 24 Mar 2024 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323648;
	bh=f2qTjhmMz1jFyOTLwRJOYcWLeZ31+lsP1caQS8kVENw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOoEruAjkPwNAM8jxcD2V5MiuZo3nCq8pcUy7dgmw9R6g7Ypbu4bhn/k7wt/edsUh
	 jWu84sCoNCZw0BzrNxTjNt1wLwA5aDRwy/GPc+O4Ah1qBwdDerPen/BEGiwVXOex4c
	 ZdgTIz4pXf/QC8nqSW8YhJv0y6LrXfxU1dxq7zuoNO6ruxEZc3aRPeeAIZkxHtaxP4
	 TB7WV+1nN3zHA+HGcwv5CD4keqJyAdh5dVpe9swaHa/R2RLWalx5pLpoN8cBsjz5Cp
	 BZGroi6OWnaOkBv84HTiHMRGbIDENcwUVhg+cIYxYeSrumWg52SgUqMB34O9dhYwMt
	 5FObvUCrwbzmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 020/238] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 19:36:48 -0400
Message-ID: <20240324234027.1354210-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit ee0017c3ed8a8abfa4d40e42f908fb38c31e7515 ]

If the driver detects that the controller is not ready before sending the
first IOC facts command, it will wait for a maximum of 10 seconds for it to
become ready. However, even if the controller becomes ready within 10
seconds, the driver will still issue a diagnostic reset.

Modify the driver to avoid sending a diag reset if the controller becomes
ready within the 10-second wait time.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20240221071724.14986-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 814ac25238058..105d781d0cacf 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6357,7 +6357,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
-- 
2.43.0


