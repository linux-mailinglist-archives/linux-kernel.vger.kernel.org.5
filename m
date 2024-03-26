Return-Path: <linux-kernel+bounces-119002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0439F88C273
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977BD1F635CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FF6FE26;
	Tue, 26 Mar 2024 12:44:08 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDA5CDE7;
	Tue, 26 Mar 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457047; cv=none; b=Fluynpr5prTO/oSFS0rDiylk96GuwmEBnrHjXOzxd3qtBVOL5CWdre86c10tK4Mxw6YjBHjV3/gzAbMCKgvW8CAkRonLaOpdMEvnurM+91Q3rXvO/ZpXMzzaLKD1aIBa1Pkn0nP3BTGuCNvwC/Jh1DKcNnLpw57r9uFnPJshbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457047; c=relaxed/simple;
	bh=+tsqbPva4v8ckvlURd/TCkXfFT7ZUNUmsZJThNP5SU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0j26Yu2aDd03psCeUYbYK2EK2jARcCXfn7CmK4FgBNJ5mhzw7KS2ZSjaPYt1gesulZuhlwuom2suX9sjGfU58MCmy5HGwR+hGnfmyTIn9WuTaBZ4RyhDNAJjoQUZSxGCUlC7nczp3xv/kaG3HD5DffGNO4VLtwA2Qr3fAy7H6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V3qDK70wkz2Bhfw;
	Tue, 26 Mar 2024 20:41:21 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id B395D1A0172;
	Tue, 26 Mar 2024 20:44:00 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 20:44:00 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <dlemoal@kernel.org>,
	<chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <yangxingui@huawei.com>,
	<liyihang9@huawei.com>
Subject: [PATCH v2] scsi: libsas: Allocation SMP request is aligned to ARCH_DMA_MINALIGN
Date: Tue, 26 Mar 2024 20:43:58 +0800
Message-ID: <20240326124358.2466259-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)

This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
(from 128). In libsas, this will cause SMP requests to be 8-byte-aligned
through kmalloc() allocation. However, for the hisi_sas hardware, all
commands address must be 16-byte-aligned. Otherwise, the commands fail to
be executed.

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.

Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
Changes since v1:
- Directly modify alloc_smp_req() instead of using handler callback.
---
 drivers/scsi/libsas/sas_expander.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..941abc7298df 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -135,7 +135,10 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 static inline void *alloc_smp_req(int size)
 {
-	u8 *p = kzalloc(size, GFP_KERNEL);
+	u8 *p;
+
+	size = ALIGN(size, ARCH_DMA_MINALIGN);
+	p = kzalloc(size, GFP_KERNEL);
 	if (p)
 		p[0] = SMP_REQUEST;
 	return p;
-- 
2.33.0


