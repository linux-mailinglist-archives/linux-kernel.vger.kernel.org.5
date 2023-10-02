Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1127B5698
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbjJBPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjJBPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:13:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F91BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:13:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406618d0992so27690385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696259622; x=1696864422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKlKP5/9RI4UDE4Mv9BGz18R+1865OFX4ZcGb0PXpPY=;
        b=McGLoOxdOdJdPFW2gBLOKuAsGz+Dpf+U1zf66LURHpycGoduMXYrB72MRpiKHBxQGu
         DlHRIc5JFAImkwD78dhw3xnHx6/QpqqmckZlPKmEuUBfA3VMRDYWMBnymXmq5ACrdK8p
         jMBl96IZgVSOmOFnE6c8LHxSfQlW9rcrFlSWjEuX+l6hXQByBBXduNPPuXYP1dXNbAr9
         v/s7gbppGuaP7BlPnLac2C/70PrW2nXztcNYQsL3OW1r+WXwYERdeLQET7gRw/kYfihL
         Ib/Z8ZIy2rUuyhe/9p6M8iRkzRmRPrClWpRR4li1UgBmZ8BLqFNu2SC323ZuAoGvEoGZ
         3GYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259622; x=1696864422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKlKP5/9RI4UDE4Mv9BGz18R+1865OFX4ZcGb0PXpPY=;
        b=C9GnVaX1RQysH2GplfbgABtiDlCTdb2Y8sy1a5ZLjHn8+k1EkpEB8GOFsFODWASnkP
         CnJORKQuqu935kNIVG74mvvTCYPECtQ4Fo+sMZhXVyf615Y3JK7vsAOfm34dfv2RJNpS
         cXtm8jxK8Ja5mbUAuQ1w3XSoWDHqk43xgCxu6lyCP0nmGHYWXKzx69lBD59R/OyFC37K
         rGzwZCBcqGvctQ0m+lio3LWuCi4FVcjUCtWLQPpdbljwugxm2H+kLQ8689bGMy6emx7+
         bBvMyt1mCwAxcrgt4mb39Jnq+wS0DTQUMfy08aEOxCfpCTIVw2jIDBrP6Y/uoqA1oaKU
         8/IQ==
X-Gm-Message-State: AOJu0YyvjMLdQsx+Hweq5+hpGJ9djnf/AFa4sD9dTev3xR8H+16PkAG8
        yNEDyMRLlPCGWXqEdMunw7NcjA==
X-Google-Smtp-Source: AGHT+IHO+YzsPhqZFo4O8yw5o3ilb0oSA+vYnzJ8XqlEcYHitO4Hyb9F4EkPU7aucBS8UpRf+rPooA==
X-Received: by 2002:a7b:c8d6:0:b0:406:5190:7d07 with SMTP id f22-20020a7bc8d6000000b0040651907d07mr11349388wml.17.1696259621727;
        Mon, 02 Oct 2023 08:13:41 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003fbe791a0e8sm7509731wmi.0.2023.10.02.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:13:41 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/5] riscv: mm: Only compile pgtable.c if MMU
Date:   Mon,  2 Oct 2023 17:10:29 +0200
Message-Id: <20231002151031.110551-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002151031.110551-1-alexghiti@rivosinc.com>
References: <20231002151031.110551-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions defined in there depend on MMU, so no need to compile it
for !MMU configs.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 9c454f90fd3d..c71d4253a171 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,10 +13,9 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += pgtable.o
 obj-y += pmem.o
 
 ifeq ($(CONFIG_MMU),y)
-- 
2.39.2

