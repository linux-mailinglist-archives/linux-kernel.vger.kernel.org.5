Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9480E19A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbjLLC2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbjLLC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:02 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC9D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:09 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e1a3199f6bso6896777b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348087; x=1702952887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOtgtWtIwGwJ1G9iBa8c13QOAAJ/9MITwOIhxFkc4ng=;
        b=PPYYK6gZjHpPN8gqQDwq9laUoxLJR5BRssNuC2urGmIwyElRbozZHvRUtt7/86JBhD
         xh1ZhXO/RKkAe2UzeroXBrd7WDIfnsKn1Nls2ux1an1mb0WJy3B002kFekxqyJb9MS/E
         Pk4bdzOU9/39GVQADWfzVii6riDnuYgOA5A5PTAalneKSG6dWSqPYMMNPMAlLPaE55hP
         g0BMXbfZ3cDz8fXBQ53z7qPeeiBvwJtIWCmlQA+Zt1EOXJF+MIxASO9BJdHL581CEmdv
         eNhj9IueQdDR+yAZhFcnsz0HwgJyur8mw7jLiseLClTgLAzdMhLyfqTVYlVDkxy5yWsn
         Yp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348087; x=1702952887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOtgtWtIwGwJ1G9iBa8c13QOAAJ/9MITwOIhxFkc4ng=;
        b=wCOgN6buPNynnODnf6ARhk9O4ZQMBqxyMhfGXMLq6+gUEYuudkz3NKlolhvSmdVeF5
         MfeeGC0MeIqL4HtU27m47wtCOVOvI4W/QyReOIIRhFUkzTphNqLCWJ6oFf+FnDcM9hvR
         EWaOA9up6Ggm+xEP5wC0yQdPadqRLzRcVLSZzEfIizLn5sr6DOW6GINBuKDj/jE+1gd5
         k+mWelQzoxpCKO40cQHAJufxwHXTxXnZGrN3h8vn8NZOvQPWLDfS0vFeDgJM9upzR0QL
         mdh+r7xEHnqh09RjNMa4Ww/8ppyGxmk1oc0l4mvoCWEsLtemFrRBCzcpQM8FMmTp8lfB
         zEBw==
X-Gm-Message-State: AOJu0Yyw8P6yV2uVl0wm05UoXZcAR7uPDdtwVRsnF2t59fHo7i84wlYI
        u19vyEcKZWlJ/rv2jpEL+mvHpByDzRx1aw==
X-Google-Smtp-Source: AGHT+IG3JcQqqXUlvmV9E4Jq3lvTw/W0aG3auxyNSagyZtjyoh921YIZwuIwFilGsSDgtbh9RCNWpQ==
X-Received: by 2002:a81:7c89:0:b0:5d7:1941:2c2f with SMTP id x131-20020a817c89000000b005d719412c2fmr4754793ywc.92.1702348087359;
        Mon, 11 Dec 2023 18:28:07 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id a200-20020a0dd8d1000000b005d35a952324sm3449101ywe.56.2023.12.11.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:07 -0800 (PST)
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
Subject: [PATCH v3 09/35] drivers/perf: optimize ali_drw_get_counter_idx() by using find_and_set_bit()
Date:   Mon, 11 Dec 2023 18:27:23 -0800
Message-Id: <20231212022749.625238-10-yury.norov@gmail.com>
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

The function searches used_mask for a set bit in a for-loop bit by bit.
Simplify it by using atomic find_and_set_bit().

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

