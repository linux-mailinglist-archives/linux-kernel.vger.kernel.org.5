Return-Path: <linux-kernel+bounces-129496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E904E896B97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264451C26EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4C136E3F;
	Wed,  3 Apr 2024 10:05:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A413D603;
	Wed,  3 Apr 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138743; cv=none; b=E1jvHxNW1QoVWpsKpqb1DH7j6d+v1N2tTDXENz7Rhh9dZQhBgBU3ASo2+9V1KDuLcntAvwOZtaFDq+AfBBZk8/919qvxePsWNkm6LJPh1kEFFIOi9MbEjqCTNFoRWQwWmGCasdSioCkF1PkT7hrWgRLS0w4RG5H42i5UtoTVxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138743; c=relaxed/simple;
	bh=INGEGqdsSMSW8P5U9FPTJWpgdgTcifxfTvht2tN20+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj6UxY7JjUCU2foQB5iNMB4roOqf/LWYksV/AEEW+hQc+i5Fl1rFahlHe7Bc+dvRUIlL0YXDMzypbqlYGMZcCtzewEt9kH1stjtXwUHjnyOdNt/ihYVHwVI/cR9QV7BADK0rYJrlE0QnWkPujWPbDk9B3wSUSVDAyXgsdKAW394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V8gLH1lnfz1JB5G;
	Wed,  3 Apr 2024 18:03:19 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id B332518007E;
	Wed,  3 Apr 2024 18:05:27 +0800 (CST)
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
Subject: [PATCH 1/9] crypto: hisilicon/sec - Add the condition for configuring the sriov function
Date: Wed, 3 Apr 2024 18:00:54 +0800
Message-ID: <20240403100102.2735306-2-huangchenghai2@huawei.com>
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


