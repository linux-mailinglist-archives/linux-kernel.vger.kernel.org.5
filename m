Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604878C002
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjH2IML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjH2ILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6DDE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so6345634e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296705; x=1693901505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywq8StQp/KBu06JcZ9GL4Zmn1HAvlwzTQDj/mQ29ODE=;
        b=cCHg9QJ7bV1PJkKT69qc78hMud5WO2XMZ2rC7Kq/zpCRpFTJt+XtyZcbFkXILGntyx
         kv1hCReR5H4Aousj8EzBEJKZoBYWg4HoA9bqmampWukHud4vwWjnBSYW2mLSV/uw7dBk
         5J6TpDKuzrxGfeGZU6O/FjXI4FI9E6Swt258hqnD6CIFS4Pk6uZiQHDIJoiwTt5mbJkm
         di96B1OScPREmCOYj0GqBT18wYEM6wMvyEpII87nIOVOr9vYyOeJYuZNw2axR5sDg/17
         GeMTgqQaxLFGx28j0AGBMtPnwqHSlnS8Q6w0W7oLv2PFIhdTmBN66ld6OxfCNZjikDnr
         QtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296705; x=1693901505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywq8StQp/KBu06JcZ9GL4Zmn1HAvlwzTQDj/mQ29ODE=;
        b=Iqk0K3jTKcqDDE0po/mt35SVqYlOX/WkLWWggZjQohIzypKBwV3kEjFz+6LVxOGfLt
         BIyuTrB2QdF9SjR+RtdxRy2NjfF2jfVl8jojNrnQhS0+VcqympNiiB/a2Pp3kifToPQN
         tv8gEsBCv1l9+nTPtNPyMAmKIJDU6HRihD9DMQVXKvQefspSMWzEKCdM3YRnD/+N3w1a
         a8/qGHz6XbaCWufS8OSz5QesZcc3nhlf4YyRvBgGLppKnlgZE9P/JjsT6+E6RnuJHRxp
         Cbeld8LCzZwVkc3ospdOygEGX2KvAkycFgf1vUAMY4HDiEEKyO721CQvRI+PjoEKk66i
         +Tdg==
X-Gm-Message-State: AOJu0YwXyqGJgrbcTnM5Nynw/9AYNQHs5xRCwwnxTAfstAelxs0j3PLV
        Skz8zSxevw+1graQwXnubwc=
X-Google-Smtp-Source: AGHT+IGwl4ZbrmE9sKqjqkXHLjLzQEeOulEYPjEqSQBVjeNPTFEyetQGhLr+FtcamNWOsT1eDs4/fw==
X-Received: by 2002:a19:6705:0:b0:4f8:7513:8cb0 with SMTP id b5-20020a196705000000b004f875138cb0mr16773184lfc.2.1693296705456;
        Tue, 29 Aug 2023 01:11:45 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:45 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Date:   Tue, 29 Aug 2023 10:11:35 +0200
Message-Id: <20230829081142.3619-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
References: <20230829081142.3619-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames the adjust_va_to_fit_type() function
to va_clip() which is shorter and more expressive.

There is no a functional change as a result of this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 00afc1ee4756..09e315f8ea34 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1382,9 +1382,9 @@ classify_va_fit_type(struct vmap_area *va,
 }
 
 static __always_inline int
-adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
-		      struct vmap_area *va, unsigned long nva_start_addr,
-		      unsigned long size)
+va_clip(struct rb_root *root, struct list_head *head,
+		struct vmap_area *va, unsigned long nva_start_addr,
+		unsigned long size)
 {
 	struct vmap_area *lva = NULL;
 	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
@@ -1500,7 +1500,7 @@ va_alloc(struct vmap_area *va,
 		return vend;
 
 	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	ret = va_clip(root, head, va, nva_start_addr, size);
 	if (WARN_ON_ONCE(ret))
 		return vend;
 
@@ -4151,9 +4151,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
 
-		ret = adjust_va_to_fit_type(&free_vmap_area_root,
-					    &free_vmap_area_list,
-					    va, start, size);
+		ret = va_clip(&free_vmap_area_root,
+			&free_vmap_area_list, va, start, size);
 		if (WARN_ON_ONCE(unlikely(ret)))
 			/* It is a BUG(), but trigger recovery instead. */
 			goto recovery;
-- 
2.30.2

