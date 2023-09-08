Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813B798943
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbjIHOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbjIHOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:53:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96011FC0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 57A6A21D26;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694184799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGsbXXqcf4ORLaF4fFwqqZYAQFs76ztvW90bKyvUaBg=;
        b=yaoSVUcftdz9Z0pvCocl71s6a42GoguCtjRHXa0NVRtJyYOG6A+9KfluK9Nx3m9FsnxsoH
        nQhFs/wVHJNXuBKUYjlgy0YSvjKAfZz5BhBOE/d/6MtSEdQP0EBpF8i9JPxbt4GAX6uJVi
        y0ZD68CA0KFlChqiBb0LB0e5BbPQwtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694184799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGsbXXqcf4ORLaF4fFwqqZYAQFs76ztvW90bKyvUaBg=;
        b=1F8uln1OGPghmt/eKsFza2ILUJbA9ByJ69bS4pA/H55d4XBFwWCspcGJ6dS96kWwjv3Hpo
        6+lv3dA372hQ5VCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3169A13357;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wGFkC181+2QaBQAAMHmgww
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
Subject: [PATCH 3/4] mm/slub: attempt to find layouts up to 1/2 waste in calculate_order()
Date:   Fri,  8 Sep 2023 16:53:06 +0200
Message-ID: <20230908145302.30320-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908145302.30320-6-vbabka@suse.cz>
References: <20230908145302.30320-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main loop in calculate_order() currently tries to find an order with
at most 1/4 waste. If that's impossible (for particular large object
sizes), there's a fallback that will try to place one object within
slab_max_order.

If we expand the loop boundary to also allow up to 1/2 waste as the last
resort, we can remove the fallback and simplify the code, as the loop
will find an order for such sizes as well. Note we don't need to allow
more than 1/2 waste as that will never happen - calc_slab_order() would
calculate more objects to fit, reducing waste below 1/2.

Sucessfully finding an order in the loop (compared to the fallback) will
also have the benefit in trying to satisfy min_objects, because the
fallback was passing 1. Thus the resulting slab orders might be larger
(not because it would improve waste, but to reduce pressure on shared
locks), which is one of the goals of calculate_order().

For example, with nr_cpus=1 and 4kB PAGE_SIZE, slub_max_order=3, before
the patch we would get the following orders for these object sizes:

 2056 to 10920 - order-3 as selected by the loop
10928 to 12280 - order-2 due to fallback, as <1/4 waste is not possible
12288 to 32768 - order-3 as <1/4 waste is again possible

After the patch:

2056 to 32768 - order-3, because even in the range of 10928 to 12280 we
                try to satisfy the calculated min_objects.

As a result the code is simpler and gives more consistent results.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5c287d96b212..f04eb029d85a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4171,23 +4171,17 @@ static inline int calculate_order(unsigned int size)
 	 * the order can only result in same or less fractional waste, not more.
 	 *
 	 * If that fails, we increase the acceptable fraction of waste and try
-	 * again.
+	 * again. The last iteration with fraction of 1/2 would effectively
+	 * accept any waste and give us the order determined by min_objects, as
+	 * long as at least single object fits within slub_max_order.
 	 */
-	for (unsigned int fraction = 16; fraction >= 4; fraction /= 2) {
+	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
 		order = calc_slab_order(size, min_objects, slub_max_order,
 					fraction);
 		if (order <= slub_max_order)
 			return order;
 	}
 
-	/*
-	 * We were unable to place multiple objects in a slab. Now
-	 * lets see if we can place a single object there.
-	 */
-	order = calc_slab_order(size, 1, slub_max_order, 1);
-	if (order <= slub_max_order)
-		return order;
-
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-- 
2.42.0

