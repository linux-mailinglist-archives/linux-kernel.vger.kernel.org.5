Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A830D7F00C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKRPyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjKRPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:37 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482A1FFF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:56 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a822f96aedso33743847b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322715; x=1700927515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Faq88orJ2tLAcgJ6Ak512QARxmUWD9dLolef7kGFuP8=;
        b=hcACIPzBulOdtEuNm05hpsAR7UMnLmhav62wLOz5hBaF+NaS7TnMBjmZHBpNdNHso7
         P+9DV7JUtJnclhdlegEPImotD8CuVBTQDwux3woKsjUay2BnxPd5e1M1kxlObqXfmW9f
         eJ4woQpt6fPpUx+nrbRY+zo9r+TviA7/olG313tK0nFv7FVi9jbvrpDy7JNbHiBZnO5Q
         vlzDinRv+pOhYFNrtwso2pyKM+KN6ZBtu/kX2ySchrgrM7X1/CdEJifdY7AuZ+2UWLvt
         B3vXQCjt4YnsaFdhCtvdY7QKaz39r/mGjN5n3SgC8583qWYGThYiyCTAfYiZsADh5+Id
         m+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322715; x=1700927515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Faq88orJ2tLAcgJ6Ak512QARxmUWD9dLolef7kGFuP8=;
        b=JNc5YYZnll6ePdQcSaPx2sghkts4R9MBTS3h1tH4SQlVASTAnJe0clnWBBlCm/RjCu
         fBflDx9U3C6UuiL5NoONY+dTAq5DQ6e6ME+RjU7iMOrOiVu/JJIo/4KulRv5m7y2bgZr
         X7H/+56lmoqpqxWPRSISL1z7TO1fHtNhlGzdjzMdr+9SOP+LEbrrqTbnq7c/JR9EHm4K
         3l6JIXmQjBoOer9TyQoZDdyRh/Ox9FtpkFbb8calxffJaJ/rQedOnlydFtsFisFCOK9J
         uamcJNszenxE6mtP+a0XoOMfuRG3Ne1KMMUocjrwoVzDH17cvGYkK077cMOut91SZKeQ
         t2aQ==
X-Gm-Message-State: AOJu0YzG4hn18fS2Zjol7VvwKRdjHeVWM075jq3Qv+rVtcyG/14LtHv7
        LYT3eq+BRER3bBppTWItmliUODBYksqaIf6K
X-Google-Smtp-Source: AGHT+IEN5VHZ3duafcnm/k8t+mVTB/cJ3CeGZaVa462hMjL/JpTWc3yeLMLvRrae0wvqSgJiWcTX/g==
X-Received: by 2002:a0d:cb0b:0:b0:5a7:dda6:cbaf with SMTP id n11-20020a0dcb0b000000b005a7dda6cbafmr2882441ywd.19.1700322714741;
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id k186-20020a0dfac3000000b00559f1cb8444sm1186383ywf.70.2023.11.18.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 31/34] drivers/perf: optimize m1_pmu_get_event_idx() by using find_bit() API
Date:   Sat, 18 Nov 2023 07:51:02 -0800
Message-Id: <20231118155105.25678-32-yury.norov@gmail.com>
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

The function searches used_mask for a bit in a for-loop bit by bit.
We can do it faster by using atomic find_and_set_bit().

The comment to the function says that it searches for the first free
counter, but obviously for_each_set_bit() searches for the first set
counter. The following test_and_set_bit() tries to enable already set
bit, which is weird.

This patch, by using find_and_set_bit(), fixes this automatically.

Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU driver")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index cd2de44b61b9..2d50670ffb01 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -447,12 +447,8 @@ static int m1_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * counting on the PMU at any given time, and by placing the
 	 * most constraining events first.
 	 */
-	for_each_set_bit(idx, &affinity, M1_PMU_NR_COUNTERS) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
-
-	return -EAGAIN;
+	idx = find_and_set_bit(cpuc->used_mask, M1_PMU_NR_COUNTERS);
+	return idx < M1_PMU_NR_COUNTERS ? idx : -EAGAIN;
 }
 
 static void m1_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
-- 
2.39.2

