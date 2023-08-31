Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035DE78F1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbjHaRSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345671AbjHaRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:18:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B20107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:33 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c64da0e46so40522239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693502312; x=1694107112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNen2wFqGs+WYv0jInGdV6FOrUFFJP4ofxSiG/zeNsQ=;
        b=hUK/2WJ6HUz5jMtQUNEG/YNVfDoRl6WnNNHu833Cff6e2iMbiNFipmQkCAmryNDcET
         IJgDZfFVhATCMOJAb322psreSf/nH3LhozVDKMdZq/GMpNsiLYMobe8UWG+RUu/y4Shw
         zqRC+4unircGcI/D3LuNZxud79ERlLvNtAB8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502312; x=1694107112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNen2wFqGs+WYv0jInGdV6FOrUFFJP4ofxSiG/zeNsQ=;
        b=cfvr+aO7PvU4zfvFOA+tmzPxQaQ5l7ZQSg0FEUmRikjl/omJGpfvuOmLzfogvcfBk4
         XloGg/lDABeBS3MGnvJM1rQpPL7S8bbIFRxDx9iCigP7XUYPPsVuZ65s86sVI/SOqjUs
         Z+QagOUFvTup1A8p2U7Jg4Xrfbr2M3b+EI65YLfRkIAYNCer1F4A5Hno5BB4xxTLAWls
         HG9SbWNwnrXNepExesMfCXJiWePBlBBos3VvvMMX3C/eRJmIOmUN2IdN/AlrWQOOXV6F
         P+hwH6pIxl/1W+4G7iihh0VZYGe32tCAKj9O9P0AJ8SjZ2gaEFM+0soUtm+s+B4eFv2O
         oDOw==
X-Gm-Message-State: AOJu0YytbXv4xkggPiShjtHaCnpuP0ZNnC6tEya/inKgCMgkbeQLtoK7
        3lbeib/7z1ZS1pQIP+PcVTOrROnWADHmOirCeQ4=
X-Google-Smtp-Source: AGHT+IH9nNzsM/Nlgp8Zi3Oo7b7WP2tj3Njcw0OCUdypAZrLXBRUvBA+50OCgoB1OKAFfZ42JKDmVA==
X-Received: by 2002:a5e:c203:0:b0:790:ab53:ed16 with SMTP id v3-20020a5ec203000000b00790ab53ed16mr6691054iop.21.1693502312260;
        Thu, 31 Aug 2023 10:18:32 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a16-20020a056638019000b0042af069eeefsm489720jaq.50.2023.08.31.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 10:18:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Thu, 31 Aug 2023 17:18:25 +0000
Message-ID: <20230831171827.2625016-1-joel@joelfernandes.org>
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

[apply test robot feedback on unused function fix.]

Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Apply review tags and test robot feedback.

 mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..f09e882ae3b8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+#ifdef CONFIG_PRINTK
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
+#endif
+
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
 	struct vmap_area *va;
@@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
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
+#ifdef CONFIG_PRINTK
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
+#endif
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
 	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
 
-	vm = find_vm_area(objp);
+	vm = try_to_find_vm_area(objp);
 	if (!vm)
 		return false;
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

