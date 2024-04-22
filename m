Return-Path: <linux-kernel+bounces-154232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C958AD9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE362866D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57943157E84;
	Mon, 22 Apr 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9fuTI4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4A157A49;
	Mon, 22 Apr 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830073; cv=none; b=p0kZENYqIXfATUvPu1QyuikCFnPXVDRru9ZAp5f+/7ONTrUdkUoAOs5hWJ9D2VbDGh3KjQn2JWEjK/jEWvY+MxabXVcb/vTBdpiuxjEcognlRLnXarzqzGpU4j8OYmyxbEgOgqlTYlV04IHthCt9iw1Jfw6aTeYiD3TsTrmen4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830073; c=relaxed/simple;
	bh=jPczAxurGcMPuw94F6WdKWgK/rv9Syz6psjxrWKjVks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELAJ+DpeWG9EoTIMZONmREyENKGnVwv4Gcy0xeoMcHHYDgdlXNXsCF8kpXUVT+NEBO36RiL2sSuzI8ZjyTKeo5B3Lyv0oIS/AxUJyNaU4ymR7Lxojr1sLqAn3LnIXtXO5++eu0t7fJEfs4vdcR+1PkAFpRYepts9TLabeyN3UnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9fuTI4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF43C4AF11;
	Mon, 22 Apr 2024 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830073;
	bh=jPczAxurGcMPuw94F6WdKWgK/rv9Syz6psjxrWKjVks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9fuTI4+HqAPDCniC3dE7Oo0cYI0kHjUz0AnUwJSGM8lMeagdLlip/v5FlZ5a+H0Y
	 1qd/x1xrCWf6uipFSqEg9HYEi/x6q1WUfzN4GbLVINe2KuifxuYLPXXvlyDFVbKyI3
	 OHb1ajsUB8ZsImTRrb90+CH+cQg3RDxEb3S9XiurJ8WRTB+dHd/RhYFh/qdd9xCXu8
	 OT2s3/cWkbkv1Gp1e7hx3DyfMWpx+qRUsnLjNEEbacAaeypt32bSm4WL7X7nK1Anrb
	 jPy/M/O+7F8xQpbNQ1jPMZMQr5sogGpjCqD/C7IP8Ht/27Vhzdu1/PHh89bYFIBnTm
	 mtkkL8ndUk1ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiang Chen <chenxiang66@hisilicon.com>,
	Xingui Yang <yangxingui@huawei.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/43] scsi: hisi_sas: Handle the NCQ error returned by D2H frame
Date: Mon, 22 Apr 2024 19:14:01 -0400
Message-ID: <20240422231521.1592991-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 358e919a351f2ea4b412e7dac6b1c23ec10bd4f5 ]

We find that some disks use D2H frame instead of SDB frame to return NCQ
error. Currently, only the I/O corresponding to the D2H frame is processed
in this scenario, which does not meet the processing requirements of the
NCQ error scenario.  So we set dev_status to HISI_SAS_DEV_NCQ_ERR and abort
all I/Os of the disk in this scenario.

Co-developed-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Link: https://lore.kernel.org/r/20240402035513.2024241-2-chenxiang66@hisilicon.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b56fbc61a15ae..86112f234740d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2244,7 +2244,15 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		if ((dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
 		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
-			ts->stat = SAS_PROTO_RESPONSE;
+			if (task->ata_task.use_ncq) {
+				struct domain_device *device = task->dev;
+				struct hisi_sas_device *sas_dev = device->lldd_dev;
+
+				sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
+				slot->abort = 1;
+			} else {
+				ts->stat = SAS_PROTO_RESPONSE;
+			}
 		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
-- 
2.43.0


