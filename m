Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E880E198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbjLLC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjLLC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:12 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57808DB;
        Mon, 11 Dec 2023 18:28:10 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5e1a2253045so6490097b3.2;
        Mon, 11 Dec 2023 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348089; x=1702952889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PPaj8bONHO84DcPLdZn/HzTWIYQqNGS4xiypCmsJDM=;
        b=EeT0ewIvIPYinBZYW6XCaUORYpOhz3jr3Z0GrxT/kf4OVCroVDB6tyMkj66+RRHzqM
         YmvftBXHOj9dQ7XYG6QcYxFMG1HCU7CZQm1kbLG0UTskk1gvX4myd+1PFk+et4UjnJWl
         FJZJLN6toQuu2l/jvRqfJsqEOtQT6x5GIj49i+Z3kLh+i49OOQmwzAhOHUlRv9p0EiFF
         UYmsEYTj0PdAGEMr6mWBrPqi7nZj28KRJ+jETrJ7YBuslj957L7+BD7Vi58dLswi9VgO
         suCPXi+W6taNzRlhJrJGGj+J2RLZmx8z1zeDh1BVT9sCrHX2bKTEKWIuMmFjWs4UIq+N
         5/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348089; x=1702952889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PPaj8bONHO84DcPLdZn/HzTWIYQqNGS4xiypCmsJDM=;
        b=B1GN6upNiIbnwH5D39OmDD1HD+jr+oyM1RFtgE+tYs+JyoNf5BWWY6W3AlKuTJ5dPh
         Lj7d0frHanBn+v61bexfqzIbdbKhMS8nSAzrhsfma9Cx0KMq8TJNKtasUXnMzc4M2P+q
         S5RlnlhMYTfGR3+NtZlI09aikaAdqPXQkaEIWQqUH7/ITxMUIYh0PVyZ3loEqGRrkqBq
         r617LQw2381cSyRD1mVZeDDZJ8EpGYWO+5nnmNt47leCx3o6othkkmxoeuQ5NOP0EU/L
         XsHfuF6PIga2rn2JtGIOrJdgkGzxps93VEeiAklbxq/95B+jVI8W73eE5jmW/X4Gr0f9
         WT8Q==
X-Gm-Message-State: AOJu0YxmZMuGuOQXLj5f/mABk/AjDzrBOufgfoTNR4E9X5PrPXjchs6/
        aZR8+dU4h/DZc+Kf4Ex96jL/dJr519Vm9w==
X-Google-Smtp-Source: AGHT+IFfVJcg/DUfJP67/YgD49DyRzNNSoiDPbtETNKOnY44IEAlaTBX9EewmceS0nAr7MYstmZuAw==
X-Received: by 2002:a0d:cc8e:0:b0:5d3:8400:ba9 with SMTP id o136-20020a0dcc8e000000b005d384000ba9mr4160620ywd.48.1702348088892;
        Mon, 11 Dec 2023 18:28:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id u13-20020a81a50d000000b005cc8b377fe9sm3395652ywg.121.2023.12.11.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:08 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 10/35] dmaengine: idxd: optimize perfmon_assign_event()
Date:   Mon, 11 Dec 2023 18:27:24 -0800
Message-Id: <20231212022749.625238-11-yury.norov@gmail.com>
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
Simplify it by using atomic find_and_set_bit(), and make a nice
one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/perfmon.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index fdda6d604262..4dd9c0d979c3 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -134,13 +134,9 @@ static void perfmon_assign_hw_event(struct idxd_pmu *idxd_pmu,
 static int perfmon_assign_event(struct idxd_pmu *idxd_pmu,
 				struct perf_event *event)
 {
-	int i;
-
-	for (i = 0; i < IDXD_PMU_EVENT_MAX; i++)
-		if (!test_and_set_bit(i, idxd_pmu->used_mask))
-			return i;
+	int i = find_and_set_bit(idxd_pmu->used_mask, IDXD_PMU_EVENT_MAX);
 
-	return -EINVAL;
+	return i < IDXD_PMU_EVENT_MAX ? i : -EINVAL;
 }
 
 /*
-- 
2.40.1

