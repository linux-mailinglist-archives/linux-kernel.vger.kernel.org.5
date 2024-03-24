Return-Path: <linux-kernel+bounces-114310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F76888A10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A56B25AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30119263839;
	Sun, 24 Mar 2024 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuVJH+Zy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3E153570;
	Sun, 24 Mar 2024 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321689; cv=none; b=ZD7cc/P8wOIT2FEcI+bUzdmgaCDKquRJqfOtsRQKJV8+k346y3geFJBPGkKWcPDjTtLpdqws0jTPLB/y5KE5+FPlca/Kwmbv0FvbnSab3tg6r9nF6nldrwUGN2bj/p7c3Ca4Xkxd9s87xUmyqy9Od1VdhdNTKdCcp//0rEZ0wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321689; c=relaxed/simple;
	bh=oqhLPo+DOeJ4q8k2R1Tcqp5ocx3a9IJ+GYd3/R2/ZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6l2plq1ncdIxEdSKi5QSK/0npLde8UhyhTzrDIliB/op5XvdNcnLlx3zDIaDZZ2jD3g0rL3/atPa4FB+I/fi7RLIT2mfaEHH7FS4MqKv0VC5pYoIJLb7DFlZhhwom3yokAcTlj0AE/5yAluNn55Gdn//NJ2ozbLv7KisDFcXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuVJH+Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E883C43394;
	Sun, 24 Mar 2024 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321688;
	bh=oqhLPo+DOeJ4q8k2R1Tcqp5ocx3a9IJ+GYd3/R2/ZIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuVJH+ZyBux8zduCBtepjJNd6xTdurIjAuSwbJEAwo4TxpjVB2mzajGBl6xUIihdd
	 buVPCmbg5JJFhZKJRqvTptdn8oRtHvoTES8X1ICIlbDWieCvB3/+NmqHVOke/kKD6f
	 lXhojDdn/yJnu3U2WXd9hGyospqcqfvowKXkdJQTqzEEmEfDnVPkPg4Ky0rATQM4xI
	 0uB2SnD7SZEZk/n9UDnaClI02zW03Ky0BbkUbsqiFud/RROZBHnxZAw2wo9DTBHmoB
	 PHKSoKme0zBkIJl1ENQTR2ZZAn2wFD4zbAKznkSCCILI4vmnSwSP31WC0g5UFwCkex
	 n/k4U1+X8pLnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 416/638] NTB: fix possible name leak in ntb_register_device()
Date: Sun, 24 Mar 2024 18:57:33 -0400
Message-ID: <20240324230116.1348576-417-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit aebfdfe39b9327a3077d0df8db3beb3160c9bdd0 ]

If device_register() fails in ntb_register_device(), the device name
allocated by dev_set_name() should be freed. As per the comment in
device_register(), callers should use put_device() to give up the
reference in the error path. So fix this by calling put_device() in the
error path so that the name can be freed in kobject_cleanup().

As a result of this, put_device() in the error path of
ntb_register_device() is removed and the actual error is returned.

Fixes: a1bd3baeb2f1 ("NTB: Add NTB hardware abstraction layer")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20231201033057.1399131-1-yangyingliang@huaweicloud.com
[mani: reworded commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/core.c                            | 8 +++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 6 +-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index 27dd93deff6e5..d702bee780826 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -100,6 +100,8 @@ EXPORT_SYMBOL(ntb_unregister_client);
 
 int ntb_register_device(struct ntb_dev *ntb)
 {
+	int ret;
+
 	if (!ntb)
 		return -EINVAL;
 	if (!ntb->pdev)
@@ -120,7 +122,11 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->ctx_ops = NULL;
 	spin_lock_init(&ntb->ctx_lock);
 
-	return device_register(&ntb->dev);
+	ret = device_register(&ntb->dev);
+	if (ret)
+		put_device(&ntb->dev);
+
+	return ret;
 }
 EXPORT_SYMBOL(ntb_register_device);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3f60128560ed0..2b7bc5a731dd6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1278,15 +1278,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = ntb_register_device(&ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
-		goto err_register_dev;
+		return ret;
 	}
 
 	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
 	return 0;
-
-err_register_dev:
-	put_device(&ndev->ntb.dev);
-	return -EINVAL;
 }
 
 static struct pci_device_id pci_vntb_table[] = {
-- 
2.43.0


