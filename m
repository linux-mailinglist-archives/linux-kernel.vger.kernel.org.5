Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F17AEF42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjIZPEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjIZPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C3116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40471c054f9so26829005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740635; x=1696345435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nyDpPdQazxwk2pvs7+quB1sTF8r3wWKIala/GUDnoY=;
        b=iQLtiJWikzzMfUnX3aBxlqJxZO34Oq4/0eY/4zy67P0ae538nhd3lqfHSMLJchldeK
         6n3PW+U4oOlKeEViXFYxh5ZUEYM2usI5M0eNEKFEZDinKouPCi5RYHGmDwO90vHLqXiU
         wJqfOI8WZSQ204TPtgtXqGRtN/AsPYi1KbzDLeHGOZODi0UnwPyrjcjrEoLRwRw01nID
         ImKqw1BsTT4/zSIqlQZuEpbqBrv3ppcWmv1EBsv6eVHAT89LCMU/JYfiyTx72i2TIeeA
         r3R1T3aio4/TENIvKRyTmPjEHUntHoHtPy8K/3JyWjEU6HadoF9bqonMDkp2WYssA77j
         yG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740635; x=1696345435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nyDpPdQazxwk2pvs7+quB1sTF8r3wWKIala/GUDnoY=;
        b=EXRs2uNRqTy2MniqwjHv85MGCm9VtXF3u7jU/DboljUF24kZE7KvVn4O6mtI8Pt5Q0
         /mANJUkCaAuo+yqb8WZCNwIzehlhr4O8LubsVxJejX+hpFu97QB9zZo7c1VdVDRMs8XS
         ySOauW7Z9Gdqv83FmfcVGtGMpW0uGqzg8l5LfV+ke/Q72JGnIhLfbzZ+5R+r4SfprHjl
         WfSNRI0nMw3VO1hGtcOwribRRB7VCh36rSa1fmcF16mTK4YY14mVonEjgaIhMgmaNiyn
         iwjXY6y4Yjlwsj8pV94Y9akRo6Z9E3tNXk6jGQ84hsXXgCwHgJUdxx0cJ12QENW4uiUq
         ncjg==
X-Gm-Message-State: AOJu0YyTsiLFMIGcvMLAutj8EWxvY2/MXLKDXA38Q4j4rrOnjiUrtbXZ
        b+NG6lxFt2ZURovys7QHcxnfOw==
X-Google-Smtp-Source: AGHT+IGYli5WdDX3fLxDTBPXQEXiU0p8vh4593GY6BMsCSxPr/ByItH+Sc2kbRCDAkHR7bnBCb9y6w==
X-Received: by 2002:a5d:595e:0:b0:31f:899b:a47 with SMTP id e30-20020a5d595e000000b0031f899b0a47mr8497274wri.4.1695740634745;
        Tue, 26 Sep 2023 08:03:54 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:54 -0700 (PDT)
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
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 3/7] riscv: report perf event for misaligned fault
Date:   Tue, 26 Sep 2023 17:03:12 +0200
Message-Id: <20230926150316.1129648-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
2.40.1

