Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1877EF0D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbjKQKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345894AbjKQKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:43:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90011F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:43:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3c51f830so15021375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1700217804; x=1700822604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u6cYv7qHS3jfyv6VusFhEGtH9TkwNd/QVhjYn00CtU=;
        b=Zd13dAUTp54nP+Z8CqTpu4nSy0MF15qBUDAuR4N1Ax4KJI0PMvW+8cNu0Wdtd6C29f
         TF16LeDplsnU88q6hJ7CU5q2vZyfEcrhMy11KOpywJ+tfjPicLpIcgkvGtMxMqdjdtd4
         qMsSsWXBMn7NBBsxxqnr0RXT1V0oRQv9RCrp91qcD7mAh5GOazG/zWNMHlUfvlcdGw9x
         LMRJUeXLa6fBjiIAxYKLwje5CvHq/gQiEdp5w1TgQt9zJ91gDaUQ6oCs2o6l4gjRHmxs
         sxBjUKGxbvBYno5Mc2Y4ntAmukNoYnNmABd8DWUCLH5vu8kK/b8rrGlUv8rVGsg9askT
         2ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217804; x=1700822604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u6cYv7qHS3jfyv6VusFhEGtH9TkwNd/QVhjYn00CtU=;
        b=qYPAcBZkLmL93Nkkdjk0ZTrVGGN5X4OVUBIfAv5OIMK1YxVjDs94VxXnup40Tcy5wJ
         wZF7JWeqdwIW8v7vAdyOiFKN3RrFHy6IymD+BDYjuzuulrn+n3ScTX32N/oSWz90fbxZ
         xBEKQGLjcn069V5UggwlQDuSDcpsrG9nF3wdhdZuzNACVFKrCqmkVF2jqotsdJeol/4H
         bDm/ndv+0LfrvOfmQnExvG/6vfmpR+3fxAK1u4bemDrExGxCx9llJlNazFACvuYotYEW
         6S0emelc8w+xYAhBOtdhsGQh52HY9mg7UJP9e66BQ28CwE2pxHUrTI/rvF1JlfNszB+o
         yBOQ==
X-Gm-Message-State: AOJu0YwGTP9uqNZHh+OdQBRHOuPI+9SHecjxAs4wzXeW4C9RrLPinddR
        zomPEGpNaLVQxTw5zvLHTJge4g==
X-Google-Smtp-Source: AGHT+IHAdwWt+tH7o0//OLex7pxxHbXHHfmO+fsGSLZGL3oaQwvN5ovIeBdWCCrPT26qIsJgH1EADQ==
X-Received: by 2002:a17:902:eb8f:b0:1cc:bf6b:f3b1 with SMTP id q15-20020a170902eb8f00b001ccbf6bf3b1mr12515205plg.37.1700217804177;
        Fri, 17 Nov 2023 02:43:24 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001b81a97860asm1117883plg.27.2023.11.17.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:43:23 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     edumazet@google.com
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] bonding: use a read-write lock in bonding_show_bonds()
Date:   Fri, 17 Nov 2023 10:43:11 +0000
Message-Id: <20231117104311.1273-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
References: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:

Call stack:
......
PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
[ffffa7a8e96bbac0] __schedule at ffffffffb0719898
[ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
[ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
[ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
[ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
[ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
[ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
[ffffa7a8e96bbc80] device_del at ffffffffb0209af8
[ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
[ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
[ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
[ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
[ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
[ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
[ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
[ffffa7a8e96bbf10] kthread at ffffffffafae132a
[ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92

290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-exporter"
[ffffa7a8d14dbb80] __schedule at ffffffffb0719898
[ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
[ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
[ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
[ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
[ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
[ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
[ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
[ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
[ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
[ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
[ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
[ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
[ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
[ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
[ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
[ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
[ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
[ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
......

Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
but there are many readers which hold the kernfs_rwsem, so it has to sleep
for a long time to wait the readers release the lock. Thread 278176 and any
other threads which call bonding_show_bonds() also need to wait because
they try to acquire the rtnl_mutex.

bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
However, the addition and deletion of bond_list are only performed in
bond_init()/bond_uninit(), so we can introduce a separate read-write lock
to synchronize bond list mutation.

What are the benefits of this change?

1) All threads which call bonding_show_bonds() only wait when the
registration or unregistration of bond device happens.

2) There are many other users of rtnl_mutex, so bonding_show_bonds()
won't compete with them.

In a word, this change reduces the lock contention of rtnl_mutex.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
v2:
- move the call stack after the description
- fix typos in the changelog
---
 drivers/net/bonding/bond_main.c  | 4 ++++
 drivers/net/bonding/bond_sysfs.c | 6 ++++--
 include/net/bonding.h            | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8e6cc0e133b7..db8f1efaab78 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5957,7 +5957,9 @@ static void bond_uninit(struct net_device *bond_dev)
 
 	bond_set_slave_arr(bond, NULL, NULL);
 
+	write_lock(&bonding_dev_lock);
 	list_del(&bond->bond_list);
+	write_unlock(&bonding_dev_lock);
 
 	bond_debug_unregister(bond);
 }
@@ -6370,7 +6372,9 @@ static int bond_init(struct net_device *bond_dev)
 	spin_lock_init(&bond->stats_lock);
 	netdev_lockdep_set_classes(bond_dev);
 
+	write_lock(&bonding_dev_lock);
 	list_add_tail(&bond->bond_list, &bn->dev_list);
+	write_unlock(&bonding_dev_lock);
 
 	bond_prepare_sysfs_group(bond);
 
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 2805135a7205..e107c1d7a6bf 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -28,6 +28,8 @@
 
 #define to_bond(cd)	((struct bonding *)(netdev_priv(to_net_dev(cd))))
 
+DEFINE_RWLOCK(bonding_dev_lock);
+
 /* "show" function for the bond_masters attribute.
  * The class parameter is ignored.
  */
@@ -40,7 +42,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	int res = 0;
 	struct bonding *bond;
 
-	rtnl_lock();
+	read_lock(&bonding_dev_lock);
 
 	list_for_each_entry(bond, &bn->dev_list, bond_list) {
 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
@@ -55,7 +57,7 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
 
-	rtnl_unlock();
+	read_unlock(&bonding_dev_lock);
 	return res;
 }
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..584ba4b5b8df 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -777,6 +777,9 @@ extern struct rtnl_link_ops bond_link_ops;
 /* exported from bond_sysfs_slave.c */
 extern const struct sysfs_ops slave_sysfs_ops;
 
+/* exported from bond_sysfs.c */
+extern rwlock_t bonding_dev_lock;
+
 /* exported from bond_3ad.c */
 extern const u8 lacpdu_mcast_addr[];
 
-- 
2.25.1

