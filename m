Return-Path: <linux-kernel+bounces-158183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0138B1CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52534281DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89006F076;
	Thu, 25 Apr 2024 08:13:15 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336B29408;
	Thu, 25 Apr 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032795; cv=none; b=SfE/96HzDNTfC6d9Vr8RcK7FayHwtzYBfBsQil2Es6rdmr6dYXtHuv5nmFxu0L/Vqn05YgGYKfQmSCuS4taekKzOpmG9K1hmFTcB00kH59+h61F4AnMR2Q1pYvPfbTDbjrHd9APxI8QlO/OZTpIZjeg8xdOgezPVGE9Qjseant0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032795; c=relaxed/simple;
	bh=YSuwMF0FZAoaHM/3I9qe3JhLN0pTJ1IGiJUwje2rEEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDLK8YslDGNx22UApaQcKJ+7iZIgRXlZ5vKtW2WIBQK+vblMRK4FKmgziTX/ypZgjXLa4jzKxCKFNBH4ayilQTBkZOrExtmj9nUORo0qhkcD/FXn9uOPVWchx8nc1j1j+hgxgxG7vD2Nd2HSXLOleZ9P/jVPHzpNp/vwjaXZXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAB3aJmCECpmZhMqAA--.7520S2;
	Thu, 25 Apr 2024 16:12:50 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: njavali@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	joe.carnuccio@qlogic.com,
	hare@suse.com,
	himanshu.madhani@qlogic.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] scsi: qla2xxx: use dma_mapping_error to check map errors
Date: Thu, 25 Apr 2024 16:12:09 +0800
Message-Id: <20240425081209.828940-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3aJmCECpmZhMqAA--.7520S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryrJF18urWxWr47Aw4Utwb_yoWftrgE9r
	4qvrZFgF4Dur17A3WIqr93Jr42v3yjqr4xuF10v345A3s5u343Xry2vayUCanFq3yUZF45
	Cw1Uuryrur18WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUP-B_UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The return value of dma_map_single() should be checked by
dma_mapping_error(). Update the check accordingly.

Fixes: ec89146215d1 ("qla2xxx: Add bsg interface to support D_Port Diagnostics.")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 0cd6f3e14882..13b6cb1b93ac 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -2147,7 +2147,7 @@ qla24xx_get_port_database(scsi_qla_host_t *vha, u16 nport_handle,
 
 	pdb_dma = dma_map_single(&vha->hw->pdev->dev, pdb,
 	    sizeof(*pdb), DMA_FROM_DEVICE);
-	if (!pdb_dma) {
+	if (dma_mapping_error(&vha->hw->pdev->dev, pdb_dma)) {
 		ql_log(ql_log_warn, vha, 0x1116, "Failed to map dma buffer.\n");
 		return QLA_MEMORY_ALLOC_FAILED;
 	}
-- 
2.25.1


