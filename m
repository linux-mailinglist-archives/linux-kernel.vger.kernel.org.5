Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC938026D5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjLCTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjLCTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:23 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67111A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:33:26 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c8c26cf056so42215287b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632005; x=1702236805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngf7R2trkvhy5az0BJAYMgMmwp9GyrCv5kj64azD/XY=;
        b=IwKOPKag07y4huwL4cYByFMZ4ox6UM2TxGUgmyL7qXkNd4B7hk/1v3OP3uTVD45TUl
         6KRVs0b5ttTlv8O5W1j3phXev8jg+zHmAoJ0BopucQxDnAOxjcJFU5V49926lpD6MtZE
         8vQET7xJBeOxn9bpPOA4PffBWwA9jV2s0gx0BBbRvwcn3+f95geuyT3QQtdfGDkJ0DN7
         dw4WAy0A9a0uzFQjFGygqKOfnBPdf8vfREUnqO5Tjjk16Zf2zcJwcAYrTS1vU0qKKc1m
         QAkmnJgTVxG/eFZy6PW1SoXROBd+mQCRGwiBlZMVjLdxESyXXYkv4GeEeLLcbpqsGIhr
         RRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632005; x=1702236805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ngf7R2trkvhy5az0BJAYMgMmwp9GyrCv5kj64azD/XY=;
        b=KRdfzlhDkbdWLogLJJhRPaE8voIIyd88qjKSKJ1m29er7d/DTo5N7vzxn8fl+MoKOA
         tPWRJ4iNnJpPc7U0uRdGwlctisxh1fxy5CcKG94oPJWua7mXbZ57dYRDzELg2CkMhL7m
         oXzw6UcFB6v8WhUeQAoMtGlv3WjTJOUShawUrjrRR8bOuZZFSU6dEZ/4o0xbOcEHPD6V
         9zCwVCPvt9RcuF1g33NMZIvCyocdBxDnbWNoS2MuVpg0zjoz6S2Ee1QP9oYU2ErF58tb
         oyt82QH3+y5c93zFQc1u+TVbkFlEpQV6uHxTbil2wCDgDvFIhc7iifZHCjAbwTCOkS4/
         w0iQ==
X-Gm-Message-State: AOJu0Yzs37z+mZG2/b2FDxN/eonWUiSUMEzWPtXi5VlwJClU5ico1r2o
        P148ucVkYobeLseSJvYgqBdEB2VbhjOSgg==
X-Google-Smtp-Source: AGHT+IGAhPIRobNSBd8Xh5ROPApH6LYXWQ7wTkKlfC05Y42RMAU/7AhplYR/16C573v1Ku+fj2bMHA==
X-Received: by 2002:a81:af4c:0:b0:5d7:1941:2c1e with SMTP id x12-20020a81af4c000000b005d719412c1emr2165207ywj.75.1701632003638;
        Sun, 03 Dec 2023 11:33:23 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id z14-20020a814c0e000000b005d14e254367sm2752264ywa.80.2023.12.03.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:22 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 09/35] drivers/perf: optimize ali_drw_get_counter_idx() by using find_bit()
Date:   Sun,  3 Dec 2023 11:32:41 -0800
Message-Id: <20231203193307.542794-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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
Acked-by: Will Deacon <will@kernel.org>
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
2.40.1

