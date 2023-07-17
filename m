Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063B755AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGQFoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGQFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:44:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B3510E6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so2421530a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689572637; x=1692164637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyK1Jggty5zZRfu0FmHGDNpSPXcYX18o45hq3r51GJg=;
        b=iXWppoz1AtZx/m5XFZNR40D+3TcADWNzySwcCoQsC8xOqLO612ZBGmlEsB4fJEs7d6
         ax4juD1nPhZsis8SaDw3nR0JT8vIqiq+LCmIVSTLgULfxal42o+la/rk7RIzjcnS6hNZ
         fuRyo21BSMXpJUlAtAMms6YDtg4a/GX6aX7oxHHXYte15u2Xa16C3wcH8Jqp15iqGjI9
         rANF8+UAkRNYlS6flx0FCR1GOrLvMBfHUskPHw+L/pdM5riM7g6iqkiMaWaSB2QxKMl4
         ELhTQUasJQ1wdhUzR2b2Iof5GcgwFPloqTGdM4+NvYX06E3mkY7CF8bmLxXuxD/2/w6l
         OPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689572637; x=1692164637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyK1Jggty5zZRfu0FmHGDNpSPXcYX18o45hq3r51GJg=;
        b=Y6ueYYud7RyGBrWrbWe2LWlmLJdKUOTMC91c3k/fyOK3X3eUOqaUnhL+aIZwfyXJxK
         SfERFxodixbnkGwm7K+qqPhItpBMi8IGsrRRlwSkBhf+qW20QS3VrBBRE9ZucY8j9uBH
         hENqTzJDggtHLoWZbgFhn/V4qhLaEK6+lqd1Uxwazo2qrv1MMDHmjbPqAVReQJk3LUNh
         Purd0rIDrbWGvM0mbbAD0XBbRoj1FbEejw8bMl/4G9j16pgEjr3KmhwWZvIOSi+1fS9j
         6q1dLArD6gDO8kI+fDcHLkFNrEOMmzodMtSvOPUE009u3TgYBmFFuOjE62tdJnvw8hYO
         orUQ==
X-Gm-Message-State: ABy/qLbhv4ZVqHm0BB4e2tCZW8sSLCIaqVwY6wOwCAEo0vR/me6rjsBa
        RfDi0td78fMVMriccfO+5Vvw5w==
X-Google-Smtp-Source: APBJJlFdGZVJYwmzxQ2PK7b0e7+IIasqkbhIeSaSVNpOZTQFe/vbgjUD2wWvkkqgR9tljz/+hAYuRg==
X-Received: by 2002:a17:90b:784:b0:267:6fd0:bd31 with SMTP id l4-20020a17090b078400b002676fd0bd31mr11124005pjz.7.1689572636858;
        Sun, 16 Jul 2023 22:43:56 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b00263e59c1a9fsm4625849pjd.34.2023.07.16.22.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:43:56 -0700 (PDT)
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
Subject: [PATCH v1 3/3] perf arm-spe: Support data source for Cortex-X4 CPU
Date:   Mon, 17 Jul 2023 13:43:27 +0800
Message-Id: <20230717054327.79815-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717054327.79815-1-leo.yan@linaro.org>
References: <20230717054327.79815-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a CPU list to maintain Neoverse CPUs (N1/N2/V2), this list is
used for parsing data source packet.  Since Cortex-x4 CPU shares the
same data source format with Neoverse CPUs, this commit adds Cortex-x4
CPU into the CPU list so we can reuse the parsing logic.

The CPU list was assumed for only Neoverse CPUs, but now Cortex-X4 has
been added into the list.  To avoid Neoverse specific naming, this patch
renames the variables and function as the default data source format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..c2cdb9f2e188 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -409,15 +409,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-static const struct midr_range neoverse_spe[] = {
+static const struct midr_range cpus_use_default_data_src[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	{},
 };
 
-static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
-						union perf_mem_data_src *data_src)
+static void arm_spe__synth_data_source_default(const struct arm_spe_record *record,
+					       union perf_mem_data_src *data_src)
 {
 	/*
 	 * Even though four levels of cache hierarchy are possible, no known
@@ -518,7 +519,8 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
+	bool is_default_dc =
+		is_midr_in_range_list(midr, cpus_use_default_data_src);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -527,8 +529,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	else
 		return 0;
 
-	if (is_neoverse)
-		arm_spe__synth_data_source_neoverse(record, &data_src);
+	if (is_default_dc)
+		arm_spe__synth_data_source_default(record, &data_src);
 	else
 		arm_spe__synth_data_source_generic(record, &data_src);
 
-- 
2.34.1

