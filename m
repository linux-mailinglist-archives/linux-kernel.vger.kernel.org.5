Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB0791C57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353401AbjIDSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbjIDSIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:08:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCC13E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:08:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-794c7d95ba5so67088939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693850891; x=1694455691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tEFwq12UF5zCmmOpDsVAwQyIeVifd7dDTHpnacK0UQ=;
        b=PTcBrWDTKRVwDJCh5irhuLEFhYUxsCnlwhsHqwYC9Sp0jahhxdX6GwDHbmTDHsvkSz
         8U3jcti9oj7DdR42hKGOba0N9st/4c7q5TihNvTLd9BO7OTUdpc0X0dPcdNJ+tUusclR
         MvMPCECcle8HeKPBRT9GibPeVCwbLkQTGWmv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693850891; x=1694455691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tEFwq12UF5zCmmOpDsVAwQyIeVifd7dDTHpnacK0UQ=;
        b=XzR0j6/svkLSCFiYJkMX4Ffgq6DiOkAvmPAiQiQZCiQNfcMOT3/PhGEqazEu2YltzC
         f4ebc7vkxedrDmarvZc03iaOeKSWAlqXTc9jRwVH+JcLqeegO9iV0DYXkqCsNSL+NZVC
         Mo1shINA9MXG3baHKNvvhHVlt5UlAH9z48YxykjNb2ETrEX/eOg4gmGFxpcktewRRUub
         80Xhju9plQfqYDUzaVm58aAePxXUQSY+0vfID2e1s3gRiIFYNnQMtuBCHrpCX716Wh4P
         CuqULOEhpaTN83p4Lm1xrkQ76k7ivG4DMH1T6d+fouLaNy5fC3U+NtrwrapoopUefz3P
         G9qA==
X-Gm-Message-State: AOJu0Yz6tyZsXHr9vgy1r1ZoWnmq6yVNMDkTrXzjj+gtJwdIERttq1nC
        DfJrXJF00HxRUs9TvZgg4wcc0nf2e4uAdsnR9lk=
X-Google-Smtp-Source: AGHT+IEHZt1WRuZqA2Wmfc55FNOuRsD84phTBzjghuiQXLfZnRv1pVitPty4syUUp7DZ6Ov+pU33MA==
X-Received: by 2002:a5e:a618:0:b0:794:c9a2:5fe3 with SMTP id q24-20020a5ea618000000b00794c9a25fe3mr12586673ioi.4.1693850891310;
        Mon, 04 Sep 2023 11:08:11 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id g15-20020a02b70f000000b0042bb13cb80fsm3520216jam.120.2023.09.04.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 11:08:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        stable@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        linux-mm@kvack.org
Subject: [PATCH v3 2/2] rcu: Dump vmalloc memory info safely
Date:   Mon,  4 Sep 2023 18:08:05 +0000
Message-ID: <20230904180806.1002832-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904180806.1002832-1-joel@joelfernandes.org>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
Cc: stable@vger.kernel.org
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
2.42.0.283.g2d96d420d3-goog

