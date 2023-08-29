Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4D78C008
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjH2IMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjH2ILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B40CBF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so60894141fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296710; x=1693901510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ79dcWK5DB43dAqCTqh1rVk+BckiUBvnWUU5cp8hRQ=;
        b=cJ578Rd8+pWkOxRraeWNzQ5Bjr4Xs8q21UHKNjn+pX9Pg9G1/d9RORSdyDavIEvqBu
         nZqw56Z/5bnZI+y6Pn8izwNVYNvZcPwy3SBuXJ0bmP150S3WqUUP2lvho86gZrTawaVa
         HN7hgQO88ZBN0j9YGepuZcSNMNKPJwd71vjjuyYtZgzfhFuO+xQAKqY/x0VT3pyjkI7i
         s33hleKJsNJYWtMKjIls/pp0qevocX7mEFRTjGXttgA1o21oQIAaRkMgOxo/Driz4GKG
         btE1nDRRXR/pCI90OWPdmQrGAGRn61cqJakmfIk3Jii9kpF3lXw5NDcqS79oKHhKU9MQ
         qvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296710; x=1693901510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ79dcWK5DB43dAqCTqh1rVk+BckiUBvnWUU5cp8hRQ=;
        b=B+lXiEiQFQU3weU1gnzrq9YvzsHSCd8HPL54g+P1HszCMx+zKF756Tcic4gXVv+c4i
         wxi2khm0RuZkP9M5jFpw3ve/TPreL7ZoyZY6DtEIPXNnil+GtzehXleeUfl2azq+ZhzV
         9t/UfuK7+k1C6qQmxWraHRfwAFKAPgEAi66KOvyW+2ySGaxDSE1DYC+zpGlcxe1FUGBQ
         kL8h8nya5X39u4xjdQURScEIFgUMZScfqbtTOmyvVERoB1k/443cLBQg5gs/E7p7t2yU
         NE0qSDjH30Ky6TfkGKFuEXB4q0cPXAraETJ0furos2Rr3vorfGZxoGGkUZs8AcZ6BgUf
         Ns1Q==
X-Gm-Message-State: AOJu0YynOhxPr0a7eaiWZQQYhr+zyBsIk2OHXxI1i5A5yTCoPRrwvWiw
        2r9vueR5kx7DghZkMPu/vA4=
X-Google-Smtp-Source: AGHT+IGSANIaQ9YHIJaAEyDEmOUUzLYSIRZPqXEseP+0YpzgIn6wX5G+06cGZdVVQpKzh93qND74Rg==
X-Received: by 2002:a05:6512:329c:b0:500:9de4:5968 with SMTP id p28-20020a056512329c00b005009de45968mr11140507lfe.59.1693296710194;
        Tue, 29 Aug 2023 01:11:50 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:49 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 8/9] mm: vmalloc: Support multiple nodes in vmallocinfo
Date:   Tue, 29 Aug 2023 10:11:41 +0200
Message-Id: <20230829081142.3619-9-urezki@gmail.com>
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

Allocated areas are spread among nodes, it implies that
the scanning has to be performed individually of each node
in order to dump all existing VAs.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 120 ++++++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 73 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 968144c16237..9cce012aecdb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4636,30 +4636,6 @@ bool vmalloc_dump_obj(void *object)
 #endif
 
 #ifdef CONFIG_PROC_FS
