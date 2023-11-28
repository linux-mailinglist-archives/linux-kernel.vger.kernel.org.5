Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141777FC8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376417AbjK1VM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346629AbjK1VMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:12:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443DB324F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF30C4339A;
        Tue, 28 Nov 2023 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205641;
        bh=x93Vc72QtVUoqgo7/cpKmUlDWDY2kNkYjpMJ7LrUzhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2wxUa8H2o1chH+oC9JP5FqeYCE5ENIG2n9fCu6T4fRQOISylFY8ldyFiP73SbqI8
         9xtazBVoP7YCnjB8AXVicSsNiy5OUZz/+S4WL7XQH3KqZUvbkL10YdsgS+NbUf/11J
         ZdfGuP//vmi+RBwsuGJ/F8+YVq/8ZHpYbrZzg//7RmQj2V/ntkk6huMf+nCk6rAfqm
         2f433WpmPxhZO8tlY93Xx1IEGdSA5U5mm40y1Sd2PiWnwfUkc+RtXLHJLL3q0c8o5b
         0XQcWDqb/ssFofQJ7yWIcbwmzZpX8PmktX4mw6dade1paStoZitO4BDktXH/LR92W7
         7uScRC3lxqE8Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Nan <linan122@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 29/40] nbd: pass nbd_sock to nbd_read_reply() instead of index
Date:   Tue, 28 Nov 2023 16:05:35 -0500
Message-ID: <20231128210615.875085-29-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit 98c598afc22d4e43c2ad91860b65996d0c099a5d ]

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
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230911023308.3467802-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3f03cb3dc33cc..b6414e1e645b7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -67,6 +67,7 @@ struct nbd_sock {
 struct recv_thread_args {
 	struct work_struct work;
 	struct nbd_device *nbd;
+	struct nbd_sock *nsock;
 	int index;
 };
 
@@ -505,15 +506,9 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
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
@@ -556,6 +551,19 @@ static int sock_xmit(struct nbd_device *nbd, int index, int send,
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
@@ -712,7 +720,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
-static int nbd_read_reply(struct nbd_device *nbd, int index,
+static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 			  struct nbd_reply *reply)
 {
 	struct kvec iov = {.iov_base = reply, .iov_len = sizeof(*reply)};
@@ -721,7 +729,7 @@ static int nbd_read_reply(struct nbd_device *nbd, int index,
 
 	reply->magic = 0;
 	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
-	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
+	result = __sock_xmit(nbd, sock, 0, &to, MSG_WAITALL, NULL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
 			dev_err(disk_to_dev(nbd->disk),
@@ -845,14 +853,14 @@ static void recv_work(struct work_struct *work)
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
@@ -887,7 +895,6 @@ static void recv_work(struct work_struct *work)
 		percpu_ref_put(&q->q_usage_counter);
 	}
 
-	nsock = config->socks[args->index];
 	mutex_lock(&nsock->tx_lock);
 	nbd_mark_nsock_dead(nbd, nsock, 1);
 	mutex_unlock(&nsock->tx_lock);
@@ -1231,6 +1238,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		INIT_WORK(&args->work, recv_work);
 		args->index = i;
 		args->nbd = nbd;
+		args->nsock = nsock;
 		nsock->cookie++;
 		mutex_unlock(&nsock->tx_lock);
 		sockfd_put(old);
@@ -1413,6 +1421,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		refcount_inc(&nbd->config_refs);
 		INIT_WORK(&args->work, recv_work);
 		args->nbd = nbd;
+		args->nsock = config->socks[i];
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-- 
2.42.0

