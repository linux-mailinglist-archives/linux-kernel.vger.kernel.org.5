Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B027C8CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJMR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:57:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C8CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:57:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9d132d92cso6324895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697219845; x=1697824645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fonQwXfCN69NQb+A4dqVyCysjcLISiFg18CBwAvV4OA=;
        b=CZJApRO+NjbZQ8Ta/q/KApTywRWp5kVIT1WTRxMy9y/QDKvJHP7FtIb/KhEfO/L5LZ
         n2qs+Ju8IvvMTtz2qkca2wdyCtUY1xm0zpyC1MOhmSRIhaeZwXvS8dNl2SVoKmmPnKA3
         uB0xsCSHNjuDXNhvRuoBH3fgBZImYmTol4Q+qfx+F80He9KNoGP7uwcDOn6cjJ8iRl2l
         Vh9nM33hRqYz+xz2X21eLAjkfRFxn2VC1d71OkSw0oQqBvz/PRypxxuXCDpD6sKcwMTf
         weCJZcsbkAiXtPOtbBx8qlt0C/CgyhPaYTPESnN6Go5W1cDGMXjdjn46Mju39lmbHwKP
         jIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697219845; x=1697824645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fonQwXfCN69NQb+A4dqVyCysjcLISiFg18CBwAvV4OA=;
        b=iaxc+03NiDO66+Hrr4A3MjSOMmYaIuG4cqiLixI+HejcLFtjZqMkjTk6600DTi/tKB
         Gz1RzTZXWQz4versI/0CuzYgximHvyrUZIYs4cOdgZ8zjlcXH/P6CnBqVtXBJ8YYRB6t
         zQKhEtcA8NaYkrJ0/X0wfB3VmukZwr55LV5sWs5zE139s8IvmUqg5wBOrxyB/J8dpaZ+
         oqVmEUNz6THt1AOUpzPqppCl2J67F8qoWidXQL2fzmE6D7fWBR14g9DXNwUrINYJrrCZ
         rP2y+9UxRir5/LMwwuy8d83NYZqIcnWlBgfC18vaujODcyMTHslxwSSlDU03bcfFcWtr
         Lz/g==
X-Gm-Message-State: AOJu0Ywdij2m4MO/fwLra0UTtiez4T0s1el81cW1XM+KI2VX+j6NCLoN
        VsrZCtSn7TragG+SuT+BIU4JNewbMaQxw3Ug
X-Google-Smtp-Source: AGHT+IFhoOHVOaGD9kq5X81RwxEZLP3PqLvj1FxrxbU49r5DYy2eSGLjob+eRv+TUFObOX1sv5UuTA==
X-Received: by 2002:a17:902:f686:b0:1c7:5581:f9c with SMTP id l6-20020a170902f68600b001c755810f9cmr29945485plg.0.1697219845416;
        Fri, 13 Oct 2023 10:57:25 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b001c63429fa89sm4232472pln.247.2023.10.13.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:57:24 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] powerpc/perf: Optimize find_alternatives_list() using binary search
Date:   Sat, 14 Oct 2023 01:57:14 +0800
Message-Id: <20231013175714.2142775-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the performance of event alternative lookup by
replacing the previous linear search with a more efficient binary
search. This change reduces the time complexity for the search process
from O(n) to O(log(n)). A pre-sorted table of event values and their
corresponding indices has been introduced to expedite the search
process.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/powerpc/perf/power6-pmu.c | 43 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index 5729b6e059de..b6030ea130eb 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -335,25 +335,34 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ 0x3000fe, 0x400056 },			/* PM_DATA_FROM_L3MISS */
 };
 
-/*
- * This could be made more efficient with a binary search on
- * a presorted list, if necessary
- */
 static int find_alternatives_list(u64 event)
 {
-	int i, j;
-	unsigned int alt;
-
-	for (i = 0; i < ARRAY_SIZE(event_alternatives); ++i) {
-		if (event < event_alternatives[i][0])
-			return -1;
-		for (j = 0; j < MAX_ALT; ++j) {
-			alt = event_alternatives[i][j];
-			if (!alt || event < alt)
-				break;
-			if (event == alt)
-				return i;
-		}
+	const unsigned int presort_event_table[] = {
+		0x0130e8, 0x080080, 0x080088, 0x10000a, 0x10000b, 0x10000d, 0x10000e,
+		0x100010, 0x10001a, 0x100026, 0x100054, 0x100056, 0x1000f0, 0x1000f8,
+		0x1000fc, 0x200008, 0x20000e, 0x200010, 0x200012, 0x200054, 0x2000f0,
+		0x2000f2, 0x2000f4, 0x2000f5, 0x2000f6, 0x2000f8, 0x2000fc, 0x2000fe,
+		0x2d0030, 0x30000a, 0x30000c, 0x300010, 0x300012, 0x30001a, 0x300056,
+		0x3000f0, 0x3000f2, 0x3000f6, 0x3000f8, 0x3000fc, 0x3000fe, 0x400006,
+		0x400007, 0x40000a, 0x40000e, 0x400010, 0x400018, 0x400056, 0x4000f0,
+		0x4000f8, 0x600005};
+	const unsigned int event_index_table[] = {
+		0,  1,  2,  3,  4,  1, 5,  6,  7,  8,  9,  10, 11, 12, 13, 12, 14,
+		7,  15, 2,  9,  16, 3, 4,  0,  17, 10, 18, 19, 20, 1,  17, 15, 19,
+		18, 2,  16, 21, 8,  0, 22, 13, 14, 11, 21, 5,  20, 22, 1,  6,  3};
+	int lo = 0;
+	int hi = ARRAY_SIZE(presort_event_table) - 1;
+
+	while (lo <= hi) {
+		int mid = lo + (hi - lo) / 2;
+		unsigned int alt = presort_event_table[mid];
+
+		if (alt < event)
+			lo = mid + 1;
+		else if (alt > event)
+			hi = mid - 1;
+		else
+			return event_index_table[mid];
 	}
 	return -1;
 }
-- 
2.25.1

