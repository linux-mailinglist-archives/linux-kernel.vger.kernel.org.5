Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942CD80E181
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345715AbjLLC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbjLLC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:01 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45BBD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:07 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cfc3a48ab2so44883077b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348086; x=1702952886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGJ1SciKtb7P2PBkuK7lu9/Kujw3Tca15jzLy63keqo=;
        b=T82cCyrEJyvbQ76JeyFds3Ot/Em5U6Yy7qAldOsfHS5EIpOV36RhORTzgqAvEa9Kjk
         zKrZmMY29gQhFo72vYT9Z2DFeJBYxN8EWFmI2fcVtcwMiSoJQzZByhfySBj+ZeIbl54H
         ez5FpRjW63+epdBUcq9DP0cscfZY/2bQd1ops8I+M5gQFXQoemr3xfIMSjPccPHPWwhc
         049diQzaZlpyBhHyuAlMIb34O/sv4uvDuOUe1faxzDT3ia+3ID+x9kRZywaJNTCx18Zn
         Bto4JK8DvuOqZorFF403J+Cqpu2E8nV9GEDdKk8cK/7sV48UtoBtTUAH6I4w/C192Sau
         IbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348086; x=1702952886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGJ1SciKtb7P2PBkuK7lu9/Kujw3Tca15jzLy63keqo=;
        b=rTmIdjMcwi0VXRK4Qz6zrnsmhMPW8HoHhJSrRWip/5JpJ+OcZzr5hQgP1hmLePvWvY
         PEog06PanhwvQnoQw8yofjoKasYFllSaB5wLnKNcDzK2I82YXUAUYngFPvKvuZTtK4TV
         8geYuFh3oqORRwUZee0p7z2K9mHJwwoIv9QHZug76nYXYYLME89PwvBKKMNSTGXbuWRv
         wbVnETpPofFM66dnAClncyC8IJrn7WDie417slilrKGNlsaGBl/1KgHCoQKzI69/RXxZ
         GVNaWgPaDP31kzWfwaeTpY59K32ueBRXgntXtNIVk6ibHo8pYLERvcZllDv5L+L9quuu
         9hQQ==
X-Gm-Message-State: AOJu0YyM2W2w1IE6puVZb7RBoRYNkdHSTex+3+Q7LwYjetE/SIXQTNWj
        KLilodYZSmP0zgADVE3mboJponxwGACe2A==
X-Google-Smtp-Source: AGHT+IEcQE9vIyfnFhCFzm+TBrntNSUln0laqng4P6N0+UfSZTYtWtqpOoUM0PVXePl69yPwn5kBMw==
X-Received: by 2002:a81:4fd6:0:b0:5e1:e94c:9e3c with SMTP id d205-20020a814fd6000000b005e1e94c9e3cmr174797ywb.14.1702348086183;
        Mon, 11 Dec 2023 18:28:06 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id u13-20020a81a50d000000b005cc8b377fe9sm3395635ywg.121.2023.12.11.18.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:05 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 08/35] perf/arm: use atomic find_bit() API
Date:   Mon, 11 Dec 2023 18:27:22 -0800
Message-Id: <20231212022749.625238-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

Simplify subsystem by use atomic find_bit() or atomic API where
applicable.

CC: Will Deacon <will@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/arm-cci.c        | 24 ++++++------------------
 drivers/perf/arm-ccn.c        | 10 ++--------
 drivers/perf/arm_dmc620_pmu.c |  9 ++-------
 drivers/perf/arm_pmuv3.c      |  8 ++------
 4 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 61de861eaf91..cb15b4cee5f7 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -320,12 +320,9 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
 		return CCI400_PMU_CYCLE_CNTR_IDX;
 	}
 
-	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
-		if (!test_and_set_bit(idx, hw->used_mask))
-			return idx;
-
-	/* No counters available */
-	return -EAGAIN;
+	idx = find_and_set_next_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1,
+							CCI400_PMU_CNTR0_IDX);
+	return idx < CCI_PMU_CNTR_LAST(cci_pmu) + 1 ? idx : -EAGAIN;
 }
 
 static int cci400_validate_hw_event(struct cci_pmu *cci_pmu, unsigned long hw_event)
@@ -802,13 +799,8 @@ static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *ev
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
@@ -861,12 +853,8 @@ static void pmu_free_irq(struct cci_pmu *cci_pmu)
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
index 6ca7be05229c..f046ad9e71f1 100644
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
2.40.1

