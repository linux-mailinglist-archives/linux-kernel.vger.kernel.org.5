Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B08798BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbjIHSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjIHSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:01:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C952125;
        Fri,  8 Sep 2023 11:01:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59930C433CC;
        Fri,  8 Sep 2023 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196078;
        bh=jFszu+GdYVWhOXqtYg5GeDOnqj7QIpD2eZMemC9VqFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/TqLOy7Vicx8nBtMJFWlP83jmIlg73TLP8o+++lV1apjJp2Ea190yz/AFrZtY6rz
         S5Ihyewa7jjSPMuBjfSV+NdhySpVQYw6CTex021JcdavtsFf73lLhEi5pCtZsrh0Pn
         e5SU8Q3CfI8lz5WX2/LxiDJGwtwTp2CWpciPaw6LbKkCoLAYmXgwwWK9uF7+wgiP3x
         /3dYSapluSaWvYMHSGcUW9usKbKGhM3stY3V4kVhpOnbrkAikQnR/+xPKXOcHgS6tC
         7yBcphQdQNYUKo+zAkLSNLTG/gObjvdES5KqOyNpBfq1Jjf1MnvzgX/f3KW8ao26oq
         DcEXeJXUJLiXA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 03/13] rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()
Date:   Fri,  8 Sep 2023 14:00:49 -0400
Message-Id: <20230908180100.3458151-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180100.3458151-1-sashal@kernel.org>
References: <20230908180100.3458151-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit e60c122a1614b4f65b29a7bef9d83b9fd30e937a ]

The rcuscale.holdoff module parameter can be used to delay the start
of rcu_scale_writer() kthread.  However, the hung-task timeout will
trigger when the timeout specified by rcuscale.holdoff is greater than
hung_task_timeout_secs:

runqemu kvm nographic slirp qemuparams="-smp 4 -m 2048M"
bootparams="rcuscale.shutdown=0 rcuscale.holdoff=300"

[  247.071753] INFO: task rcu_scale_write:59 blocked for more than 122 seconds.
[  247.072529]       Not tainted 6.4.0-rc1-00134-gb9ed6de8d4ff #7
[  247.073400] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.074331] task:rcu_scale_write state:D stack:30144 pid:59    ppid:2      flags:0x00004000
[  247.075346] Call Trace:
[  247.075660]  <TASK>
[  247.075965]  __schedule+0x635/0x1280
[  247.076448]  ? __pfx___schedule+0x10/0x10
[  247.076967]  ? schedule_timeout+0x2dc/0x4d0
[  247.077471]  ? __pfx_lock_release+0x10/0x10
[  247.078018]  ? enqueue_timer+0xe2/0x220
[  247.078522]  schedule+0x84/0x120
[  247.078957]  schedule_timeout+0x2e1/0x4d0
[  247.079447]  ? __pfx_schedule_timeout+0x10/0x10
[  247.080032]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.080591]  ? __pfx_process_timeout+0x10/0x10
[  247.081163]  ? __pfx_sched_set_fifo_low+0x10/0x10
[  247.081760]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.082287]  rcu_scale_writer+0x6b1/0x7f0
[  247.082773]  ? mark_held_locks+0x29/0xa0
[  247.083252]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.083865]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.084412]  kthread+0x179/0x1c0
[  247.084759]  ? __pfx_kthread+0x10/0x10
[  247.085098]  ret_from_fork+0x2c/0x50
[  247.085433]  </TASK>

This commit therefore replaces schedule_timeout_uninterruptible() with
schedule_timeout_idle().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d1221731c7cfd..35aab6cbba583 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -424,7 +424,7 @@ rcu_scale_writer(void *arg)
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
+		schedule_timeout_idle(holdoff * HZ);
 
 	/*
 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
-- 
2.40.1

