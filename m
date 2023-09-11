Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E55A79A171
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjIKCib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjIKCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:38:30 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77399;
        Sun, 10 Sep 2023 19:38:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RkW9R5Rqsz4f3k6X;
        Mon, 11 Sep 2023 10:38:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyaff5kPj6sAA--.61661S4;
        Mon, 11 Sep 2023 10:38:20 +0800 (CST)
From:   linan666@huaweicloud.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of index
Date:   Mon, 11 Sep 2023 10:33:08 +0800
Message-Id: <20230911023308.3467802-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyaff5kPj6sAA--.61661S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47AF4fZFyrWw1fXw45GFg_yoWxJrW7pF
        s8Ca93Gr4UGFy7urWrAayDCr1rK3yxKa9rGryxJ34Syrn5C3s5CFy0ka4jyF15CrW8AFsr
        JFsYgF1rAw18A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF
        7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjxUwc_TUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
may occurs.

  T1
  nbd_ioctl
   __nbd_ioctl
    nbd_add_socket
     blk_mq_freeze_queue
				T2
  				recv_work
  				 nbd_read_reply
  				  sock_xmit
     krealloc config->socks
				   def config->socks

Pass nbd_sock to nbd_read_reply(). And introduce a new function
sock_xmit_recv(), which differs from sock_xmit only in the way it get
socket.

==================================================================
BUG: KASAN: use-after-free in sock_xmit+0x525/0x550
Read of size 8 at addr ffff8880188ec428 by task kworker/u12:1/18779

Workqueue: knbd4-recv recv_work
Call Trace:
 __dump_stack
 dump_stack+0xbe/0xfd
 print_address_description.constprop.0+0x19/0x170
 __kasan_report.cold+0x6c/0x84
 kasan_report+0x3a/0x50
 sock_xmit+0x525/0x550
 nbd_read_reply+0xfe/0x2c0
 recv_work+0x1c2/0x750
 process_one_work+0x6b6/0xf10
 worker_thread+0xdd/0xd80
 kthread+0x30a/0x410
 ret_from_fork+0x22/0x30

Allocated by task 18784:
 kasan_save_stack+0x1b/0x40
 kasan_set_track
 set_alloc_info
 __kasan_kmalloc
 __kasan_kmalloc.constprop.0+0xf0/0x130
 slab_post_alloc_hook
 slab_alloc_node
 slab_alloc
 __kmalloc_track_caller+0x157/0x550
 __do_krealloc
 krealloc+0x37/0xb0
 nbd_add_socket
 +0x2d3/0x880
 __nbd_ioctl
 nbd_ioctl+0x584/0x8e0
 __blkdev_driver_ioctl
 blkdev_ioctl+0x2a0/0x6e0
 block_ioctl+0xee/0x130
 vfs_ioctl
 __do_sys_ioctl
 __se_sys_ioctl+0x138/0x190
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Freed by task 18784:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x40
 __kasan_slab_free.part.0+0x13f/0x1b0
 slab_free_hook
 slab_free_freelist_hook
 slab_free
 kfree+0xcb/0x6c0
 krealloc+0x56/0xb0
 nbd_add_socket+0x2d3/0x880
 __nbd_ioctl
 nbd_ioctl+0x584/0x8e0
 __blkdev_driver_ioctl
 blkdev_ioctl+0x2a0/0x6e0
 block_ioctl+0xee/0x130
 vfs_ioctl
 __do_sys_ioctl
 __se_sys_ioctl+0x138/0x190
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/block/nbd.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a346dbd73543..712b2d164eed 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -67,6 +67,7 @@ struct nbd_sock {
 struct recv_thread_args {
 	struct work_struct work;
 	struct nbd_device *nbd;
+	struct nbd_sock *nsock;
 	int index;
 };
 
@@ -490,15 +491,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 	return BLK_EH_DONE;
 }
 
-/*
- *  Send or receive packet. Return a positive value on success and
- *  negtive value on failue, and never return 0.
- */
-static int sock_xmit(struct nbd_device *nbd, int index, int send,
-		     struct iov_iter *iter, int msg_flags, int *sent)
+static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
+		       struct iov_iter *iter, int msg_flags, int *sent)
 {
-	struct nbd_config *config = nbd->config;
-	struct socket *sock = config->socks[index]->sock;
 	int result;
 	struct msghdr msg;
 	unsigned int noreclaim_flag;
@@ -541,6 +536,19 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
 	return result;
 }
 
+/*
+ *  Send or receive packet. Return a positive value on success and
+ *  negtive value on failure, and never return 0.
+ */
+static int sock_xmit(struct nbd_device *nbd, int index, int send,
+		     struct iov_iter *iter, int msg_flags, int *sent)
+{
+	struct nbd_config *config = nbd->config;
+	struct socket *sock = config->socks[index]->sock;
+
+	return __sock_xmit(nbd, sock, send, iter, msg_flags, sent);
+}
+
 /*
  * Different settings for sk->sk_sndtimeo can result in different return values
  * if there is a signal pending when we enter sendmsg, because reasons?
@@ -697,7 +705,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
-static int nbd_read_reply(struct nbd_device *nbd, int index,
+static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 			  struct nbd_reply *reply)
 {
 	struct kvec iov = {.iov_base = reply, .iov_len = sizeof(*reply)};
@@ -706,7 +714,7 @@ static int nbd_read_reply(struct nbd_device *nbd, int index,
 
 	reply->magic = 0;
 	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
-	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
+	result = __sock_xmit(nbd, sock, 0, &to, MSG_WAITALL, NULL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
 			dev_err(disk_to_dev(nbd->disk),
@@ -830,14 +838,14 @@ static void recv_work(struct work_struct *work)
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
 	struct request_queue *q = nbd->disk->queue;
-	struct nbd_sock *nsock;
+	struct nbd_sock *nsock = args->nsock;
 	struct nbd_cmd *cmd;
 	struct request *rq;
 
 	while (1) {
 		struct nbd_reply reply;
 
-		if (nbd_read_reply(nbd, args->index, &reply))
+		if (nbd_read_reply(nbd, nsock->sock, &reply))
 			break;
 
 		/*
@@ -872,7 +880,6 @@ static void recv_work(struct work_struct *work)
 		percpu_ref_put(&q->q_usage_counter);
 	}
 
-	nsock = config->socks[args->index];
 	mutex_lock(&nsock->tx_lock);
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
@@ -1216,6 +1223,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		INIT_WORK(&args->work, recv_work);
 		args->index = i;
 		args->nbd = nbd;
+		args->nsock = nsock;
 		nsock->cookie++;
 		mutex_unlock(&nsock->tx_lock);
 		sockfd_put(old);
@@ -1398,6 +1406,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		refcount_inc(&nbd->config_refs);
 		INIT_WORK(&args->work, recv_work);
 		args->nbd = nbd;
+		args->nsock = config->socks[i];
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-- 
2.39.2

