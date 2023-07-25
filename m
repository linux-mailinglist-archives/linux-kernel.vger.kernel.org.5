Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE83E760B24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGYHGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGYHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:06:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679512C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:05:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3056103b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690268757; x=1690873557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YiFtbazXCGKkSvCu29PAaqFDD+rQJcJJfLFd8Lc7dE=;
        b=Lo8PhI9mKE9la2FEdDvKX1tKoJGeVXRVcEQOW8jg2w5CkcWv8ZCbVQoo+JCfVSl54g
         Q5oJhDZ3TzZ7C7f224IcRM8uioFnSKcrB1Pdr3oK9+sDnWK6kd/KXRBMXqCeeYoeTpUJ
         MuP9Gl3ESPfQLD1iIuQDEpJkLT6PhSJHM+mSwSGBK9n/umasczanNmv3dkxRML+cA/6o
         hz/XazC11REsa+u1YQHtT5OxoXhozjrPCdMJjG/tH+b3nSxQs9R569DldPwxdVpzhK9F
         jUFVWptCwB8EEhQSjyNw0S1XavIOqT4w97EAteNO4iJZ6461qx8mn6jPQtdMdgKKY8jf
         aKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268757; x=1690873557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YiFtbazXCGKkSvCu29PAaqFDD+rQJcJJfLFd8Lc7dE=;
        b=j0eK2ZH3iPVvyF9Ea8lz8uvxazzkrtH42aNvjZ0RXCCtprpUB3xUIBpDKrURCTluLJ
         ahfrTae+/GzGpKOEpZeWs9t8d86ZSDcKoN40+CBz1Wp8zu4ZFdi9QC56GvTHTpT+50JM
         UjAlHVS0iD/s4eQx8CWOdnlJ26DV+CLeA8O+ujbnrjgTJHKWYnVky/H3k6BAtwaTfxoP
         QrnSJ063eRakg0vW7kG6uWY737H9cZSY9OijDRyDijyN4+8P7VdaQV6PL4lkO3dyWA/2
         /85FZMT254+v4vezcGsVoxft7tMsGwcjflusKuA+gq6RuuMhfoaIEdyGrbLF4/4gGUQE
         ajAQ==
X-Gm-Message-State: ABy/qLbDzLo1OiUxf6ClpfoDF7KzyRlccegnxvqJbq6hZQTZ3G8V77iT
        nOM4L428IjZuKbRoB7mcgsKglg==
X-Google-Smtp-Source: APBJJlF1A/Z82CCGebQwtGRBNWpKXwCNpXTVvBfVWCdAsLP+dS3MDL1fCd2yzzWjcU83xc4D0sJCQQ==
X-Received: by 2002:a05:6a20:9717:b0:12d:4c17:bb2d with SMTP id hr23-20020a056a20971700b0012d4c17bb2dmr9066791pzc.26.1690268756829;
        Tue, 25 Jul 2023 00:05:56 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b00640dbbd7830sm9165478pfn.18.2023.07.25.00.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Jul 2023 00:05:56 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] riscv: Fix local irq restore when flags indicates irq disabled
Date:   Tue, 25 Jul 2023 15:05:49 +0800
Message-Id: <20230725070549.89810-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arch_local_irq_restore() is called with flags indicating irqs
disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
implementation based on csr_set() function only sets SR_IE bit of
CSR_STATUS when SR_IE bit of flags is high and does nothing when
SR_IE bit of flags is low.

This commit supplies csr clear operation when calling irq restore
function with flags indicating irq disabled.

Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 08d4d6a5b7e9..7c31fc3c3559 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
 /* set interrupt enabled status */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
-- 
2.39.2 (Apple Git-143)

