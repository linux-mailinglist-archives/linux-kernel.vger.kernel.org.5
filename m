Return-Path: <linux-kernel+bounces-43818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B990484192F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B570B24B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2F15AABD;
	Tue, 30 Jan 2024 02:23:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501A53E3B;
	Tue, 30 Jan 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706581394; cv=none; b=e28vdG5VK5NTzg4wYD4v6qpm5bHwoRO4rVRlSlAcXlchQjEygwx65YyC6I2D16rkGDIj1vwK+/s6OM4F9iwfIFuPph5Xg1vW4oZ9kJVTWI2x9xXmI7oZuz3puKHy7ahQVt4df6Ra2iQ9S8FMyq0GWMrrtMMVI7YXd1ewjrSlEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706581394; c=relaxed/simple;
	bh=BcYpGvuVymYjsYzO5oAZoUEk24DPF79BmnHTgMndg6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2SvmRzwslc2ZboWsx7VFY9MRtvzrMlEKsnGSZoZGaHqrZatDyBzKv/r7D6HVi4cdwR4wUQIzhyrclUZQ60c3bNrVGnzOcUR5fibwYfR5/9Xi/NNJXPOBY7Uu7sQiRVntm/ia94gSDbZPwraNXapFZPb54t1mZpmFPxVygrX9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TP88q1CxKz4f3kKY;
	Tue, 30 Jan 2024 10:23:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AB8691A0232;
	Tue, 30 Jan 2024 10:23:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBGBXbhlrAigCQ--.55484S17;
	Tue, 30 Jan 2024 10:23:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: mpatocka@redhat.com,
	heinzm@redhat.com,
	xni@redhat.com,
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
Subject: [PATCH RFC v4 13/14] dm: wait for IO completion before removing dm device
Date: Tue, 30 Jan 2024 10:18:42 +0800
Message-Id: <20240130021843.3608859-14-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBGBXbhlrAigCQ--.55484S17
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy3tr1rGFWxAw4UGw1rZwb_yoW8Gw4xpF
	4aqay5KrW5XrWjkw4Ut3yUCF1FyFs3K3yxCrW29w1fu3W5Gr9xXF48tFW3JrWUAFy5Arsx
	ZF4Ut3s8Gw48JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

__dm_destroy() guarantee that device openers is zero, and then
only call 'presuspend' and 'postsuspend' for the target. For
request-based dm, 'md->holders' will be grabbed for each rq and
__dm_destroy() will wait for 'md->holders' to be zero. However, for
bio-based device, __dm_destroy() doesn't wait for all bios to be done.

Fix this problem by calling dm_wait_for_completion() to wail for all
inflight IO to be done, like what dm_suspend() does.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8dcabf84d866..2c0eae67d0f1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -58,6 +58,7 @@ static DEFINE_IDR(_minor_idr);
 static DEFINE_SPINLOCK(_minor_lock);
 
 static void do_deferred_remove(struct work_struct *w);
+static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_state);
 
 static DECLARE_WORK(deferred_remove_work, do_deferred_remove);
 
@@ -2495,6 +2496,8 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 	if (!dm_suspended_md(md)) {
 		dm_table_presuspend_targets(map);
 		set_bit(DMF_SUSPENDED, &md->flags);
+		if (wait)
+			dm_wait_for_completion(md, TASK_UNINTERRUPTIBLE);
 		set_bit(DMF_POST_SUSPENDING, &md->flags);
 		dm_table_postsuspend_targets(map);
 	}
-- 
2.39.2


