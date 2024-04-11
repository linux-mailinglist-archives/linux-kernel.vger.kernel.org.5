Return-Path: <linux-kernel+bounces-139712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC228A06C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B911F21EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1EB13BC2B;
	Thu, 11 Apr 2024 03:32:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F423BF;
	Thu, 11 Apr 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806343; cv=none; b=tLjOahEzabtFVA/ki2fDsFhFwc/aBUhqtUJkWBDA/ivEVqUIphvqp6IEgGJ+GTbRKSFuXi2VuvUS651PaNtv1+kp+75VW2/wzvcgrCyv1az1uawNPVa3TicUkKJ7oMuD3xd7KeAXk+qOyCC+KlsiyP9czUDpKRth/YRk9MbGgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806343; c=relaxed/simple;
	bh=LJnrSC3jza6cxko7UQdq3ELr9otaVsouVRjamnWwlCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaPpWZ5dUds8NdXxOExStd36EBYBLd0c61JL4aIGkE/kJcicqvb41ifG61Y2xWh3w7QufIcnusjXB0bGLNDma7qWXadqOOWmK9wlw5VOak5tA5NGSxG4iP4mDn7lMYPpaF4smNO7fy93y2a4sykYutzYbW0Mtkt4U99py7k+J4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFQHH6nwJz4f3jpk;
	Thu, 11 Apr 2024 11:32:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 601331A016E;
	Thu, 11 Apr 2024 11:32:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6+WRdmbRutJg--.8020S5;
	Thu, 11 Apr 2024 11:32:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	johannes.thumshirn@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next 1/2] block: fix that blk_time_get_ns() doesn't update time after schedule
Date: Thu, 11 Apr 2024 11:23:48 +0800
Message-Id: <20240411032349.3051233-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6+WRdmbRutJg--.8020S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy7Ary5KFW5Cw4fXw1rtFb_yoW5JF17pF
	WYgFyYgw4ktrZ2qa13CrsxXFyfKrWUJayUW3s8Ca1akan0gr1xJw1vkryfWrWUAFZ5Ar4a
	gFySgFZ3Ja45u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

While monitoring the throttle time of IO from iocost, it's found that
such time is always zero after the io_schedule() from ioc_rqos_throttle,
for example, with the following debug patch:

+       printk("%s-%d: %s enter %llu\n", current->comm, current->pid, __func__, blk_time_get_ns());
        while (true) {
                set_current_state(TASK_UNINTERRUPTIBLE);
                if (wait.committed)
                        break;
                io_schedule();
        }
+       printk("%s-%d: %s exit  %llu\n", current->comm, current->pid, __func__, blk_time_get_ns());

It can be observerd that blk_time_get_ns() always return the same time:

[ 1068.096579] fio-1268: ioc_rqos_throttle enter 1067901962288
[ 1068.272587] fio-1268: ioc_rqos_throttle exit  1067901962288
[ 1068.274389] fio-1268: ioc_rqos_throttle enter 1067901962288
[ 1068.472690] fio-1268: ioc_rqos_throttle exit  1067901962288
[ 1068.474485] fio-1268: ioc_rqos_throttle enter 1067901962288
[ 1068.672656] fio-1268: ioc_rqos_throttle exit  1067901962288
[ 1068.674451] fio-1268: ioc_rqos_throttle enter 1067901962288
[ 1068.872655] fio-1268: ioc_rqos_throttle exit  1067901962288

And I think the root cause is that 'PF_BLOCK_TS' is always cleared
by blk_flush_plug() before scheduel(), hence blk_plug_invalidate_ts()
will never be called:

blk_time_get_ns
 plug->cur_ktime = ktime_get_ns();
 current->flags |= PF_BLOCK_TS;

io_schedule:
 io_schedule_prepare
  blk_flush_plug
   __blk_flush_plug
    /* the flag is cleared, while time is not */
    current->flags &= ~PF_BLOCK_TS;
 schedule
 sched_update_worker
  /* the flag is not set, hence plug->cur_ktime is not cleared */
  if (tsk->flags & PF_BLOCK_TS)
   blk_plug_invalidate_ts()

blk_time_get_ns
 /* got the time stashed before schedule */
 return plug->cur_ktime;

Fix the problem by clearing cached time in __blk_flush_plug().

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..e317d7bc0696 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1195,6 +1195,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
 
+	plug->cur_ktime = 0;
 	current->flags &= ~PF_BLOCK_TS;
 }
 
-- 
2.39.2


