Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255075D88E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGVBPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGVBPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6535B7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689988487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6R1QlipilZ8PvReJeTFJdQRGxlgRH9JHq1e33Yk320=;
        b=dLY+o8touajtdGZANP3lfS13GaXY1CsU2zlQh145X9+iLRoL3BnY3+0VRjFkAhTs9+RPGo
        VO2HnG3D57o7xlvGgQO0rsO5EFnRRy6vrXY0xd+21B1MhS8Nxx7nBtaWynEv6jPf3X7qda
        N8UNbIFi9RuJwrgsbWU+65rAziyaXio=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-hhOyGdPgPGOUGHeqaxD95g-1; Fri, 21 Jul 2023 21:14:43 -0400
X-MC-Unique: hhOyGdPgPGOUGHeqaxD95g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2CDB29AA2C2;
        Sat, 22 Jul 2023 01:14:42 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 534F9492C13;
        Sat, 22 Jul 2023 01:14:40 +0000 (UTC)
Date:   Sat, 22 Jul 2023 09:14:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 2/3] mm/percpu.c: optimize the code in
 pcpu_setup_first_chunk() a little bit
Message-ID: <ZLstfVZZUJigJzNq@MiWiFi-R3L-srv>
References: <20230721131800.20003-1-bhe@redhat.com>
 <20230721131800.20003-3-bhe@redhat.com>
 <ZLryLmHm99Pea2Yj@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLryLmHm99Pea2Yj@snowbird>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/23 at 02:01pm, Dennis Zhou wrote:
