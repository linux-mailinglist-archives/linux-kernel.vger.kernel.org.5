Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4A7F0092
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKRPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjKRPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:16 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A310D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db35caa1749so1089841276.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322680; x=1700927480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyoEyO/BvLzExTTgi8khHbjKTjqWvT4r1T0zFU2+3B4=;
        b=eAYDhoo5LWl01TZzKDQXAmWOeLYBLa9ZfNNJzDryiiiKwgUj3vr9CiGvbrY52X16Av
         dj8pzPLEJkly88f2AFSiwtyDHLrXAwvFx31AtIoq5z5MMLih/iSgVURt0Xxq502emeKo
         gQc3vABv8BLyuSyPGa5OzloOSa9dVKMpXn6UFx36MkYrKBQ1Cel/rI08NTYNLgP7DkH3
         Rm1Hcmj19H60/2+r3AbHCcBUxCeV9YUXZNWPL2Aqokjx56A0j8351VYK7Dh6RqI+ikbL
         6ECJWdJ0/v9b0kLWNz0ltGrc4Hd4LJbz5g+XZKUZFInfhKKa+C8lGRayWOAk3WIPY9iB
         h0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322680; x=1700927480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyoEyO/BvLzExTTgi8khHbjKTjqWvT4r1T0zFU2+3B4=;
        b=m2NYVouJlQ3nztd4ThDpV9tFA6WKt9N+1txXYqQjI/tIRw3yvISK4GHwEYxnMY+ftV
         60R7BitGLxitdDWvm6Xf5xGUm8cPVIP5ze0zQz6YaQ0P8+fepffJ4eOYrct229ba1Psn
         pbRfvE1PfWFoQfPd9H+1sO5X/UzIo9Sj1UOVS5WmgOuYLY7B+P5MXGeMF7+VYfEx7LbV
         nRbZVYyjo0OP+e8inNvq276koqUo5PjocWWtjxpwG/Wo8Lceew1C7PqDGj4DJLacZ8Dt
         aBMJP1CslGURRXgjA7R9IkxmJ1astmNGBKbVetexEzJax+LrMziBpin3Mw2EFoZm/VDu
         8FHA==
X-Gm-Message-State: AOJu0Yy8ciWodJy13aZrAlVptmfSGhDYO+hZGr+SlpF5/4r7WvfrxWoM
        Zz+4noxOb0JojUbleUQU4igdxfpk6PVIYLWw
X-Google-Smtp-Source: AGHT+IHj+eYHr1ru2W9s2X50eY6fyN3D8n3j9pP2d8TuQd1yVcJckTMxAXGClEhkj7DzHhTwgJSZvQ==
X-Received: by 2002:a25:bb92:0:b0:daf:be86:a2ea with SMTP id y18-20020a25bb92000000b00dafbe86a2eamr2470792ybg.38.1700322680273;
        Sat, 18 Nov 2023 07:51:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id d2-20020a25cd02000000b00d8679407796sm999292ybf.48.2023.11.18.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:19 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 07/34] perf/arm: optimize opencoded atomic find_bit() API
Date:   Sat, 18 Nov 2023 07:50:38 -0800
Message-Id: <20231118155105.25678-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch subsystem to use atomic find_bit() or atomic iterators as
appropriate.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/arm-cci.c        | 23 +++++------------------
 drivers/perf/arm-ccn.c        | 10 ++--------
 drivers/perf/arm_dmc620_pmu.c |  9 ++-------
 drivers/perf/arm_pmuv3.c      |  8 ++------
 4 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 61de861eaf91..70fbf9d09d37 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -320,12 +320,8 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
 		return CCI400_PMU_CYCLE_CNTR_IDX;
 	}
 
-	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
-		if (!test_and_set_bit(idx, hw->used_mask))
-			return idx;
-
-	/* No counters available */
-	return -EAGAIN;
+	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);
+	return idx < CCI_PMU_CNTR_LAST(cci_pmu) + 1 ? idx : -EAGAIN;
 }
 
 static int cci400_validate_hw_event(struct cci_pmu *cci_pmu, unsigned long hw_event)
@@ -802,13 +798,8 @@ static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *ev
 	if (cci_pmu->model->get_event_idx)
 		return cci_pmu->model->get_event_idx(cci_pmu, hw, cci_event);
 
-	/* Generic code to find an unused idx from the mask */
-	for (idx = 0; idx <= CCI_PMU_CNTR_LAST(cci_pmu); idx++)
-		if (!test_and_set_bit(idx, hw->used_mask))
-			return idx;
-
-	/* No counters available */
-	return -EAGAIN;
+	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);
+	return idx < CCI_PMU_CNTR_LAST(cci_pmu) + 1 ? idx : -EAGAIN;
 }
 
 static int pmu_map_event(struct perf_event *event)
@@ -861,12 +852,8 @@ static void pmu_free_irq(struct cci_pmu *cci_pmu)
 {
 	int i;
 
-	for (i = 0; i < cci_pmu->nr_irqs; i++) {
-		if (!test_and_clear_bit(i, &cci_pmu->active_irqs))
-			continue;
-
+	for_each_test_and_clear_bit(i, &cci_pmu->active_irqs, cci_pmu->nr_irqs)
 		free_irq(cci_pmu->irqs[i], cci_pmu);
-	}
 }
 
 static u32 pmu_read_counter(struct perf_event *event)
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 728d13d8e98a..d657701b1f23 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -589,15 +589,9 @@ static const struct attribute_group *arm_ccn_pmu_attr_groups[] = {
 
 static int arm_ccn_pmu_alloc_bit(unsigned long *bitmap, unsigned long size)
 {
-	int bit;
-
-	do {
-		bit = find_first_zero_bit(bitmap, size);
-		if (bit >= size)
-			return -EAGAIN;
-	} while (test_and_set_bit(bit, bitmap));
+	int bit = find_and_set_bit(bitmap, size);
 
-	return bit;
+	return bit < size ? bit : -EAGAIN;
 }
 
 /* All RN-I and RN-D nodes have identical PMUs */
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 30cea6859574..e41c84dabc3e 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -303,13 +303,8 @@ static int dmc620_get_event_idx(struct perf_event *event)
 		end_idx = DMC620_PMU_MAX_COUNTERS;
 	}
 
-	for (idx = start_idx; idx < end_idx; ++idx) {
-		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
-			return idx;
-	}
-
-	/* The counters are all in use. */
-	return -EAGAIN;
+	idx = find_and_set_next_bit(dmc620_pmu->used_mask, end_idx, start_idx);
+	return idx < end_idx ? idx : -EAGAIN;
 }
 
 static inline
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 18b91b56af1d..784b0383e9f8 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -825,13 +825,9 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 				    struct arm_pmu *cpu_pmu)
 {
-	int idx;
+	int idx = find_and_set_next_bit(cpuc->used_mask, cpu_pmu->num_events, ARMV8_IDX_COUNTER0);
 
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
-	return -EAGAIN;
+	return idx < cpu_pmu->num_events ? idx : -EAGAIN;
 }
 
 static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
-- 
2.39.2

