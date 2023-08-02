Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347A076C824
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjHBIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjHBIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:14:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7681BE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:14:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so70101645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690964054; x=1691568854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjQVCQzw/foc3dsQkAiySfY58yT/va7beD4yh0w30/c=;
        b=LVFQ2dZGP21fC/kUACk7CYGiwQnTmTdEMNpsVOwilpWSU+otD0Tl3tdGDllj7tXr1W
         jhKu7YfUMIsWFCxb+4ETnF5P6/3sgg3A8MZYT7Q9MQPJDOZDjk8/0XpWOjlQJpGFGSxn
         rcYkG6fylsTc+/K5y38AtKdbl/emEf0U9Jzni7oIVRNeq4OSYQnuEaK3bZU/4qMEESW0
         PwrTdMeseO38VBX2C4ycjFvlxVegWLgWpMQkROEpwdsUzl2Yrhzufa8Oc76mYFKCFdwo
         +7al1faTYq/Z4RNiHU+SgKQQJVzCV2A97XGxIZam5EIhhXwTzkvb71s8vWM97pDy60+Y
         t09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964054; x=1691568854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjQVCQzw/foc3dsQkAiySfY58yT/va7beD4yh0w30/c=;
        b=dhTmZO+1z7H23/oOfSQmwqMWPy5FH/JRqg4iVeMYs+5Fzup+ts3wajQkX9o5dhVdzW
         i28LZujZVvgrGI/+s9QtjBHSVSpaz6+bx/QcNk2FUTNvYhBLOvZQkEnSqDY3Y2aza2eI
         qcffbXRVJZyUuiOfYE7kekrkehHDQdtsJUFbCeYgaXUwcR/riFfe04Twht5j4s/7aMwQ
         QP2Mai65F4NaFHN8S5j+BgOKjqwJCEEKdUhwa4F2H51fB07aEuaqMFCTj9Hi62rvRMr4
         PrKVtbJe/fjLFBSiIIrLiyNheGQ8BEg883BFtaYt0LLHVsYgucDo8AN94G5hquwaObm6
         8hFQ==
X-Gm-Message-State: ABy/qLZIgMYw5/eFY3rM3y2O+FeXae5/zVTgVw7lvGxxZZbq8n21QAiH
        ziw+J7XyZEvzi4Yi0v8YFoQU+w==
X-Google-Smtp-Source: APBJJlErLwgoDP8iDix/tr5UDLAhtyf8g2R724EpAdETX/89BVYhEkQwSGG2X1rV+vouEBYxHEJVHg==
X-Received: by 2002:a05:600c:214d:b0:3fe:20b6:41b2 with SMTP id v13-20020a05600c214d00b003fe20b641b2mr4228012wml.4.1690964054306;
        Wed, 02 Aug 2023 01:14:14 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2f3a89d4sm1040419wmc.7.2023.08.02.01.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:14:14 -0700 (PDT)
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
Subject: [PATCH v6 10/10] perf: tests: Adapt mmap-basic.c for riscv
Date:   Wed,  2 Aug 2023 10:03:28 +0200
Message-Id: <20230802080328.1213905-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802080328.1213905-1-alexghiti@rivosinc.com>
References: <20230802080328.1213905-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv now supports mmaping hardware counters to userspace so adapt the test
to run on this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/tests/mmap-basic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index e68ca6229756..886a13a77a16 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -284,7 +284,8 @@ static struct test_case tests__basic_mmap[] = {
 			 "permissions"),
 	TEST_CASE_REASON("User space counter reading of instructions",
 			 mmap_user_read_instr,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
+			 (defined(__riscv) && __riscv_xlen == 64)
 			 "permissions"
 #else
 			 "unsupported"
@@ -292,7 +293,8 @@ static struct test_case tests__basic_mmap[] = {
 		),
 	TEST_CASE_REASON("User space counter reading of cycles",
 			 mmap_user_read_cycles,
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
+			 (defined(__riscv) && __riscv_xlen == 64)
 			 "permissions"
 #else
 			 "unsupported"
-- 
2.39.2

