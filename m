Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44E7F7510
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKXN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjKXN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A619BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qX2dA3aqMotkmkgBnT9s/2Q/bW+jQxPjHk8bIRl2TXE=;
        b=dQWeGBfKXMPea9Kj/9qHdaRFhs6cbWq9G+QHWZkqxUminddsyiLqg5ILBCnQ+Wo/rkcETm
        zXzv++mcKEnuIMWkojOJbWVHLodNAEnCEXh1dke6pZ4PN0lLN3o9uK0a0GvPYKHe2/G6SM
        4Lpjtx7snDBxf0B4qa2on9d+IaitCvM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-yyv_70-8PeWkL3Q6JW939Q-1; Fri,
 24 Nov 2023 08:27:26 -0500
X-MC-Unique: yyv_70-8PeWkL3Q6JW939Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8A52806053;
        Fri, 24 Nov 2023 13:27:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE44C2166B2B;
        Fri, 24 Nov 2023 13:27:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 15/20] mm/rmap_id: verify precalculated subids with CONFIG_DEBUG_VM
Date:   Fri, 24 Nov 2023 14:26:20 +0100
Message-ID: <20231124132626.235350-16-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's verify the precalculated subids for 4/5/6 values.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap_id.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/rmap_id.c b/mm/rmap_id.c
index 6c3187547741..421d8d2b646c 100644
--- a/mm/rmap_id.c
+++ b/mm/rmap_id.c
@@ -481,3 +481,29 @@ void free_rmap_id(int id)
 	ida_free(&rmap_ida, id);
 	spin_unlock(&rmap_id_lock);
 }
+
+#ifdef CONFIG_DEBUG_VM
+static int __init rmap_id_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rmap_subids_4); i++)
+		WARN_ON_ONCE(calc_rmap_subid(1u << RMAP_SUBID_4_MAX_ORDER, i) !=
+			     rmap_subids_4[i]);
+
+#if MAX_ORDER >= RMAP_SUBID_5_MIN_ORDER
+	for (i = 0; i < ARRAY_SIZE(rmap_subids_5); i++)
+		WARN_ON_ONCE(calc_rmap_subid(1u << RMAP_SUBID_5_MAX_ORDER, i) !=
+			     rmap_subids_5[i]);
+#endif
+
+#if MAX_ORDER >= RMAP_SUBID_6_MIN_ORDER
+	for (i = 0; i < ARRAY_SIZE(rmap_subids_6); i++)
+		WARN_ON_ONCE(calc_rmap_subid(1u << RMAP_SUBID_6_MAX_ORDER, i) !=
+			     rmap_subids_6[i]);
+#endif
+
+	return 0;
+}
+module_init(rmap_id_init)
+#endif /* CONFIG_DEBUG_VM */
-- 
2.41.0

