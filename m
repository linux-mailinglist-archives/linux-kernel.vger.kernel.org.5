Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B76755AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGQFoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGQFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:43:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6B171B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-557790487feso3255746a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689572624; x=1692164624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJVMF1IIkNq63VwvS5LTa45fwtvPnCXPypevGA/AZ+Y=;
        b=L+R5P/xPEW0wjozR2kzFcZdpWJhNejB9kiLqQzpHpyDisrfJd5pIExqibJDEvtVzr9
         b45LK/6gVDJbuWTQH4CdYY47A0pnJ7mCwwGWoC/LfsB/jH4Nw4gQfeQHqDWfV9OkwHc5
         t1sjrBkExaRxHaANVDnpcKetedtv6OMxRwhpme6NRUUqQFRVvJekapOfLlCqQfxJudSt
         tYaQyEuUcYYf41lIaDcXmCaxddVE5VIatGQbi9Q2aQ+U7Mu/S/nQae6gzYckC03yLhla
         BqMFZwzN4xzIS6fbTHrfuJoZLkMhZ0MjTxNATQwzgYTNhARZGI+qoaN+paHOCnb96gYF
         1+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689572624; x=1692164624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJVMF1IIkNq63VwvS5LTa45fwtvPnCXPypevGA/AZ+Y=;
        b=CE86oH6Gh2tnWdthhvycj7pJpCULVM487XYef1mIGiD2Ne5QmCG2upCkbe7MXtHk6P
         PpQzSdff6BWVbcPFFbgWdUu0QSaRYxcP/eVIfB8DCI+WBfJRI/cYbwTFIj87zNnEHZJs
         tsN3XWziJVWd9wHeRHaC92vZ3cLAqkjh7WtXoEWI4Sikp2Qmip3cBoZSpmKThUHrDG5b
         qyLiDcs3epDJ+BlvutRei7owiH0lte5AXt0ipFqepBbMoHayPtaTtG3TbNK0k7Z43l6K
         mP+mYhLSc6i8ziTAqWgnr0O/kcEgXDfSZgH2pMuHdOX3K6oGthlxyoyqhPjvOr1Ih9nr
         GEuQ==
X-Gm-Message-State: ABy/qLa8qo0WRGL7YW8TrWWPggegsMqqFXW6bqPOynanqbnRHR0JuPW+
        Ngm7OZyhUt4NVFt3v7GgmOPf3w==
X-Google-Smtp-Source: APBJJlHaE3CrjE0PQjnJgiVJCZQ1oF2x5SJZrfn3kEyWzBRSj741G4imf6hUkP9gS98SZzfAjMp/8w==
X-Received: by 2002:a17:90a:7f82:b0:263:f748:21c3 with SMTP id m2-20020a17090a7f8200b00263f74821c3mr10708679pjl.36.1689572624415;
        Sun, 16 Jul 2023 22:43:44 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b00263e59c1a9fsm4625849pjd.34.2023.07.16.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:43:44 -0700 (PDT)
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
Subject: [PATCH v1 1/3] arm64: Add Cortex-X4 CPU part definitions
Date:   Mon, 17 Jul 2023 13:43:25 +0800
Message-Id: <20230717054327.79815-2-leo.yan@linaro.org>
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

Add the part number and MIDR definitions for Cortex-X4.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5f6f84837a49..415be1a000c6 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
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

