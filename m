Return-Path: <linux-kernel+bounces-166594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9858B9CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9F1F24889
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9A15F30D;
	Thu,  2 May 2024 14:46:50 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71815B148;
	Thu,  2 May 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661209; cv=none; b=fHDbngFDABVJBFGeRi0nS2hIw0KDu4HdAqMsOQmQi/byElr7op6aQ/XBXthWlcoNavVDesmTYsnRYsotFtuHsf9j6rrJ7R52ix+xcwDB4OWgcj0gYXwWxVSZJhwEg6NktObjxcZfxlkx1AmbSvjZtrb8b/YSEMXl563Hkzgqgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661209; c=relaxed/simple;
	bh=EhzWsTWACEjCUnlwxHyfabgFLKuatNS81iZvkVCsVyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 In-Reply-To:References; b=elYo9coXkeKauVObgcGoR/AtJOVzoOSEMNdQ7Dvg3ngMyEbaRx6/JbwiGlS/yQ/UXykf3uApbr6jzlBytZ4P29W+Ary/J9+2mAWGfyv8i+yuYe17sE1yhqiZi9IyoIkuU+Sbv0XrkUh4UwoOqnEpHG2JbZhrjNcnvoP6cKhAWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.181.50])
	by mail-app2 (Coremail) with SMTP id by_KCgA3L4GZpjNmnigDAg--.28S4;
	Thu, 02 May 2024 22:44:51 +0800 (CST)
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
Subject: [PATCH net 2/2] ax25: fix potential reference counting leak in ax25_addr_ax25dev
Date: Thu,  2 May 2024 22:43:38 +0800
Message-Id: <cb44ea91c0b7084079c3086d6d75e7984505cec7.1714660565.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1714660565.git.duoming@zju.edu.cn>
References: <cover.1714660565.git.duoming@zju.edu.cn>
In-Reply-To: <cover.1714660565.git.duoming@zju.edu.cn>
References: <cover.1714660565.git.duoming@zju.edu.cn>
X-CM-TRANSID:by_KCgA3L4GZpjNmnigDAg--.28S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWrAF18GFyrZw17XF45GFg_yoWDurb_uF
	97ury7Ww1DJr1UCw1rXF48Jry7Zw10gwnrJr1ayFZ7trW5ta47JrWkJw1UXr1UXa47Cr4F
	qF1rGrW3Aw4IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUblkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
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
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUwAwsUUU
	UU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIJAWYySJ0M6ABgsM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The reference counting of ax25_dev potentially increase more
than once in ax25_addr_ax25dev(), which will cause memory leak.

In order to fix the above issue, only increase the reference
counting of ax25_dev once, when the res is not null.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 07723095c60..945af92a7b6 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -37,8 +37,9 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
-			ax25_dev_hold(ax25_dev);
 		}
+	if (res)
+		ax25_dev_hold(ax25_dev);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	return res;
-- 
2.17.1


