Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4673778CC03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjH2SZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjH2SZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:25:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF122184;
        Tue, 29 Aug 2023 11:25:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso611036966b.1;
        Tue, 29 Aug 2023 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693333514; x=1693938314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wJKsxPPAwU8P0xFe6s5m7FtWYcJnzstIMaUssxows=;
        b=USmTA0Zpnd39zNwCscgDhVmJfdimtkHk5M60JfbR4NeG8idAyycBdRUJ1DnrSNSWy5
         d/TcIOMuxuZ7Y8tSH/7W+LBOE6px3hkflXWSzYmbdy6sddLkq3FPZ88L2jZTOJ5rxPte
         t4JU2zKKw+hb1Q40geCpT1x2Q/DeRIkSYOMng6Q3W5cwB5fVZ6yYCNPcOF7bfvQjjDZL
         ilESCvGar1donrPd8nsWESwyiH1w96XibWBDHI2q5+UESwBags9bLKpXqWrdUFvyBroa
         Z+IA4W0euR01ZMNWvo8jmF73KyD5GYbnfFSdpVOla+Kudlzq+fHkf4aYh2tuwWaeGE8Y
         CQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333514; x=1693938314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9wJKsxPPAwU8P0xFe6s5m7FtWYcJnzstIMaUssxows=;
        b=IrERHn4QV19XQvJCLnSeQc7Cuqt4COVLb9m9I95VYYoULrl5Tkl2v+sQvIjPPj7uXR
         cUY+Urng17bwx3inwzCFyrsLTyY49loT7vZ1ZrM4DVL1HenOugJtMc4siT+7AeYmNNzL
         ZavrGERjSCbSWpR+bRCzTOlGWkG1YNJKv6jixperMm28llDXF1KFG/N74JUYy123TNQ5
         CLFuAHfiBYtJC1XnS3nYto5xHusMwqrDZe4FtZfbhA4cQrGfFbUHe2UrcgcF0EulVh9t
         o7wKiAWkeVF179np/HW8fJnhCXwoT53I+s7teSiUhTObCZmj0SiD03woCm2cn/hH4NH5
         itNg==
X-Gm-Message-State: AOJu0YxcGK6wD1r4KkzttIWpiBDrp/7qpQ1Qa0C3/P4C79xCgM/aTqPK
        ZQM/iyc1Sf7N63PDTYXPzMeHIIsh82Q=
X-Google-Smtp-Source: AGHT+IG09DLRH/DAaKEwd338k1tCj81ilV1q2bHbiBzkYx6c3tqUpN3c8PbENbHA3Hr5CoeQqX0aMA==
X-Received: by 2002:a17:906:2009:b0:99b:dd38:864d with SMTP id 9-20020a170906200900b0099bdd38864dmr21889620ejo.23.1693333513740;
        Tue, 29 Aug 2023 11:25:13 -0700 (PDT)
Received: from nam-dell ([131.155.246.6])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090606d800b0099364d9f0e2sm6243333ejb.98.2023.08.29.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:25:13 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     guoren@kernel.org, Nam Cao <namcaov@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] riscv: kprobes: allow writing to x0
Date:   Tue, 29 Aug 2023 20:25:00 +0200
Message-Id: <20230829182500.61875-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instructions can write to x0, so we should simulate these instructions
normally.

Currently, the kernel hangs if an instruction who writes to x0 is
simulated.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/probes/simulate-insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index d3099d67816d..6c166029079c 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -24,7 +24,7 @@ static inline bool rv_insn_reg_set_val(struct pt_regs *regs, u32 index,
 				       unsigned long val)
 {
 	if (index == 0)
-		return false;
+		return true;
 	else if (index <= 31)
 		*((unsigned long *)regs + index) = val;
 	else
-- 
2.34.1

