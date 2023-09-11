Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BD379C081
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjIKV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjIKMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:08:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585DF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:08:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fbbea0dfeso683361b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694434122; x=1695038922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSJYBbbihUnR+SJdFgIqZaBRE+pUOWIbd9WmzD5l0Kc=;
        b=hRlDfiYEOP5zYTy12PSsV1dflKpKtppGRyQYmqFGe2+6lxG+vITguVy6Lfh7kTBuOW
         eHpaKeYEEBJ9huLt1+zke9Ydq52yadF95IXqwapm975kv8xWne2t+SCw1+tJcQ0S04i7
         ZNRPRTFVff+gHim2y8B0hhB912fn9e/xM4dAeCOgUxbrN7rezw0lX8Os8M2vGZrDXZ6a
         ABhAWAroMaZOfasbrMCNaGukHimJKNjczMsO3+01vBaVRYqQwjbeXiy9rGzEix9OteQI
         VFsXivw+FYGIuxU5ROK3G3aWuBCyKJOMVsjsl2G27bKbKSztSxFMZnOnOYZ/156hpVxJ
         VP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694434122; x=1695038922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSJYBbbihUnR+SJdFgIqZaBRE+pUOWIbd9WmzD5l0Kc=;
        b=eFSclt8b3LdKdEVGVJbS34H7GHx9scEodLoHlzeH01KHIkkphy+4fppbehow83ybCS
         LFxp7bTsokvlnqdkxBYzAcj7UKFVGG7k3EcTFxFge52Zgp6D95HpHIncuOWwIJmhM/pe
         jatMsAXRb3NB4TIIceYpwkYcEfGG9Cv5KDvmREIoUgHa9pJjZ/BqWO8rbBGJUh4Ld6X/
         C2BZPUrCBLJr55jWHTLeY/7S936osahkSuy48qsWqONqjId9sNTSX9sYMVpkThDPrAE6
         eWzpAdoK/tpKIDkgcbrIC1FAc6ikw9+I/raVjrqugd2+qqBGegQFafw0zouGgt3LHN3G
         Qmdg==
X-Gm-Message-State: AOJu0Yy2puTDSKVjWSsrf9N6ff+kwEgZcW/UvJH9hkHgfOwzZhw+Nt5f
        OMa1LVH7uERuE5h5MFRrbA8=
X-Google-Smtp-Source: AGHT+IEELzDYjd1GGYqAEUdWsr0auvuWK1hvgv4pN/ua3LiOE+U12IXWq2U7TsuuxUal9lTzrYhTuw==
X-Received: by 2002:a05:6300:8005:b0:140:8537:85c1 with SMTP id an5-20020a056300800500b00140853785c1mr6513639pzc.28.1694434121812;
        Mon, 11 Sep 2023 05:08:41 -0700 (PDT)
Received: from haodong-Precision.fareast.nevint.com ([116.228.68.226])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0068725ff9befsm5454004pfa.207.2023.09.11.05.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:08:41 -0700 (PDT)
From:   Haodong Wong <haydenw.kernel@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        haodong.wong@nio.com
Subject: [PATCH] locking/rwbase: Fix race condition in rwlock_rt fast path
Date:   Mon, 11 Sep 2023 20:07:32 +0800
Message-Id: <20230911120732.2007894-1-haydenw.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the writer in fast path check onwer before sub READER_BIAS,since
var readers=READER_BIAS, reader thread can jump to critical section to
access the data that modified by writer which may cause itself panic.

For example we observed below panic in SMP PREEMPT RT:

Call trace:

    try_to_wake_up+0x374/0x5d0
    default_wake_function+0x3c/0x70
    autoremove_wake_function+0x3c/0x70
    __wake_up_common+0x90/0x150
    __wake_up_common_lock+0x7c/0xc0
    __wake_up+0x40/0x50
    ep_poll_callback+0xa0/0x260
    __wake_up_common+0x90/0x150
    __wake_up_common_lock+0x7c/0xc0
    __wake_up_sync_key+0x40/0x50
    sock_def_readable+0x44/0x90
    tcp_data_ready+0x3c/0xf0
    tcp_rcv_established+0x754/0x7f0
    tcp_v4_do_rcv+0x1f0/0x2e0
    tcp_v4_rcv+0xb60/0xc80
    ip_protocol_deliver_rcu+0x44/0x200
    ip_local_deliver_finish+0x68/0x80
    ip_local_deliver+0x80/0x130
    ip_sublist_rcv_finish+0x48/0x70
    ip_sublist_rcv+0x178/0x1f0
    ip_list_rcv+0x108/0x1b0
    __netif_receive_skb_list_core+0x18c/0x220
    netif_receive_skb_list_internal+0x18c/0x2a0
    napi_complete_done+0xc4/0x210
    ether_napi_poll_rx+0xa4/0xe0
    net_rx_action+0x120/0x430
    __do_softirq+0x120/0x3b4
    __local_bh_enable_ip+0xd8/0x140
    irq_forced_thread_fn+0x84/0xc0
    irq_thread+0x150/0x260
    kthread+0x17c/0x1a0
    ret_from_fork+0x10/0x18

The process is as follows:
Writer Thread					Reader Thread

ep_poll:					ep_poll_callback:
  write_lock_irq:				  read_lock_irq:

	set rtmutex onwer in fast patch
							  if reader < 0
                                                             exit read_lock
  __remove_wait_queue

						   _wake_up PANIC happen

Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
---
 kernel/locking/rtmutex_common.h | 15 +++++++++++++++
 kernel/locking/rwbase_rt.c      |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 1162e07cdaea..d81042657ce2 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -161,6 +161,15 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
+static inline struct task_struct *rt_mutex_owner_acquire(struct rt_mutex_base *lock)
+{
+	/* Add rt mutex onwer acquire method */
+	unsigned long owner = (unsigned long) smp_load_acquire(&lock->owner);
+
+	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
+}
+
+
 /*
  * Constants for rt mutex functions which have a selectable deadlock
  * detection.
@@ -229,6 +238,12 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	return NULL;
 }
+
+static inline struct task_struct *rt_mutex_owner_acquire(struct rt_mutex_base *lock)
+{
+	return NULL;
+}
+
 #endif  /* !CONFIG_RT_MUTEXES */
 
 #endif
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 25ec0239477c..ca271f57b9c1 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -54,6 +54,15 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
 {
 	int r;
 
+	/*
+	 * Reader should check if writer in fast patch in case of they
+	 * have race condition in the first time.
+	 */
+
+	if ((atomic_read(&lock->readers) == READER_BIAS) &&
+			rt_mutex_owner_acquire(&lock->rtmutex))
+		return 0;
+
 	/*
 	 * Increment reader count, if sem->readers < 0, i.e. READER_BIAS is
 	 * set.
-- 
2.25.1

