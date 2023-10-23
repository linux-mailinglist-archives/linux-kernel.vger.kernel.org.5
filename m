Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4157D2CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjJWIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjJWI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:29:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762CD7B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so2386712b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049795; x=1698654595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUO1/BVdvM4H5C6LBNItdP0IIJipRGNxmDV7eD7nopg=;
        b=eIYgUBkXxqcUP0Fa4z7vj8CIE5bLNxOer2Zrmzreg36NkvNydrY5vMC1ckvF/Ei60M
         0cmk2xdY6RkcYFLQ4QG4z9dO9cNwvm/UKD1Wojx7RSkgNDTJ2phfJ8JoBwfIGd7xL4W7
         K1L8g/zVyGF3JT7EbxnhYabXmBv40ESR4rqqcf8ffNLbUTKHrsjW9fo72FGc31s50fTR
         x07UFMAMOMe9N1VrgS3RcdypsifHCmUvus/kaEGh7q3EFhTY8vj+14yMUTas77+PaqZJ
         Iij0X4vIlEjVECHAFjLDqVGbdgqWgE26Uvg8ZItAlDWiA6SlYslVhw5qhdDq0Ci/XtYZ
         PL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049795; x=1698654595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUO1/BVdvM4H5C6LBNItdP0IIJipRGNxmDV7eD7nopg=;
        b=eOG3RQnWcde32Y9SWVSREX51lxF3U92XdFmLyPu3NqvqbVcjEy1W4VQ2Xoz7FjK62d
         XZD+Nk4AvvjxI+L9U+WlT5Z2Zt+Q4/IYfNPp4zPfqtREYHsm3odnf+Nl+U1yOegzlNpI
         Bjy1K8R+xKVA/CgYWC6lAA/dsRqBQvm1xg3xL3uARy4NmVIar0u7TtSihK9INmAIT1jD
         Xl/iPEf+IDHi7p+3DgjcpeNSoEBXa9Mr2ScgN0TQGunSKKnQP83+j8NZNJsPx+dQ/PZF
         b2bEFcNR4E5UT+UMv9VnmhoNcuG0P61Dk0X1nRoIJSOfzF9qcBMM1V6g3SnoGyF7fZaG
         yYkA==
X-Gm-Message-State: AOJu0YzlYWwmrGSTxK7F8YkcMVKm+weIiHIV8tTKx7/jShuoZm4ZjqW1
        bQ47tdsQ1nF6d3IBRhemtPdO5g==
X-Google-Smtp-Source: AGHT+IEuewyI9+tw5QJUm2oN6guHecDPjWsmm8bO+1FZNslxYqHTr+PcfG3+59e4kYZAI8n0lGmkLw==
X-Received: by 2002:a05:6a20:2615:b0:151:7d4c:899c with SMTP id i21-20020a056a20261500b001517d4c899cmr4935811pze.25.1698049795184;
        Mon, 23 Oct 2023 01:29:55 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:54 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 06/12] riscv: Allow requesting irq as pseudo NMI
Date:   Mon, 23 Oct 2023 16:29:05 +0800
Message-Id: <20231023082911.23242-7-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements pseudo NMI callbacks for riscv_intc_irq chip. We
use an immediate macro to denote NMIs of each cpu. Each bit of it
represents an irq. Bit 1 means corresponding irq is registered as NMI
while bit 0 means not.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Hangjing Li <lihangjing@bytedance.com>
Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
Reviewed-by: Yu Li <liyu.yukiteru@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 17 ++++++++++++++
 drivers/irqchip/irq-riscv-intc.c  | 38 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 60c19f8b57f0..9700a17a003a 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -12,6 +12,23 @@
 
 #ifdef CONFIG_RISCV_PSEUDO_NMI
 
+#define __ALLOWED_NMI_MASK			0
+#define ALLOWED_NMI_MASK			(__ALLOWED_NMI_MASK & irqs_enabled_ie)
+
+static inline bool nmi_allowed(int irq)
+{
+	return (BIT(irq) & ALLOWED_NMI_MASK);
+}
+
+static inline bool is_nmi(int irq)
+{
+	return (BIT(irq) & ALLOWED_NMI_MASK);
+}
+
+static inline void set_nmi(int irq) {}
+
+static inline void unset_nmi(int irq) {}
+
 static inline void local_irq_switch_on(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 7fad1ba37e5c..83a0a744fce6 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -67,11 +67,49 @@ static void riscv_intc_irq_eoi(struct irq_data *d)
 	 */
 }
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+
+static int riscv_intc_irq_nmi_setup(struct irq_data *d)
+{
+	unsigned int hwirq = d->hwirq;
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (WARN_ON((hwirq >= BITS_PER_LONG) || !nmi_allowed(hwirq)))
+		return -EINVAL;
+
+	desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
+	set_nmi(hwirq);
+
+	return 0;
+}
+
+static void riscv_intc_irq_nmi_teardown(struct irq_data *d)
+{
+	unsigned int hwirq = d->hwirq;
+	struct irq_desc *desc = irq_to_desc(d->irq);
+
+	if (WARN_ON(hwirq >= BITS_PER_LONG))
+		return;
+
+	if (WARN_ON(!is_nmi(hwirq)))
+		return;
+
+	desc->handle_irq = handle_percpu_devid_irq;
+	unset_nmi(hwirq);
+}
+
+#endif /* CONFIG_RISCV_PSEUDO_NMI */
+
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+	.irq_nmi_setup = riscv_intc_irq_nmi_setup,
+	.irq_nmi_teardown = riscv_intc_irq_nmi_teardown,
+	.flags = IRQCHIP_SUPPORTS_NMI,
+#endif
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.20.1

