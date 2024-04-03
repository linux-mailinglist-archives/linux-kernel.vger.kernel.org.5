Return-Path: <linux-kernel+bounces-129490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7058896B99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B0AB26960
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E553136989;
	Wed,  3 Apr 2024 10:05:32 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE081135A44;
	Wed,  3 Apr 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138731; cv=none; b=aSn5w3t19kTxvxmqpL5Y6gokG+MA5fCpZjvpftuQ4+bRUxHX6F3C17HPwGoUzEOpVRQfJyyGNOt8x/95c390+qpvJFBZlPG20TWI7aCv0/Ac0voaoOpaMKJyc2vDlgbHGgnPrOnfV8s4WIrEQCiEDtBMqRoWUl0TwK3Es/VnpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138731; c=relaxed/simple;
	bh=59QhSJcBaUPchWNL7bHjebEqRTh9j7wS95eCWvo0nRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEz3YYTaRaPO0X2PmA6RMHsFXyS8drUO0oGxWcxGcCjjBXw/APyl/COSphoTGJD6Y/L94POq2B4vm9QEeCsnK7byYNpVZAdSkXXhZzNZxdrNKI0+TrBXZILLBBl5JkGnuosWN+sJZc27ghbAMgW6BxFgmu01q6WucMRApPPHJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8gKn6y5Nz1QCDj;
	Wed,  3 Apr 2024 18:02:53 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 20CB818005D;
	Wed,  3 Apr 2024 18:05:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 18:05:27 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 4/9] crypto: hisilicon/debugfs - Fix the processing logic issue in the debugfs creation
Date: Wed, 3 Apr 2024 18:00:57 +0800
Message-ID: <20240403100102.2735306-5-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240403100102.2735306-1-huangchenghai2@huawei.com>
References: <20240403100102.2735306-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200003.china.huawei.com (7.185.36.122)

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


