Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A9770E68
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHEHWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjHEHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B834EC7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:21:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHvCN5xgbz4f3mJ4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:21:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZR_+M1kFAdsPg--.4573S5;
        Sat, 05 Aug 2023 15:21:37 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] hexdump: minimize the output width of the offset
Date:   Sat,  5 Aug 2023 15:21:15 +0800
Message-Id: <20230805072116.1260-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZR_+M1kFAdsPg--.4573S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13tF4UKF13XF17Cw4UJwb_yoW8tw45pF
        98t3yYgFZ7Jr1xCr17Ar10gr1Yka47C3W0kFWqk34qvF4UWF1fXrykKFW3try5Jr1qqrsI
        qr9rtw1Fyr17Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
        WxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8U73DUUUUU==
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
the output width is fixed to 8. But we usually dump only tens or hundreds
of bytes, occasionally thousands of bytes. Therefore, the output offset
value always has a number of leading zeros, which increases the number of
bytes printed and reduces readability. Let's minimize the output width of
the offset based on the number of significant bits of its maximum value.

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
index 06833d404398d74..86cb4cc3eec485a 100644
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
+		unsigned long tmp = len - 1;	/* offset start from 0, so minus 1 */
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
@@ -282,7 +291,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			       level, prefix_str, ptr + i, linebuf);
 			break;
 		case DUMP_PREFIX_OFFSET:
-			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
+			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
 			break;
 		default:
 			printk("%s%s%s\n", level, prefix_str, linebuf);
-- 
2.34.1

