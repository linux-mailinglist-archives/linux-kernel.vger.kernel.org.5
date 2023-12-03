Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C98026D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjLCTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjLCTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:29 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF771AA;
        Sun,  3 Dec 2023 11:33:28 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d279bcce64so42084617b3.3;
        Sun, 03 Dec 2023 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632005; x=1702236805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi6EtRexnxsYKFo0M3vY7B0gbt3XJMUCNtf5IqfsGHw=;
        b=EkpNMf9DpQ7W8Mp6QjkU0cIPZuVbJ16SAG8Xg+8rjko6MSuYFCiW1yipNzJ89BaIa8
         JXtNqUX/OPRL5gb+ti+X4b8W0ZMDRw2i2iWWObtL+nh4tU9IF93a6tvK4uqYjNgRCrFQ
         wrFH0rN8N4HUXeervioH+IaoN/fPV67x9dKnaGdV/gfS2WZRioFfFj4q687Po3FPxhIl
         WNnlhRkAUAKmWUMJrjFHNxTT/8HlrxYxYbiTVzP249rkR4JsMsc6IhXxHbvNHTWtx3IJ
         d4VJLXVQFMK9JvrT5H2wZQasJMq9c4M0Z0T/YxzxbTrIeLNM1KK2T2j8aFfl6zqhcpeU
         1SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632005; x=1702236805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi6EtRexnxsYKFo0M3vY7B0gbt3XJMUCNtf5IqfsGHw=;
        b=svpMYiwALevcZgRp5d91HBH8b9w7lfX0oHaB5NgSiWK6Khetj9AvEYnJScYAapFYTN
         rKLksaB8JBTe3bN2JYby7sMxgYExgoLKmbX+OAkoQm8Dvkjlbz9r8479dZ1EXioro1s4
         LlJc72DJdlHfmRaAyLlL4Bm3f3RkVR/fzbfMzoCvcJ5PlyiEnVVgMMEHt9Vpy9JVUqkv
         BUm6DngnWEoUJ6df5UnsvUQmlYl+6JCtxO7CZHux0y48hNy3BTmjTGIVrkix4Ywp3Fxn
         ct1HCPD5nxuZnnIOprN0tBQOS7/QOKUQRLk6Yxra1hxKVowffMhyjyp4Ela+z1LTmUAm
         rezw==
X-Gm-Message-State: AOJu0YxvXl2HaNV3SKWANWxoKVq+fIWm4dPoP5V6cllbx1kQWm74ZMHX
        EtzWmoiaE6DVT8O/r6tQraD7ge8sSykUfg==
X-Google-Smtp-Source: AGHT+IFhD23ll2GtzppIVNMZfHEwsNDR4k5+P3y4tWDr9NcAD1wxCeSFg7SG3St40uUjOOI2P8JViQ==
X-Received: by 2002:a81:b725:0:b0:5d7:eb34:5bf with SMTP id v37-20020a81b725000000b005d7eb3405bfmr933036ywh.3.1701632005220;
        Sun, 03 Dec 2023 11:33:25 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id c22-20020a814e16000000b005d875372a84sm300300ywb.38.2023.12.03.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:24 -0800 (PST)
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
Subject: [PATCH v2 10/35] dmaengine: idxd: optimize perfmon_assign_event()
Date:   Sun,  3 Dec 2023 11:32:42 -0800
Message-Id: <20231203193307.542794-9-yury.norov@gmail.com>
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

