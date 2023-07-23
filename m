Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0575E469
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGWTKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGWTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:10:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CB10E5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:09:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so23740005ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139372; x=1690744172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKo85STH0xt3042Px3GwfcVzSaeLLym3sMWM8T4c8oI=;
        b=n2mPX/AnU5HRR2TatQSvEtq454ZA0uqEV+XcsaSntFyzBasdSjUD2ZxXYhdtKsJ8Ek
         N9htiNr2hrIdgrBE9skKL+CIacqccCRmdK02SxoejK2Q1awY9vRG/2TvqQDK6Syxfxj8
         2kbd0N7UF3rp7kIS3xCjLnlJqHAmiS4StmhmdAYyMZNjjd5Dkf8T4ZdXZx+nRl8G5CyZ
         xyId8mYgj1BZRUun2hsOiY5K4Oo/jHj9H2P94lDE6qSxJT3Z5wZbzJKGx1BSBfKHLgV6
         MGGFpyqeVUcYcdjRQFSL+G+W1+7NynXeEe0rLe7ZlLKTi9rEp8ygNOqDEXZo4x/wXXa7
         /u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139372; x=1690744172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKo85STH0xt3042Px3GwfcVzSaeLLym3sMWM8T4c8oI=;
        b=Bx5svf+iVEjZQo7NhHIPZC9ch54edsnPwkn8DxQuZNfXb6GLDU/iiMghnZ6AaB6RIk
         7cYJFvZOxDjxtCvJgnP8bgpnCf55MGZWH7i3hGSd33Mt14sxjddRWzKmxJBJnr1gpY+0
         UPAiUlipeJ1HGIFNogF09R8fZm6b9Xqbvnka/xuWl9IX3FO50Ov1F1ugwavd0iLSHnVl
         E15zDWUxyVQsYTAGbzZpyvJa0yCGe1w+Mx89gELVQ8B7F7pVe6zJfoxRmEiITBdxpw4J
         K8T2mIxAw7rC4ZUb9VS41BV3i3bJFFR9WP9cQjyps6JUbAt0RJX8ChEQ5RknReE+onIk
         nQYQ==
X-Gm-Message-State: ABy/qLaPbOqvH+j8/SBzOfEGk09MVUcO++DGTD/Vz0BusOcEXyXe2tvT
        ioVZXn9q9O+l5Q047oMtFEA=
X-Google-Smtp-Source: APBJJlF1frUPXLA+nNbwlQwx8oe1ROZ8tR8dgVHs6kFaKVR6/CntGZhb6WAHDnToH/UXDwmWuSjusA==
X-Received: by 2002:a17:902:f687:b0:1bb:8cb6:3f99 with SMTP id l7-20020a170902f68700b001bb8cb63f99mr4867895plg.14.1690139371565;
        Sun, 23 Jul 2023 12:09:31 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b53d3d8f3dsm7168625plg.299.2023.07.23.12.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:09:31 -0700 (PDT)
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
Subject: [RFC 1/2] Revert "mm, slub: change percpu partial accounting from objects to pages"
Date:   Mon, 24 Jul 2023 04:09:05 +0900
Message-ID: <20230723190906.4082646-2-42.hyeyoo@gmail.com>
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

This is partial revert of commit b47291ef02b0 ("mm, slub: change percpu
partial accounting from objects to pages"). and full revert of commit
662188c3a20e ("mm/slub: Simplify struct slab slabs field definition").

While b47291ef02b0 prevents percpu partial slab list becoming too long,
it assumes that the order of slabs are always oo_order(s->oo).

The current approach can surprisingly lower the number of objects cached
per cpu when it fails to allocate high order slabs. Instead of accounting
the number of slabs, change it back to accounting objects, but keep
the assumption that the slab is always half-full.

With this change, the number of cached objects per cpu is not surprisingly
decreased even when it fails to allocate high order slabs. It still
prevents large inaccuracy because it does not account based on the
number of free objects when taking slabs.
---
 include/linux/slub_def.h |  2 --
 mm/slab.h                |  6 ++++++
 mm/slub.c                | 31 ++++++++++++-------------------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..589ff6a2a23f 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -109,8 +109,6 @@ struct kmem_cache {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
 	unsigned int cpu_partial;
-	/* Number of per cpu partial slabs to keep around */
-	unsigned int cpu_partial_slabs;
 #endif
 	struct kmem_cache_order_objects oo;
 
diff --git a/mm/slab.h b/mm/slab.h
index 799a315695c6..be38a264df16 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -65,7 +65,13 @@ struct slab {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 				struct {
 					struct slab *next;
+#ifdef CONFIG_64BIT
 					int slabs;	/* Nr of slabs left */
+					int pobjects;	/* Approximate count */
+#else
+					short int slabs;
+					short int pobjects;
+#endif
 				};
 #endif
 			};
diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..199d3d03d5b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -486,18 +486,7 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
-	unsigned int nr_slabs;
-
 	s->cpu_partial = nr_objects;
-
-	/*
-	 * We take the number of objects but actually limit the number of
-	 * slabs on the per cpu partial list, in order to limit excessive
-	 * growth of the list. For simplicity we assume that the slabs will
-	 * be half-full.
-	 */
-	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
-	s->cpu_partial_slabs = nr_slabs;
 }
 #else
 static inline void
@@ -2275,7 +2264,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	struct slab *slab, *slab2;
 	void *object = NULL;
 	unsigned long flags;
-	unsigned int partial_slabs = 0;
+	int objects_taken = 0;
 
 	/*
 	 * Racy check. If we mistakenly see no partial slabs then we
@@ -2312,11 +2301,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		} else {
 			put_cpu_partial(s, slab, 0);
 			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
+			objects_taken += slab->objects / 2;
 		}
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 		if (!kmem_cache_has_cpu_partial(s)
-			|| partial_slabs > s->cpu_partial_slabs / 2)
+			|| objects_taken > s->cpu_partial / 2)
 			break;
 #else
 		break;
@@ -2699,13 +2688,14 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 	struct slab *slab_to_unfreeze = NULL;
 	unsigned long flags;
 	int slabs = 0;
+	int pobjects = 0;
 
 	local_lock_irqsave(&s->cpu_slab->lock, flags);
 
 	oldslab = this_cpu_read(s->cpu_slab->partial);
 
 	if (oldslab) {
-		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
+		if (drain && oldslab->pobjects >= s->cpu_partial) {
 			/*
 			 * Partial array is full. Move the existing set to the
 			 * per node partial list. Postpone the actual unfreezing
@@ -2714,14 +2704,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 			slab_to_unfreeze = oldslab;
 			oldslab = NULL;
 		} else {
+			pobjects = oldslab->pobjects;
 			slabs = oldslab->slabs;
 		}
 	}
 
 	slabs++;
+	pobjects += slab->objects / 2;
 
 	slab->slabs = slabs;
 	slab->next = oldslab;
+	slab->pobjects = pobjects;
 
 	this_cpu_write(s->cpu_slab->partial, slab);
 
@@ -5653,13 +5646,13 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
-		if (slab)
+		if (slab) {
 			slabs += slab->slabs;
+			objects += slab->objects;
+		}
 	}
 #endif
 
-	/* Approximate half-full slabs, see slub_set_cpu_partial() */
-	objects = (slabs * oo_objects(s->oo)) / 2;
 	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
@@ -5669,7 +5662,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 		if (slab) {
 			slabs = READ_ONCE(slab->slabs);
-			objects = (slabs * oo_objects(s->oo)) / 2;
+			objects = READ_ONCE(slab->pobjects);
 			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
 					     cpu, objects, slabs);
 		}
-- 
2.41.0

