Return-Path: <linux-kernel+bounces-40519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECD383E1D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0618B1F27D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0B25560;
	Fri, 26 Jan 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rHbfKoiP"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7E5788E;
	Fri, 26 Jan 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294391; cv=none; b=a3ivfu5+cHqCIhH/bHycQ+XCAKx8TNa3ZfXa7v/cKDPjhCTp0HUYvQ20P9eIkdZd/EN7MEr4XtPgB/EOOZ9UKO6CuL9UR7VYijPZFDXkjb52LzMA0YV9gDU7nMav/B1/V9mXdC/3Kj2PB9Ki7POcCAPwdc5t+iGzxJui4gl5khI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294391; c=relaxed/simple;
	bh=eauj58OBoo8xZvl2rPD9VNk7G7uSuwhiIRJeInveqVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToYPsFqCsPiJAyaiUGNSHW1qFXKkq5rSMMoTHqmyUQZIUZ5H197epqQitpWw849DL7BKKQY7Vfs4kzGUQmqkSy+klIya0oi1ZB1bvOOvWoJRjMvmM4I00/oWgmZWXKfPQWx3Eep5Pyia1CgEspV1niJG8RUADp8ghyuaBMp0OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rHbfKoiP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [109.252.166.233])
	by mail.ispras.ru (Postfix) with ESMTPSA id E20BF40F1DF0;
	Fri, 26 Jan 2024 18:39:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E20BF40F1DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1706294378;
	bh=78dGZXUBaq73+RyFvDkx3Qmk9Enz29Z8QRzceyGVnSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHbfKoiPtBUj9RX0e6g7eyvQnUJR6LiVQXkiE6qOSgZDDLGIQBjjA7eB8kD3toNKR
	 f+MnrndJnalJOSwZ7EUJfNz994HPwIIjc5VgAvgHLPoR0J0p3vZqjDvcH4yg58LBGb
	 cETAVhLPe1r1ONrTyDIU8W8l9Rtto/KMjbHrfiEM=
From: Vadim Marchenko <v.marchenko@ispras.ru>
To: HighPoint Linux Team <linux@highpoint-tech.com>
Cc: Vadim Marchenko <v.marchenko@ispras.ru>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hptiop: Fix buffer overflow of hba->reqs[]
Date: Fri, 26 Jan 2024 19:50:59 +0300
Message-Id: <20240126165059.8175-1-v.marchenko@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006204653.4677-1-jakosvadim@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer overflow when accessing an hba->reqs[tag]. Since the tag value is
read from the device with readl(), it can be greater than 
HPTIOP_MAX_REQUESTS, which is the maximum size of reqs[].
struct hptiop_hba { ... struct hptiop_request reqs[HPTIOP_MAX_REQUESTS]; ... }

For example, if tag is 0x80000101, then in hptiop.c:79 we will pass tag equal
to (tag & ~IOPMU_QUEUE_ADDR_HOST_BIT) = (0x80000101 & 0x7fffffff) = 0x101 = 257
and get a buffer overflow in hptiop_host_request_callback_itl().

To fix it, we need to get the last 8 bits of the tag before accessing the
hba->reqs[tag]. We can do this by calculating bitwise and of tag with macros
IOPMU_QUEUE_REQUEST_INDEX_BITS which is equal to 0xff.
By the way, array access that prevents overflow was in commit 286aa031664b
("[SCSI] hptiop: Support HighPoint RR4520/RR4522 HBA") in function
hptiop_request_callback_mvfrey(), and this fix extends it to all other cases.

Found by Linux Verification Center (linuxtesting.org) with KLEVER.

