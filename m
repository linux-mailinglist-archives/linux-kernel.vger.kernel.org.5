Return-Path: <linux-kernel+bounces-166579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BBD8B9CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8765E282E75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F14153569;
	Thu,  2 May 2024 14:46:35 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929F153514;
	Thu,  2 May 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661194; cv=none; b=NGLFhnvrYKH8r/g1qHzmkw/b5toSm6xJa/MVO+KxrcP7+SIu7426jbDc7NQI726qLRpGtiGpEpt5F/7ZfWa84xB3zumi6k2ZsDHGEMPitvbJXbV5My+Y8FwQlY2WDjXifhPODWr+38NR31WmGDGLDH7JSSwO1DABHMiZCWaxHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661194; c=relaxed/simple;
	bh=NUzH0xLjYug2wA1GsDRruTxJ0XL95zyZdLIf5ZhzrS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=REbt6fA15nVdc+ZEob4AtP+i4LofA3pcujnCA7xXtC5XIju1YfdLJIheGMKAcB7qwLyKDzQrhoE8RgdluxrbR5x47FIL3aBYu+5YFRpa1UXgjkS2zk3MWsBqEvMGURf5Iyu689aM/nmrKFTAYrVc1NXEAPZu7Hxn0MHI59mzOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.181.50])
	by mail-app2 (Coremail) with SMTP id by_KCgA3L4GZpjNmnigDAg--.28S3;
	Thu, 02 May 2024 22:44:26 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dan.carpenter@linaro.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net 1/2] ax25: change kfree in ax25_dev_free to ax25_dev_free
Date: Thu,  2 May 2024 22:43:37 +0800
Message-Id: <81bc171fb2246201236c341e9b7d799f509d7dd4.1714660565.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1714660565.git.duoming@zju.edu.cn>
References: <cover.1714660565.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1714660565.git.duoming@zju.edu.cn>
References: <cover.1714660565.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgA3L4GZpjNmnigDAg--.28S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw48CFy8GryrArWDArWUurg_yoWfJFX_uF
	1kAFZrXw4UJr1UCw1rCFWrJry7Ww1jgw1fJryfAFZ7t34Yqa4UJrWkWr18XF1UurWUCr4I
	qr1rJr13Ar43JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUblkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCF54CY
	xVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhYFZUUU
	UU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIJAWYySJ0M6ABdsx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The ax25_dev is managed by reference counting, so it should not be
deallocated directly by kfree() in ax25_dev_free(), replace it with
ax25_dev_put() instead.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 282ec581c07..07723095c60 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -208,7 +208,7 @@ void __exit ax25_dev_free(void)
 		s        = ax25_dev;
 		netdev_put(ax25_dev->dev, &ax25_dev->dev_tracker);
 		ax25_dev = ax25_dev->next;
-		kfree(s);
+		ax25_dev_put(s);
 	}
 	ax25_dev_list = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
-- 
2.17.1


