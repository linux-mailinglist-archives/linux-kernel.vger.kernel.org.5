Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F0F76C7FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjHBIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjHBIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:08:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFABDF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:08:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so62033391fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690963687; x=1691568487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYevbpqWo7vfFaWnhd9GizwhPV+tk9zz00ActpJaBGA=;
        b=C7xv7YytwoR4uq7JIdhqZuJEkUTXlgAK8JHUJmTCCPtBiKU4xgvR7g4saOc5fR/eUi
         9v0d5p/9jcPbnZqTuBT2wl+C1J0cd8A7wqLULFvLvLOoFzh58uKt6CegTBYXnRQMlTJq
         UQVg5kvuetK1K9IEmMvGmkReA+pcjWnjUS2zXkWXT3C2mSMrqvJJS5G8sgGzIdZrfNRm
         f2Zf/sRlkU1+aiyhp7tww9itJbUfT0bciaWjqyZn7C477eevRSxmbICRZdx09GeJX70T
         GGfAvuHm0TI2u9eBd+hP8mafHOqR2C7stZ/pEq72HC7hbBj2xt04rk2Pwh86yl1AAQtI
         tOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963687; x=1691568487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYevbpqWo7vfFaWnhd9GizwhPV+tk9zz00ActpJaBGA=;
        b=dG5HgnAg2SNVuW1EujTm9RbxP9+kJ7FqNcYGErDm2CxSct2hCCLYcYjkfgsybucRhA
         U522VbtXZPxL2Jqx6jBHQFrOIwFeIAWU1Fm0SySEB0YRLGIdnnyRFu3ok4lX53g4QLPS
         EIujWt93L+aeXLbbGztN9KjPK3SlBQ0IwJpRvSLHfw5hFj69Kb3UynAAk+LnoB6CQqiT
         WIQLHxt0XzuQn5DNkMuAnnMgVxx4rFdYawnG1K5COpjDUGk1GvzlF4q+6z2JModbTqdm
         WqF7U3gD8KTVmPH1EaECsN541N2Pdvpb23NzfszzkIm/0vync2peFz4v2TjgWjpKzBPn
         RImA==
X-Gm-Message-State: ABy/qLY6URy2/rpPOAXINSyts9MO6ViHrlikkQ13g5rGI4E1IjfJ8rwE
        9g5O1D5RCYC41p4quzdom0mWPg==
X-Google-Smtp-Source: APBJJlEPQvg2jgzCR48BQ66CmJM6kIoAutXpKdyiFQV/CJqhQCtj7ohJtumlf3uKGjAiRcFtAoyp9g==
X-Received: by 2002:a2e:9ec1:0:b0:2b9:acad:b4b8 with SMTP id h1-20020a2e9ec1000000b002b9acadb4b8mr3835806ljk.52.1690963687046;
        Wed, 02 Aug 2023 01:08:07 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b003fe15c466f3sm3667960wmg.0.2023.08.02.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:08:06 -0700 (PDT)
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
Subject: [PATCH v6 04/10] drivers: perf: Rename riscv pmu sbi driver
Date:   Wed,  2 Aug 2023 10:03:22 +0200
Message-Id: <20230802080328.1213905-5-alexghiti@rivosinc.com>
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

That's just cosmetic, no functional changes.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 4 ++--
 include/linux/perf/riscv_pmu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4163ff517471..760eb2afcf82 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -907,7 +907,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 static struct platform_driver pmu_sbi_driver = {
 	.probe		= pmu_sbi_device_probe,
 	.driver		= {
-		.name	= RISCV_PMU_PDEV_NAME,
+		.name	= RISCV_PMU_SBI_PDEV_NAME,
 	},
 };
 
@@ -934,7 +934,7 @@ static int __init pmu_sbi_devinit(void)
 	if (ret)
 		return ret;
 
-	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
+	pdev = platform_device_register_simple(RISCV_PMU_SBI_PDEV_NAME, -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		platform_driver_unregister(&pmu_sbi_driver);
 		return PTR_ERR(pdev);
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9f70d94942e0..5deeea0be7cb 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -21,7 +21,7 @@
 
 #define RISCV_MAX_COUNTERS	64
 #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
-#define RISCV_PMU_PDEV_NAME	"riscv-pmu"
+#define RISCV_PMU_SBI_PDEV_NAME	"riscv-pmu-sbi"
 #define RISCV_PMU_LEGACY_PDEV_NAME	"riscv-pmu-legacy"
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
-- 
2.39.2

