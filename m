Return-Path: <linux-kernel+bounces-114573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA7888B19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478A61F276CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FA5E07E;
	Sun, 24 Mar 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON9tU3lA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293022F8E1;
	Sun, 24 Mar 2024 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322216; cv=none; b=g1hRtLJrdSRWaZt/MOtD1xPONonEpVnNunDh+lVyMIXJ/E8U7IXFOUsGV+14/onuz/Ub6EJ0iubW0I1PMfNRyNbwNMES3IieiSclDONI2s2GJfQNvqczr5YiffXXSi4YLv2H83RUN4nkct8dU89hFhlKLNiHXJsu5jrJGc1qlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322216; c=relaxed/simple;
	bh=HLooVr+1H8aCbz+d13YJUg/y8vTw5izopbsBCrh0JbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck8NbUD8D2gg4LJvdChhMUHZMreS7jfUuldoA/a/3NLUIjfaR4hJxjDSIygGWyxDpoOD6B16eEg7muBzjDn8HT+EIwedH+jxHwna3uGSs5cljOUVxD7N0PdZ/QkZrGjxErYfWz15XtwkH9IU/CyLmnZP4+nlhl9mmZu7XL94zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON9tU3lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21FBC43390;
	Sun, 24 Mar 2024 23:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322215;
	bh=HLooVr+1H8aCbz+d13YJUg/y8vTw5izopbsBCrh0JbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ON9tU3lATohbKq1JF0NSzIMml8HOJDQK06lIwdlZJJ0quU3RraUf6SDJNKCsneZ2X
	 LXPNh7YB4fAzo4DtlTq/Mn/LXsb4aKhvYIIDkX/r8lNwj1vqZ/70/FJoDNunwq3kAy
	 6aGOowmauubi9E/hHuEklRowqqubM6u+CWFLtjkR4zdqerCHN9G8yhuuXWsR2gAXO+
	 OYmWecPBda/QWvJLjx6jmRoYsVfVkxxFDC3kF7xcLIOfDIFg7MUft5FU9tUiIPNNFc
	 RjaZt1DG3yPv6r22Zt0PJP9ENQB8iPzhvTMNyyDXh/Z7whyj2I+hcw8j8dIZVJIfhS
	 WwQpfXwm6Qnxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 295/451] NTB: fix possible name leak in ntb_register_device()
Date: Sun, 24 Mar 2024 19:09:31 -0400
Message-ID: <20240324231207.1351418-296-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index cd985a41c8d65..b4c1a4f6029d4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1281,15 +1281,11 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


