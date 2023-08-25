Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C04787E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHYC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbjHYC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:59:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF32E7A;
        Thu, 24 Aug 2023 19:59:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4S124V1z4f3k5X;
        Fri, 25 Aug 2023 10:59:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kfGehkow4WBg--.35864S5;
        Fri, 25 Aug 2023 10:59:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 1/2] md: don't dereference mddev after export_rdev()
Date:   Fri, 25 Aug 2023 10:55:31 +0800
Message-Id: <20230825025532.1523008-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
References: <20230825025532.1523008-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kfGehkow4WBg--.35864S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xAry8GFy7Gw1xGry3Arb_yoW5JF1fp3
        ySkFW3Gr1qkr48ArWUW3WkW343Z3WvqrW3ArWI9F4rZa4YvrsF9r43AF1q9rZ5K3s7CFs5
        J3W8Xay3X3WrWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Except for initial reference, mddev->kobject is referenced by
rdev->kobject, and if the last rdev is freed, there is no guarantee that
mddev is still valid. Hence mddev should not be used anymore after
export_rdev().

This problem can be triggered by following test for mdadm at very
low rate:

New file: mdadm/tests/23rdev-lifetime

devname=${dev0##*/}
devt=`cat /sys/block/$devname/dev`
pid=""
runtime=2

clean_up_test() {
        pill -9 $pid
        echo clear > /sys/block/md0/md/array_state
}

trap 'clean_up_test' EXIT

add_by_sysfs() {
        while true; do
                echo $devt > /sys/block/md0/md/new_dev
        done
}

remove_by_sysfs(){
        while true; do
                echo remove > /sys/block/md0/md/dev-${devname}/state
        done
}

echo md0 > /sys/module/md_mod/parameters/new_array || die "create md0 failed"

add_by_sysfs &
pid="$pid $!"

remove_by_sysfs &
pid="$pid $!"

sleep $runtime
exit 0

Test cmd:

./test --save-logs --logdir=/tmp/ --keep-going --dev=loop --tests=23rdev-lifetime

Test result:

general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bcb: 0000 [#4] PREEMPT SMP
CPU: 0 PID: 1292 Comm: test Tainted: G      D W          6.5.0-rc2-00121-g01e55c376936 #562
RIP: 0010:md_wakeup_thread+0x9e/0x320 [md_mod]
Call Trace:
 <TASK>
 mddev_unlock+0x1b6/0x310 [md_mod]
 rdev_attr_store+0xec/0x190 [md_mod]
 sysfs_kf_write+0x52/0x70
 kernfs_fop_write_iter+0x19a/0x2a0
 vfs_write+0x3b5/0x770
 ksys_write+0x74/0x150
 __x64_sys_write+0x22/0x30
 do_syscall_64+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix this problem by don't dereference mddev after export_rdev().

Fixes: 3ce94ce5d05a ("md: fix duplicate filename for rdev")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 470986943e74..3bb0d9ce0d28 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -840,14 +840,14 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
+	md_wakeup_thread(mddev->thread);
+	wake_up(&mddev->sb_wait);
+
 	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
 		list_del_init(&rdev->same_set);
 		kobject_del(&rdev->kobj);
 		export_rdev(rdev, mddev);
 	}
-
-	md_wakeup_thread(mddev->thread);
-	wake_up(&mddev->sb_wait);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
-- 
2.39.2

