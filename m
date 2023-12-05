Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC380554B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjLEM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjLEM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:57:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A4A0;
        Tue,  5 Dec 2023 04:57:48 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sl0tr1Plpz4f3lCn;
        Tue,  5 Dec 2023 20:57:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id DCA8D1A0B90;
        Tue,  5 Dec 2023 20:57:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA5HHm9l7uI9Cw--.19151S4;
        Tue, 05 Dec 2023 20:57:44 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     josef@toxicpanda.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng@huaweicloud.com, lilingfeng3@huawei.com
Subject: [PATCH -next v2] nbd: get config_lock before sock_shutdown
Date:   Tue,  5 Dec 2023 20:56:41 +0800
Message-Id: <20231205125641.1913393-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA5HHm9l7uI9Cw--.19151S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3XF15CrWDZF4rtr48Xrb_yoW5Xw4rpF
        43CFs8Gr45X3WSga9xJ34xWry5G3saga17Gry7u3WSvrZ7CrWxurn5KFy3Cr1DJr9xXF45
        XFyFgFnYya98JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267
        AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyU
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUkrcfUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

Config->socks in sock_shutdown may trigger a UAF problem.
The reason is that sock_shutdown does not hold the config_lock,
so that nbd_ioctl can release config->socks at this time.

T0: NBD_DO_IT
T1: NBD_SET_SOCK

T0						T1

nbd_ioctl
  mutex_lock(&nbd->config_lock)
  // get lock
  __nbd_ioctl
	nbd_start_device_ioctl
	  nbd_start_device
	  mutex_unlock(&nbd->config_lock)
	  // relase lock
	  wait_event_interruptible
	  (kill, enter sock_shutdown)
	  sock_shutdown
					nbd_ioctl
					  mutex_lock(&nbd->config_lock)
					  // get lock
					  __nbd_ioctl
					    nbd_add_socket
					      krealloc
						kfree(p)
					        //config->socks is NULL
	    nbd_sock *nsock = config->socks // error

Fix it by moving config_lock up before sock_shutdown.

Link: https://lore.kernel.org/all/ab998dda-80ba-7d8b-0cae-36665826deb5@huaweicloud.com/
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
v1->v2:
  Make comment more detailed.

 drivers/block/nbd.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 855fdf5c3b4e..7a044b4726b4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -92,6 +92,11 @@ struct nbd_config {
 	unsigned long runtime_flags;
 	u64 dead_conn_timeout;
 
+	/*
+	 * Anyone who tries to get config->socks needs to be
+	 * protected by config_lock since it may be released
+	 * by krealloc in nbd_add_socket.
+	 */
 	struct nbd_sock **socks;
 	int num_connections;
 	atomic_t live_connections;
@@ -876,6 +881,10 @@ static void recv_work(struct work_struct *work)
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
 
+	/*
+	 * recv_work will not get config_lock here if recv_workq is flushed
+	 * in ioctl since nbd_open is holding config_refs.
+	 */
 	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
@@ -1417,13 +1426,21 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
+
+	/*
+	 * Get config_lock before sock_shutdown to prevent UAF since nbd_add_socket
+	 * may release config->socks concurrently.
+	 *
+	 * config_lock can be got before flush_workqueue since recv_work will not
+	 * get it in the current scenario.
+	 */
+	mutex_lock(&nbd->config_lock);
 	if (ret) {
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 	}
 
 	flush_workqueue(nbd->recv_workq);
-	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
-- 
2.39.2

