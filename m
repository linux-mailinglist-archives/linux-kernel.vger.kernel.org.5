Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0D7A1D06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjIOLBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIOLBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:01:35 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E0F272E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:11 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9a5d86705e4so143356866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775609; x=1695380409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv8bl1gghcslEiMH0/FhgvPpwPOagI6elAD3nLRWX2k=;
        b=S2p93F7A0wqiuJDV2GRyCDi4nQ/GWf5rYiMWy293ffMZgTknAV9VtkFjanCFblpjeZ
         Vz8riOrDUxMru8/Xd+jpL+9x03lPexD3tetyF6nW+ZLbmerLobIp+mZKD17m9CNfUpsE
         MOqVfSqBBVEwpWiGN4oAFbfSgW2oDtnN6GHD4WjvkPcaimIqVdD4ytihCT2228jmRTAH
         4jruLV64m/j0Dw4HwPpSfLEXH1kKv5/XByh5i9fjp1NAjcewXlYamwpJh3hR/KRt2IZJ
         WL363SQmgT7XUMl8Xni4TtoUSQoQYLnnhqDNxZLxAbv/ueK4lNbA92kVd7zi0iRu4Gm1
         YX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775609; x=1695380409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv8bl1gghcslEiMH0/FhgvPpwPOagI6elAD3nLRWX2k=;
        b=g2nqZt46D62gJ28PDU44Ewco64f38IXFwp4Cy6tpusUORM4BbPIRf/nt6Oy/jSndvG
         nbXmc18Pyyk4ADw43gGJwGA0Piyvag/9ntzt+GMXp14OcLt+57GN3hGsYndvnIxBDon+
         ecNVLGFBhIMorGl4LUtaOP7hCYlaM4yFZJKPNS8izFZC1IUlG/+9pa58XUNcBn0oJ1+h
         xlMa9mC1YEv3d/gPFIiKpEW2aUSVAvoIetEwrotD/bxT0TnDzGGqyvygDYydxzqcL/Ty
         mr90a+PZlSPdECU4YzaEeASnxFeGX4UQ+5wDY90CzLQnfchjXYucyttalYBonI5Yhrea
         Bxqw==
X-Gm-Message-State: AOJu0YypZwY/twRykJ3dixZKFY4+xCFyxlR3GeuneEn48g2T2UC3TRxP
        4xog3X59U5j9aS5mKEw2DNxZH4PXqAPN5DU47Q==
X-Google-Smtp-Source: AGHT+IEynAr2SnY1fMJiDuLoEg0/d2a8kjbFH3ONSC9J81629RSdKiVLHnan7ER1f/DyQsRkv3eYGMXRY5zwIxc8BQ==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a17:907:71d7:b0:9ad:c478:586b with
 SMTP id zw23-20020a17090771d700b009adc478586bmr6329ejb.13.1694775609336; Fri,
 15 Sep 2023 04:00:09 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:31 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-13-matteorizzo@google.com>
Subject: [RFC PATCH 12/14] mm/slub: introduce the deallocated_pages sysfs attribute
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

When SLAB_VIRTUAL is enabled this new sysfs attribute tracks the number
of slab pages whose physical memory has been reclaimed but whose virtual
memory is still allocated to a kmem_cache.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 include/linux/slub_def.h |  4 +++-
 mm/slub.c                | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 693e9bb34edc..eea402d849da 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -88,7 +88,7 @@ struct kmem_cache_cpu {
  */
 struct kmem_cache_virtual {
 #ifdef CONFIG_SLAB_VIRTUAL
-	/* Protects freed_slabs and freed_slabs_min */
+	/* Protects freed_slabs, freed_slabs_min, and nr_free_pages */
 	spinlock_t freed_slabs_lock;
 	/*
 	 * Slabs on this list have virtual memory of size oo allocated to them
@@ -97,6 +97,8 @@ struct kmem_cache_virtual {
 	struct list_head freed_slabs;
 	/* Same as freed_slabs but with memory of size min */
 	struct list_head freed_slabs_min;
+	/* Number of slab pages which got freed */
+	unsigned long nr_freed_pages;
 #endif
 };
 
diff --git a/mm/slub.c b/mm/slub.c
index 66ae60cdadaf..0f7f5bf0b174 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2110,6 +2110,8 @@ static struct slab *get_free_slab(struct kmem_cache *s,
 
 	if (likely(slab)) {
 		list_del(&slab->slab_list);
+		WRITE_ONCE(s->virtual.nr_freed_pages,
+			s->virtual.nr_freed_pages - (1UL << slab_order(slab)));
 
 		spin_unlock_irqrestore(&s->virtual.freed_slabs_lock, flags);
 		return slab;
@@ -2158,6 +2160,8 @@ static struct slab *alloc_slab_page(struct kmem_cache *s,
 		/* Rollback: put the struct slab back. */
 		spin_lock_irqsave(&s->virtual.freed_slabs_lock, flags);
 		list_add(&slab->slab_list, freed_slabs);
+		WRITE_ONCE(s->virtual.nr_freed_pages,
+			s->virtual.nr_freed_pages + (1UL << slab_order(slab)));
 		spin_unlock_irqrestore(&s->virtual.freed_slabs_lock, flags);
 
 		return NULL;
@@ -2438,6 +2442,8 @@ static void slub_tlbflush_worker(struct kthread_work *work)
 			WARN_ON(oo_order(slab->oo) != oo_order(s->min));
 			list_add(&slab->slab_list, &s->virtual.freed_slabs_min);
 		}
+		WRITE_ONCE(s->virtual.nr_freed_pages, s->virtual.nr_freed_pages +
+			(1UL << slab_order(slab)));
 		spin_unlock(&s->virtual.freed_slabs_lock);
 	}
 	spin_unlock_irqrestore(&slub_kworker_lock, irq_flags);
@@ -4924,6 +4930,7 @@ static inline void slab_virtual_open(struct kmem_cache *s)
 	spin_lock_init(&s->virtual.freed_slabs_lock);
 	INIT_LIST_HEAD(&s->virtual.freed_slabs);
 	INIT_LIST_HEAD(&s->virtual.freed_slabs_min);
+	s->virtual.nr_freed_pages = 0;
 #endif
 }
 
@@ -6098,6 +6105,14 @@ static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(objects_partial);
 
+#ifdef CONFIG_SLAB_VIRTUAL
+static ssize_t deallocated_pages_show(struct kmem_cache *s, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", READ_ONCE(s->virtual.nr_freed_pages));
+}
+SLAB_ATTR_RO(deallocated_pages);
+#endif /* CONFIG_SLAB_VIRTUAL */
+
 static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 {
 	int objects = 0;
@@ -6424,6 +6439,9 @@ static struct attribute *slab_attrs[] = {
 	&min_partial_attr.attr,
 	&cpu_partial_attr.attr,
 	&objects_partial_attr.attr,
+#ifdef CONFIG_SLAB_VIRTUAL
+	&deallocated_pages_attr.attr,
+#endif
 	&partial_attr.attr,
 	&cpu_slabs_attr.attr,
 	&ctor_attr.attr,
-- 
2.42.0.459.ge4e396fd5e-goog

