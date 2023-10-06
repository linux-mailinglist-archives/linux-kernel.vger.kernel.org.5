Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEEA7BBC43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjJFQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjJFQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:00:27 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CAAD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:00:25 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dcead29b3eso1424900fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696608025; x=1697212825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qipDY+TyShwnZedCZslVfS1LPA9lYq7Ryr1gmRWX8Wk=;
        b=f7ji7foXE1FCJI8aT5/i5jSpXuwJ9bf/pjfj68WbvhzDBTTnQJQDOqDPre2trVwl9d
         vV26jHAZlqCtd1alyXVcyid9qikF61VZJPJIxeXlkrJfRe9RYtJJor1jCccuIv9OrTMT
         1QldXMuAyMTS4K3O+8USesUG3YO6jppRKvQBpQ9LWaOqNTnQX7h6rQ6u8Mgk/RquZfU7
         NukcpImZU3Ud0lgsvmzkqKsz4EJ3p0783BvY5dVI3krYCHABpkCK2VxLUFCbWAeThuZ4
         FCCPjdTnV9QBytdUzH1HV8FejEbMA6CXFt9BzbC1euCVhE902mM0gtSVeX0OL65iFPSQ
         3KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696608025; x=1697212825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qipDY+TyShwnZedCZslVfS1LPA9lYq7Ryr1gmRWX8Wk=;
        b=UOHY9usUo93W/PU0XZbrnwK3HOzAHPwu6nk3DEDhLqoTMFchuXzF5oQK+lZ95J05/s
         wAbEIuxQAt1LKMXG1/JkMWIrTcMxeMxSspNKucQDrgCiVIFzj/QLfdy+0ic1R2yT+zSU
         B9Ftjp4KAM0gYuXvcMmmg4R6SFrm+hbuhYnd2dEmntKaaHTFB6Co4wkjTy2SGbJCfx3b
         HsO0gZS4ISuuupgJd8YNgi4d8ItVigTEiXsI4/Wkhrwl2N+0W8jL3yuCduz+XlBKb4g0
         uKyGipyf2z4t9Z8kf+ZZOL9gRGUKWUWsfWNffHIZbQKq5o7TBdSvW3uYok922kN2YMZN
         s8Cg==
X-Gm-Message-State: AOJu0Yy6r4clBg0Su7ig2mDNwDdZAG0nm5eUSxmVyS78hkugjTGOWeRF
        6SDNmIyGNc+HiV5X/DtOueyDtw==
X-Google-Smtp-Source: AGHT+IFcrDjjLybvUkweHij+P/eiaXeTS/GeNwh9ZIJUxL310AKztCl3NLTVHG9Tj3lqj+S9iQZQJg==
X-Received: by 2002:a05:6870:8294:b0:1db:3679:198a with SMTP id q20-20020a056870829400b001db3679198amr9905667oae.24.1696608025151;
        Fri, 06 Oct 2023 09:00:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id o16-20020a0ccb10000000b00656506a1881sm1485256qvk.74.2023.10.06.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:00:24 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, stable@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Nhat Pham <nphamcs@gmail.com>
Subject: [PATCH] mm: zswap: fix pool refcount bug around shrink_worker()
Date:   Fri,  6 Oct 2023 12:00:24 -0400
Message-ID: <20231006160024.170748-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a zswap store fails due to the limit, it acquires a pool
reference and queues the shrinker. When the shrinker runs, it drops
the reference. However, there can be multiple store attempts before
the shrinker wakes up and runs once. This results in reference leaks
and eventual saturation warnings for the pool refcount.

Fix this by dropping the reference again when the shrinker is already
queued. This ensures one reference per shrinker run.

Reported-by: Chris Mason <clm@fb.com>
Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Cc: stable@vger.kernel.org	[5.6+]
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 083c693602b8..37d2b1cb2ecb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1383,8 +1383,8 @@ bool zswap_store(struct folio *folio)
 
 shrink:
 	pool = zswap_pool_last_get();
-	if (pool)
-		queue_work(shrink_wq, &pool->shrink_work);
+	if (pool && !queue_work(shrink_wq, &pool->shrink_work))
+		zswap_pool_put(pool);
 	goto reject;
 }
 
-- 
2.42.0

