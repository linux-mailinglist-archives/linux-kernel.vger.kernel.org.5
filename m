Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDB75175A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjGMEV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjGMEV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC914270F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a04e5baffcso281647b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222077; x=1691814077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4zzHPL0k6H0MdOKWy9H+XqQmDxwRKjupee59FsBT9w=;
        b=LBEyRpU8G6PNHITLYWQWY9IyEPJyBkyQ5+FvSpkPn/XDu4Dao59DBpPH/zWMmJUshw
         lq0kdCLAyTLvXPRb/y+83fvqbRcDI/W+LuQaPuNH3C+pY8AU4jRsRBWwzik8OP0E5MYJ
         PLiAqFM/MrZKLDfuQYnYD93VG+rfaatGql8SPpIviN7wELQguFKteyX1AeorHVMmxNPn
         Dez/e+bAAstVLLoChOoqn9Uzy/cGstHq6rZ1lRNBHeKGx45FkUpllKlYAJDdihR1tDxk
         aA2G7wm5jd0vkB34MMv+IA+CCV9qlxehsMStgJw+N7ZnVOnzXTdoq5hxDAEmnVkUZ8Pj
         TUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222077; x=1691814077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4zzHPL0k6H0MdOKWy9H+XqQmDxwRKjupee59FsBT9w=;
        b=acAnTfycF/NEKusufq/KfqC6ZQfluAr0IXcKttuukiDjU5+0V49nSZfRVsVCiSTWcq
         zmkt23YUnd2BWXU6sPfFkKPGrDHUA48cv8FDMEY0ZsK9IORRHvnfVA8F4RIqVfEAUVHE
         o+CpQsqPULY+ssB/gNz4EAsav4fU14bfj+hHNRr21F24DJCe0x4RovzzwIbDJ8oCTLhT
         rZRQHPOv4v2hC1THlb4ztjPR5Ue/N1udpCWaizUk7U47V1e6gesFsvY57CuhJkTWyzWZ
         fvyG3ki/CVo+mtFQjis5/TOuyMd4bvCLGizOxMWs0+qFgv1A0DjhK1cWEnDfS+eGFtD/
         9AfQ==
X-Gm-Message-State: ABy/qLaRLGSyRO7a+2CQ66JYqKxKnMMzNnONbMIoj2xZtUiS0W/0wIL+
        zzebKKFCpC2e+2G3DRC9LFaCU+BtouzhG+5cji1YZA==
X-Google-Smtp-Source: APBJJlFywht9zcExknT1dtSzacVpV7iePijCw8nKXr7IhX52uQwv585dT1T9ycEkrhz/WrX75xHfuw==
X-Received: by 2002:a05:6808:573:b0:3a3:6536:dd89 with SMTP id j19-20020a056808057300b003a36536dd89mr525184oig.49.1689222076949;
        Wed, 12 Jul 2023 21:21:16 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:16 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 08/21] mm/zsmalloc: convert obj_malloc() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:23 +0900
Message-ID: <20230713042037.980211-9-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713042037.980211-1-42.hyeyoo@gmail.com>
References: <20230713042037.980211-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index be9762a49237..06227da86afc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1412,12 +1412,12 @@ EXPORT_SYMBOL_GPL(zs_huge_class_size);
 static unsigned long obj_malloc(struct zs_pool *pool,
 				struct zspage *zspage, unsigned long handle)
 {
-	int i, nr_page, offset;
+	int i, nr_zsdesc, offset;
 	unsigned long obj;
 	struct link_free *link;
 	struct size_class *class;
 
-	struct page *m_page;
+	struct zsdesc *m_zsdesc;
 	unsigned long m_offset;
 	void *vaddr;
 
@@ -1426,14 +1426,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	obj = get_freeobj(zspage);
 
 	offset = obj * class->size;
-	nr_page = offset >> PAGE_SHIFT;
+	nr_zsdesc = offset >> PAGE_SHIFT;
 	m_offset = offset_in_page(offset);
-	m_page = get_first_page(zspage);
+	m_zsdesc = get_first_zsdesc(zspage);
 
-	for (i = 0; i < nr_page; i++)
-		m_page = get_next_page(m_page);
+	for (i = 0; i < nr_zsdesc; i++)
+		m_zsdesc = get_next_zsdesc(m_zsdesc);
 
-	vaddr = kmap_atomic(m_page);
+	vaddr = zsdesc_kmap_atomic(m_zsdesc);
 	link = (struct link_free *)vaddr + m_offset / sizeof(*link);
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
 	if (likely(!ZsHugePage(zspage)))
@@ -1446,7 +1446,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
-	obj = location_to_obj(m_page, obj);
+	obj = location_to_obj(zsdesc_page(m_zsdesc), obj);
 
 	return obj;
 }
-- 
2.41.0

