Return-Path: <linux-kernel+bounces-93602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E412D873240
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216441C22368
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976DF5F470;
	Wed,  6 Mar 2024 09:13:52 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0B5EE7B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716432; cv=none; b=ndRoV8DHMHIKrD6Isl2VWttFKasO82tVCla+VXb2vwS7KA1oo+D5Vur+AXRytwYN/u+miwI+QY0sg4XCgTUkARV2UB+TIDJAnuqgKvfjHs66N99OUPP5MuqGUv3ZS6MOe2nFfPeVr0GlvrzggBkPdyxSjKL78GhPXOVT5UM0sGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716432; c=relaxed/simple;
	bh=vgjcoJJdph/huFuIxzbWX00E1sJslOVBdlRPU0xo/JU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bYJqG+EJGFmgg/rfWdaVg0w8pgrlzQKJDWl3t+umV22Qp1HGyCJzL5r1/yu4b1KiSxOEyHR2MRJ6cG52a28UjsL/Ro5AzqG5rHWImXjgHRMtTK9XJt6ehT6vohJToa6LspfSoIhvJnoFvbyQNGL/lyhQGVM3dB/7qiknrf+AfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.17.6])
	by mail-app3 (Coremail) with SMTP id cC_KCgDXbjqcM+hl8KcCAg--.1124S2;
	Wed, 06 Mar 2024 17:13:10 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	axboe@kernel.dk,
	brauner@kernel.org,
	hare@suse.de,
	jinpu.wang@ionos.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] um: Fix return value in ubd_init()
Date: Wed,  6 Mar 2024 17:12:59 +0800
Message-Id: <20240306091259.18605-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDXbjqcM+hl8KcCAg--.1124S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18Gw4rtw4UuFWfZw1kZrb_yoWDCwcEkr
	ykXr9ruw4DKr47Jry2v343Z3sIya1jkrs3ZayIvry3JFsxCw4avw4fCrn8Aw4UWrsa9FWq
	yrWIyr93CF47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0tC7UUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIMAWXnadMR0wACs0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When kmalloc_array() fails to allocate memory, the ubd_init()
should return -ENOMEM instead of -1. So, fix it.

Fixes: f88f0bdfc32f ("um: UBD Improvements")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/um/drivers/ubd_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 92ee2697ff3..85e33caf62a 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1098,7 +1098,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1109,7 +1109,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
-- 
2.17.1


