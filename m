Return-Path: <linux-kernel+bounces-16709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B398242C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3466EB21332
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8B22334;
	Thu,  4 Jan 2024 13:39:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E82232E;
	Thu,  4 Jan 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T5SNw0Sxjz4f3jM1;
	Thu,  4 Jan 2024 21:39:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5FDF91A026E;
	Thu,  4 Jan 2024 21:39:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hACtZZlhgMKFg--.12033S4;
	Thu, 04 Jan 2024 21:39:15 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	linan122@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] md: use RCU lock to protect traversal in md_spares_need_change()
Date: Thu,  4 Jan 2024 21:36:29 +0800
Message-Id: <20240104133629.1277517-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hACtZZlhgMKFg--.12033S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyxKr1DZr1DZFWfJryxXwb_yoW8JF4xpF
	s2gFy5uw48X3yrGa45uF95WF1rXw1rKFWjyF97C3y8Z3WDAr1qkry3K390qrZ5GFyIyFyj
	q3W2va1ku3W3AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1
	a9aPUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Since md_start_sync() will be called without the protect of mddev_lock,
and it can run concurrently with array reconfiguration, traversal of rdev
in it should be protected by RCU lock.
Commit bc08041b32ab ("md: suspend array in md_start_sync() if array need
reconfiguration") added md_spares_need_change() to md_start_sync(),
casusing use of rdev without any protection.
Fix this by adding RCU lock in md_spares_need_change().

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/md.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bdd57324c37..902b43b65052 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9228,9 +9228,14 @@ static bool md_spares_need_change(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 
-	rdev_for_each(rdev, mddev)
-		if (rdev_removeable(rdev) || rdev_addable(rdev))
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev) {
+		if (rdev_removeable(rdev) || rdev_addable(rdev)) {
+			rcu_read_unlock();
 			return true;
+		}
+	}
+	rcu_read_unlock();
 	return false;
 }
 
-- 
2.31.1