-static void *s_start(struct seq_file *m, loff_t *pos)
-{
-	struct vmap_node *vn = addr_to_node(0);
-
-	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vn->busy.lock);
-
-	return seq_list_start(&vn->busy.head, *pos);
-}
-
-static void *s_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	struct vmap_node *vn = addr_to_node(0);
-	return seq_list_next(p, &vn->busy.head, pos);
-}
-
-static void s_stop(struct seq_file *m, void *p)
-{
-	struct vmap_node *vn = addr_to_node(0);
-
-	spin_unlock(&vn->busy.lock);
-	mutex_unlock(&vmap_purge_lock);
-}
-
 static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 {
 	if (IS_ENABLED(CONFIG_NUMA)) {
@@ -4703,84 +4679,82 @@ static void show_purge_info(struct seq_file *m)
 	}
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int vmalloc_info_show(struct seq_file *m, void *p)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *v;
+	int i;
 
-	vn = addr_to_node(0);
-	va = list_entry(p, struct vmap_area, list);
+	for (i = 0; i < nr_nodes; i++) {
+		vn = &nodes[i];
 
-	if (!va->vm) {
-		if (va->flags & VMAP_RAM)
-			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
-				(void *)va->va_start, (void *)va->va_end,
-				va->va_end - va->va_start);
+		spin_lock(&vn->busy.lock);
+		list_for_each_entry(va, &vn->busy.head, list) {
+			if (!va->vm) {
+				if (va->flags & VMAP_RAM)
+					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
+						(void *)va->va_start, (void *)va->va_end,
+						va->va_end - va->va_start);
 
-		goto final;
-	}
+				continue;
+			}
 
-	v = va->vm;
+			v = va->vm;
 
-	seq_printf(m, "0x%pK-0x%pK %7ld",
-		v->addr, v->addr + v->size, v->size);
+			seq_printf(m, "0x%pK-0x%pK %7ld",
+				v->addr, v->addr + v->size, v->size);
 
-	if (v->caller)
-		seq_printf(m, " %pS", v->caller);
+			if (v->caller)
+				seq_printf(m, " %pS", v->caller);
 
-	if (v->nr_pages)
-		seq_printf(m, " pages=%d", v->nr_pages);
+			if (v->nr_pages)
+				seq_printf(m, " pages=%d", v->nr_pages);
 
-	if (v->phys_addr)
-		seq_printf(m, " phys=%pa", &v->phys_addr);
+			if (v->phys_addr)
+				seq_printf(m, " phys=%pa", &v->phys_addr);
 
-	if (v->flags & VM_IOREMAP)
-		seq_puts(m, " ioremap");
+			if (v->flags & VM_IOREMAP)
+				seq_puts(m, " ioremap");
 
-	if (v->flags & VM_ALLOC)
-		seq_puts(m, " vmalloc");
+			if (v->flags & VM_ALLOC)
+				seq_puts(m, " vmalloc");
 
-	if (v->flags & VM_MAP)
-		seq_puts(m, " vmap");
+			if (v->flags & VM_MAP)
+				seq_puts(m, " vmap");
 
-	if (v->flags & VM_USERMAP)
-		seq_puts(m, " user");
+			if (v->flags & VM_USERMAP)
+				seq_puts(m, " user");
 
-	if (v->flags & VM_DMA_COHERENT)
-		seq_puts(m, " dma-coherent");
+			if (v->flags & VM_DMA_COHERENT)
+				seq_puts(m, " dma-coherent");
 
-	if (is_vmalloc_addr(v->pages))
-		seq_puts(m, " vpages");
+			if (is_vmalloc_addr(v->pages))
+				seq_puts(m, " vpages");
 
-	show_numa_info(m, v);
-	seq_putc(m, '\n');
+			show_numa_info(m, v);
+			seq_putc(m, '\n');
+		}
+		spin_unlock(&vn->busy.lock);
+	}
 
 	/*
 	 * As a final step, dump "unpurged" areas.
 	 */
-final:
-	if (list_is_last(&va->list, &vn->busy.head))
-		show_purge_info(m);
-
+	show_purge_info(m);
 	return 0;
 }
 
-static const struct seq_operations vmalloc_op = {
-	.start = s_start,
-	.next = s_next,
-	.stop = s_stop,
-	.show = s_show,
-};
-
 static int __init proc_vmalloc_init(void)
 {
+	void *priv_data = NULL;
+
 	if (IS_ENABLED(CONFIG_NUMA))
-		proc_create_seq_private("vmallocinfo", 0400, NULL,
-				&vmalloc_op,
-				nr_node_ids * sizeof(unsigned int), NULL);
-	else
-		proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
+		priv_data = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
+
+	proc_create_single_data("vmallocinfo",
+		0400, NULL, vmalloc_info_show, priv_data);
+
 	return 0;
 }
 module_init(proc_vmalloc_init);
-- 
2.30.2

