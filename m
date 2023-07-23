Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC875E46A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGWTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGWTKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:10:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1FE7A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:09:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad8383faso28217935ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139377; x=1690744177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/RoRea2RA0cNUB7aJ08JIbxus10wCykI3szBf/b3NI=;
        b=Ou4Wv9xAdrG23117hD6v3zkc3JOqEdfqt1Qu9ZrCNSbLtrIaXd+6wF32CEMSTd5na6
         7A4Guaqf64bRqeW0tCtQ3dcA6oQku9WLgiqy4Me04QKAWd3fmPrJLmu8AjG0JZx3jRBL
         hstkawb10WlcxmKoFfy0da+F7E75mpmfcKyMuRUHGldiAFUkoLeykz80oJDSAuWDOXWk
         KXk5oTCiwgbucfFmgcXHqCnTDdL05FW9V+s4UvDhY8p68ItPDrDmUNJBHBrjC6auj4W7
         /lrlhfTfTf9r+moYceZyaJC6HkUM5ekZ3jNJYt3cPYA4LvyFgu4LhZluoSlht0DWlKVo
         jKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139377; x=1690744177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/RoRea2RA0cNUB7aJ08JIbxus10wCykI3szBf/b3NI=;
        b=cyNV4vtshXh02Tj4TV8DRaP2sV7JI6V9BV5PtuGgIszKa0+bzTI35vnlnTanQmQa2N
         6s/8WCwZiWVt73V3ZeoIesru0OTQjf3PzrBw8QsTxkUGeLWP/fzbcfjAaewJVr17dve9
         bAEtaI0IJcPsbrvDL/DKkd+KqP2/UzO7MIm4d043jdwYSY7LQzyEtSw4B25iSu3v3/6/
         ztnRrxUNwPihyj6hNQsaAkgnuZY1q3pM71PfXgURuZKO2bA9vAmOWLR+czgyTstboKBB
         oXNPKjgP03oOJdNk7+8/WEo64lKna65wtFr/nQAf8AsJt5rmOZO0eQ0belLBIGE/q17I
         3MGA==
X-Gm-Message-State: ABy/qLYwPVF7ir2QbGiTq5BBlyOoQWg2x3iofwSHyYBF4gOapG7K7vTe
        wwAHNs4R0+bl9wvgdS2d6Y8=
X-Google-Smtp-Source: APBJJlGkPj1Di2xoKkNZYf+n3venm8BAIC1yQaqaQC5aMCdLWvD6Q5YstcIl0N6JZs1PReycc5iu/Q==
X-Received: by 2002:a17:903:1208:b0:1b9:d307:c1df with SMTP id l8-20020a170903120800b001b9d307c1dfmr10327171plh.17.1690139377245;
        Sun, 23 Jul 2023 12:09:37 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b53d3d8f3dsm7168625plg.299.2023.07.23.12.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:09:36 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC 2/2] mm/slub: prefer NUMA locality over slight memory saving on NUMA machines
Date:   Mon, 24 Jul 2023 04:09:06 +0900
Message-ID: <20230723190906.4082646-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190906.4082646-1-42.hyeyoo@gmail.com>
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, SLUB sets remote_node_defrag_ratio to 1000, which makes it
(in most cases) take slabs from remote nodes first before trying allocating
new folios on the local node from buddy.

Documentation/ABI/testing/sysfs-kernel-slab says:
> The file remote_node_defrag_ratio specifies the percentage of
> times SLUB will attempt to refill the cpu slab with a partial
> slab from a remote node as opposed to allocating a new slab on
> the local node.  This reduces the amount of wasted memory over
> the entire system but can be expensive.

Although this made sense when it was introduced, the portion of
per node partial lists in the overall SLUB memory usage has been decreased
since the introduction of per cpu partial lists. Therefore, it's worth
reevaluating its overhead on performance and memory usage.

[
	XXX: Add performance data. I tried to measure its impact on
	hackbench with a 2 socket NUMA 	machine. but it seems hackbench is
	too synthetic to benefit from this, because the	skbuff_head_cache's
	size fits into the last level cache.

	Probably more realistic workloads like netperf would benefit
	from this?
]

Set remote_node_defrag_ratio to zero by default, and the new behavior is:
	1) try refilling per CPU partial list from the local node
	2) try allocating new slabs from the local node without reclamation
	3) try refilling per CPU partial list from remote nodes
	4) try allocating new slabs from the local node or remote nodes

If user specified remote_node_defrag_ratio, it probabilistically tries
3) first and then try 2) and 4) in order, to avoid unexpected behavioral
change from user's perspective.
---
 mm/slub.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 199d3d03d5b9..cfdea3e3e221 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2319,7 +2319,8 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 /*
  * Get a slab from somewhere. Search in increasing NUMA distances.
  */
-static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
+static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc,
+			     bool force_defrag)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
@@ -2347,8 +2348,8 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 	 * may be expensive if we do it every time we are trying to find a slab
 	 * with available objects.
 	 */
-	if (!s->remote_node_defrag_ratio ||
-			get_cycles() % 1024 > s->remote_node_defrag_ratio)
+	if (!force_defrag && (!s->remote_node_defrag_ratio ||
+			get_cycles() % 1024 > s->remote_node_defrag_ratio))
 		return NULL;
 
 	do {
@@ -2382,7 +2383,8 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 /*
  * Get a partial slab, lock it and return it.
  */
-static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
+static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc,
+			 bool force_defrag)
 {
 	void *object;
 	int searchnode = node;
@@ -2394,7 +2396,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, pc);
+	return get_any_partial(s, pc, force_defrag);
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -3092,6 +3094,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	struct slab *slab;
 	unsigned long flags;
 	struct partial_context pc;
+	gfp_t local_flags;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3208,10 +3211,35 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.flags = gfpflags;
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
-	freelist = get_partial(s, node, &pc);
+
+	freelist = get_partial(s, node, &pc, false);
 	if (freelist)
 		goto check_new_slab;
 
+	/*
+	 * try allocating slab from the local node first before taking slabs
+	 * from remote nodes. If user specified remote_node_defrag_ratio,
+	 * try taking slabs from remote nodes first.
+	 */
+	slub_put_cpu_ptr(s->cpu_slab);
+	local_flags = (gfpflags | __GFP_NOWARN | __GFP_THISNODE);
+	local_flags &= ~(__GFP_NOFAIL | __GFP_RECLAIM);
+	slab = new_slab(s, local_flags, node);
+	c = slub_get_cpu_ptr(s->cpu_slab);
+
+	if (slab)
+		goto alloc_slab;
+
+	/*
+	 * At this point no memory can be allocated lightly.
+	 * Take slabs from remote nodes.
+	 */
+	if (node == NUMA_NO_NODE) {
+		freelist = get_any_partial(s, &pc, true);
+		if (freelist)
+			goto check_new_slab;
+	}
+
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, gfpflags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);
@@ -3221,6 +3249,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
+alloc_slab:
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
@@ -3404,7 +3433,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 	pc.flags = gfpflags;
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
-	object = get_partial(s, node, &pc);
+	object = get_partial(s, node, &pc, false);
 
 	if (object)
 		return object;
@@ -4538,7 +4567,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	set_cpu_partial(s);
 
 #ifdef CONFIG_NUMA
-	s->remote_node_defrag_ratio = 1000;
+	s->remote_node_defrag_ratio = 0;
 #endif
 
 	/* Initialize the pre-computed randomized freelist if slab is up */
-- 
2.41.0