> Hello,
> 
> On Fri, Jul 21, 2023 at 09:17:59PM +0800, Baoquan He wrote:
> > This removes the need of local varibale 'chunk', and optimize the code
> > calling pcpu_alloc_first_chunk() to initialize reserved chunk and
> > dynamic chunk to make it simpler.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/percpu.c | 32 +++++++++++++-------------------
> >  1 file changed, 13 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 1480bf283d11..c25b058a46ad 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2581,7 +2581,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  {
> >  	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
> >  	size_t static_size, dyn_size;
> > -	struct pcpu_chunk *chunk;
> >  	unsigned long *group_offsets;
> >  	size_t *group_sizes;
> >  	unsigned long *unit_off;
> > @@ -2697,7 +2696,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  	pcpu_unit_pages = ai->unit_size >> PAGE_SHIFT;
> >  	pcpu_unit_size = pcpu_unit_pages << PAGE_SHIFT;
> >  	pcpu_atom_size = ai->atom_size;
> > -	pcpu_chunk_struct_size = struct_size(chunk, populated,
> > +	pcpu_chunk_struct_size = struct_size((struct pcpu_chunk *)0, populated,
> >  					     BITS_TO_LONGS(pcpu_unit_pages));
> >  
> >  	pcpu_stats_save_ai(ai);
> > @@ -2735,28 +2734,23 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  
> >  	/*
> >  	 * Initialize first chunk.
> > -	 * If the reserved_size is non-zero, this initializes the reserved
> > -	 * chunk.  If the reserved_size is zero, the reserved chunk is NULL
> > -	 * and the dynamic region is initialized here.  The first chunk,
> > -	 * pcpu_first_chunk, will always point to the chunk that serves
> > -	 * the dynamic region.
> > +	 * If the reserved_size is non-zero, initializes the reserved chunk
>                                          ^initialize
> > +	 * firstly. If the reserved_size is zero, the reserved chunk is NULL
>         ^ can remove firstly.
> > +	 * and the dynamic region is initialized directly. The first chunk,
> > +	 * pcpu_first_chunk, will always point to the chunk that serves the
> > +	 * dynamic region.
> 
> Reading this, I'll probably reword this comment to explain the reserved
> chunk better.

Agree. The expression is a little messy and too colloquial.

> 
> >  	 */
> >  	tmp_addr = (unsigned long)base_addr + static_size;
> > -	map_size = ai->reserved_size ?: dyn_size;
> > -	chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> > -
> > -	/* init dynamic chunk if necessary */
> >  	if (ai->reserved_size) {
> > -		pcpu_reserved_chunk = chunk;
> > -
> > -		tmp_addr = (unsigned long)base_addr + static_size +
> > -			   ai->reserved_size;
> > -		map_size = dyn_size;
> > -		chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> > +		map_size = ai->reserved_size;
> > +		pcpu_reserved_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> >  	}
> >  
> > -	/* link the first chunk in */
> > -	pcpu_first_chunk = chunk;
> > +	/* init dynamic chunk if necessary */
> > +	tmp_addr += (unsigned long)ai->reserved_size;
> 
> I'm not a big fan of += the tmp_addr as I personally find it easier to
> read if it's just laid out explicitly.

OK, will change.

> 
> > +	map_size = dyn_size;
> > +	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
> > +
> >  	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
> >  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
> >  
> > -- 
> > 2.34.1
> > 
> 
> Overall, I think this is good, but I'd go 1 step further and get rid of
> map_size. Regarding tmp_addr, I'd prefer if we kept all the math
> together.

Makes sense. Thanks a lot for your careful review and great suggestions.

According to your comments, I made a draft v2. Please help check if I
have got them correctly and if the new change is OK to you.

From 17832ce8a755d8327b853a18c6f1cc00c9f93e50 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 27 Jun 2023 09:33:28 +0800
Subject: [PATCH] mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a
 little bit
Content-type: text/plain

This removes the need of local varibale 'chunk', and optimize the code
calling pcpu_alloc_first_chunk() to initialize reserved chunk and
dynamic chunk to make it simpler.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 1480bf283d11..83fc47206680 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2581,14 +2581,12 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 {
 	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
 	size_t static_size, dyn_size;
-	struct pcpu_chunk *chunk;
 	unsigned long *group_offsets;
 	size_t *group_sizes;
 	unsigned long *unit_off;
 	unsigned int cpu;
 	int *unit_map;
 	int group, unit, i;
-	int map_size;
 	unsigned long tmp_addr;
 	size_t alloc_size;
 
@@ -2697,7 +2695,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_unit_pages = ai->unit_size >> PAGE_SHIFT;
 	pcpu_unit_size = pcpu_unit_pages << PAGE_SHIFT;
 	pcpu_atom_size = ai->atom_size;
-	pcpu_chunk_struct_size = struct_size(chunk, populated,
+	pcpu_chunk_struct_size = struct_size((struct pcpu_chunk *)0, populated,
 					     BITS_TO_LONGS(pcpu_unit_pages));
 
 	pcpu_stats_save_ai(ai);
@@ -2734,29 +2732,21 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	dyn_size = ai->dyn_size - (static_size - ai->static_size);
 
 	/*
-	 * Initialize first chunk.
-	 * If the reserved_size is non-zero, this initializes the reserved
-	 * chunk.  If the reserved_size is zero, the reserved chunk is NULL
-	 * and the dynamic region is initialized here.  The first chunk,
-	 * pcpu_first_chunk, will always point to the chunk that serves
-	 * the dynamic region.
+	 * Initialize first chunk:
+	 *
+	 * - If the reserved_size is non-zero, initialize the reserved
+	 *   chunk firstly. Otherwise, the reserved chunk is NULL.
+	 *
+	 * - The first chunk, pcpu_first_chunk, always points to the
+	 *   chunk that serves the dynamic region.
 	 */
 	tmp_addr = (unsigned long)base_addr + static_size;
-	map_size = ai->reserved_size ?: dyn_size;
-	chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
-
-	/* init dynamic chunk if necessary */
-	if (ai->reserved_size) {
-		pcpu_reserved_chunk = chunk;
-
-		tmp_addr = (unsigned long)base_addr + static_size +
-			   ai->reserved_size;
-		map_size = dyn_size;
-		chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
-	}
+	if (ai->reserved_size)
+		pcpu_reserved_chunk = pcpu_alloc_first_chunk(tmp_addr,
+						ai->reserved_size);
+	tmp_addr = (unsigned long)base_addr + static_size + ai->reserved_size;
+	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, dyn_size);
 
-	/* link the first chunk in */
-	pcpu_first_chunk = chunk;
 	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
-- 
2.34.1

