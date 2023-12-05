Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547AD804DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjLEJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:26:43 -0500
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566DC98
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com F310FC0012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
        s=mta-04; t=1701768407;
        bh=KfrrOaxwH0SW4+l9ufl40h36vnN/7a6MQbhAMTM4iK0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=Nzyn95L01DWqMe66VD4dfGJiBUbIvWFv7soLnpcOVJfOYV0OASs5taow3dJ+QbY8T
         hAWKRDA1uKueBZt59xqREHO9ejuaeU5JKMvbB8Xub2dyCaiL7ZCkRHuVPfeKcKZiz3
         MSTkvZFuH/6g/fnH/X92FfQDQcVlPcK94c4JJwqbtFSmUSWJ/TejYwdk5lYepj4x/l
         Xq1NZnTkFjB1w4uIR7xuOzDNE4q81yVY7S3WvTUpsnS7BRQ9q8u8+pzMIn7Hs5j0TX
         s+1eY4MDnAxgjQ2blv7KCBBdH15fkPSIhnq8ZKdju31KncokSCFcwmCoC1MCcHJnlQ
         Ey5tiESAnu8NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
        s=mta-03; t=1701768407;
        bh=KfrrOaxwH0SW4+l9ufl40h36vnN/7a6MQbhAMTM4iK0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=PJfYgTgfmnYJvj9cmQlFOQkV/k5cGatNDFRqynyCqu6Cq+BzbGiKVUe+Npbsxkp6a
         zEauUV7gsIOZZgQAlLkRr2X+eMfO4bgaukqbNVfkSeRK/NslMgjCU5mWOvJ+oqBPhJ
         qn9J1A8YIrGs2ndCOG7Hlrz1dA1t7oFqizsGEbLyN5UZUCp5oRm1jnCh6rX4lO81Bl
         7kCqzh+copb+ggT96UxKVOxcYbegEHYn8K3Z9rfft54zaCQwH835SUOiTMrDoPmnaT
         JRPnn4fzr6Jw0AnBgVcwxLRy0QzSlSY1jeDz1hQSxcBMaZKaaPKLUHqLVxu0Wqrsi9
         GNxAwFkQjL+Jg==
From:   Vadim Shakirov <vadim.shakirov@syntacore.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Vadim Shakirov <vadim.shakirov@syntacore.com>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] drivers: perf: added capabilities for legacy PMU
Date:   Tue, 5 Dec 2023 12:25:55 +0300
Message-ID: <20231205092555.35617-2-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
References: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-02.corp.yadro.com (10.78.5.239)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the PERF_PMU_CAP_NO_INTERRUPT flag because the legacy pmu driver
does not provide sampling capabilities

Added the PERF_PMU_CAP_NO_EXCLUDE flag because the legacy pmu driver
does not provide the ability to disable counter incrementation in
different privilege modes

Suggested-by: Atish Patra <atishp@atishpatra.org>
Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index a179ed6ac980..fa0bccf4edf2 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -123,6 +123,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->event_mapped = pmu_legacy_event_mapped;
 	pmu->event_unmapped = pmu_legacy_event_unmapped;
 	pmu->csr_index = pmu_legacy_csr_index;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 
 	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 }
-- 
2.34.1

