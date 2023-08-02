Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBE76C81A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjHBIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHBIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:12:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC11716
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:12:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso60233325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963932; x=1691568732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cSgJAHYTUnT7EM82v2w304ZdRWAgN6wEFUjF/hB87M=;
        b=ZY45fPleIMseKM4cyfGJi+sI4NPdRTXruHiC2M15hOTi+UE4Bf2pB9Z9MVAI4IBQF/
         BbMvcTvkB7VZKimvVYxFY2XWlber5/H8MaKOH//zydx6HH45VnqXhuFLywrrQ0zaRUnL
         Ptqi0H9fU7/oLemakiWSI3CFeW53PivDuvpUxYu0x2rWtIw2VE7waNFLqu+42jJQhn3u
         dBNwDsBVQk6TZhy8KsveIxKeHIQWbdizzvg8yt9CP7dywSzDVzMaSz1+elrSSjlBVVGF
         m7X3irDoPLF+saps91kRPqpUGnUWvgkOdLFqgKIj0sPaatw7YetpNJcoZk16pvdtJNkv
         SM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963932; x=1691568732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cSgJAHYTUnT7EM82v2w304ZdRWAgN6wEFUjF/hB87M=;
        b=SPXIh6WB6gKMb0D2vdg5d/mT4a6v8bY5jslaCooK3KAUbFBPoW4wbgr6FmBaqY88/1
         fW44tQgyhsS//8vWKrnyDE583ZEYf+R1R2+RtZoMgKQ30O6JTemsmofJi2PE/IVhoevk
         uMDHXYTaagQ9v8tkf0QCbaAzS22yyHMbl0COV+Mt6Ms289EJZiN5cOj4Duui8pitoNg0
         29hHF38wPpH9UBY7z/OBTuMFCKql82zeq4/sz1+h76ZcG5/ZCq1bH6WxZufQpguL/pbG
         QyQnFRl9WupZa+cFEC5CMtvmHqUfMGZb84wnIylFznCEkde7wFnHJrgnrH0x9gdVkiRR
         GS+Q==
X-Gm-Message-State: ABy/qLa12nDx9jvcKGWmvJ9BZKRalcRyHpGfUkbVxtZcKY80V+vmt9jg
        zu8ZRBUsQyi4Sz9e+Ml45zflvA==
X-Google-Smtp-Source: APBJJlFODy2Hmr2Q6DovqhlsZUIZjP/yEjAO7EKuY8afbw5+j6M3rXaiiUZ8xQpTUJ2mKjGA2xKlgw==
X-Received: by 2002:a7b:ce14:0:b0:3fc:a8:dc3c with SMTP id m20-20020a7bce14000000b003fc00a8dc3cmr4134949wmc.37.1690963931776;
        Wed, 02 Aug 2023 01:12:11 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm18269448wrs.53.2023.08.02.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:12:11 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
Date:   Wed,  2 Aug 2023 10:03:26 +0200
Message-Id: <20230802080328.1213905-9-alexghiti@rivosinc.com>
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

riscv now uses this sysctl so document its usage for this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 27 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 3800fab1619b..8019103aac10 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -941,16 +941,35 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
-perf_user_access (arm64 only)
-=================================
+perf_user_access (arm64 and riscv only)
+=======================================
+
+Controls user space access for reading perf event counters.
 
-Controls user space access for reading perf event counters. When set to 1,
-user space can read performance monitor counter registers directly.
+arm64
+=====
 
 The default value is 0 (access disabled).
 
+When set to 1, user space can read performance monitor counter registers
+directly.
+
 See Documentation/arch/arm64/perf.rst for more information.
 
+riscv
+=====
+
+When set to 0, user space access is disabled.
+
+The default value is 1, user space can read performance monitor counter
+registers through perf, any direct access without perf intervention will trigger
+an illegal instruction.
+
+When set to 2, which enables legacy mode (user space has direct access to cycle
+and insret CSRs only). Note that this legacy value is deprecated and will be
+removed once all user space applications are fixed.
+
+Note that the time CSR is always directly accessible to all modes.
 
 pid_max
 =======
-- 
2.39.2

