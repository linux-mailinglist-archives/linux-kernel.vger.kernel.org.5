Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE4798944
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbjIHOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbjIHOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:53:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFD1BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:53:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FCAB21D25;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694184799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Z1sKJpFTH+GkYm0khClKXyg32JfDaf6DR+O1U32B1U=;
        b=YuP4yGAgh8IJXJqsJ73xpH1c8mWzwQKxk19hlkWByx+xqNYN38WeOb48/N6bxU0xCx8maW
        W1jKRpnjfatbKB8YELQlCeuLU2hRZzscE/fnXEfChJl//ljQGtUhCDbG9stCFPzEOpYgEa
        m9vCuphfho6ykKwxQy2FsDwCQfrC7nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694184799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Z1sKJpFTH+GkYm0khClKXyg32JfDaf6DR+O1U32B1U=;
        b=zdKRoEqR5QeAuWFifH3Asdg2OEmp22MdGD1d+kXPIOxuQfreIS8fFSyp4hCLbK4CVYH8py
        dB2y1nrKP4MuEvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0857E131FD;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMVrAV81+2QaBQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Sep 2023 14:53:19 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/4] mm/slub: remove min_objects loop from calculate_order()
Date:   Fri,  8 Sep 2023 16:53:05 +0200
Message-ID: <20230908145302.30320-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908145302.30320-6-vbabka@suse.cz>
References: <20230908145302.30320-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calculate_order() currently has two nested loops. The inner one that
gradually modifies the acceptable waste from 1/16 up to 1/4, and the
outer one that decreases min_objects down to 2.

Upon closer inspection, the outer loop is unnecessary. Decreasing
min_objects could have in theory two effects to make the inner loop and
its call to calc_slab_order() succeed where a previous iteration with
higher min_objects would not:

- it could cause the min_objects-derived min_order to fit within
  slub_max_order. But min_objects is already pre-capped to max_objects
  that's derived from slub_max_order above the loops, so every iteration
  tries at least slub_max_order in calc_slab_order()

- it could cause calc_slab_order() to be called with lower min_objects
  thus potentially lower min_order in its loop. This would make a
  difference if the lower order could cause the fractional waste test to
  succeed where a higher order has already failed with same fract_leftover
  in the previous iteration with a higher min_order. But that's not
  possible, because increasing the order can only result in lower (or
  same) fractional waste. If we increase the slab size 2 times, we will
  fit at least 2 times the number of objects (thus same fraction of
  waste), or it will allow us to fit one more object (lower fraction of
  waste).

For more confidence I have tried adding a printk to notify when
decreasing min_objects resulted in a success, and simulated calculations
for a range of object sizes, nr_cpus and page_sizes. As expected, the
printk never triggered.

Thus remove the outer loop and adjust comments accordingly.

There's almost no functional change except a weird corner case when
slub_min_objects=1 on boot command line would cause the whole two nested
loops to be skipped before this patch. Now it would try to find the best
layout as usual, resulting in potentially higher orderthat minimizes
waste. This is not wrong and will be further expanded by the next patch.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c6e694cb17b9..5c287d96b212 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4141,14 +4141,6 @@ static inline int calculate_order(unsigned int size)
 	unsigned int max_objects;
 	unsigned int nr_cpus;
 
-	/*
-	 * Attempt to find best configuration for a slab. This
-	 * works by first attempting to generate a layout with
-	 * the best configuration and backing off gradually.
-	 *
-	 * First we increase the acceptable waste in a slab. Then
-	 * we reduce the minimum objects required in a slab.
-	 */
 	min_objects = slub_min_objects;
 	if (!min_objects) {
 		/*
@@ -4168,18 +4160,24 @@ static inline int calculate_order(unsigned int size)
 	max_objects = order_objects(slub_max_order, size);
 	min_objects = min(min_objects, max_objects);
 
-	while (min_objects > 1) {
-		unsigned int fraction;
-
-		fraction = 16;
-		while (fraction >= 4) {
-			order = calc_slab_order(size, min_objects,
-					slub_max_order, fraction);
-			if (order <= slub_max_order)
-				return order;
-			fraction /= 2;
-		}
-		min_objects--;
+	/*
+	 * Attempt to find best configuration for a slab. This works by first
+	 * attempting to generate a layout with the best possible configuration and
+	 * backing off gradually.
+	 *
+	 * We start with accepting at most 1/16 waste and try to find the
+	 * smallest order from min_objects-derived/slub_min_order up to
+	 * slub_max_order that will satisfy the constraint. Note that increasing
+	 * the order can only result in same or less fractional waste, not more.
+	 *
+	 * If that fails, we increase the acceptable fraction of waste and try
+	 * again.
+	 */
+	for (unsigned int fraction = 16; fraction >= 4; fraction /= 2) {
+		order = calc_slab_order(size, min_objects, slub_max_order,
+					fraction);
+		if (order <= slub_max_order)
+			return order;
 	}
 
 	/*
-- 
2.42.0

