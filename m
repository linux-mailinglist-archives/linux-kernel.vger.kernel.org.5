Return-Path: <linux-kernel+bounces-28030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF482F953
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC11C2568E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E42F141984;
	Tue, 16 Jan 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbYCHewL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D21413B1;
	Tue, 16 Jan 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434941; cv=none; b=a3U0HnEVgQWtfhqOTzbkJyrs3UcZKRjMVqfqk2i/hkiRORltgaKLa3RmXXSgKHSAK8DWcRu3yo6e8OA13DJhvVV9dxTHYKkRf52/SdWFLTrHdxFYlldCMv/agCWyW8mBsBR+vZUlk2n29JXBiDMj1Kzx60+Iy0L049+RC006uMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434941; c=relaxed/simple;
	bh=zXmXAqqpRMdVsTfBPNfFFt3JfHNeAXRHKQ1D41aeyzU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=jTfAcI49efuDuDSBkLWm/YxKsrEyjvnVWzc7hukVWtvNFRHpKOJNopeRQ4ZC+eNuilFnTihCHYQh4Nnn8t1S+VGC0e6o6H2ubf0e0QvEBUKYbaPq+wdwFRYhw7OPS8a1MFzwQweq95uC7kb3cjHhRwVEWimAIMUuT+uNNiUFojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbYCHewL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9117AC43399;
	Tue, 16 Jan 2024 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434940;
	bh=zXmXAqqpRMdVsTfBPNfFFt3JfHNeAXRHKQ1D41aeyzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbYCHewLxUO+eg12xbNK222+k78Wit8uMZDgNmpPsJ9GVNnCpwEY/93BglR6TLPl6
	 FX5EdQzby4cD8bgAp/5DVjF2Z4W/AOb2kFZihBVsZhWWB0LBX147C+9IyE4RLqkwrP
	 GHS0X7h3z2NIi7GyIjsauuSEwX8H4yh0gzN0ZgmLAp4WKu4WMZi+dlTZ7iI7ZEkIso
	 oYPqQLYLOXIRHWvqIhpFDGeqC+6tHu/IeTEU0xoXX6ZGWxjj5Ah0E3ewuknyOZoGoN
	 fN38RngFkqjxZymR2gOnLaGpB7bw5pnRUCVVNkm6khbKm5e2AdkxFmWgv8meTysu7S
	 fsJeX+ziRTSuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sumit Saxena <sumit.saxena@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	sathya.prakash@broadcom.com,
	kashyap.desai@broadcom.com,
	sreekanth.reddy@broadcom.com,
	jejb@linux.ibm.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/68] scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116
Date: Tue, 16 Jan 2024 14:53:12 -0500
Message-ID: <20240116195511.255854-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Sumit Saxena <sumit.saxena@broadcom.com>

[ Upstream commit c9260ff28ee561fca5f96425c9328a9698e8427b ]

Add PCI IDs checks for the cases where SAS5116 diverges from SAS4116 in
behavior.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Link: https://lore.kernel.org/r/20231123160132.4155-3-sumit.saxena@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 ++-
 drivers/scsi/mpi3mr/mpi3mr_os.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index d2c7de804b99..41636c4c43af 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1886,7 +1886,8 @@ static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
 
 	reply_qid = qidx + 1;
 	op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
-	if (!mrioc->pdev->revision)
+	if ((mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) &&
+		!mrioc->pdev->revision)
 		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
 	op_reply_q->ci = 0;
 	op_reply_q->ephase = 1;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 6d55698ea4d1..dc9151c25053 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4957,7 +4957,10 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		mpi3mr_init_drv_cmd(&mrioc->evtack_cmds[i],
 				    MPI3MR_HOSTTAG_EVTACKCMD_MIN + i);
 
-	if (pdev->revision)
+	if ((pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) &&
+		!pdev->revision)
+		mrioc->enable_segqueue = false;
+	else
 		mrioc->enable_segqueue = true;
 
 	init_waitqueue_head(&mrioc->reset_waitq);
-- 
2.43.0


