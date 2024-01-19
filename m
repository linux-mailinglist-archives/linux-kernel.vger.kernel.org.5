Return-Path: <linux-kernel+bounces-31021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126978327A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950212854E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3E3C6AC;
	Fri, 19 Jan 2024 10:27:19 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE143CF58;
	Fri, 19 Jan 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660039; cv=none; b=jxZm/j8c7UqMJVy9109MUmT95l6O41LEbKSZlvWyJkVFKQvobvHjk5AU0CQI78hmGItRg8CT7c+mGtXsZIfUdehWdPsfPZI2Utp2RwW3tJ4IC/BIfcqyjI3xDmGfgX1xUNQNMaS1CcO6gBxMIfch6wUsx2gRRbPjZQERuVuGlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660039; c=relaxed/simple;
	bh=OeXYmq796cWfyhLGmSdSaW/w3qx5YzavRBqUbqVZRTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6THlX82LZ9Fv3iKToMDJClDY0qgAMM0oUNu569xif6PrFc+C5JW4tmBZ2YSzQa8oVxhJnv/O/ecyhtDmDJNCAri/GusDfSwwa7PBNBM4CTeJnGxDgN6Z8U91rYB01DUlHdGkEcRrTFRwcIbWtz2nUykOQGwOKWxwtf4JpQ5YSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TGbNZ30NDz29kXD;
	Fri, 19 Jan 2024 18:25:34 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 506EF14062E;
	Fri, 19 Jan 2024 18:27:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 18:27:12 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <brauner@kernel.org>,
	<jlayton@kernel.org>, <riel@surriel.com>, <jack@suse.cz>,
	<viro@zeniv.linux.org.uk>, <hdanton@sina.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH v3] ipc/mqueue: fix potential sleeping issue in mqueue_flush_file
Date: Fri, 19 Jan 2024 18:37:03 +0800
Message-ID: <20240119103703.2004155-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)

I analyze the potential sleeping issue of the following processes:
Thread A                                Thread B
..                                     netlink_create  //ref = 1
do_mq_notify                            ...
  sock = netlink_getsockbyfilp          ...     //ref = 2
  info->notify_sock = sock;             ...
..                                     netlink_sendmsg
..                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
..                                       netlink_unicast
..                                         sk = netlink_getsockbyportid //ref = 3
..                                         netlink_sendskb
..                                           __netlink_sendskb
..                                             skb_queue_tail //put skb to sk_receive_queue
..                                         sock_put //ref = 2
..                                     ...
..                                     netlink_release
..                                       deferred_put_nlk_sk //ref = 1
mqueue_flush_file
  spin_lock
  remove_notification
    netlink_sendskb
      sock_put  //ref = 0
        sk_free
          ...
          __sk_destruct
            netlink_sock_destruct
              skb_queue_purge  //get skb from sk_receive_queue
                ...
                __skb_queue_purge_reason
                  kfree_skb_reason
                    __kfree_skb
                    ...
                    skb_release_all
                      skb_release_head_state
                        netlink_skb_destructor
                          vfree(skb->head)  //sleeping while holding spinlock

In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
When the mqueue executes flush, the sleeping bug will occur. Put sock
after releasing the spinlock.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v3: Put sock after releasing the spinlock.
v2: CCed some networking maintainer & netdev list
---
 ipc/mqueue.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5eea4dc0509e..4832343b7049 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -664,12 +664,23 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 static int mqueue_flush_file(struct file *filp, fl_owner_t id)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
+	struct sock *sk = NULL;
 
 	spin_lock(&info->lock);
-	if (task_tgid(current) == info->notify_owner)
-		remove_notification(info);
+	if (task_tgid(current) == info->notify_owner) {
+		if (info->notify_owner != NULL &&
+		    info->notify.sigev_notify == SIGEV_THREAD) {
+			sk = info->notify_sock;
+			sock_hold(sk);
+		}
 
+		remove_notification(info);
+	}
 	spin_unlock(&info->lock);
+
+	if (sk)
+		sock_put(sk);
+
 	return 0;
 }
 
-- 
2.34.1


