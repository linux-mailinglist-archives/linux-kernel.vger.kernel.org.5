Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5133B7655B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjG0OQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjG0OQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:16:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188930E3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:16:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so10279315e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690467400; x=1691072200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=1D/LtkuWMncLALJQA5Oohv9cG2Yw+utKrrqtK7JM1Yn+RymNvnSY9fFX1PAdOFVeFE
         +EX6RtgOuFxjr92TeijPn7uPEeNPprpopyNfm4DKu1YQS60vpDYm97TMm2WA9IjYgrq9
         Z3b4kymmbenBoGqlHA4IGwvWqjIUqqdILO4p1ldIlhsqIgrkvJWVsxVRnD2pr40UmyvI
         GUkRgoCKbYOQGm+SSqgBoGHcyLTdDbsx0VDmg6KBrY1rScjMUOHT4RauNbC6fqgNdVIN
         KPlCA2ru+fvWXDWpul7da/vvCtyBhVp3gfp0i7CgchDcih5kFfwJsBrXkPJzk7TYoh+F
         k/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467400; x=1691072200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFKT0CCXN0CmmHE2x8MUQw5sccSB1SdakxOhkM1UsG4=;
        b=ehPzB4LM8UE6EHKC2tYZD7JtNoX+a5QSW3EtNgBPaNlGYiwiNyaXD1fIQuGg7NYJdf
         vc8H/roKaPsxGr/TBJQdndJ52y2bVezrXSepDMZoBS8Da2akywnefsHARtKxFYBcD1iU
         RmaiDMVes4ZF3DS1a/oC/HvKr4WRfE2LcFgv5ImqmE+vxjlXwCRwTiiFFG9VZMfgE395
         GcnQWafYeaG2ynt7jeRSZufXhgx0Ly6J9toDNI/Cu5pz4HyDQNrcVjftAHuU2bSNJZ+s
         rGAaSxR6VqQlP45iI4KcYvcpt9PDaSHkwwJERZOVkb/Mqi4zA7X/I4ylHELw5zqFG/tW
         lwlw==
X-Gm-Message-State: ABy/qLYdsJNXJOqWBKl5cDlo4gqXlW8F02aEU3lEhwS/AF+pCbELOmiF
        Uv/3Iaab2oyCRmC4F/QbRml39Q==
X-Google-Smtp-Source: APBJJlFGXcEc5+7cQs2g/tb5RaUcskCDcRqTea7shaZLYg1es1PZHB8gAvi5TEUY06Z7+y5IFGcPcw==
X-Received: by 2002:a05:600c:20d4:b0:3fb:c9f4:150e with SMTP id y20-20020a05600c20d400b003fbc9f4150emr1784324wmm.14.1690467400406;
        Thu, 27 Jul 2023 07:16:40 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v16-20020a1cf710000000b003fc080acf68sm4789003wmh.34.2023.07.27.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:16:39 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 02/10] include: riscv: Fix wrong include guard in riscv_pmu.h
Date:   Thu, 27 Jul 2023 16:14:20 +0200
Message-Id: <20230727141428.962286-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727141428.962286-1-alexghiti@rivosinc.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current include guard prevents the inclusion of asm/perf_event.h
which uses the same include guard: fix the one in riscv_pmu.h so that it
matches the file name.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 include/linux/perf/riscv_pmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 43fc892aa7d9..9f70d94942e0 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -6,8 +6,8 @@
  *
  */
 
-#ifndef _ASM_RISCV_PERF_EVENT_H
-#define _ASM_RISCV_PERF_EVENT_H
+#ifndef _RISCV_PMU_H
+#define _RISCV_PMU_H
 
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
@@ -81,4 +81,4 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
 
 #endif /* CONFIG_RISCV_PMU */
 
-#endif /* _ASM_RISCV_PERF_EVENT_H */
+#endif /* _RISCV_PMU_H */
-- 
2.39.2

