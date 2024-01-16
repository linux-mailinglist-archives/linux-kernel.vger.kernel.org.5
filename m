Return-Path: <linux-kernel+bounces-27795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9EC82F606
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234FD1C24056
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3E241FA;
	Tue, 16 Jan 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMiBuYbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEF241EC;
	Tue, 16 Jan 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434213; cv=none; b=HBwfoC/DR6kpjMoOROB+2MLutGSpTdzYCbYvmUScTxtKdRSa3vLRcm8jSzS1MiYFyrfnt24vbW2XYaU9h5nX6iD5FCn2XGtAu50M14qBp9665K1ESWp4GvYwl8k3G/4eRToqUHVG0oPq4OsYKeWyHyIZEpNMgFHCsDLArb6kU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434213; c=relaxed/simple;
	bh=qJn6YXD92hdjIH1J1vQ9Ek4z3czSnXQxpQoMk7hPPF0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=T0IWVEZ29fAxVw7XmVERFteID+fKzwtaHTilWLfHiP19IaGQJdB3HUp7REiEn9M/UbFTJ81E2kkIWGabpwjRIktWxHW1sOHSgcyk8dKATCzCXmdMNSvxgk/8rtU0FVRABe0V29Rd3ly8FQH8xorauebIrR7sMzVSDBOrxApyGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMiBuYbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF4BC433C7;
	Tue, 16 Jan 2024 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434213;
	bh=qJn6YXD92hdjIH1J1vQ9Ek4z3czSnXQxpQoMk7hPPF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMiBuYbXlvvxRQ3rSP6D7ZG1Fv5XCWY8DWM+pbhh5z5CWCvBmUeBZZ6Eq6Sgeb2L7
	 A+sPW99Z9tmHP+Pl4eoOkBikQlAk/BXn8Zbjz79Vd9LklRbMYVHwKFro+n5MYn0WPD
	 3dwcot58aWq0Dy/Y4USwuXtOyYnUUiQpfbYCCbcQ72Ws2+FHY8rvxnE3uvUe5QCX4w
	 u8wzYDExEcFhgfNl8kx/TDk8hxhR9I0bM4zwed76bK9O4Y6T0W+iuw4Ht+i5IhWS4J
	 y7Z9zmIVHMv54KZHYWv6ufU2HNatSGOaaDnxRS+eSc53yE64RbL908SSzJMmQGDS9p
	 DMHKHIU7PvCVw==
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
Subject: [PATCH AUTOSEL 6.7 025/108] scsi: mpi3mr: Add support for SAS5116 PCI IDs
Date: Tue, 16 Jan 2024 14:38:51 -0500
Message-ID: <20240116194225.250921-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 040031eb0c12..a8d7dbf0159a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5430,6 +5430,14 @@ static const struct pci_device_id mpi3mr_pci_id_table[] = {
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


