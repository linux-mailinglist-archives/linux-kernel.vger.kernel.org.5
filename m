Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372937632F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjGZJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGZJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:56:20 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB93B6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:55:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9pp303mvz9v7bl
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:42:03 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.211.226])
        by APP1 (Coremail) with SMTP id LxC2BwBHo95C7cBk+WYTBQ--.33492S5;
        Wed, 26 Jul 2023 10:54:52 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Alyssa Ross <hi@alyssa.is>, Li Zhengyu <lizhengyu3@huawei.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org (open list)
Cc:     Torsten Duwe <duwe@suse.de>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v2 3/3] riscv/kexec: load initrd high in available memory
Date:   Wed, 26 Jul 2023 11:54:01 +0200
Message-Id: <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHo95C7cBk+WYTBQ--.33492S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13KrWrXFWfuw4kArW7XFb_yoW8Gr1Dpw
        sxCF4UGrWUuwsrC34j93Wxua48Aa95Wr1aga1DCayrJrs8XrW5Z3yqq342vF4vkr1agF9Y
        vFyY9r1S93WkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjmFAJUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

When initrd is loaded low, the secondary kernel fails like this:

 INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region

This initrd load address corresponds to the _end symbol, but the
reservation is aligned on PMD_SIZE, as explained by a comment in
setup_bootmem().

It is technically possible to align the initrd load address accordingly,
leaving a hole between the end of kernel and the initrd, but it is much
simpler to allocate the initrd top-down.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/elf_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 38390d3bdcac..c08bb5c3b385 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -281,7 +281,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		kbuf.buffer = initrd;
 		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
-		kbuf.top_down = false;
+		kbuf.top_down = true;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(&kbuf);
 		if (ret)
-- 
2.25.1

