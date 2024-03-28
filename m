Return-Path: <linux-kernel+bounces-122460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71C88F7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B2B1F26C49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86484F5E6;
	Thu, 28 Mar 2024 06:27:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08E4EB42;
	Thu, 28 Mar 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607236; cv=none; b=f1HAVI0/Z8tg4EysQe/qmcSfwgmtM18MUshXq/iHY1lquVfEXKOb037m/VuAlm/rMD27Im2kyAgO7Ug3xM9TwDT0Lbb/xRhIsc0VLJakV7e2CWfGajxqh+h9mW2aQMpLEUJj2cwq5LXPZ27P72SkfQjnep8vEoASdliv6VVi+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607236; c=relaxed/simple;
	bh=/S13wRNr5LsSZgLf9WFNV5wLCibrFCIJ8lAI341NND0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bS0hcKhssdeDrKdScF/RASAuetk5IM0n0xmuXFsUihVYm7WllWLOsIcDaujJUICMUA0wcwCBqCvxZYGSPoOevGdV/SpqxqxkbcO9dsToU+zNIz1Bjl5Yf5KYBxvTvr3WcIW1ntWXopAzXIjp7tl3VOxorOJhMkWa/3jWJcQC+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V4tnH1yPyz1xt4F;
	Thu, 28 Mar 2024 14:25:07 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D5D1402CA;
	Thu, 28 Mar 2024 14:27:08 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 14:27:07 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <dlemoal@kernel.org>,
	<chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>,
	<liyihang9@huawei.com>
Subject: [PATCH v3] scsi: libsas: Allocation SMP request is aligned to 16B
Date: Thu, 28 Mar 2024 14:26:57 +0800
Message-ID: <20240328062657.581460-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)

This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
(from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
through kmalloc() allocation. However, for the hisi_sas hardware, all
commands address must be 16-byte-aligned. Otherwise, the commands fail to
be executed.

So use 16B as the alignment for SMP request.

Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
Changes since v2:
- Use 16B as alignment for SMP requests instead of ARCH_DMA_MINALIGN.

Changes since v1:
- Directly modify alloc_smp_req() instead of using handler callback.
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..5ddbd00d5c76 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 static inline void *alloc_smp_req(int size)
 {
-	u8 *p = kzalloc(size, GFP_KERNEL);
+	u8 *p = kzalloc(ALIGN(size, 16), GFP_KERNEL);
 	if (p)
 		p[0] = SMP_REQUEST;
 	return p;
-- 
2.33.0


