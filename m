Return-Path: <linux-kernel+bounces-134241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF3389AF65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E81C215D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC52C690;
	Sun,  7 Apr 2024 08:04:40 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8B25776;
	Sun,  7 Apr 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477080; cv=none; b=AwJbpMwSnbDbP5f0pNopOqARZ5trRr+9TYQc5hxGNG9cdPimxvaxBZ9RPuNgyFS6LsZ3/Y+237iFyHe/Ou5P8xmtRIDoUt4cfbZWbjTCl0LbztJTh2UrlLMNjWNfnyHUm91aP5EHDxJAeccCk5KZQzrmn42eFrNudsMv2YlzvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477080; c=relaxed/simple;
	bh=59QhSJcBaUPchWNL7bHjebEqRTh9j7wS95eCWvo0nRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8j5U/CKLIXOZDb88wFag3p9KQjy/QlyzT3fTGlbMtwu7LOA/lk87gT55DtKxMj7ZBugMZ/lPJB9sLzCysljgChjZsI7CweFZidmhoCYSVVdPWCeI1wVXUKr+GQXL9+abyKctEaeDYYi56pRKmNW8sce2cNSXWSmcThh+9o1XHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VC4VK0RZLz1wqPL;
	Sun,  7 Apr 2024 16:03:37 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A7D51A0172;
	Sun,  7 Apr 2024 16:04:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:30 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 4/9] crypto: hisilicon/debugfs - Fix the processing logic issue in the debugfs creation
Date: Sun, 7 Apr 2024 15:59:55 +0800
Message-ID: <20240407080000.673435-5-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240407080000.673435-1-huangchenghai2@huawei.com>
References: <20240407080000.673435-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500025.china.huawei.com (7.221.188.170)

There is a scenario where the file directory is created but the
file attribute is not set. In this case, if a user accesses the
file, an error occurs.

So adjust the processing logic in the debugfs creation to
prevent the file from being accessed before the file attributes
such as the index are set.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 6351a452878d..e9fa42381242 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -1090,12 +1090,12 @@ static void qm_create_debugfs_file(struct hisi_qm *qm, struct dentry *dir,
 {
 	struct debugfs_file *file = qm->debug.files + index;
 
-	debugfs_create_file(qm_debug_file_name[index], 0600, dir, file,
-			    &qm_debug_fops);
-
 	file->index = index;
 	mutex_init(&file->lock);
 	file->debug = &qm->debug;
+
+	debugfs_create_file(qm_debug_file_name[index], 0600, dir, file,
+			    &qm_debug_fops);
 }
 
 static int qm_debugfs_atomic64_set(void *data, u64 val)
-- 
2.30.0


