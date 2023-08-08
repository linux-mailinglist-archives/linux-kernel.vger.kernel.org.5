Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65727736DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHHCmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHHCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:42:06 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B7E5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:42:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RKcsL2HdKz4f3lKc
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:41:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6l1q9FkbBbIAA--.8214S4;
        Tue, 08 Aug 2023 10:42:01 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/2] hexdump: minimize the output width of address and offset
Date:   Tue,  8 Aug 2023 10:41:44 +0800
Message-Id: <20230808024146.1335-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6l1q9FkbBbIAA--.8214S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr13ZF4DCr1UZrWDKryfWFg_yoWDArg_X3
        s2qrykCa1UJFyrJFZrJFn5AryDCa17Cr1xZFnrXrnrJrWrJr1UWw4DWFyDXr1rWrnxGa4D
        Jw1DtrZ7Ar10gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1SfO7UUUUU==
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

v1 --> v2:
1. Move the code for calculating the output width of the offset into
   the case DUMP_PREFIX_OFFSET.
2. Add Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

v1:
The dump prefix is added to facilitate the reading of the dumped memory.
However, if the prefix content is too repeated or redundant, the readability
is reduced, and the ring buffer becomes full quickly and other prints are
overwritten.

For example: (DUMP_PREFIX_OFFSET)
Before:
dump_size=36:
00000000: c0 ba 8c 80 00 80 ff ff 6c 93 ee 2f ee bf ff ff
00000010: 00 50 1e 98 ff 27 ff ff 01 00 00 00 00 00 00 00
00000020: 80 ca 2f 98

After:
dump_size=36:
00: c0 3a 91 80 00 80 ff ff 6c 93 ae 76 30 ce ff ff
10: 00 60 cd 60 7d 4e ff ff 01 00 00 00 00 00 00 00
20: 40 9e 29 40


Zhen Lei (2):
  hexdump: minimize the output width of the offset
  hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16

 include/linux/printk.h |  1 +
 lib/hexdump.c          | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

