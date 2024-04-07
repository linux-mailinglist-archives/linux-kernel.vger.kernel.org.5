Return-Path: <linux-kernel+bounces-134238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9289AF60
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747A428221C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556471EB3D;
	Sun,  7 Apr 2024 08:04:37 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873F1096F;
	Sun,  7 Apr 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477076; cv=none; b=ktmYXWgXSLMzw/LXclmTWpRDciJtJ6KAA2HutGNPRwEB4lmzH/2hCmMH/Aal+nV7EqSnGVanXJdFUMRKU1q0ELbIgkv7fu0U92tungo7NX7ZtIOSWRkhxAnKU1xInVtWgZC2yeQlEeRykIsqk/1G2HygkkWLK96X1/K9+sdkElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477076; c=relaxed/simple;
	bh=INGEGqdsSMSW8P5U9FPTJWpgdgTcifxfTvht2tN20+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6DcqjpT8awZ4VRW6XEK4ZwrIZ1i7Y0h3iJ8zljNv+0dh1DJKz0IFMZ7I/XRMeUZGUJ9NW1YuateX7AM492EfFWoCcHZ9Bcvz8xcydHJepaS6u7pPXxhtcxBFMNz90yH9UFELxXnxSxp4HiP9oAP9DvVsXOuAYwj1N5uedjH94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VC4VV6wX0z1GG9P;
	Sun,  7 Apr 2024 16:03:46 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F0C7140416;
	Sun,  7 Apr 2024 16:04:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:28 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 1/9] crypto: hisilicon/sec - Add the condition for configuring the sriov function
Date: Sun, 7 Apr 2024 15:59:52 +0800
Message-ID: <20240407080000.673435-2-huangchenghai2@huawei.com>
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

When CONFIG_PCI_IOV is disabled, the SRIOV configuration
function is not required. An error occurs if this function is
incorrectly called.

Consistent with other modules, add the condition for
configuring the sriov function of sec_pci_driver.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index c290d8937b19..f4e10741610f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -1324,7 +1324,8 @@ static struct pci_driver sec_pci_driver = {
 	.probe = sec_probe,
 	.remove = sec_remove,
 	.err_handler = &sec_err_handler,
-	.sriov_configure = hisi_qm_sriov_configure,
+	.sriov_configure = IS_ENABLED(CONFIG_PCI_IOV) ?
+				hisi_qm_sriov_configure : NULL,
 	.shutdown = hisi_qm_dev_shutdown,
 	.driver.pm = &sec_pm_ops,
 };
-- 
2.30.0


