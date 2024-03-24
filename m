Return-Path: <linux-kernel+bounces-114859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB68891CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66091F2DD94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C41BB749;
	Mon, 25 Mar 2024 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtVt4cvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E513C695;
	Sun, 24 Mar 2024 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323502; cv=none; b=bzBGV9qYNd94MxK/fX9UWrCTNLa4Vzf5WbtacoTi5rGC/DMPSxlQgs0ZQzXgijbttX5MbeJZdynXb8INgCjIUAH19FmNYQgMuNSfh4Frjn4vAT0ZIKL9tGaUV4zy/7aUrBWeqkBvH9U4p7ZYOTx8K3vTvlBtvwq6B4lk/+J+Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323502; c=relaxed/simple;
	bh=AEgavoyrrcEhc7TQRZz57wcjIAh4rUCr3ZqQ1UuR1uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taSrir7wQCmyW9Z/ueOFDejWYWBWAoS+jR0ZdEOa+QwO+oDwCgjEO0qrgtVYqsvawUkxhQnb9B50397TUG9TYboU9KUg2qHFw96myYT8IdtDZKpN/R2sZjF+/741S1okzGF5E0y7l1jA/v9QwUx7Al7JVkVX9V+HkB6REa0KAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtVt4cvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD2BC43394;
	Sun, 24 Mar 2024 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323501;
	bh=AEgavoyrrcEhc7TQRZz57wcjIAh4rUCr3ZqQ1UuR1uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtVt4cvzus2D2vTdmPs0V9EQGjfJ0z8BGIJvrlC+enMwrwQmXqstPpbACrKMUruYi
	 Bc54hfMghmv/0DLfoStpFF92V8PhUrG4hpZYa6xrTz0xT3cB6E1ywniw9tjpluwIZu
	 J18kOuAZQCHPp7i2rboDFLGBH5nARzA6EVPmamEZE1bGk8cEak1ktttBYBsnm7C9gt
	 tXOssNKKqL6P5QDF6uEVVUfWAM4LPzSNFXuYKV7eurFEcmwcxmzb/BUV0ss2cFh8Cb
	 bNI1YYlHZ3lnVTH9XIy7Z1ABAYgVKug2CZ75JJsAoJjZ/cEs1pIWMbVyCMPMaRP6/4
	 6FTmgk5TGR7vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 206/317] NTB: fix possible name leak in ntb_register_device()
Date: Sun, 24 Mar 2024 19:33:06 -0400
Message-ID: <20240324233458.1352854-207-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 138742af51707..d4cd4bd4a0881 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1242,15 +1242,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


