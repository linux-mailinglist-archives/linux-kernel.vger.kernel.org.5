Return-Path: <linux-kernel+bounces-115474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63120889BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1781F2E212D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AC722349E;
	Mon, 25 Mar 2024 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrRF7hQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540112A159;
	Sun, 24 Mar 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320901; cv=none; b=uUGkEBbg9HukLob860TWEE1HoO0cv7WUEy07zJYqQGFdJPvCoQXU+PETkgNIiai29X3zA6BR1kzD1rgsTDQ9uu1lw2bP5Qi+TdYT5kkxFLdqkbE+UUo17Qm6O0JQZY/TKl6qfj6A2khrlTlp2keblmrE4Tj5SpHCn2hzUbhKngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320901; c=relaxed/simple;
	bh=oqhLPo+DOeJ4q8k2R1Tcqp5ocx3a9IJ+GYd3/R2/ZIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONe36ANDJ60PiGpkGmTK1/e8jVcS3Umry1RXqT0mtFjaCI2wdYe0TUdEAudUyc96B/QYXwBmgTawI6E0Q/bm+Tpw/0Cm0eDnl/v3SFU42qiYeA0TKwaBIq+yEi09FLCR1fpdFyYx3Gj2e3OAvVDOmjtizpKSmuCUYhYSntyc29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrRF7hQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87414C433F1;
	Sun, 24 Mar 2024 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320901;
	bh=oqhLPo+DOeJ4q8k2R1Tcqp5ocx3a9IJ+GYd3/R2/ZIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrRF7hQCRcZSucTI10dV9vSrvqmxssRni6xg+Cbla5QaCcciMvhlQMk9+tjZoBx+i
	 AyDEsLDzsOcEoDSiOCUCUqlcoKKHvnkAeLDuM6QT2nGr1c0c9giPqQ9uwLPtGdffs8
	 aQPCLOfjBK+QQ2fr4bn8x35o2m78KltxLGQEVFU1zm2HqiPZxAuY2q9wkqcDhUSnOb
	 rdPR7qs+RV/xbAZVH7HZvBiu/JD8Q1IdrlVBgnwUgiCUVDEqxbD2KYXQ5lhnhdSIjk
	 iGUajLTkovkRPdQwABGUxHZkvr7m88FKjVONqqBVaxTqrmNXF9rSzsRXAp6DOFwj6+
	 9m0loPAnX5+lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 464/713] NTB: fix possible name leak in ntb_register_device()
Date: Sun, 24 Mar 2024 18:43:10 -0400
Message-ID: <20240324224720.1345309-465-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


