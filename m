Return-Path: <linux-kernel+bounces-164962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BAB8B857E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36012815E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA614CB28;
	Wed,  1 May 2024 06:03:00 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F24AEF0;
	Wed,  1 May 2024 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543380; cv=none; b=awL1VTOOi+g/aRKjXjbVMUNzQC3q263O1OjEEzi4BdxQs0IXcUJR312OXtl2UDR2Neq6pCPS5cldVlle3Ydz1qSYzImZdkeOkLKQRDyX1mhFLPN+aamp35Whw+fv15cVR2Lla9e6MTJpBUevl+8Xtix0AhJ1wiJBUQy53DcOx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543380; c=relaxed/simple;
	bh=NsSHWAOnJLPmfESyYmOLz4+6u3ckmWGYVWl6cypFpRA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LU44NqzI+swHCwq+KsEvEoIgLSdbplx7CUlgSi9uESLH3V7EAAWXkKfyX8UJbjsMoztSwkUwXKWzJwh9qPQt01QdamngFzc4lEa6hcFYRSjkw9zFmo8W8MNtmo0PIfQi4FqjBy/crqQvVS0q01hFqTgXLFs97PNnydEz+qK+7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.181.32])
	by mail-app3 (Coremail) with SMTP id cC_KCgAHK+7w2jFmSZ6tAQ--.16749S2;
	Wed, 01 May 2024 14:02:27 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	dan.carpenter@linaro.org,
	lars@oddbit.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Date: Wed,  1 May 2024 14:02:18 +0800
Message-Id: <20240501060218.32898-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgAHK+7w2jFmSZ6tAQ--.16749S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWfGF45AFWfCFyDJw47urg_yoW5Ww1rpF
	WY9F45Ar97Jr1xJr4DG34xWr1UZryjqw4kAry5ZF1Ikw13X3s8Jr18KryUJryUJrWfJF18
	Xw1DWr4DZF4kuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjmiiDUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUHAWYw9x0FNgA7s0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There are two scenarios that might cause refcount leak
issues of ax25_dev.

Scenario one:

The refcount of ax25_dev potentially increase more
than once in ax25_addr_ax25dev(), which will cause
memory leak.

In order to fix the above issue, only increase the
refcount of ax25_dev once, when the res is not null.

Scenario two:

The original code sets the refcount of ax25_dev to 1
in the initial stage and then increase the refcount
when the ax25_dev is added to the ax25_dev_list. As a
result, the refcount of ax25_dev is 2. But when the
device is shutting down. The ax25_dev_device_down()
drops the refcount once or twice depending on if we
goto unlock_put or not, which will cause memory leak.

In order to mitigate the above issues, only increase
the refcount of ax25_dev when the ax25_dev is added
to the ax25_dev_list and decrease the refcount of
ax25_dev after it is removed from the ax25_dev_list.

What's more, the ax25_dev should not be deallocated
directly by kfree() in ax25_dev_free(), replace it
with ax25_dev_put() instead.

Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_dev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 282ec581c07..0e6dd98d3fa 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -37,8 +37,9 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
-			ax25_dev_hold(ax25_dev);
 		}
+	if (res)
+		ax25_dev_hold(res);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	return res;
@@ -58,7 +59,6 @@ void ax25_dev_device_up(struct net_device *dev)
 		return;
 	}
 
-	refcount_set(&ax25_dev->refcount, 1);
 	dev->ax25_ptr     = ax25_dev;
 	ax25_dev->dev     = dev;
 	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
@@ -88,7 +88,7 @@ void ax25_dev_device_up(struct net_device *dev)
 	ax25_dev->next = ax25_dev_list;
 	ax25_dev_list  = ax25_dev;
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_hold(ax25_dev);
+	refcount_set(&ax25_dev->refcount, 1);
 
 	ax25_register_dev_sysctl(ax25_dev);
 }
@@ -135,7 +135,6 @@ void ax25_dev_device_down(struct net_device *dev)
 
 unlock_put:
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_put(ax25_dev);
 	dev->ax25_ptr = NULL;
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
@@ -208,7 +207,7 @@ void __exit ax25_dev_free(void)
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


