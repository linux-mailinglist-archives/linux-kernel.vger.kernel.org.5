Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC13776FCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjHDJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHDJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:14:16 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491B4C3F;
        Fri,  4 Aug 2023 02:11:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHKhv1xgXz4f400Q;
        Fri,  4 Aug 2023 17:11:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHLwMxk2KskPg--.58335S4;
        Fri, 04 Aug 2023 17:11:42 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v6 0/5] rcu: Dump memory object info if callback function is invalid
Date:   Fri,  4 Aug 2023 17:11:30 +0800
Message-Id: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHLwMxk2KskPg--.58335S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3ur4ruryktryxAF47Jwb_yoW8Zr4Upw
        nxW3sxWryUJry3CF13ZF1I9ry5Jw4xGFsIk3ZxZw18uw1Fvr97uFykJr1IqF98GF97K3WU
        t3WYkF1jkF1UZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkI
        j40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
        6uWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

v5 --> v6:
1. Use print_hex_dump() to dump the memory of slab object.
2. Add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
3. Minimize the output width of the offset

v4 --> v5:
1. Add Reviewed-by Acked-by for patch 1/3
2. Add patch 3/3:
   mm: Dump the memory of slab object in kmem_dump_obj()

v3 --> v4:
1. Remove kmem_valid_obj() and convert kmem_dump_obj() to work the same way
   as vmalloc_dump_obj().
2. In kernel/rcu/rcu.h
-#include <linux/mm.h>
+#include <linux/slab.h>

v2 --> v3:
1. I made statistics about the source of 'rhp'. kmem_valid_obj() accounts for
   more than 97.5%, and vmalloc accounts for less than 1%. So change call
   mem_dump_obj() to call kmem_dump_obj() can meet debugging requirements and
   avoid the potential deadlock risk of vmalloc_dump_obj().
-		mem_dump_obj(rhp);
+		if (kmem_valid_obj(rhp))
+			kmem_dump_obj(rhp);

   The discussion about vmap_area_lock deadlock in v2:
   https://lkml.org/lkml/2022/11/11/493

2. Provide static inline empty functions for kmem_valid_obj() and kmem_dump_obj()
   when CONFIG_PRINTK=n.

v1 --> v2:
1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
2. Paul E. McKenney helped me update the commit message, thanks.


Zhen Lei (5):
  hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
  hexdump: minimize the output width of the offset
  mm: Remove kmem_valid_obj()
  mm: Dump the memory of slab object in kmem_dump_obj()
  rcu: Dump memory object info if callback function is invalid

 include/linux/printk.h |  1 +
 include/linux/slab.h   |  5 ++--
 kernel/rcu/rcu.h       |  7 +++++
 kernel/rcu/srcutiny.c  |  1 +
 kernel/rcu/srcutree.c  |  1 +
 kernel/rcu/tasks.h     |  1 +
 kernel/rcu/tiny.c      |  1 +
 kernel/rcu/tree.c      |  1 +
 lib/hexdump.c          | 17 +++++++++--
 mm/slab_common.c       | 68 ++++++++++++++++++++++--------------------
 mm/util.c              |  4 +--
 11 files changed, 67 insertions(+), 40 deletions(-)

-- 
2.34.1

