Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB712755AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGQFoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjGQFoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:44:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F1E6E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3b7f992e7so3050608b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689572630; x=1692164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsbOtl8L95SdhjWYG9IqPkOwivVCIhS13RLWT0N8NVw=;
        b=vHh+YxpGgOeFPoUz6LbKohjblFtJ+aagx7LTHqU+6uuuDLEtG6yjzf4YQ7DE5QkgY+
         ZJdUlNh5htpZgVKtizGZJ9JLuuGFMTv6fr/zmK8FZnef4x1qw6q9L2vVBjnsqYGQotpK
         4DPUJYeRwOGpCw5cuywoWQ8XOzaVnNAA3onCMVooFi1M3CRp0Xa0086m25zw0BTQVOWg
         ukisL4F12f43EfIe4EHgU/gZlB8H82zLIIm1Sh+70JWJBUe/X6OdS4CQd8BjGtebaaGe
         n2TooFHDZuO82dSgdxNmMnxS5ngXRJmF4OCX2iAEO9NCzHG/UXoPOJNkUWMwxx01yBII
         6Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689572630; x=1692164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsbOtl8L95SdhjWYG9IqPkOwivVCIhS13RLWT0N8NVw=;
        b=aXQ3CWOekuBMly+f4kK5HrOZHG6dyoPR6F6hNzcfOO/8VQkx0b/tEcayDsmBriB/Mq
         hbCKzwVvAsR0NSh+3Hgj6xT4LfqbPzjGYxJy+5GzoVsJdhDA3Y+ZJjaS9Z4UiPyFzk0F
         oIgmTIp8PF/B01FpN2FhlxaQsmh7YJGYvvfiFa4ez1sr051XIkllXX13aHJbfVkQmlzW
         4lomK56v8gohUuS1ryiLLHG+1M6djJZq4H69PGBb29eHVIFQmH1NfsPfHL3//SIzRf2L
         kd6+cJVLJxYU6UGRvgm7Hs9pAtngYQwzohCutXIv6K1B26aT6lsggc/zyFbhmwrc0gYg
         qtCQ==
X-Gm-Message-State: ABy/qLYNQOHR4AdSesuvsFmk+fXfv+xfZPegZiiZOwS0EcW0D6oM67Fh
        uPk/gdXclznRky0j1GlpAj17og==
X-Google-Smtp-Source: APBJJlEo6ll+1XbDqr9kcoMe97+yzdfGUxeY4rr02L0hXAIYQalB2a0NK6Q9W4JWbXy/Y8j2jLCDBQ==
X-Received: by 2002:a05:6808:f87:b0:3a4:25ab:eecb with SMTP id o7-20020a0568080f8700b003a425abeecbmr11762333oiw.51.1689572630652;
        Sun, 16 Jul 2023 22:43:50 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b00263e59c1a9fsm4625849pjd.34.2023.07.16.22.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:43:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] tools headers arm64: Sync Cortex-X4 CPU part definitions
Date:   Mon, 17 Jul 2023 13:43:26 +0800
Message-Id: <20230717054327.79815-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717054327.79815-1-leo.yan@linaro.org>
References: <20230717054327.79815-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync Cortex-X4 CPU part number and MIDR definitions with the kernel
header.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 5f6f84837a49..415be1a000c6 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,7 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X4		0xD82
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -153,6 +154,7 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.34.1

