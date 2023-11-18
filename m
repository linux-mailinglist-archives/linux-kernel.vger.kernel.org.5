Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA67F0094
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjKRPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjKRPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:17 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07410EC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:24 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5bf58914bacso32809437b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322682; x=1700927482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UsBR6w3W758FRiCdHZSwpEWSnagR0QzKE5nlW0aMIc=;
        b=nQs2UW3wVet4kSsKbSzaXKJxEP2BuksvcT/EJAsDwDfEp6x0P9IKYl818BEEF4AWP5
         HGtA5IY818T7+BWc3POZXJRStncOM+cEpVsgppyURmDZPKkHamsdXZTwgwWI4kLk+au4
         epfgzV4FElITDS9w4wHt4jRqEuiufR4mHUAgAx95EYNuBk8qBK/ozLdmZEIPThfhhSi2
         nfRFUF/4bRkUEYrp1Qx9A9GAVRaAZb7JK0tdeX1K5a63pfMrnpWUmd6q1kdL/wBa+LGE
         0IsXZQl4aE+RMaJOPZ1DRx6w0VbY4c2db9ZAB3Q2TTwTvx9iJ9nE93Bf0z1YbB4K8Op6
         JJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322682; x=1700927482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UsBR6w3W758FRiCdHZSwpEWSnagR0QzKE5nlW0aMIc=;
        b=ghirHcFsp0Z5YM/lQMSVuwGaysjCiq3GZC0nFrWUKgyCjdDJ9h7+H4GNRVt+QQS+DB
         r7caDzVSwXRCbSgITNvvqhDKS0T18RI6ciunWBUe1gGPc1q4GY8pS3Dtqmo++gLlZchu
         1/DoIxHumrmChxJK7WkD0qDnLPE+PK8Wu2Up94aGpGa9mLBWzOtjVEpA+QQ882BjKd/o
         qE7P6yq3wirdlsB929LsVpXpovpIrQj2k/qP6r3Tyffi/21dYpE8brSrKbqgcpLaEocg
         tlVUcX3QzJEbZVX0y55OQEeIEyILd3i68jGzrVjIDVzgzRyQ+6tVmrDEoNAMnn/ypG4m
         dCIQ==
X-Gm-Message-State: AOJu0YwD2iYuveaU0a+UiAU13EZWIVfbcOfWx4tLejy63EiPQzSRZTzR
        fQjL5n114NS7OI3jMZvgHUC+lNZk0diFg21W
X-Google-Smtp-Source: AGHT+IFMi3zL8WSF03nEf+gU11A9ztIok6tcrLg24vsR46a+e0EFl+1hnebBli0fdxvl68Hs4Jerug==
X-Received: by 2002:a0d:dc43:0:b0:59b:ec85:54ee with SMTP id f64-20020a0ddc43000000b0059bec8554eemr3160808ywe.39.1700322682161;
        Sat, 18 Nov 2023 07:51:22 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id d19-20020a814f13000000b0058ddb62f99bsm1187785ywb.38.2023.11.18.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 08/34] drivers/perf: optimize ali_drw_get_counter_idx() by using find_bit()
Date:   Sat, 18 Nov 2023 07:50:39 -0800
Message-Id: <20231118155105.25678-9-yury.norov@gmail.com>
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

The function searches used_mask for a set bit in a for-loop bit by bit.
We can do it faster by using atomic find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 19d459a36be5..2a3b7701d568 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -274,15 +274,9 @@ static const struct attribute_group *ali_drw_pmu_attr_groups[] = {
 static int ali_drw_get_counter_idx(struct perf_event *event)
 {
 	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
-	int idx;
+	int idx = find_and_set_bit(drw_pmu->used_mask, ALI_DRW_PMU_COMMON_MAX_COUNTERS);
 
-	for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; ++idx) {
-		if (!test_and_set_bit(idx, drw_pmu->used_mask))
-			return idx;
-	}
-
-	/* The counters are all in use. */
-	return -EBUSY;
+	return idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS ? idx : -EBUSY;
 }
 
 static u64 ali_drw_pmu_read_counter(struct perf_event *event)
-- 
2.39.2

