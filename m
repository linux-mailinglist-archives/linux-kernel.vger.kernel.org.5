Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051876FD00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHDJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHDJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:14:17 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F284ECD;
        Fri,  4 Aug 2023 02:11:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHKhx4cp4z4f403j;
        Fri,  4 Aug 2023 17:11:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHLwMxk2KskPg--.58335S6;
        Fri, 04 Aug 2023 17:11:45 +0800 (CST)
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
Subject: [PATCH v6 2/5] hexdump: minimize the output width of the offset
Date:   Fri,  4 Aug 2023 17:11:32 +0800
Message-Id: <20230804091136.1177-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHLwMxk2KskPg--.58335S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fZw1kGw45uw18Zr1rtFb_yoW8uFyxpF
        nxK34YgFZ7Jr1Ikr17Ar10gF1YkFyUA3W0yFWqk34qqF4UWF15JrWkKFW3tFy5Jr4qqrsx
        Jr9rtw1Fyr17GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UtR67UUUUU
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

The offset of case DUMP_PREFIX_OFFSET always starts from 0. Currently,
the output width is fixed to 8. Therefore, the high-order bits filled
with zeros are meaningless except for increasing the number of characters
to be printed. Let's minimize the output width of the offset to improve
readability.

Before:
dump_size=36:
00000000: c0 ba 8c 80 00 80 ff ff 6c 93 ee 2f ee bf ff ff
00000010: 00 50 1e 98 ff 27 ff ff 01 00 00 00 00 00 00 00
00000020: 80 ca 2f 98

After:
dump_size=8:
0: c0 ba 89 80 00 80 ff ff

dump_size=36:
00: c0 3a 91 80 00 80 ff ff 6c 93 ae 76 30 ce ff ff
10: 00 60 cd 60 7d 4e ff ff 01 00 00 00 00 00 00 00
20: 40 9e 29 40

dump_size=300:
000: c0 ba 8d 80 00 80 ff ff 6c 93 ce d4 78 a7 ff ff
010: 00 00 16 18 0c 40 ff ff 01 00 00 00 00 00 00 00
020: 01 00 00 00 00 00 00 00 e8 bc 8d 80 00 80 ff ff
... ...
110: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
120: 00 08 12 01 0c 40 ff ff 00 00 01 00

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/hexdump.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 247c8765cc7ca3f..d3c5b7bb1b8813b 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -263,12 +263,21 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, bool ascii)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, linelen, width = 0, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
 
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
 
+	if (prefix_type == DUMP_PREFIX_OFFSET) {
+		unsigned long tmp = len;
+
+		do {
+			width++;
+			tmp >>= 4;
+		} while (tmp);
+	}
+
 	for (i = 0; i < len; i += rowsize) {
 		linelen = min(remaining, rowsize);
 		remaining -= rowsize;
@@ -286,7 +295,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			       prefix_str, 0xffff & (unsigned long)(ptr + i), linebuf);
 			break;
 		case DUMP_PREFIX_OFFSET:
-			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
+			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
 			break;
 		default:
 			printk("%s%s%s\n", level, prefix_str, linebuf);
-- 
2.34.1

