Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD667D6135
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjJYFcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYFcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:32:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBC128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca052ec63bso45418895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698211903; x=1698816703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktOpyXH4xJvQjTjiv4myd5jeNbk19v5L3mPK+5WZ6SE=;
        b=NU7pgaOdmQtFzDcIrlAIpOrOJoOsBrWSARf6YtfdENDvS7C4ZK7Y2f487st1NvLZDZ
         8DifvchcrofAMOJYA0GIQf1Ve4gF/jGVRBj75oE641NdFxJYK/iPCpMgBz2aHu5200QD
         Y3gD1n9kakT92wbc04GZ04o1I7iDLsUczJrCBUV/4Gv/Iv+eW6wB/reJZ4Ln2q+e4g4r
         rgIfegf6/PYCVUvkFAXSyaVfQsBzpfvFgqbTvlUmPLCWwg6bBLFHylyfNfKsNo+Hy8L4
         Mg/h2vMG6VEeZDJbjGb/1fZw+i22RqEYL+QiPjkEPNBLi5BMyLA1eedvaLJ+8grzf0sj
         Upjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698211903; x=1698816703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktOpyXH4xJvQjTjiv4myd5jeNbk19v5L3mPK+5WZ6SE=;
        b=nOK6Eniae8kUW4nj6O+dda93MBTxVV3cYxT2bLjqxPevWzwTewphABK81aZtGY1ER3
         fOdFaHMsQoGWVcimpVTrEGbg6mqpyInhsNvU3Mi6KC7kKOm5LJV0hr76fn/Eq6wehWMy
         oMxvYHw9rY2ZXSBxFcgM7Vkul0QdXNX+yf0DY352nF+JHr7xoy7D3vfXzUBEc+zaGMyx
         +XZxPWHNA1Sm3Pl5+Pq+7PocjcgJKMe62h3h3hMUeQxWxtxg4TQLYEUd4J4ZQBd2v00e
         Ia+cpTpFP/a886jOXjIA/XEKMOjRc+VsxGLzR/Kn5MDBr37+rowkgbIkLVQs/4AJWeBO
         pb9A==
X-Gm-Message-State: AOJu0Yzf6la89x5HF84CzPZunqn4BFh49cxi+MhRgDCPgplFDiEXXFeu
        cYNPWZ00+IKERUF6KA8HfzxeiQ==
X-Google-Smtp-Source: AGHT+IFBNwIwfANneov1NrawUxvJ/9EtUDvFvK9xFRIKuWtX2JAggywQQ3wA2YrUCMumS8dfPYnqsA==
X-Received: by 2002:a17:902:e5d0:b0:1bd:d911:2a85 with SMTP id u16-20020a170902e5d000b001bdd9112a85mr16244605plf.12.1698211903253;
        Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bc2831e1a9sm8278906plg.90.2023.10.24.22.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:31:42 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH] lib,kprobes: objpool_try_add_slot merged into objpool_push
Date:   Wed, 25 Oct 2023 13:31:33 +0800
Message-Id: <20231025053133.343923-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After several rounds of objpool improvements the existence
of inline function objpool_try_add_slot is not appropriate
any more:
1) push can only happen on local cpu node, the cpu param of
   objpool_try_add_slot is misleading
2) objpool_push is only a wrapper of objpool_try_add_slot,
   with the original loop of all cpu nodes removed

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/objpool.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index a032701beccb..7474a3a60cad 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -152,13 +152,17 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 }
 EXPORT_SYMBOL_GPL(objpool_init);
 
-/* adding object to slot, abort if the slot was already full */
-static inline int
-objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
+/* reclaim an object to object pool */
+int objpool_push(void *obj, struct objpool_head *pool)
 {
-	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	struct objpool_slot *slot;
 	uint32_t head, tail;
+	unsigned long flags;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
 
+	slot = pool->cpu_slots[raw_smp_processor_id()];
 	/* loading tail and head as a local snapshot, tail first */
 	tail = READ_ONCE(slot->tail);
 
@@ -173,21 +177,9 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
 	/* update sequence to make this obj available for pop() */
 	smp_store_release(&slot->last, tail + 1);
 
-	return 0;
-}
-
-/* reclaim an object to object pool */
-int objpool_push(void *obj, struct objpool_head *pool)
-{
-	unsigned long flags;
-	int rc;
-
-	/* disable local irq to avoid preemption & interruption */
-	raw_local_irq_save(flags);
-	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
 	raw_local_irq_restore(flags);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(objpool_push);
 
-- 
2.40.1

