Return-Path: <linux-kernel+bounces-27934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972482F800
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B341F26320
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0FD241F8;
	Tue, 16 Jan 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5iO947q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCDA12B727;
	Tue, 16 Jan 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434612; cv=none; b=sdXCpKxBmYXbm9keLJBEa4ClhKnoj2N8jwodEi+224OyTMHJ563s5ObctZ2TmH58/tSKG7ychyp2sm/xiEUyoO6w8G2lM2mOd5zhH63KrQ84W8COBJ/VLgzsYB0m9sR6LOl86icQoGkBsENFyGOAUmL9jx5CCCZx9xt+KTPkP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434612; c=relaxed/simple;
	bh=YInVuToZNnGUR8kgfMsQcj2of3vPAEhMfLeqA8nVPQU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qaEDXPLL53KCCXhvo4sf8ezo1hTPpC4pdpXaRcBM29lig82wN2VnrpPfwwZb5HDxUgMI3eHrXe8LY/XP0uvEY9Xr98s6dYq5uva5v4oGYWdzOca2w5lhsNw4XXCt54hiltDnXFoo6PqBrCaW77l2YBiGOX1eH5fRBi1Vs6f9+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5iO947q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC5C433C7;
	Tue, 16 Jan 2024 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434611;
	bh=YInVuToZNnGUR8kgfMsQcj2of3vPAEhMfLeqA8nVPQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5iO947qeQXRny0ZZN8Nk3GZGj069ajlSlINWr7xwypE7xTaidyLZipLhw8te9xvk
	 MFqkww3OezYh+S3UYUYIBmwPYjfBUHretFnq2ThTSlTwFT7fHaUv8e4BwZicQ69IBW
	 Ep/jUpgkbrmL2YeCoq9NMKzX39KQONl5TqCgGKAvPw1kJIhzdwJT3yCO1/COBA0DZ7
	 ODYKH5IjiJj1ake5rU9VPUT01fgz2LaQ2wSMkfUbdIcbZ5Adai8C7MxcPgorQb6Af+
	 tPiEjtWhYszQfIdMHVtZp2qvpsMvGXyPWNmk4o0TcawnjxEuKH00uvBHL7sIo0vBFh
	 OtItT/PiRivZA==
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
Subject: [PATCH AUTOSEL 6.6 026/104] scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116
Date: Tue, 16 Jan 2024 14:45:52 -0500
Message-ID: <20240116194908.253437-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index f039f1d98647..0d148c39ebcc 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1892,7 +1892,8 @@ static int mpi3mr_create_op_reply_q(struct mpi3mr_ioc *mrioc, u16 qidx)
 
 	reply_qid = qidx + 1;
 	op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD;
-	if (!mrioc->pdev->revision)
+	if ((mrioc->pdev->device == MPI3_MFGPAGE_DEVID_SAS4116) &&
+		!mrioc->pdev->revision)
 		op_reply_q->num_replies = MPI3MR_OP_REP_Q_QD4K;
 	op_reply_q->ci = 0;
 	op_reply_q->ephase = 1;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 01437716ffd1..0dd8f487a7c7 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5084,7 +5084,10 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


