Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9976C822
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjHBINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjHBINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:13:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7C2689
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:13:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso10820296e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963993; x=1691568793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y/bQQbBFHXNw50XUcOgOJzdcwsaF1ZFeXZB2P7FgjM=;
        b=csnH5qnZNRgQkg/B+nfGz7zVemQT+gGvFMobtlHK8PmLj2NEIk81Dg1RgIwrPOKQaF
         CSSKfKgqiGXCHTcvCB4092k4CCD2O0Yz0o5XK7jr/ehZ6cP8627jVZPHIBULuypRWVFY
         5lUgUrOIicnA4Iw17NOSQVQaEztdbIuo1oEcbFWwNzjCCSocKLRSxjqsmwLLmFRdukUA
         iRqIq6Bx+LSNbAsz2enAsWsiIId0DXiC71Gh6ZIzE9NdmeUrnMwZAJgXVFHNmpw4eI/j
         3G88B6BQ4jh10ED3tPMqUumWi4nrcVzf3tb5mXl2952Ta2ry99uBPObhwLudwC8K90T8
         CxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963993; x=1691568793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y/bQQbBFHXNw50XUcOgOJzdcwsaF1ZFeXZB2P7FgjM=;
        b=DRhzH2oVLM8RODmKNTq8kif9tq2aK1CcM8B6kf71hEN5xau2BJC+wk3nE1n26kdIOe
         soSrkKfZIfspKpm6wu1xMGdM5Ih3yRLKt5OfS3SybOsScSEEWcOzl9wad0anssqD0kAv
         Qs7Mwv+nUEaeWQXp/KTK75q0FhTqcsaZQXmoYifsneCJFrcrUEXMzL8CV0kY/va7Gfeo
         fFcEmHPr17WBLi3e1r1uAA7TFFI58f4mU9Grc5U/YJTLgiLb8gfJibriuMaaJ9uHkerM
         ZtIcDCYjHzMgG8jMeE1wTomrDI2jmgqS2qO6/JzEXjxI6/2x/JmxcWIEJipzrPClbX5y
         FHHw==
X-Gm-Message-State: ABy/qLZJ72ozLpSWO9LAtH6t2ZWGaC7D0eequorE+hX8QrfWST/9n8sv
        uELcHdYItCZStFuzV5ZfX1wQ9w==
X-Google-Smtp-Source: APBJJlGK09HgaF9wFvXB+jOQcgV4RSRZVrsi2YRdYqNUz3TOvrlz2ov4hOf7OCGN+tQF8Incs16BXA==
X-Received: by 2002:a05:6512:4003:b0:4f8:7055:6f7e with SMTP id br3-20020a056512400300b004f870556f7emr3111543lfb.44.1690963992981;
        Wed, 02 Aug 2023 01:13:12 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003fc01f7b415sm1013823wmh.39.2023.08.02.01.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:13:12 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v6 09/10] tools: lib: perf: Implement riscv mmap support
Date:   Wed,  2 Aug 2023 10:03:27 +0200
Message-Id: <20230802080328.1213905-10-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802080328.1213905-1-alexghiti@rivosinc.com>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv now supports mmaping hardware counters so add what's needed to
take advantage of that in libperf.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 tools/lib/perf/mmap.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 0d1634cedf44..2184814b37dd 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -392,6 +392,72 @@ static u64 read_perf_counter(unsigned int counter)
 
 static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
 
+/* __riscv_xlen contains the witdh of the native base integer, here 64-bit */
+#elif defined(__riscv) && __riscv_xlen == 64
+
+/* TODO: implement rv32 support */
+
+#define CSR_CYCLE	0xc00
+#define CSR_TIME	0xc01
+
+#define csr_read(csr)						\
+({								\
+	register unsigned long __v;				\
+		__asm__ __volatile__ ("csrr %0, %1"		\
+		 : "=r" (__v)					\
+		 : "i" (csr) : );				\
+		 __v;						\
+})
+
+static unsigned long csr_read_num(int csr_num)
+{
+#define switchcase_csr_read(__csr_num, __val)           {\
+	case __csr_num:                                 \
+		__val = csr_read(__csr_num);            \
+		break; }
+#define switchcase_csr_read_2(__csr_num, __val)         {\
+	switchcase_csr_read(__csr_num + 0, __val)        \
+	switchcase_csr_read(__csr_num + 1, __val)}
+#define switchcase_csr_read_4(__csr_num, __val)         {\
+	switchcase_csr_read_2(__csr_num + 0, __val)      \
+	switchcase_csr_read_2(__csr_num + 2, __val)}
+#define switchcase_csr_read_8(__csr_num, __val)         {\
+	switchcase_csr_read_4(__csr_num + 0, __val)      \
+	switchcase_csr_read_4(__csr_num + 4, __val)}
+#define switchcase_csr_read_16(__csr_num, __val)        {\
+	switchcase_csr_read_8(__csr_num + 0, __val)      \
+	switchcase_csr_read_8(__csr_num + 8, __val)}
+#define switchcase_csr_read_32(__csr_num, __val)        {\
+	switchcase_csr_read_16(__csr_num + 0, __val)     \
+	switchcase_csr_read_16(__csr_num + 16, __val)}
+
+	unsigned long ret = 0;
+
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE, ret)
+	default:
+		break;
+	}
+
+	return ret;
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+
+static u64 read_perf_counter(unsigned int counter)
+{
+	return csr_read_num(CSR_CYCLE + counter);
+}
+
+static u64 read_timestamp(void)
+{
+	return csr_read_num(CSR_TIME);
+}
+
 #else
 static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
 static u64 read_timestamp(void) { return 0; }
-- 
2.39.2

