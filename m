Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F457F04FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjKSJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjKSJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:25:56 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A3138
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:25:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so2773282b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1700385951; x=1700990751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl0+5wne9atTu1deNj/aM6BhU2wZluYA+vtbr+CP8oc=;
        b=UDdJGanhZR2MhMHOZY+K4NfuIexN9FN6hUP9X+WdxdJgCmKHINM6cI05xcijvsVsGb
         9Bg9UyxE9Nycd+nk/IMcu+tnAY8ic8cQWnTSKCpUc4DJI6Kze1mRrJAJjQZooDAchboi
         HZMmjpaVCyzL+6BN6c/GWGP+k0v3sawqSkExPidXTeJCgYb1brI7JKBWOaAKx3gr+dTD
         5lEcRQUp+9Wm65YkV/48GV0jtv2/icg8B/sS6xRhmOyOCbPjAkXmj6jw1oQdo88MIWj1
         k4n5mZ6ByeRDfp9vn5mtPp0QXJ9s4RN35hv/SajBFA7Z55nvtuCmM4O3R9jUAh2qNquX
         tEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700385951; x=1700990751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl0+5wne9atTu1deNj/aM6BhU2wZluYA+vtbr+CP8oc=;
        b=B0SaUsORfNeAR0qudqQ4iiG4dC7TRT2t12n04vbpZQRRvtQyzyOh65k4tG8jwnhcso
         LQdLVsXoFRHx4JF3r07Qs6hD1vAQXHwVJsl4VLqDfp3pKNFIVaW0VN9jzkIvHNoS1+VK
         Jt06qtvU9VrTiQC20XocdNDHfv11N8kP0KQknP+5NE1DYC273IE5Cv62KfuVittyTVyK
         G4brJ1Ywh//6RupLIRqeNJyjG0lDpVKQP8ytS7zRRgSdqDxh97+8oeyyOqHZv693ib+W
         rjI8mYUJr2nAXCRUg7cmln91Y0wICmHbxc7+zbHCVkfRf11+oHlMp5Suya0jF01h4qr1
         Alag==
X-Gm-Message-State: AOJu0YzgnnpG3oIhc7QIc/RLOc9W3/RJyN8m1vPntaOdJ9eR4N/jyOlO
        6Vuu5OWtL4SdOsXGXarKlFeBmV85yR01hq1lBAtfF0rW
X-Google-Smtp-Source: AGHT+IEgZIYHLvOa28MWmYQ4TUN9OQAx9cgdtnyK3TVYFd5RmO1wYor5816Txy+B6+Ukt6Pn5kFWSg==
X-Received: by 2002:a17:902:ecc6:b0:1cf:530b:d007 with SMTP id a6-20020a170902ecc600b001cf530bd007mr1873339plh.53.1700385950979;
        Sun, 19 Nov 2023 01:25:50 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001cc0e3a29a8sm4060770plh.89.2023.11.19.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:25:50 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     edumazet@google.com
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v3 2/2] bonding: use a read-write lock in bonding_show_bonds()
Date:   Sun, 19 Nov 2023 09:25:30 +0000
Message-Id: <20231119092530.13071-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
to synchronize bond list mutation. In addition, bonding_show_bonds() could
race with dev_change_name(), so we need devnet_rename_sem to protect the
access to dev->name.

What are the benefits of this change?

1) All threads which call bonding_show_bonds() only wait when the
registration or unregistration of bond device happens or the name
of net device changes.

2) There are many other users of rtnl_mutex, so bonding_show_bonds()
won't compete with them.

In a word, this change reduces the lock contention of rtnl_mutex.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
v2:
- move the call stack after the description
- fix typos in the changelog
v3:
- add devnet_rename_sem in bonding_show_bonds()
- update the changelog
---
 drivers/net/bonding/bond_main.c  | 4 ++++
 drivers/net/bonding/bond_sysfs.c | 8 ++++++--
 include/net/bonding.h            | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)

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
index 2805135a7205..5de71af7c36f 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -28,6 +28,8 @@
 
 #define to_bond(cd)	((struct bonding *)(netdev_priv(to_net_dev(cd))))
 
+DEFINE_RWLOCK(bonding_dev_lock);
+
 /* "show" function for the bond_masters attribute.
  * The class parameter is ignored.
  */
@@ -40,7 +42,8 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	int res = 0;
 	struct bonding *bond;
 
-	rtnl_lock();
+	down_read(&devnet_rename_sem);
+	read_lock(&bonding_dev_lock);
 
 	list_for_each_entry(bond, &bn->dev_list, bond_list) {
 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
@@ -55,7 +58,8 @@ static ssize_t bonding_show_bonds(const struct class *cls,
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
 
-	rtnl_unlock();
+	read_unlock(&bonding_dev_lock);
+	up_read(&devnet_rename_sem);
 	return res;
 }
 
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 6c16d778b615..ede4116457e2 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -783,6 +783,9 @@ extern const u8 lacpdu_mcast_addr[];
 /* exported from net/core/dev.c */
 extern struct rw_semaphore devnet_rename_sem;
 
+/* exported from bond_sysfs.c */
+extern rwlock_t bonding_dev_lock;
+
 static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *skb)
 {
 	dev_core_stats_tx_dropped_inc(dev);
-- 
2.25.1

