Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4E7B834F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbjJDPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbjJDPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F06BBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40651b22977so4786545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432466; x=1697037266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A29BZTVXLOLIyIz1ohc6hcIwjz2FYyV3nDH2JWKPVDg=;
        b=038fOEJ7sMKpTNos3DP4JF9BjrQ0B1hvj3xVwgi210QNblv0DcTlVsUii8uxv7sw8u
         PoGZ/QiffIshotB255I0FB8ncOZbx73LVaM73MLfrArkam3vK79CJjatl+xLzwyLSwgv
         Fz+GGNEYh+IXyey6noexJEx27YXvqi4NfcQ3/jS4nIuokAM163tJoM93WiURJX2GT0ku
         +VuwvpPH/7PYmYLz+5JoAikFweIOKYCRBNg5QQYSub5RaLd3YJBDkUstxXprK3T9oJl+
         QvWUYnOP2F3/yHSo1QiOCWu2hat4+E48gwqJ280EW8eMjmr4AwY4S2l9OQtiXR3yDBf5
         OAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432466; x=1697037266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A29BZTVXLOLIyIz1ohc6hcIwjz2FYyV3nDH2JWKPVDg=;
        b=XjpwtYIJjDl3ewq6ro9z2n59B05Iq2N9KkdK2j4Ys6yfktKs8Y/A2uTtrpT7Lmyhl9
         1kBYrfQ6eNSKtOH2jniVNFc1eeAYLMKoHpB1/ph8xXvHvkD3ItxvAii+pHnv3rEBPT+v
         Q7OgoX1Y3fkuHAovfkZRjn32aNHoo2MF/RxvQkpMsR4GtI/3mA/cV0PptNj7ZkUvIjfH
         OaNBQCw1AWiy3qHksUWE/7FnzE7O/99eDiAnpi/kcSUmqtc1jE3MO0iAJgRduDzYCTWL
         HTtHEZh986PlZMSCu9rjIuAA2fGD1UtsrN/3XeAmZMldgiC+WFAkEBUQtC5eVNhKQ4Lb
         z/Xg==
X-Gm-Message-State: AOJu0YzBjVguGZdiKBy+EWD5Vt/xItXDI//WI8SDNciyaNYRtN0Z5wSg
        rFR0LPM6ygTExqYPWoQGsmTOzw==
X-Google-Smtp-Source: AGHT+IFAs4QCRFIPXdPu9HEhZ6Wlf941rotRjfMZx0FFxD9JoHwVNXpveZ0GmS/Rdy6s4UjHyzja0A==
X-Received: by 2002:a05:600c:3c96:b0:403:334:fb0d with SMTP id bg22-20020a05600c3c9600b004030334fb0dmr2534922wmb.4.1696432466012;
        Wed, 04 Oct 2023 08:14:26 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 3/8] riscv: report perf event for misaligned fault
Date:   Wed,  4 Oct 2023 17:14:00 +0200
Message-ID: <20231004151405.521596-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing calls to account for misaligned fault event using
perf_sw_event().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 9daed7d756ae..804f6c5e0e44 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/perf_event.h>
 #include <linux/irq.h>
 #include <linux/stringify.h>
 
@@ -294,6 +295,8 @@ int handle_misaligned_load(struct pt_regs *regs)
 	unsigned long addr = regs->badaddr;
 	int i, fp = 0, shift = 0, len = 0;
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -382,6 +385,8 @@ int handle_misaligned_store(struct pt_regs *regs)
 	unsigned long addr = regs->badaddr;
 	int i, len = 0;
 
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.42.0

