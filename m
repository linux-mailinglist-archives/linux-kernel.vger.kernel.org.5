Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0F76FCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjHDJOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHDJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:14:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF014EC4;
        Fri,  4 Aug 2023 02:11:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHKhw3YXXz4f403R;
        Fri,  4 Aug 2023 17:11:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHLwMxk2KskPg--.58335S5;
        Fri, 04 Aug 2023 17:11:44 +0800 (CST)
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
Subject: [PATCH v6 1/5] hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
Date:   Fri,  4 Aug 2023 17:11:31 +0800
Message-Id: <20230804091136.1177-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHLwMxk2KskPg--.58335S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UGw45KFWUuF17Jw1kZrb_yoW5WF13pa
        s0gry5GF40gF4xGr1UJrWUCr1YyrZ8Ca40kFWqyw10kryxWFW7Xw4kXFW3Gry5Gr4FqFnx
        Jry7t345Kr1UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1D73DUUUUU=
        =
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

Currently, function print_hex_dump() supports three dump prefixes:
DUMP_PREFIX_NONE, DUMP_PREFIX_ADDRESS and DUMP_PREFIX_OFFSET. But for some
usage scenarios, they don't work perfectly. For example, dump the content
of one task's stack. In order to quickly identify a stack frame,
DUMP_PREFIX_ADDRESS is preferred. But printing multiple 64-bit addresses
is a bit unwise when the 'sp' value is already printed. It is redundant
and unintuitive.

For example:
dump memory at sp=ffff800080883a90:
ffff800080883a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
ffff800080883aa0: 5833f000 ffff3580 00000001 00000000
ffff800080883ab0: 40299840 ffff3580 590dfa00 ffff3580
ffff800080883ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
ffff800080883ad0: 40877180 ffff3580 590dfa00 ffff3580
ffff800080883ae0: 4090f600 ffff3580 80883cb0 ffff8000
ffff800080883af0: 00000010 00000000 00000000 00000000
ffff800080883b00: 4090f700 ffff3580 00000001 00000000

Generally, we do not dump more than 64 KB memory. It is sufficient to
print only the lower 16 bits of the address.

dump memory at sp=ffff800080883a90:
3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
3aa0: 5833f000 ffff3580 00000001 00000000
3ab0: 40299840 ffff3580 590dfa00 ffff3580
3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
3ad0: 40877180 ffff3580 590dfa00 ffff3580
3ae0: 4090f600 ffff3580 80883cb0 ffff8000
3af0: 00000010 00000000 00000000 00000000
3b00: 4090f700 ffff3580 00000001 00000000

Another benefit of adding DUMP_PREFIX_ADDRESS_LOW16 is that we don't have
to worry about %p outputting address as hashed value.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/printk.h | 1 +
 lib/hexdump.c          | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1ed2e..ccad9e8eaaf0c31 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -704,6 +704,7 @@ extern const struct file_operations kmsg_fops;
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_ADDRESS_LOW16,
 	DUMP_PREFIX_OFFSET
 };
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398d74..247c8765cc7ca3f 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -281,6 +281,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
 			break;
+		case DUMP_PREFIX_ADDRESS_LOW16:
+			printk("%s%s%04lx: %s\n", level,
+			       prefix_str, 0xffff & (unsigned long)(ptr + i), linebuf);
+			break;
 		case DUMP_PREFIX_OFFSET:
 			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
 			break;
-- 
2.34.1

