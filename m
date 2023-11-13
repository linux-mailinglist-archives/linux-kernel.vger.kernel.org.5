Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773A7E9CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjKMNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:06:19 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9E1711
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:06:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so3287597b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699880776; x=1700485576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXoWjqfg8+j8eT28RHElwz66GqwL0VNwqWlpAIhmXQc=;
        b=hvT6X8quBGBXaDDJ/FtKdy/06sGZIbJHtLKtKSB+Xoaj8KBrPUzETkFjS6wiovr3sV
         T4nh8KXe5zP1BTVCT/4RlUNUhfWwUoIpKbmd2qJrIJsaRiQDuWo6EzAaJARC7QRTmuhJ
         oYEVqS46E83mAWjt+Kn17FxuZ02ug6dJWzx3AQvHrNUdwcoCXlt7uj7gMwNjTCkkEpFK
         ye4erKCwUGj2CCCeTpRHU5lHPPoqXFzDPi70pndrSsLLw2pBLP6vs/KRcyBb/AkTJzJF
         DJen2rtandxL53wsBAXVxjL7lVTmqNDLXyPRx0RE+u56YzjrRTyDO4kEs1dWm9d8NHBc
         5TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699880776; x=1700485576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXoWjqfg8+j8eT28RHElwz66GqwL0VNwqWlpAIhmXQc=;
        b=ZLtK5yNKVjeJg6HtzaKf+RqwO4c7qtuOYrXCFN/qd9pREd62CEmZW6uBujXzAX8qtd
         UDAw5QPAHK1HbJasvjPDhC469ZUEImsNKjPlu6HYqAXBNnueQ+/TMFi8fqFPC+PvLPhi
         G3ZSC2t1+ztcXugTLVwPtDSJgY9Jhq1/2UkbL9KeBfgcW4wNZ5075A9ziQNTZiakL3+u
         mduhPauQg60tNL3aFC6zbqMHGh19TKDRMDtuaqhL1bgqOsgelmz7vSsMUPqki8mtSYsP
         foy9kn+uLVjJa8NfZiRZ/TfgndY0Wo23YRIki8wH56ryJD3NJLWDm4s905AcHAv5CGkf
         CZ6Q==
X-Gm-Message-State: AOJu0YwG1T12u99svZixO1nOA3zLWdKfGSputGngx3RRIOg2pGWOriCs
        h4BGC1bottJp4Mm+1AI6LhxZww==
X-Google-Smtp-Source: AGHT+IHJ3nZBgscbZNQTk6JtG1TVoFaqi3hf5LL5vRLXl4Ospw7faDez8f3mP1+E9odJmLya4BzKgA==
X-Received: by 2002:a05:6a00:1406:b0:6bc:e7f8:821e with SMTP id l6-20020a056a00140600b006bce7f8821emr8344990pfu.10.1699880775952;
        Mon, 13 Nov 2023 05:06:15 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id g3-20020aa78743000000b0068ff0a633fdsm3810805pfo.131.2023.11.13.05.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:06:15 -0800 (PST)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
Date:   Mon, 13 Nov 2023 21:06:01 +0800
Message-Id: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently found two scenarios where zswap entry could not be
released, which will cause shrink_worker and active recycling
to fail.
1)The swap entry has been freed, but cached in swap_slots_cache,
no swap cache and swapcount=0.
2)When the option zswap_exclusive_loads_enabled disabled and
zswap_load completed(page in swap_cache and swapcount = 0).

The above two cases need to be determined by swapcount=0,
fix it.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/zswap.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 74411dfdad92..db95491bcdd5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1063,11 +1063,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct mempolicy *mpol;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	struct swap_info_struct *si;
 	struct zpool *pool = zswap_find_zpool(entry);
 	bool page_was_allocated;
 	u8 *src, *tmp = NULL;
 	unsigned int dlen;
-	int ret;
+	int ret = 0;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
@@ -1082,16 +1083,30 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	mpol = get_task_policy(current);
 	page = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
 				NO_INTERLEAVE_INDEX, &page_was_allocated);
-	if (!page) {
+	if (!page)
 		ret = -ENOMEM;
-		goto fail;
-	}
-
-	/* Found an existing page, we raced with load/swapin */
-	if (!page_was_allocated) {
+	else if (!page_was_allocated) {
+		/* Found an existing page, we raced with load/swapin */
 		put_page(page);
 		ret = -EEXIST;
-		goto fail;
+	}
+
+	if (ret) {
+		si = get_swap_device(swpentry);
+		if (!si)
+			goto out;
+
+		/* Two cases to directly release zswap_entry.
+		 * 1) -ENOMEM,if the swpentry has been freed, but cached in
+		 * swap_slots_cache(no page and swapcount = 0).
+		 * 2) -EEXIST, option zswap_exclusive_loads_enabled disabled and
+		 * zswap_load completed(page in swap_cache and swapcount = 0).
+		 */
+		if (!swap_swapcount(si, swpentry))
+			ret = 0;
+
+		put_swap_device(si);
+		goto out;
 	}
 
 	/*
@@ -1106,7 +1121,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
 		ret = -ENOMEM;
-		goto fail;
+		goto out;
 	}
 	spin_unlock(&tree->lock);
 
@@ -1151,7 +1166,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	return ret;
 
-fail:
+out:
 	if (!zpool_can_sleep_mapped(pool))
 		kfree(tmp);
 
-- 
2.25.1

