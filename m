Return-Path: <linux-kernel+bounces-30096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0583192D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D222B24FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913E2421D;
	Thu, 18 Jan 2024 12:33:41 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652A33FA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581220; cv=none; b=B7/KbdlfOJLBvN6cxZNEnT06nWTzpjZdh37XL61pO0XrCFj2ozdGNNN7xAo9e94OSzUiFkCZ6IkK5uNX8CVpql0NR5DqrlZzvMXOg+K+BueL0mVWB0ubnvXvJetLMVyLt6PuFrrg+w8uVGI8M2mTbvw+4MYu9XQHJnHhOfu+ges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581220; c=relaxed/simple;
	bh=bXRtTkMsQOcByH1DqJEtaBQEU/8SZM69SRf+aMse1Nw=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=h7hRJrr2H3ASWY/ZgWV/faH1WLe2rzIly0uSPuGamFXT8xMfrEFn8WYpJh3GakZKng5LMM5jx0NyOH/0JZLXz97XDv37QF8FyCIGwcniPqkBnBUOt3qudWu3sL7MZGCHutWJIL9xgy6E/3jtqQ+B6rouuswW//YiQudRLsm0tKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TG2Gc3jkKz4f3kFh
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:33:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49E9B1A016E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:33:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnLW+aGqllR6blBA--.39914S2;
	Thu, 18 Jan 2024 20:33:32 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] writeback: avoid to move skipped wb in offline_cgwbs list
Date: Fri, 19 Jan 2024 04:31:19 +0800
Message-Id: <20240118203119.764016-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnLW+aGqllR6blBA--.39914S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xCF18Wr17CrW3GF48JFb_yoWDtFX_ua
	9Yvr1UGrnxursY9Fya9a4UXrZYkw4kCr17WF40y347A3yUAr4DuFWkJFn7Xry8XFWagrWf
	WrZIvw45Gr1q9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

There is no need to move skipped wb to local list. Only move wb which is
going to be cleanup to avoid unnecessary work.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/backing-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 039dc74b505a..681548f848c5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -773,8 +773,6 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
 	while (!list_empty(&offline_cgwbs)) {
 		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
 				      offline_node);
-		list_move(&wb->offline_node, &processed);
-
 		/*
 		 * If wb is dirty, cleaning up the writeback by switching
 		 * attached inodes will result in an effective removal of any
@@ -790,6 +788,8 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
 		if (!wb_tryget(wb))
 			continue;
 
+		list_move(&wb->offline_node, &processed);
+
 		spin_unlock_irq(&cgwb_lock);
 		while (cleanup_offline_cgwb(wb))
 			cond_resched();
-- 
2.30.0


