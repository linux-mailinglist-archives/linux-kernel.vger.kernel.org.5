Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8680C52E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjLKJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjLKJsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:48:55 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC4D7;
        Mon, 11 Dec 2023 01:49:00 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB5Eh5v030119;
        Mon, 11 Dec 2023 01:48:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=PoiiWUzRFeTheOdRjkrDEE8JNrQqQk/GgJ9siaFpBAU=; b=
        eDWpKhKefghm9RTliDC4eJNHjb3aF2Lhv286zyaI0uUgc+dXWzis3f+vqmL71o2H
        LKJ26zOnT1zGXduqBKfUuAJbLY3PvfB/EtOPbx8mMrygysTWwiLu+4Qn8mQP1tQg
        e2xA2ODi1cUG4vJRdbWSwUjDcIihUGDCyUpSrnPXxdnMnqifnrljGxqpk0jnG15h
        U3AYxt6UI2y9NbMxO6rlJm96s3/PJSw4gcvQ7YuzT7BGFmPAPcYP3brJiXg8eYb5
        z50SSoRSDaGQnm17ArbCZQfF0ZBxg+AQBXIeCq6GqR1iPeWBl2mipQ08q5TCwfLD
        Wu304vH33JT1KVC2Wp/h5A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uvmd49bg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Dec 2023 01:48:43 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 01:48:47 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 01:48:45 -0800
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mani@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] radix-tree: fix memory leak in radix_tree_insert
Date:   Mon, 11 Dec 2023 17:48:39 +0800
Message-ID: <20231211094840.642118-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
References: <000000000000bfba3a060bf4ffcf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pNPi7wZfZzeAjCWv6vYlAjJ8orPVZAcd
X-Proofpoint-ORIG-GUID: pNPi7wZfZzeAjCWv6vYlAjJ8orPVZAcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=900 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110079
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Syz report]
BUG: memory leak
unreferenced object 0xffff88810bbf56d8 (size 576):
  comm "syz-executor250", pid 5051, jiffies 4294951219 (age 12.920s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    f0 a9 2d 0c 81 88 ff ff f0 56 bf 0b 81 88 ff ff  ..-......V......
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:624 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:712
    [<ffffffff84ae105d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae105d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae26f6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32d2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c32>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c32>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d7b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

[Analysis]
When creating child nodes, if not all child nodes used to store indexes are created,
so the child nodes created before the failure should be released.

Reported-and-tested-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 lib/radix-tree.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index a89df8afa510..c5caf5b7523a 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -616,9 +616,10 @@ static int __radix_tree_create(struct radix_tree_root *root,
 	struct radix_tree_node *node = NULL, *child;
 	void __rcu **slot = (void __rcu **)&root->xa_head;
 	unsigned long maxindex;
-	unsigned int shift, offset = 0;
+	unsigned int shift, offset = 0, mmshift = 0;
 	unsigned long max = index;
 	gfp_t gfp = root_gfp_mask(root);
+	int ret;
 
 	shift = radix_tree_load_root(root, &child, &maxindex);
 
@@ -628,6 +629,7 @@ static int __radix_tree_create(struct radix_tree_root *root,
 		if (error < 0)
 			return error;
 		shift = error;
+		mmshift = error;
 		child = rcu_dereference_raw(root->xa_head);
 	}
 
@@ -637,8 +639,10 @@ static int __radix_tree_create(struct radix_tree_root *root,
 			/* Have to add a child node.  */
 			child = radix_tree_node_alloc(gfp, node, root, shift,
 							offset, 0, 0);
-			if (!child)
-				return -ENOMEM;
+			if (!child) {
+				 ret = -ENOMEM;
+				 goto freec;
+			}
 			rcu_assign_pointer(*slot, node_to_entry(child));
 			if (node)
 				node->count++;
@@ -656,6 +660,17 @@ static int __radix_tree_create(struct radix_tree_root *root,
 	if (slotp)
 		*slotp = slot;
 	return 0;
+freec:
+	if (mmshift > 0) {
+		struct radix_tree_node *pn;
+		while (shift < mmshift && node) {
+			pn = node->parent;
+			radix_tree_node_rcu_free(&node->rcu_head);
+			shift += RADIX_TREE_MAP_SHIFT;
+			node = pn;
+		}
+	}
+	return ret;
 }
 
 /*
-- 
2.43.0

