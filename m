Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4FB7655E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjG0O1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjG0O1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:27:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC6273C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:27:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31783d02093so537108f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690468036; x=1691072836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91jtKpAX8BKXnlM2DqECzDjrTgIUONnRJGEpBfq59o4=;
        b=USVtlzZpNwlYrsQ/yWuVvPJRGGc68ABNqkAYawYirkXn7ZDuug3OTHFZiUyezO7zda
         zGcr8wBTIGK2jIwXcydY8wz70yiXl/2gtFoFFqUROTaVNxkcaF1qwUTPGaWD14w2PTvO
         BIrYBbC3g+PleFK3ZHxJLfZE8n3mzvSPjUlpZH2pJJVLlQi7uMxJnDxJVgTExpOhiLwQ
         rN3BDxQ5jQZ1Y5LNxPkC6gTGFIkfNsL5zGj8utGStZ1gc6WWAqb/23rigAebUbt5YvbA
         ERiLCKS0iev3LQVaq9aa+s9Wx3HIeZ42CARfGbLjAl9BUCw3E0mlK6NA1DSEBd+uhTbm
         nZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468036; x=1691072836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91jtKpAX8BKXnlM2DqECzDjrTgIUONnRJGEpBfq59o4=;
        b=ZbNVHVRvHEuI2K9idR6d1X3KmTBJQQecOBUkzumc8QZFgIKtRT49db3fKkmNxnm/og
         fsPlzU4bukIvo7q0tgli0bYL4jfxYPpwKnkRSk2QGoVU4jD8bt8NNk9puw/+pOzJPajI
         1et+szFh8KLnjsCBcFDWwIIn/veLzGjaKIEYdKLU+2tMATPODaL5J6Faq/uT3ZLgTyXW
         ExixuJHAYKT3eGXXbc1GDzcdYp0Jw9AEBMOahhL5sSxMfpbB/Gm2595KBx3xDL6OecwM
         kDnSp+NOoradkYPt66umkxKGmKXWvQGVwjMciKPSiEOhUfrIjHOYFJzO5rqvWsRhJJWQ
         oPgw==
X-Gm-Message-State: ABy/qLbNjctFdWc4G3rvZnK1Gx/sgNd6wQvNPt07oCkrsEUgnuKHrMyw
        WYM4Dmafq/xYANBsygSpkIm7zQ==
X-Google-Smtp-Source: APBJJlGi6sdh3z78UtOfwf67hU0/mwQxZ1a4Ih0Kmo4uc5K941Szn210hkA/E32YMDfeTSdDnLxI8w==
X-Received: by 2002:a5d:428a:0:b0:317:5cfb:714e with SMTP id k10-20020a5d428a000000b003175cfb714emr2129750wrq.55.1690468035860;
        Thu, 27 Jul 2023 07:27:15 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b003143c6e09ccsm2266885wru.16.2023.07.27.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:27:15 -0700 (PDT)
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
Subject: [PATCH v4 08/10] Documentation: admin-guide: Add riscv sysctl_perf_user_access
Date:   Thu, 27 Jul 2023 16:14:26 +0200
Message-Id: <20230727141428.962286-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727141428.962286-1-alexghiti@rivosinc.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
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

riscv now uses this sysctl so document its usage for this architecture.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

