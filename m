Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF27736DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjHHCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHHCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:42:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6AE62
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:42:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RKcsN42ghz4f3lg4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:42:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6l1q9FkbBbIAA--.8214S5;
        Tue, 08 Aug 2023 10:42:01 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/2] hexdump: minimize the output width of the offset
Date:   Tue,  8 Aug 2023 10:41:45 +0800
Message-Id: <20230808024146.1335-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230808024146.1335-1-thunder.leizhen@huaweicloud.com>
References: <20230808024146.1335-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6l1q9FkbBbIAA--.8214S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13tF4UKF13XF17Cw4UJwb_yoW8tryrpF
        n8t3y5KFZ7JF1IyrnFyr10gF1Yka47CF10kFWqk34qvF4DWr13JrykKFW3try5Jr4vvrsI
        qry7t3WFyr17Gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU88-BtUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/hexdump.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398d74..1064706d57c15ed 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -263,7 +263,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    const void *buf, size_t len, bool ascii)
 {
 	const u8 *ptr = buf;
-	int i, linelen, remaining = len;
+	int i, linelen, width = 0, remaining = len;
 	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
 
 	if (rowsize != 16 && rowsize != 32)
@@ -282,7 +282,15 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			       level, prefix_str, ptr + i, linebuf);
 			break;
 		case DUMP_PREFIX_OFFSET:
-			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
+			if (!width) {
+				unsigned long tmp = len - 1; /* offset start from 0, so minus 1 */
+
+				do {
+					width++;
+					tmp >>= 4;
+				} while (tmp);
+			}
+			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
 			break;
 		default:
 			printk("%s%s%s\n", level, prefix_str, linebuf);
-- 
2.34.1

