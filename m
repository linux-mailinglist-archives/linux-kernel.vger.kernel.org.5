Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF27D4CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjJXJoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJXJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:11 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285E10F5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:34:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UijxEztLRTexuc2wmlND22JYjAvU8peNSSAQw8rq2PA=;
        b=gykdRjMal5sST/bB2trCR8USAxy2UxFWhSeBpIeqaRzeF5OYDFVsgF9netz4vEDOO1YDYl
        eTbp0AKHNXuWCACBnN9eOw9UgYy91M8GYL3m9MQgwc5I0MLP0NIaEzdLHE9x29GwvY+Peq
        YX7cFeuPsGeiRsn56VsLqoroQhjglBc=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 5/7] slub: Introduce freeze_slab()
Date:   Tue, 24 Oct 2023 09:33:43 +0000
Message-Id: <20231024093345.3676493-6-chengming.zhou@linux.dev>
In-Reply-To: <20231024093345.3676493-1-chengming.zhou@linux.dev>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

We will have unfrozen slabs out of the node partial list later, so we
need a freeze_slab() function to freeze the partial slab and get its
freelist.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 7d0234bffad3..5b428648021f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3079,6 +3079,33 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 	return freelist;
 }
 
+/*
+ * Freeze the partial slab and return the pointer to the freelist.
+ */
+static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
+{
+	struct slab new;
+	unsigned long counters;
+	void *freelist;
+
+	do {
+		freelist = slab->freelist;
+		counters = slab->counters;
+
+		new.counters = counters;
+		VM_BUG_ON(new.frozen);
+
+		new.inuse = slab->objects;
+		new.frozen = 1;
+
+	} while (!__slab_update_freelist(s, slab,
+		freelist, counters,
+		NULL, new.counters,
+		"freeze_slab"));
+
+	return freelist;
+}
+
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
-- 
2.40.1

