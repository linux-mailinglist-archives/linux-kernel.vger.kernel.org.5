Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C478F1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbjHaRSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbjHaRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:18:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574ED1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7928ba24936so39680439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693502313; x=1694107113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/9/PG9jMlcZB3crQaMzRcArzBV6KYUSerMEBj6hrg8=;
        b=wnXucAJkc2nuHeATCDpeHVx9G1R69YpGFcXqhsDDMu5Di7FZMIEzmSpOH1kXZOPdBi
         WDuXkyGZqQuUTChlJsr7VZXnXl3LTWt57hw9d+HkXQfbEIvnURNj/cDO6otoy+oiKHV0
         KEODxwkdQWMDeIk2bsG9rHmKAyvgfSLdLndro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502313; x=1694107113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/9/PG9jMlcZB3crQaMzRcArzBV6KYUSerMEBj6hrg8=;
        b=IaN3JB1YDF0aljV3quzLZgLNduSRnSGqa2DBVS/l9y4cza/QLDoHsKiu6BHmwmv4VZ
         RuOdhOZuFzU/eoQveWB4jSoabidwCjmSbqJEcPDOcG4DDQ3d/odIoURv6Yi0No4ntf/V
         cD7t4gFzX02y0XWRG/V3gjy2RZ/wpl3owozIkYyqRIgXISBpQot+Rvcw22uayDV04c8r
         6/pVye8+f1Fix52idYhbRHWPO1geglhzDgMfeWGCdLPysir5hY2tv2Pf1s3vwISGWTWr
         LiDNoAmMna4nLAk6GrgIz5Bl5Y8CWaC1CGTPVW95GMnANPIQKzXx5N5vcXh6vW/ibPLt
         JdlA==
X-Gm-Message-State: AOJu0YzOYPjoT9C7D4InA5gxY6wN2wwnR0gcNfQ+MO/PPux43Y/60UTZ
        NXXq0s2Qimv6zAJ3KClCiVWut+RFwDaKc+FphcU=
X-Google-Smtp-Source: AGHT+IHcox5PcaIvs7MVFvtB0jCP2GW2W8V6QqMbhxRIywTxp3y1gSk6Bn/EIRCUTsCRwW8btiaIxA==
X-Received: by 2002:a05:6602:370a:b0:792:4d29:ecc7 with SMTP id bh10-20020a056602370a00b007924d29ecc7mr6959672iob.15.1693502313379;
        Thu, 31 Aug 2023 10:18:33 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a16-20020a056638019000b0042af069eeefsm489720jaq.50.2023.08.31.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:18:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, linux-mm@kvack.org
Subject: [PATCH v2 2/2] rcu: Dump vmalloc memory info safely
Date:   Thu, 31 Aug 2023 17:18:26 +0000
Message-ID: <20230831171827.2625016-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831171827.2625016-1-joel@joelfernandes.org>
References: <20230831171827.2625016-1-joel@joelfernandes.org>
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

