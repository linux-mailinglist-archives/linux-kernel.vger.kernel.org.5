Return-Path: <linux-kernel+bounces-99117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F48783A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4951F20F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C269DEA;
	Mon, 11 Mar 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9pFRtc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C669D3C;
	Mon, 11 Mar 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170096; cv=none; b=J4Nmx7orkvWyl4gHWApJNCgzp53AfQmWfxRANamy5dTZVLYuCSJv0XIBQDnWJNpr508xeXcLGK2XYLEhOQKUnEYd5IPX4NGYgNKotT/iIjYb01yZYWH832YTR0d+LxcpNT5YLy1s9p8Jxh23DLoxCzb5z0Ga/R5RKpbY8Mrnp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170096; c=relaxed/simple;
	bh=paOHW1kIZrwXOBOt+eRefXVJRjuNEshaUz8HY4Qj0Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rp7CKMYCqkSiiVk1m4IjQFHZ7cMaHnzwZBCaNi5JqaYlxsKPkBOE8/xvascQ87zWBSWk4JUIQoZVHHjf1eWG96fZo2io27+71yJMWg4iSGAtpK5kQiST9Q2Cf8FpfJOKvfoOsC2o2xEWvPgkAifU6DSMvEAknx9ncJxfGHHgtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9pFRtc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683D7C433F1;
	Mon, 11 Mar 2024 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170096;
	bh=paOHW1kIZrwXOBOt+eRefXVJRjuNEshaUz8HY4Qj0Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=f9pFRtc4hfT0fCh6Dy1E/Z4zPFKosYG1DQ1z+PXuXrOOXci/iS0lPd0GCE08Q+kIj
	 0HeCVmyDYMusuJ4h/cIOKIprybFmXVO4QPfcTOHC9t9ErhjJ7fYUuqdcJEkNfpH5Pz
	 sVR6CQhOjs4Z5ivimxJniX/5Mr6Zq+dGaym7X0gjV9SpJS7D475RA2mswI3fqqBcFa
	 vHFAvpR6MGEb4Jvb2fu/WlOiossXyNtKV8ilmWCZTn1TB+ntN17l15+Ws05Wa72mCr
	 vuq9a15M6RWNmGQAEYJzXqB8RLhqvZJ54I3NIPqqBppbthcil15gLcgJ4Me7labIxV
	 7G96G/Wr5QETw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	jejb@linux.ibm.com,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/3] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Mon, 11 Mar 2024 11:14:51 -0400
Message-ID: <20240311151454.318918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.309
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
index 447ac667f4b2b..7588c2c11a879 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5584,7 +5584,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
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


