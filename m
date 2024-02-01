Return-Path: <linux-kernel+bounces-47868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E768453F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938A21F28E23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FF15D5B8;
	Thu,  1 Feb 2024 09:30:34 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A215B975;
	Thu,  1 Feb 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779833; cv=none; b=HaVF47Yr/yGFfsyddbtBrP+ICCTmu+ZymH4hmgxlPLBf1AjHiJuClyb3OtuyjskWPkex+gUZps/PcrKvmiVNKGEZxSMtd61Cq+HQgb91IM7XStMbWRxIEguydEEhmYZKzWctpTYegx2hGFn8z/2mz3iyn2VDySvqewEteGs0gd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779833; c=relaxed/simple;
	bh=W6rufQZZ+hnLEGX0/LnkFyb5yoGyGO/17y5HhbzHXQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5JEHjW3OyqPkLvxLRFnJFCl4I71n/NwsadaZeZjUwqnapD4uN41gQkEe+5Tcj74doe3tXZVnoIzmmizwLWNBZIDXrvGH6icTI1PlbIAHrTSPFyPHesOoWocGsPvoTHDr4oGsAjZ+AhA2Dp1Ap9FFrbkm5/ghQ3GkP8fK1wbXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQYXw3LNSz4f3l6h;
	Thu,  1 Feb 2024 17:30:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A6FFF1A0199;
	Thu,  1 Feb 2024 17:30:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBGtZLtl8V6KCg--.33515S9;
	Thu, 01 Feb 2024 17:30:28 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
	blazej.kucman@linux.intel.com,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	jbrassow@f14.redhat.com,
	neilb@suse.de,
	shli@fb.com,
	akpm@osdl.org
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 05/14] md: don't suspend the array for interrupted reshape
Date: Thu,  1 Feb 2024 17:25:50 +0800
Message-Id: <20240201092559.910982-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201092559.910982-1-yukuai1@huaweicloud.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBGtZLtl8V6KCg--.33515S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fuFy3ZFWkArykCr17Jrb_yoW8ur13p3
	y3tF1ayrs8X39ava1UG3s2gFyYk3s5trWYy3srJ34UAw13Gr1fGr43Gr4qvFyY9ry3trs0
	qr1Yq34rGF1qkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

md_start_sync() will suspend the array if there are spares that can be
added or removed from conf, however, if reshape is still in progress,
this won't happen at all or data will be corrupted(remove_and_add_spares
won't be called from md_choose_sync_action for reshape), hence there is
no need to suspend the array if reshape is not done yet.

Meanwhile, there is a potential deadlock for raid456:

1) reshape is interrupted;

2) set one of the disk WantReplacement, and add a new disk to the array,
   however, recovery won't start until the reshape is finished;

3) then issue an IO across reshpae position, this IO will wait for
   reshape to make progress;

4) continue to reshape, then md_start_sync() found there is a spare disk
   that can be added to conf, mddev_suspend() is called;

Step 4 and step 3 is waiting for each other, deadlock triggered. Noted
this problem is found by code review, and it's not reporduced yet.

Fix this porblem by don't suspend the array for interrupted reshape,
this is safe because conf won't be changed until reshape is done.

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6c5d0a372927..85fde05c37dd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9374,12 +9374,17 @@ static void md_start_sync(struct work_struct *ws)
 	bool suspend = false;
 	char *name;
 
-	if (md_spares_need_change(mddev))
+	/*
+	 * If reshape is still in progress, spares won't be added or removed
+	 * from conf until reshape is done.
+	 */
+	if (mddev->reshape_position == MaxSector &&
+	    md_spares_need_change(mddev)) {
 		suspend = true;
+		mddev_suspend(mddev, false);
+	}
 
-	suspend ? mddev_suspend_and_lock_nointr(mddev) :
-		  mddev_lock_nointr(mddev);
-
+	mddev_lock_nointr(mddev);
 	if (!md_is_rdwr(mddev)) {
 		/*
 		 * On a read-only array we can:
-- 
2.39.2


