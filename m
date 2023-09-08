Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A1798942
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbjIHOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244103AbjIHOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:53:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35F1FC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 825EA1FEFF;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694184799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBS/rfQAa9CuGAOXLs/AG66+kZ+35/pxxXJ2H3zd1io=;
        b=AErap95nCfprazdQmp9OXffnXycQVwIbGZpHDVA0rP1sASRm6I/cAKuQEAWyQwn3yPrIhj
        n2us9Yv71zG8n60xarSDoURo97o0UJr6tPpUw1eQl5dNdrsDvGofv7aMgtveGRu7mN2InU
        ErsEOQVo1bhO94LeTmRRs1dVrdIzL/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694184799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBS/rfQAa9CuGAOXLs/AG66+kZ+35/pxxXJ2H3zd1io=;
        b=PBQchTCPYcBZU1rMZMkGvd3jPhMJtIy0CS2wp+p1ullQX6NqzbDhx7UDZYJDCdQdtJKh3v
        ubVT/MasEOcFelDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59E68131FD;
        Fri,  8 Sep 2023 14:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iIFAFV81+2QaBQAAMHmgww
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
Subject: [PATCH 4/4] mm/slub: refactor calculate_order() and calc_slab_order()
Date:   Fri,  8 Sep 2023 16:53:07 +0200
Message-ID: <20230908145302.30320-10-vbabka@suse.cz>
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

After the previous cleanups, we can now move some code from
calc_slab_order() to calculate_order() so it's executed just once, and
do some more cleanups.

- move the min_order and MAX_OBJS_PER_PAGE evaluation to
  calc_slab_order().

- change calc_slab_order() parameter min_objects to min_order

Also make MAX_OBJS_PER_PAGE check more robust by considering also
min_objects in addition to slub_min_order. Otherwise this is not a
functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f04eb029d85a..1c91f72c7239 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4110,17 +4110,12 @@ static unsigned int slub_min_objects;
  * the smallest order which will fit the object.
  */
 static inline unsigned int calc_slab_order(unsigned int size,
-		unsigned int min_objects, unsigned int max_order,
+		unsigned int min_order, unsigned int max_order,
 		unsigned int fract_leftover)
 {
-	unsigned int min_order = slub_min_order;
 	unsigned int order;
 
-	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
-		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
-
-	for (order = max(min_order, (unsigned int)get_order(min_objects * size));
-			order <= max_order; order++) {
+	for (order = min_order; order <= max_order; order++) {
 
 		unsigned int slab_size = (unsigned int)PAGE_SIZE << order;
 		unsigned int rem;
@@ -4139,7 +4134,7 @@ static inline int calculate_order(unsigned int size)
 	unsigned int order;
 	unsigned int min_objects;
 	unsigned int max_objects;
-	unsigned int nr_cpus;
+	unsigned int min_order;
 
 	min_objects = slub_min_objects;
 	if (!min_objects) {
@@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
 		 * order on systems that appear larger than they are, and too
 		 * low order on systems that appear smaller than they are.
 		 */
-		nr_cpus = num_present_cpus();
+		unsigned int nr_cpus = num_present_cpus();
 		if (nr_cpus <= 1)
 			nr_cpus = nr_cpu_ids;
 		min_objects = 4 * (fls(nr_cpus) + 1);
@@ -4160,6 +4155,10 @@ static inline int calculate_order(unsigned int size)
 	max_objects = order_objects(slub_max_order, size);
 	min_objects = min(min_objects, max_objects);
 
+	min_order = max(slub_min_order, (unsigned int)get_order(min_objects * size));
+	if (order_objects(min_order, size) > MAX_OBJS_PER_PAGE)
+		return get_order(size * MAX_OBJS_PER_PAGE) - 1;
+
 	/*
 	 * Attempt to find best configuration for a slab. This works by first
 	 * attempting to generate a layout with the best possible configuration and
@@ -4176,7 +4175,7 @@ static inline int calculate_order(unsigned int size)
 	 * long as at least single object fits within slub_max_order.
 	 */
 	for (unsigned int fraction = 16; fraction > 1; fraction /= 2) {
-		order = calc_slab_order(size, min_objects, slub_max_order,
+		order = calc_slab_order(size, min_order, slub_max_order,
 					fraction);
 		if (order <= slub_max_order)
 			return order;
-- 
2.42.0

