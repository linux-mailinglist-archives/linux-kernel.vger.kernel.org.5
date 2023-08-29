Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337278C001
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjH2IMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjH2ILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A7BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500a398cda5so6586848e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296705; x=1693901505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL90/r5YfKaetndDygiXgRj9+82zEERzAQ0GDLDkLpU=;
        b=KBNx8+rMsWH6nCoZ+bqmYd9kAnk7WAnmsK1kBQsrAlAXw5G8gE0GvO3mXpHwmsaxo6
         2gpql4OfGm5mlUT87PooQWCwid+0V/L0gGFxqRSDE33LssOioQu9/J/GftDFL6eIFLP2
         WxkgXO7BfDqg+QFz6qDLjaC8GnQeNtUf+7iVTY2FPuZQ/tnQIvQOLSskE2Oh9B9ZvZ4N
         k1zIv/bkiyfhvv0zqX0jqhpriTp5UMS5HJvEu/9ev2Hy7/A7kVeOcLNiym9jh4PUxSk8
         3Seg6UEsuWTLjTaMi36vLbd4qiliQuH+YQaAE0zVR/5ngM7wauyPOpps+nix0j1IeD0M
         0l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296705; x=1693901505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL90/r5YfKaetndDygiXgRj9+82zEERzAQ0GDLDkLpU=;
        b=fTJcdCbadPhkgnfsPBSjDM78kgoNWA+WwSvl/HdMG0ll6/8Y6PrFHD4G2XxVCxnXMI
         tJk4DM70Ye6FOSR6U4WlhY3MMq9q6E1D2+44+Gr1BUHWpz7C5uSFiotOlBPWNbvwZJAc
         vLWFz+R0zPySZdcHSGPaio5Qn7gpUQzml2FEQ7dU5gPKjAZQnBGE1wWPwD5n3LawvIfb
         IZq+CREyEP1sDc1ZL+v1GCeBXVUO7VaK1BhPasMoBtHnHqX9KjVWqzroNNDsI80dHy1a
         7UmQwDl8jdcuqfMvVZk4Ga2RlhqFA0Yrieic5FmjEqv7oYARuyfCpRfH0dNRdqc7N2YX
         DTbw==
X-Gm-Message-State: AOJu0YzFVVzvcUxXshggBhiLZPv0jWwsd5oY3WVGrQ1t3YmkMBslyUyD
        PQ4LRJW8Z5undOor/YKXTx8=
X-Google-Smtp-Source: AGHT+IGMSDc2itGbnAweqsvba/FoxkJn/ThOjItzn70Gby98afKeT+YDst0o5W/Z6YiFsaM3uYPSNA==
X-Received: by 2002:a19:911a:0:b0:500:acf1:b432 with SMTP id t26-20020a19911a000000b00500acf1b432mr5985858lfd.63.1693296704660;
        Tue, 29 Aug 2023 01:11:44 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:44 -0700 (PDT)
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
Subject: [PATCH v2 1/9] mm: vmalloc: Add va_alloc() helper
Date:   Tue, 29 Aug 2023 10:11:34 +0200
Message-Id: <20230829081142.3619-2-urezki@gmail.com>
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

Currently __alloc_vmap_area() function contains an open codded
logic that finds and adjusts a VA based on allocation request.

Introduce a va_alloc() helper that adjusts found VA only. It
will be used later at least in two places.

There is no a functional change as a result of this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..00afc1ee4756 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1481,6 +1481,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
 	return 0;
 }
 
+static unsigned long
+va_alloc(struct vmap_area *va,
+		struct rb_root *root, struct list_head *head,
+		unsigned long size, unsigned long align,
+		unsigned long vstart, unsigned long vend)
+{
+	unsigned long nva_start_addr;
+	int ret;
+
+	if (va->va_start > vstart)
+		nva_start_addr = ALIGN(va->va_start, align);
+	else
+		nva_start_addr = ALIGN(vstart, align);
+
+	/* Check the "vend" restriction. */
+	if (nva_start_addr + size > vend)
+		return vend;
+
+	/* Update the free vmap_area. */
+	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
+	if (WARN_ON_ONCE(ret))
+		return vend;
+
+	return nva_start_addr;
+}
+
 /*
  * Returns a start address of the newly allocated area, if success.
  * Otherwise a vend is returned that indicates failure.
@@ -1493,7 +1519,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	bool adjust_search_size = true;
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
-	int ret;
 
 	/*
 	 * Do not adjust when:
@@ -1511,18 +1536,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 	if (unlikely(!va))
 		return vend;
 
-	if (va->va_start > vstart)
-		nva_start_addr = ALIGN(va->va_start, align);
-	else
-		nva_start_addr = ALIGN(vstart, align);
-
-	/* Check the "vend" restriction. */
-	if (nva_start_addr + size > vend)
-		return vend;
-
-	/* Update the free vmap_area. */
-	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
-	if (WARN_ON_ONCE(ret))
+	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
+	if (nva_start_addr == vend)
 		return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
-- 
2.30.2

