Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667F762F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjGZIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGZIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:06:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78CE56181
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CIorq
        VVzQAbHZJUC4BNCOgZhZAEVr+TjS5Zo30Detsc=; b=l/NGQ3KMJcSYdMQcAXRCC
        Kb6LTOmgan9yuAZWYFc9dTLL9qZKqcxiYbCwaWlHrL/AMmUAOxWuem0hy+DtysGH
        JE/M5DiERCZ5aOjSkXxNpK5IyC5J+iE9QRUmzYacY9FxJ8Vbl7jY/L7h3TQnQDzc
        xMhBJQRSmJInihcjjR84do=
Received: from yw-virtual-machine.localdomain (unknown [180.110.115.47])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDXEzFczsBkuNlkBQ--.45898S2;
        Wed, 26 Jul 2023 15:42:21 +0800 (CST)
From:   wang_yang <wang_yang6662023@163.com>
To:     palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wang_yang <wang_yang6662023@163.com>,
        Wang Yang <yangwang@nj.iscas.ac.cn>
Subject: [PATCH] RISC-V: Use GCC __builtin_prefetch() to implement prefetch(). GCC's __builtin_prefetch() was introduced a long time ago, all supported GCC versions have it.So this patch is to use it for implementing the prefetch. RISC-V Cache Management Operation instructions has been supported by GCC last year.you can refer to https://github.com/gcc-mirror/gcc/commit/3df3ca9014f94fe4af07444fea19b4ab29ba8e73 It is worth noting that CPU based on RISC-V should support Zicbop extension. This has been already done on other architectures (see the commit: https://github.com/torvalds/linux/commit/0453fb3c528c5eb3483441a466b24a4cb409eec5).
Date:   Wed, 26 Jul 2023 15:42:18 +0800
Message-Id: <20230726074218.32933-1-wang_yang6662023@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXEzFczsBkuNlkBQ--.45898S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kKr13Xw4DKFWxCw4xCrg_yoW3uwb_Cw
        1xJa10grW8ZF48uFy2yw4rtrWjy395tF9rWF4Iy3WYy3srWa1UXa9rGw1UJryUZrs0qFsr
        uF98Zay8GryakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjsXotUUUUU==
X-Originating-IP: [180.110.115.47]
X-CM-SenderInfo: 5zdqwsp1dqwlawwsijqt6rljoofrz/1tbiYx649VaEP9up8gAAsd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wang Yang <yangwang@nj.iscas.ac.cn>
---
 arch/riscv/include/asm/processor.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..f16d4c85ca5b 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -70,6 +70,17 @@ extern void start_thread(struct pt_regs *regs,
 
 extern unsigned long __get_wchan(struct task_struct *p);
 
+#define ARCH_HAS_PREFETCH
+static inline void prefetch(const void *ptr)
+{
+	__builtin_prefetch(ptr, 0, 3);
+}
+
+#define ARCH_HAS_PREFETCHW
+static inline void prefetchw(const void *ptr)
+{
+	__builtin_prefetch(ptr, 1, 3);
+}
 
 static inline void wait_for_interrupt(void)
 {
-- 
2.34.1

