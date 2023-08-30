Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D278DBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjH3Skn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbjH3LEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:04:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96CACCB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:04:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34cb5c41777so16806245ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693393449; x=1693998249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHeTYTQd3e1UM6bbclCSBl0XSX253sv8qZjrdw63cyw=;
        b=XT2OsL8vone9h4Yy4OmsyMpk2y+6JK29K6/bBBRVBW6l9foNBRC97Hf7GgUsraeUyM
         blWWPincJbqW6PX2S+ZKKqHkAQoI7JQKVJ6hsyNr0z7UiQ7pkJUo/rYh9SLrVQ0gn+uK
         IH3qBlYF8LASht9S16w2pvBHWs64kKsHyS1s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693393449; x=1693998249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHeTYTQd3e1UM6bbclCSBl0XSX253sv8qZjrdw63cyw=;
        b=Id+CtPsmH2oQN9s5NYpKdRyxifPlPXidxN3+JQa7W5+K9fC1oS00u2RnW2ESZlZA40
         BuT6YFUYn7nXZn2lgeMAao07fAbCzxsd1LX3cYOMf8sm4ebh7LIKEUSTnYUQogU5Wqww
         1aJlL04ALlxYMGYEOpPo3g3dWDJCTPY+7D4ONAzCBXOOFXvkHPD6pB+huOIc4g8ZNhjW
         5dpqCkxjzYtWeKinvxnj1kLMynD42687nF+yZ1INf3n4d1E31bfeuMxIQAZUvTHWGJhk
         0zQzODl18/rac0TpZnYaW8q8196WcsauSeoj5Nw+lHnZK8dS6Zro1a73Wke1GIB3HoUT
         tzwg==
X-Gm-Message-State: AOJu0YyjSNY7iD6sRnMuev1xiU8xZDfTJu8wZQGa9syh5FN0pgizopoE
        woCwMhNIDGGiE1HUcm9w0FtqBY6CQVnZ5v+Bha8=
X-Google-Smtp-Source: AGHT+IFund/NrHtbXmr+nM6CwUfYexlETTDEs47RWR1PjvxqSHb7wpadyvNQl1N8KUpp7GybkOZn3Q==
X-Received: by 2002:a05:6e02:ee7:b0:34c:b992:58b1 with SMTP id j7-20020a056e020ee700b0034cb99258b1mr1918104ilk.2.1693393448834;
        Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id k8-20020a926f08000000b00348880831fdsm3701371ilc.58.2023.08.30.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>, linux-mm@kvack.org
Subject: [PATCH 2/2] rcu: Dump vmalloc memory info safely
Date:   Wed, 30 Aug 2023 11:04:00 +0000
Message-ID: <20230830110402.386898-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830110402.386898-1-joel@joelfernandes.org>
References: <20230830110402.386898-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

Currently, for double invoke call_rcu(), will dump rcu_head objects
memory info, if the objects is not allocated from the slab allocator,
the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
need to be held, since the call_rcu() can be invoked in interrupt context,
therefore, there is a possibility of spinlock deadlock scenarios.

And in Preempt-RT kernel, the rcutorture test also trigger the following
lockdep warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
3 locks held by swapper/0/1:
 #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
 #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
 #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
irq event stamp: 565512
hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
Preemption disabled at:
[<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xb0
 dump_stack+0x14/0x20
 __might_resched+0x1aa/0x280
 ? __pfx_rcu_torture_err_cb+0x10/0x10
 rt_spin_lock+0x53/0x130
 ? find_vmap_area+0x1f/0x70
 find_vmap_area+0x1f/0x70
 vmalloc_dump_obj+0x20/0x60
 mem_dump_obj+0x22/0x90
 __call_rcu_common+0x5bf/0x940
 ? debug_smp_processor_id+0x1b/0x30
 call_rcu_hurry+0x14/0x20
 rcu_torture_init+0x1f82/0x2370
 ? __pfx_rcu_torture_leak_cb+0x10/0x10
 ? __pfx_rcu_torture_leak_cb+0x10/0x10
 ? __pfx_rcu_torture_init+0x10/0x10
 do_one_initcall+0x6c/0x300
 ? debug_smp_processor_id+0x1b/0x30
 kernel_init_freeable+0x2b9/0x540
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x1f/0x150
 ret_from_fork+0x40/0x50
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

The previous patch fixes this by using the deadlock-safe best-effort
version of find_vm_area. However, in case of failure print the fact that
the pointer was a vmalloc pointer so that we print at least something.

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index dd12b9531ac4..406634f26918 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1071,7 +1071,9 @@ void mem_dump_obj(void *object)
 	if (vmalloc_dump_obj(object))
 		return;
 
-	if (virt_addr_valid(object))
+	if (is_vmalloc_addr(object))
+		type = "vmalloc memory";
+	else if (virt_addr_valid(object))
 		type = "non-slab/vmalloc memory";
 	else if (object == NULL)
 		type = "NULL pointer";
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

