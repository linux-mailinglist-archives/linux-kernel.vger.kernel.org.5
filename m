Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D849D75C77D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGUNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGUNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A630D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689945504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHVCmyopA5Gpa/p3+Tf6DYpT7yyPaihL3mV5AOHJdCk=;
        b=XAzIyho8/DboWSj3xN/J/72F8nZmEkC0lmX2CB/0WnpqFvwS3Zf0LcJOrqD5HmMr7MJ2Cr
        Laubjc3eX7yBEt2j7QX5o9n2Y6uJZuD6xj90IzeEWrz+U7N0rOK5lPRMDh/Wz1rYjFEpAC
        bj8vUGDdyrDg3aB9r7XbMfrOl18IyvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-gPqUh22iP5KQ72sCd8VWSA-1; Fri, 21 Jul 2023 09:18:18 -0400
X-MC-Unique: gPqUh22iP5KQ72sCd8VWSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C41080123E;
        Fri, 21 Jul 2023 13:18:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 771C540C2071;
        Fri, 21 Jul 2023 13:18:13 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mawupeng1@huawei.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little bit
Date:   Fri, 21 Jul 2023 21:17:59 +0800
Message-Id: <20230721131800.20003-3-bhe@redhat.com>
In-Reply-To: <20230721131800.20003-1-bhe@redhat.com>
References: <20230721131800.20003-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

This removes the need of local varibale 'chunk', and optimize the code
calling pcpu_alloc_first_chunk() to initialize reserved chunk and
dynamic chunk to make it simpler.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 1480bf283d11..c25b058a46ad 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2581,7 +2581,6 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 {
 	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
 	size_t static_size, dyn_size;
-	struct pcpu_chunk *chunk;
 	unsigned long *group_offsets;
 	size_t *group_sizes;
 	unsigned long *unit_off;
@@ -2697,7 +2696,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_unit_pages = ai->unit_size >> PAGE_SHIFT;
 	pcpu_unit_size = pcpu_unit_pages << PAGE_SHIFT;
 	pcpu_atom_size = ai->atom_size;
-	pcpu_chunk_struct_size = struct_size(chunk, populated,
+	pcpu_chunk_struct_size = struct_size((struct pcpu_chunk *)0, populated,
 					     BITS_TO_LONGS(pcpu_unit_pages));
 
 	pcpu_stats_save_ai(ai);
@@ -2735,28 +2734,23 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 
 	/*
 	 * Initialize first chunk.
-	 * If the reserved_size is non-zero, this initializes the reserved
-	 * chunk.  If the reserved_size is zero, the reserved chunk is NULL
-	 * and the dynamic region is initialized here.  The first chunk,
-	 * pcpu_first_chunk, will always point to the chunk that serves
-	 * the dynamic region.
+	 * If the reserved_size is non-zero, initializes the reserved chunk
+	 * firstly. If the reserved_size is zero, the reserved chunk is NULL
+	 * and the dynamic region is initialized directly. The first chunk,
+	 * pcpu_first_chunk, will always point to the chunk that serves the
+	 * dynamic region.
 	 */
 	tmp_addr = (unsigned long)base_addr + static_size;
-	map_size = ai->reserved_size ?: dyn_size;
-	chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
-
-	/* init dynamic chunk if necessary */
 	if (ai->reserved_size) {
-		pcpu_reserved_chunk = chunk;
-
-		tmp_addr = (unsigned long)base_addr + static_size +
-			   ai->reserved_size;
-		map_size = dyn_size;
-		chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
+		map_size = ai->reserved_size;
+		pcpu_reserved_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
 	}
 
-	/* link the first chunk in */
-	pcpu_first_chunk = chunk;
+	/* init dynamic chunk if necessary */
+	tmp_addr += (unsigned long)ai->reserved_size;
+	map_size = dyn_size;
+	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, map_size);
+
 	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
-- 
2.34.1

