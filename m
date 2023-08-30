Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9578DF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjH3TIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbjH3LEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:04:11 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7ACC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34df399c316so3055675ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693393447; x=1693998247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bzb0sW6tNrIYQR91p9kftRZaZNiQ/iubHSIhY1eKkc=;
        b=GJUmWv0U7/GKw3RWPZoxUHg8aeUxd8sBp/DTJ2+rFdnsQZkPQz0ZFyZrSfK54qd2kO
         RZhkdtBAp9L2FI9cFqNhR/r2GwzxmVnNevg6fF2z79DXg0tPhRKCppiOygJEXQpVKC0R
         zicpPWZdgIUEA+CmYCxENeVQgtRsoUZMujIDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693393447; x=1693998247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Bzb0sW6tNrIYQR91p9kftRZaZNiQ/iubHSIhY1eKkc=;
        b=UglJx/WJNso+gOz69iP8yqE3A1BVIHIEjvu6qk0XXDdxPbOSDzjp+vWBwc4XbKdgMi
         8UyvwDtuYy/muUdy7LAMzuwUuc6qEevAnHdkq3ZHA9rwoH8oSgrZYfQcC3W6ST5U6zVH
         QFIs1VUs7W6iuF4EPcH4umoii4KxGRJaI+592nGnHR+6TGrWydNSeViHiAfdLWjH54J7
         HR8XLUTpkuMEXeuDklZxsfAuslo6DNvvwWJUBiyyemCp7pVKZUymVkS0MdY0v97yzW6C
         Wqmepppq2tJbabLyLuS21LjQv0Q/0XjDOkUsMNWLeasplDPDo4rpv5W1JIgAWLv+DPG0
         Zjbg==
X-Gm-Message-State: AOJu0Yw6VfQey/6lo5RTanR/BTvu7XJYBO0f3WupZ4DYWQluEEkmDcIo
        grt/NuS8PsPkbPh/pmhG3mwzVGIlKwbpssxsTxY=
X-Google-Smtp-Source: AGHT+IE0HDgO4IV5KIonhYC6qUiVBNTzmO3mraM6GsxI7117CCavMJf06wCisJIG3/9IfOckEZyYiA==
X-Received: by 2002:a05:6e02:f11:b0:346:7c6d:c667 with SMTP id x17-20020a056e020f1100b003467c6dc667mr1886994ilj.13.1693393447713;
        Wed, 30 Aug 2023 04:04:07 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id k8-20020a926f08000000b00348880831fdsm3701371ilc.58.2023.08.30.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:04:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Subject: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Wed, 30 Aug 2023 11:03:59 +0000
Message-ID: <20230830110402.386898-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unsafe to dump vmalloc area information when trying to do so from
some contexts. Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..dae347e446e6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1865,6 +1865,18 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
+{
+	struct vmap_area *va;
+
+	if (!spin_trylock(&vmap_area_lock))
+		return NULL;
+	va = __find_vmap_area(addr, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	return va;
+}
+
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
@@ -2671,6 +2683,27 @@ struct vm_struct *find_vm_area(const void *addr)
 	return va->vm;
 }
 
+/**
+ * try_to_find_vm_area - find a continuous kernel virtual area
+ * @addr:	  base address
+ *
+ * This function is the same as find_vm_area() except that it is
+ * safe to call if vmap_area_lock is already held and returns NULL
+ * if it is. See comments in find_vmap_area() for other details.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+static struct vm_struct *try_to_find_vm_area(const void *addr)
+{
+	struct vmap_area *va;
+
+	va = find_vmap_area_trylock((unsigned long)addr);
+	if (!va)
+		return NULL;
+
+	return va->vm;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -4277,7 +4310,7 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
-	vm = find_vm_area(objp);
+	vm = try_to_find_vm_area(objp);
 	if (!vm)
 		return false;
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

