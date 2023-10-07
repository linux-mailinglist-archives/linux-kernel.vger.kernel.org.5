Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888F27BC674
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbjJGJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJGJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:35:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097FB9;
        Sat,  7 Oct 2023 02:35:30 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S2g6G0vgMzRhlv;
        Sat,  7 Oct 2023 17:31:34 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 17:35:27 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: Fix UAF for hci_chan
Date:   Sat, 7 Oct 2023 17:35:21 +0800
Message-ID: <20231007093521.2404844-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports a UAF problem as follows:

BUG: KASAN: slab-use-after-free in hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
 l2cap_send_conn_req net/bluetooth/l2cap_core.c:1286 [inline]
 l2cap_start_connection+0x465/0x620 net/bluetooth/l2cap_core.c:1514
 l2cap_conn_start+0xbf3/0x1130 net/bluetooth/l2cap_core.c:1661
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 27110:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hci_chan_create+0xc8/0x300 net/bluetooth/hci_conn.c:2714
 l2cap_conn_add+0x69/0xc10 net/bluetooth/l2cap_core.c:7841
 l2cap_chan_connect+0x61f/0xeb0 net/bluetooth/l2cap_core.c:8053
 bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
 lowpan_control_write+0x55e/0x850 net/bluetooth/6lowpan.c:1129
 full_proxy_write+0x113/0x1c0 fs/debugfs/file.c:236
 vfs_write+0x286/0xaf0 fs/read_write.c:582
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5067:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 hci_chan_list_flush net/bluetooth/hci_conn.c:2754 [inline]
 hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
 hci_conn_del+0x4f8/0xc40 net/bluetooth/hci_conn.c:1156
 hci_abort_conn_sync+0xa45/0xfe0
 hci_cmd_sync_work+0x228/0x400 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

There are two main reasons for this:
1. In the case of hci_conn_add() concurrency, the handle of
hci_conn allocated through hci_conn_hash_alloc_unset() is not unique.
2. The processes related to hci_abort_conn() and hci_connect_xxx()
can be concurrent, but the two processes lack synchronization.

To fix this, use ida to manage the allocation of conn->handle, and
add the HCI_CONN_DISC flag to achieve synchronization between
hci_abort_conn() and hci_connect_xxx() related processes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 include/net/bluetooth/hci_core.h | 17 ++++++++++----
 net/bluetooth/hci_conn.c         | 39 ++++++++++++++++----------------
 net/bluetooth/hci_core.c         |  3 +++
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e6359f7346f1..72818fc49ccd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -350,6 +350,8 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
+	struct ida	unset_handle_ida;
+
 	char		name[8];
 	unsigned long	flags;
 	__u16		id;
@@ -969,6 +971,7 @@ enum {
 	HCI_CONN_AUTH_INITIATOR,
 	HCI_CONN_DROP,
 	HCI_CONN_CANCEL,
+	HCI_CONN_DISC,
 	HCI_CONN_PARAM_REMOVAL_PEND,
 	HCI_CONN_NEW_LINK_KEY,
 	HCI_CONN_SCANNING,
@@ -1174,7 +1177,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type == type && !bacmp(&c->dst, ba)) {
+		if (c->type == type && !bacmp(&c->dst, ba) &&
+		    !test_bit(HCI_CONN_DISC, &c->flags)) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1195,8 +1199,9 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != LE_LINK)
-		       continue;
+		if (c->type != LE_LINK ||
+		    test_bit(HCI_CONN_DISC, &c->flags))
+			continue;
 
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
@@ -1386,7 +1391,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 
 	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type == LE_LINK && c->state == BT_CONNECT &&
-		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
+		    !test_bit(HCI_CONN_SCANNING, &c->flags) &&
+		    !test_bit(HCI_CONN_DISC, &c->flags)) {
 			rcu_read_unlock();
 			return c;
 		}
@@ -1520,7 +1526,8 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
-	if (atomic_dec_and_test(&conn->refcnt)) {
+	if (atomic_dec_and_test(&conn->refcnt) &&
+	    !test_bit(HCI_CONN_DISC, &conn->flags)) {
 		unsigned long timeo;
 
 		switch (conn->type) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..6045d32e28d3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 	hci_conn_hash_del(hdev, conn);
 
+	if (HCI_CONN_HANDLE_UNSET(conn->handle))
+		ida_free(&hdev->unset_handle_ida, conn->handle);
+
 	if (conn->cleanup)
 		conn->cleanup(conn);
 
@@ -928,29 +931,17 @@ static void cis_cleanup(struct hci_conn *conn)
 	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
 }
 
-static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
+static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
 {
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-	u16 handle = HCI_CONN_HANDLE_MAX + 1;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		/* Find the first unused handle */
-		if (handle == 0xffff || c->handle != handle)
-			break;
-		handle++;
-	}
-	rcu_read_unlock();
-
-	return handle;
+	return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1,
+			       U16_MAX, GFP_ATOMIC);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role)
 {
 	struct hci_conn *conn;
+	int handle;
 
 	BT_DBG("%s dst %pMR", hdev->name, dst);
 
@@ -960,7 +951,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
-	conn->handle = hci_conn_hash_alloc_unset(hdev);
+	handle = hci_conn_hash_alloc_unset(hdev);
+	if (unlikely(handle < 0)) {
+		kfree(conn);
+		return NULL;
+	}
+	conn->handle = handle;
 	conn->hdev  = hdev;
 	conn->type  = type;
 	conn->role  = role;
@@ -2897,6 +2893,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int ret;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -2925,6 +2922,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		}
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle),
-				  NULL);
+	ret = hci_cmd_sync_queue(hdev, abort_conn_sync,
+				 UINT_PTR(conn->handle), NULL);
+	if (!ret)
+		set_bit(HCI_CONN_DISC, &conn->flags);
+
+	return ret;
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a5992f1b3c9b..67b652c18a44 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2535,6 +2535,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
+	ida_init(&hdev->unset_handle_ida);
+
 	INIT_LIST_HEAD(&hdev->mesh_pending);
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->reject_list);
@@ -2786,6 +2788,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
+	ida_destroy(&hdev->unset_handle_ida);
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
 	kfree_skb(hdev->recv_event);
-- 
2.25.1

