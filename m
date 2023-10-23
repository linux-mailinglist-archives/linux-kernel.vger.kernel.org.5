Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE37D2CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjJWIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjJWIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4BD78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso2364945b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049784; x=1698654584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTPdJw2kGsvWjCGGMUBG2xz20Ji8Kpf17R3X8M8D7Aw=;
        b=QXrBeRI9/K2u7fFuEiXyWhP+s+WDdIkIDNK7dgyOyREi7X/AaaFR5ZxO59sCIK1Be7
         Hfg3pqCjVLhgx0fEYu6As3sAciDBzXuQrxwSR/RBKYwrEJOX7uPyozsjX/w3qPivaLoh
         Gu7FbhsbtVvYjV1bETgjQhzEGooawk4MrbmPh3ZeujuRuvvbb/6x4VwF1DvsNoUtPkW8
         QvExDqWKO6QeUSMU9V2kTRRhBAabH6QUaabugN6ZhkcG6SSMA1ji9g9y7DJeHRB66Mee
         PSYa6t5j6d323VNRb/gg46biF2cL6CXMMRl2RFsptajj6DHo8vmwKMedhIPN9kSQIMba
         Ltfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049784; x=1698654584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTPdJw2kGsvWjCGGMUBG2xz20Ji8Kpf17R3X8M8D7Aw=;
        b=gitXaW1cLgpjpWc0NeLY7z8etkWB3ItUNFAgjg9o2IFMLw0hfEF1Ni8LoGiLNpnE6u
         jNLW4epXAZGq8pA/Ft6PyCu6s+ugTKpKT9vR4kbI1ZdeTz13iNBNm9JvTNU5+m4/Mydf
         5m94Af+AvG9iXro4Fq5EzEXye9vvIRCH9lSKk9NurMiiUSW6HUNA29LXMLpmRUNlDyvC
         yWfggeSjCc4DXAmoEn8ZEy3pSP28mFxRFrYH/oxSit+j1TAfsdQ5N58biuN+21KYz1LG
         8sih9c4YBPBVW99Y95JQczdSexOdJX9Cn4Sol3ESwAmi47zEjt6s7kV/YVufrPtXi1PT
         Dxjw==
X-Gm-Message-State: AOJu0Yz0QVI9h96brbS7Ikz3SuFmwJc159u2ytwvARrhg34P3CKUGLBg
        e60K6gGXLV5FeS7qsVreH43TIw==
X-Google-Smtp-Source: AGHT+IHy0ee6CNfNaI0e1G2cSIdQi3bfs3nWqXWt1dZTbNcZKi88wQbICOA1lqr6IbE3K2mo4LQppQ==
X-Received: by 2002:a05:6a21:3398:b0:174:1466:359c with SMTP id yy24-20020a056a21339800b001741466359cmr6820626pzb.61.1698049783818;
        Mon, 23 Oct 2023 01:29:43 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:43 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 04/12] riscv: Switch back to CSR_STATUS masking when going idle
Date:   Mon, 23 Oct 2023 16:29:03 +0800
Message-Id: <20231023082911.23242-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WFI instruction makes current core stall until interrupt happens.
In WFI's implementation, core can only be waken up from interrupt
which is both pending in CSR_IP and enabled in CSR_IE. After we switch
to CSR_IE masking for irq disabling, WFI instruction can never resume
execution if CSR_IE is masked.

This commit handles this special case. When WFI instruction is called with
CSR_IE masked, we unmask CSR_IE first and disable irqs in traditional
CSR_STATUS way instead.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/processor.h |  4 ++++
 arch/riscv/kernel/irq.c            | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3e23e1786d05..ab9b2b974979 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -111,10 +111,14 @@ extern void start_thread(struct pt_regs *regs,
 extern unsigned long __get_wchan(struct task_struct *p);
 
 
+#ifndef CONFIG_RISCV_PSEUDO_NMI
 static inline void wait_for_interrupt(void)
 {
 	__asm__ __volatile__ ("wfi");
 }
+#else
+void wait_for_interrupt(void);
+#endif
 
 struct device_node;
 int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 9cc0a7669271..e7dfd68e9ca3 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -15,6 +15,23 @@
 #include <asm/softirq_stack.h>
 #include <asm/stacktrace.h>
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+
+void wait_for_interrupt(void)
+{
+	if (irqs_disabled()) {
+		local_irq_switch_off();
+		local_irq_enable();
+		__asm__ __volatile__ ("wfi");
+		local_irq_disable();
+		local_irq_switch_on();
+	} else {
+		__asm__ __volatile__ ("wfi");
+	}
+}
+
+#endif /* CONFIG_RISCV_PSEUDO_NMI */
+
 static struct fwnode_handle *(*__get_intc_node)(void);
 
 void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
-- 
2.20.1

