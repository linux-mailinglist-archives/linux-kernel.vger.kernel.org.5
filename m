Return-Path: <linux-kernel+bounces-113323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E983888368
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09E21C23893
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E996CDC0;
	Sun, 24 Mar 2024 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxnNwu0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119A194C84;
	Sun, 24 Mar 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320125; cv=none; b=LqC3HEZ+1hNllF8vUzyhrzx0WEVLRb06jzp+/KMcn++0/VfGZbD48cnN4npSoOcyyIjVgBWZL7r/NpXWOylpLIhNB8ouyyHWQcMegd6rAy3mialRHzm/cjMHzpYgKufEkS3bnWwoEUQ6/mBPW+U6rZmDp5+6bvxlXssaVGO8sdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320125; c=relaxed/simple;
	bh=IDMABsbKodk7Jluai+Wa3cMHJI+CkDyCinjyT2vhD84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZtFkapJQZDU/VarGJBmQV8q0GH7V0FYMw2GMKlQAp2ZtDIhUCNNARbmd0HJ+f/QU3pa7ND5Elj34GjC5Xyw3gUGjNj4mCCpO0tWr4GNS0jsMmxibd5iVKocma6AmyilnWjUieP/DiQRel5ADKMaHWbGL9KB3XLPyLiPOWHeui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxnNwu0/ reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A105C433A6;
	Sun, 24 Mar 2024 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320125;
	bh=IDMABsbKodk7Jluai+Wa3cMHJI+CkDyCinjyT2vhD84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxnNwu0/9Ymd5p27lPfdBWCfT2fGTZiv4hmMwv1RN+OVDnMLMxd+eEJdq2SLMFNve
	 oT3tX83Oz8pBQv9e5iNC0YEPGvHtBqP4rslNdZaZI7cDm8T73LA6H0WCZnJyKUYAxx
	 7ka9pI5c8VsS7agu4hZ3YVaVGK9KHgunZVUDwMNFyebKYVoMO6mpDD3bLyUab/RWAK
	 RXMVdkrGaD7W80MNRCTGCBUht8xiGkWBIoSd6Rtnmy5UsaGBBSZwyaAju+qyLgkrCx
	 AQJISW2s5GBieUPnEfm/KeDMqrBHSZl2sDGgALx03L5e4HhKpO5OHc1S0KNK8/GHbD
	 RlxaScZbVEHhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 432/715] NTB: fix possible name leak in ntb_register_device()
Date: Sun, 24 Mar 2024 18:30:11 -0400
Message-ID: <20240324223455.1342824-433-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index e75a2af77328e..5b84821c0d602 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1275,15 +1275,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