Signed-off-by: Vadim Marchenko <v.marchenko@ispras.ru>
---
 drivers/scsi/hptiop.c | 22 +++++++++++++++-------
 drivers/scsi/hptiop.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f5334ccbf2ca..174a350c4f58 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -176,6 +176,7 @@ static void hptiop_request_callback_mv(struct hptiop_hba *hba, u64 tag)
 {
 	u32 req_type = (tag >> 5) & 0x7;
 	struct hpt_iop_request_scsi_command *req;
+	u32 req_idx;
 
 	dprintk("hptiop_request_callback_mv: tag=%llx\n", tag);
 
@@ -188,7 +189,8 @@ static void hptiop_request_callback_mv(struct hptiop_hba *hba, u64 tag)
 		break;
 
 	case IOP_REQUEST_TYPE_SCSI_COMMAND:
-		req = hba->reqs[tag >> 8].req_virt;
+		req_idx = (tag >> 8) & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(tag & MVIOP_MU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = cpu_to_le32(IOP_RESULT_SUCCESS);
 
@@ -231,6 +233,7 @@ static void hptiop_request_callback_mvfrey(struct hptiop_hba *hba, u32 _tag)
 {
 	u32 req_type = _tag & 0xf;
 	struct hpt_iop_request_scsi_command *req;
+	u32 req_idx;
 
 	switch (req_type) {
 	case IOP_REQUEST_TYPE_GET_CONFIG:
@@ -239,10 +242,11 @@ static void hptiop_request_callback_mvfrey(struct hptiop_hba *hba, u32 _tag)
 		break;
 
 	case IOP_REQUEST_TYPE_SCSI_COMMAND:
-		req = hba->reqs[(_tag >> 4) & 0xff].req_virt;
+		req_idx = (_tag >> 4) & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(_tag & IOPMU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = IOP_RESULT_SUCCESS;
-		hptiop_finish_scsi_req(hba, (_tag >> 4) & 0xff, req);
+		hptiop_finish_scsi_req(hba, req_idx, req);
 		break;
 
 	default:
@@ -717,6 +721,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 				struct hpt_iop_request_scsi_command *req)
 {
 	struct scsi_cmnd *scp;
+	u32 req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
 
 	dprintk("hptiop_finish_scsi_req: req=%p, type=%d, "
 			"result=%d, context=0x%x tag=%d\n",
@@ -726,7 +731,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 	BUG_ON(!req->header.result);
 	BUG_ON(req->header.type != cpu_to_le32(IOP_REQUEST_TYPE_SCSI_COMMAND));
 
-	scp = hba->reqs[tag].scp;
+	scp = hba->reqs[req_idx].scp;
 
 	if (HPT_SCP(scp)->mapped)
 		scsi_dma_unmap(scp);
@@ -770,22 +775,25 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 skip_resid:
 	dprintk("scsi_done(%p)\n", scp);
 	scsi_done(scp);
-	free_req(hba, &hba->reqs[tag]);
+	free_req(hba, &hba->reqs[req_idx]);
 }
 
 static void hptiop_host_request_callback_itl(struct hptiop_hba *hba, u32 _tag)
 {
 	struct hpt_iop_request_scsi_command *req;
 	u32 tag;
+	u32 req_idx;
 
 	if (hba->iopintf_v2) {
 		tag = _tag & ~IOPMU_QUEUE_REQUEST_RESULT_BIT;
-		req = hba->reqs[tag].req_virt;
+		req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 		if (likely(_tag & IOPMU_QUEUE_REQUEST_RESULT_BIT))
 			req->header.result = cpu_to_le32(IOP_RESULT_SUCCESS);
 	} else {
 		tag = _tag;
-		req = hba->reqs[tag].req_virt;
+		req_idx = tag & IOPMU_QUEUE_REQUEST_INDEX_BITS;
+		req = hba->reqs[req_idx].req_virt;
 	}
 
 	hptiop_finish_scsi_req(hba, tag, req);
diff --git a/drivers/scsi/hptiop.h b/drivers/scsi/hptiop.h
index 394ef6aa469e..742ce87ab56d 100644
--- a/drivers/scsi/hptiop.h
+++ b/drivers/scsi/hptiop.h
@@ -32,6 +32,7 @@ struct hpt_iopmu_itl {
 #define IOPMU_QUEUE_ADDR_HOST_BIT    0x80000000
 #define IOPMU_QUEUE_REQUEST_SIZE_BIT    0x40000000
 #define IOPMU_QUEUE_REQUEST_RESULT_BIT   0x40000000
+#define IOPMU_QUEUE_REQUEST_INDEX_BITS   0xff
 
 #define IOPMU_OUTBOUND_INT_MSG0      1
 #define IOPMU_OUTBOUND_INT_MSG1      2
-- 
2.39.2


