Return-Path: <linux-kernel+bounces-138100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2889ECA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82831B24CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46713D28D;
	Wed, 10 Apr 2024 07:49:10 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E548BE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735349; cv=none; b=dtqUCkl1W+OAidBRENDtgFPmhC6oKAB7Xj7C2sSho1Masr97k2moQZFypB98YPA8UeiipVYAe0kHwWIpeMJVGi4vFeXaN5j63lJXOmelroRftUwJ52AdFmpFxJpvWBmRihb57cxjIsnxGzLIyZB/mciCz7VhjzKoUi3D3tpv38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735349; c=relaxed/simple;
	bh=L7+yEMnAAQhrm90UXztYYYVX1BAD5yIkJu/9V9n1ex4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/Ff/butnNa2n9KYhZbkEYQWtqOMgeHuIfVv8sbxLKNaSudF6XYJJbdex5hLfGo8rDOJ9CTQsFgm7TsQBiITc02RfdqiXMA2fpZe6RnFBIGfHmiALnSDPEsOKr2qeFEovsGq3h5y0RMT0DZW7LQbqWzoXhNSEs195FKIEimYbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VDvzY3YCfzNnVX;
	Wed, 10 Apr 2024 15:46:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7510118005D;
	Wed, 10 Apr 2024 15:49:05 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:49:04 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ubi: ubi_init: Fix missed debugfs cleanup in error handling path
Date: Wed, 10 Apr 2024 15:40:32 +0800
Message-ID: <20240410074033.2523399-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410074033.2523399-1-chengzhihao1@huawei.com>
References: <20240410074033.2523399-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

The debugfs dir is created in ubi_init, but it is not destroyed in error
handling path of ubi_init when ubi is loaded by inserting module (eg.
attaching failure), which leads to subsequent ubi_init calls failed.
Fix it by destroying debugfs dir in corresponding error handling path.

Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a7e3a6246c0e..7f95fd7968a8 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1372,7 +1372,7 @@ static int __init ubi_init(void)
 
 		/* See comment above re-ubi_is_module(). */
 		if (ubi_is_module())
-			goto out_slab;
+			goto out_debugfs;
 	}
 
 	register_mtd_user(&ubi_mtd_notifier);
@@ -1387,6 +1387,8 @@ static int __init ubi_init(void)
 
 out_mtd_notifier:
 	unregister_mtd_user(&ubi_mtd_notifier);
+out_debugfs:
+	ubi_debugfs_exit();
 out_slab:
 	kmem_cache_destroy(ubi_wl_entry_slab);
 out_dev_unreg:
-- 
2.39.2


