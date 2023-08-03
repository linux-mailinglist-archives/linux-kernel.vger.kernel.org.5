Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10A76E573
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjHCKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjHCKTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:19:14 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB3A35BE;
        Thu,  3 Aug 2023 03:19:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGlF92nt6z4f3yDV;
        Thu,  3 Aug 2023 18:19:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgD3mp4Uf8tk4+TaPQ--.35755S7;
        Thu, 03 Aug 2023 18:19:09 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Christoph Lameter <cl@linux.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 3/3] mm: Dump the memory of slab object in kmem_dump_obj()
Date:   Thu,  3 Aug 2023 18:17:54 +0800
Message-Id: <20230803101754.1149-4-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230803101754.1149-1-thunder.leizhen@huaweicloud.com>
References: <20230803101754.1149-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3mp4Uf8tk4+TaPQ--.35755S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7WFWDKrWxKF1rKFW8tFb_yoW8Kr13pr
        9xGr1UK3yxArnrCrs3J3WkXF45J3ykC3WkJayavr17Zw1UJr48uF97tF92kFWUGF1Fqa9F
        yrZ0vFnIgryUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFR6zUUUU
        U
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/slab_common.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ee6ed6dd7ba9fa5..0232de9a3b29cf5 100644
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
@@ -580,12 +580,36 @@ bool kmem_dump_obj(void *object)
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
+		int *p = object, n = 16;
+
+		p += n / 2;
+		if ((void *)p > kp.kp_objp + object_size)
+			p = kp.kp_objp + object_size;
+
+		p -= n;
+		if ((void *)p < kp.kp_objp)
+			p = kp.kp_objp;
+
+		n = min_t(int, object_size / sizeof(int), n);
+		for (i = 0; i < n; i++, p++) {
+			if (i % 4 == 0)
+				pr_info("[%04lx]:", 0xffff & (unsigned long)p);
+			pr_cont(" %08x", *p);
+		}
+		pr_cont("\n");
+	}
+
 	for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
 		if (!kp.kp_stack[i])
 			break;
-- 
2.34.1

