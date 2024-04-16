Return-Path: <linux-kernel+bounces-146373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0358A646C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81B9281CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1696F07F;
	Tue, 16 Apr 2024 06:57:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D01118E;
	Tue, 16 Apr 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250677; cv=none; b=utI+NaP1Svffulc773A3rraB05CmkJUmughkTqNoJsQHYDt9hP8ztwo4ANfakzs+dE2xTaCzMh5zyT9XSWuE4oDYSKjUQXS4BF2Qqpb8Q3KGIFj6FNxozTBzAI0rjNAwSoz36ULDc1tdj80cu+WrQyB5Yu0lgz70wIioXlZZRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250677; c=relaxed/simple;
	bh=fLKO6hroLL0HsTLsxsNlQGyZGX8uG93HQqMSW+Yofk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/FoaaVR5qLpmN+/tVfEoinKzC0xQCl0dgazZcJDaqn9u/Ph+QQH0Mkcr/Zb+m9vxetYQppQJUyKZCBzLvM7IIUgt7RaronCQ4MCCuJb318L9MV6cc+/2k3gD8j9MUsbAbZcQT42FEoedR2DS5dwg6W0HwFJBiA8yTTxfTVXDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJZbF47G3z1GH8J;
	Tue, 16 Apr 2024 14:56:57 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 08D0918002F;
	Tue, 16 Apr 2024 14:57:50 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 14:57:49 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <adaplas@gmail.com>, <deller@gmx.de>, <fullwaywang@outlook.com>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH -next] fbdev: savage: Handle err return when savagefb_check_var failed
Date: Tue, 16 Apr 2024 06:51:37 +0000
Message-ID: <20240416065137.530693-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200010.china.huawei.com (7.221.188.124)

The commit 04e5eac8f3ab("fbdev: savage: Error out if pixclock equals zero")
checks the value of pixclock to avoid divide-by-zero error. However
the function savagefb_probe doesn't handle the error return of
savagefb_check_var. When pixclock is 0, it will cause divide-by-zero error.

Fixes: 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
Cc: stable@vger.kernel.org
---
 drivers/video/fbdev/savage/savagefb_driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index ebc9aeffdde7..ac41f8f37589 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2276,7 +2276,10 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (info->var.xres_virtual > 0x1000)
 		info->var.xres_virtual = 0x1000;
 #endif
-	savagefb_check_var(&info->var, info);
+	err = savagefb_check_var(&info->var, info);
+	if (err)
+		goto failed;
+
 	savagefb_set_fix(info);
 
 	/*
-- 
2.34.1


