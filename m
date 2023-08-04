Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0C76FD02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjHDJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHDJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:14:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433DA4ED0;
        Fri,  4 Aug 2023 02:11:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHKj006DBz4f400j;
        Fri,  4 Aug 2023 17:11:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHLwMxk2KskPg--.58335S8;
        Fri, 04 Aug 2023 17:11:48 +0800 (CST)
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
Subject: [PATCH v6 4/5] mm: Dump the memory of slab object in kmem_dump_obj()
Date:   Fri,  4 Aug 2023 17:11:34 +0800
Message-Id: <20230804091136.1177-5-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHLwMxk2KskPg--.58335S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7WFWDKrWxKF1rKFW8tFb_yoW8tw15pr
        9xCryxG3yxJrnrurs7J3WkXF15G3ykC3WkGaya9r17Zw18Jr48u3Z7JF9FkFWUAa1Fq39F
        yrZ0vFsagFyUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rV
        AKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU192
        -UUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The contents of the slab object may contain some magic words and other
useful information that may be helpful in locating problems such as
memory corruption and use-after-free.

To avoid print flooding, dump up to "16 * sizeof(int) = 64" bytes
centered on argument 'ojbect'.

For example:
slab kmalloc-64 start ffff4043802d8b40 pointer offset 24 size 64
[8b40]: 12345678 00000000 8092d000 ffff8000
[8b50]: 00101000 00000000 8199ee00 ffff4043
[8b60]: 00000000 00000000 00000000 00000100
[8b70]: 00000000 9abcdef0 a8744de4 ffffc7fe

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/slab_common.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ee6ed6dd7ba9fa5..3564e60a2584b12 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -553,7 +553,7 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
 bool kmem_dump_obj(void *object)
 {
 	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
-	int i;
+	int i, object_size = 0;
 	struct slab *slab;
 	unsigned long ptroffset;
 	struct kmem_obj_info kp = { };
@@ -580,12 +580,33 @@ bool kmem_dump_obj(void *object)
 		ptroffset = ((char *)object - (char *)kp.kp_objp) - kp.kp_data_offset;
 		pr_cont(" pointer offset %lu", ptroffset);
 	}
-	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size)
-		pr_cont(" size %u", kp.kp_slab_cache->object_size);
+	if (kp.kp_slab_cache && kp.kp_slab_cache->object_size) {
+		object_size = kp.kp_slab_cache->object_size;
+		pr_cont(" size %u", object_size);
+	}
 	if (kp.kp_ret)
 		pr_cont(" allocated at %pS\n", kp.kp_ret);
 	else
 		pr_cont("\n");
+
+	/* Dump a small piece of memory centered on 'object' */
+	if (kp.kp_objp && object_size) {
+		void *p = object;
+		int dump_size = 64;
+
+		p += dump_size / 2;
+		if (p > kp.kp_objp + object_size)
+			p = kp.kp_objp + object_size;
+
+		p -= dump_size;
+		if (p < kp.kp_objp)
+			p = kp.kp_objp;
+
+		dump_size = min(object_size, dump_size);
+		print_hex_dump(KERN_INFO, "",
+			       DUMP_PREFIX_ADDRESS_LOW16, 16, 4, p, dump_size, false);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
 		if (!kp.kp_stack[i])
 			break;
-- 
2.34.1

