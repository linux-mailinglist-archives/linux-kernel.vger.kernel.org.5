Return-Path: <linux-kernel+bounces-27933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E582F7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64335B238F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A312B712;
	Tue, 16 Jan 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J++FxfaV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15612AAF7;
	Tue, 16 Jan 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434610; cv=none; b=Va3KUOScCBvi7UP1vPRo5uRh01lFLl0dJOx+Imsu77gBLkJhQz4QJHGzU1/+7+RRLu8Ppyim8159uvs1O84rpXlnVoohAjmPpO4hWwFS8eJDmJS4Zb1N0LB0GZGsLfhQGP7jYs5Uf0SgMmMt1qzchGZbDbuQ/KacYiJHexwrPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434610; c=relaxed/simple;
	bh=A27CkGYWx+BSRiTz62jKaGieCPCgYNM2ItzwNfmNMF8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Vzj2uiTHphPOGTkcLJwRw4UZpu88hmjhO4nqYm1r0Xe3tYTfGnoMRR2xpen7HPsO8ctxSO+rLBb3jybV5O+sR7BYJCGGosEmVysuTRfv5iqtm6tvl+9Jxiw81A+Rlon2oeMILzRHUkjU/3cjmg8vsJCd4MUM8dX9f11aW6NFBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J++FxfaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9553C43390;
	Tue, 16 Jan 2024 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434609;
	bh=A27CkGYWx+BSRiTz62jKaGieCPCgYNM2ItzwNfmNMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J++FxfaVIPEKVaDCeXKL1fpy7lC/2ACqEA/biDgnG6JwfmmXkZmn9Ex6pbxN99Xhp
	 aYicF19/6Ey686UWn2+eU6WpQZsyQPDx8YBqjif754EZDMUVh73Bj6rKGvQzKL5Zld
	 G/lRK3LW/uWNurAgYaX8Jac0iNTSz0dY2zMZdrYYPqhs4pYYgsmjSC/y6mM4rGiIZW
	 szCCrvZAAfqBqDKQIPcX8HywuNZ6yN0bxQQGxzL/OetT3wYGRcFO6BKjFmYQEsp1fB
	 tpQzF+jBnOGsoKLEFbUJIPy+v2Lq1hMJlBiH4SErFVk4OZ2EH5GZgLykaJSP4mJ+ay
	 SzxTrYnV5pEUg==
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
Subject: [PATCH AUTOSEL 6.6 025/104] scsi: mpi3mr: Add support for SAS5116 PCI IDs
Date: Tue, 16 Jan 2024 14:45:51 -0500
Message-ID: <20240116194908.253437-25-sashal@kernel.org>
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

[ Upstream commit 6fa21eab82be57a3ad2470fac27b982793805336 ]

Add support for Broadcom's SAS5116 IO/RAID controllers PCI IDs.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Link: https://lore.kernel.org/r/20231123160132.4155-2-sumit.saxena@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 89ba015c5d7e..01437716ffd1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5413,6 +5413,14 @@ static const struct pci_device_id mpi3mr_pci_id_table[] = {
 		PCI_DEVICE_SUB(MPI3_MFGPAGE_VENDORID_BROADCOM,
 		    MPI3_MFGPAGE_DEVID_SAS4116, PCI_ANY_ID, PCI_ANY_ID)
 	},
+	{
+		PCI_DEVICE_SUB(MPI3_MFGPAGE_VENDORID_BROADCOM,
+		    MPI3_MFGPAGE_DEVID_SAS5116_MPI, PCI_ANY_ID, PCI_ANY_ID)
+	},
+	{
+		PCI_DEVICE_SUB(MPI3_MFGPAGE_VENDORID_BROADCOM,
+		    MPI3_MFGPAGE_DEVID_SAS5116_MPI_MGMT, PCI_ANY_ID, PCI_ANY_ID)
+	},
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, mpi3mr_pci_id_table);
-- 
2.43.0


