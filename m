Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96151751765
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjGMEXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjGMEW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:22:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE726BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666edfc50deso161849b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222103; x=1691814103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqbwv8O+lxJHxid3fsI/4aDUJzUIFl2vk+EDGGzJMlE=;
        b=HhBiTuA3YRFVYYtX8/M0YJ6lb1HKlwUn3kN2x4yXQkPMRexnTuCNWiRQsxPM4Z3iot
         K/7cVMrpdqnXwqA69sfPQzAirtFx3g33cYzX2PZR8LeFPkVsNkqyf3a+CqglzU6PT7VN
         lzTikbIsFgelxLz6BdKj+2ew5u6NbqpOO3A8TU+aT+87uJAmc1FaYlwxI7hX4YIecnWB
         8MrcygZ1GUYj35Q/AdYZJYSlQ55TU5BtSv5zHrWoTbOL/rt43IIq8zzrExczRxc1Chwm
         VN3KzXoIEVrT5+2xolvk0RaRzKulzYpRW+TbtM4OQXgGLLRrFe2PG8vfUgcZH9O5BTyb
         UqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222103; x=1691814103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqbwv8O+lxJHxid3fsI/4aDUJzUIFl2vk+EDGGzJMlE=;
        b=GckVZf+7qWXMSjO8K/jrseY253bazieUZP4H7MTqHp3OvnP3ijgfvutR43nzhruzcP
         nQBPZyovH5pI/xz1+NMmX7GrcL7JYa9WGJKA5Op0+myIu8iuNfCfhEXu1dCnoSUMO/kc
         94i++/sSDZIoI0+oZ/kHyaS7E48THpx0hrFDROWiSXgqirFDD3AKkaxbTEQyssksTK4X
         KKbktRRtiQLqQyPG5bYsxPnecp30XpSpL2cpvKboJtY4p5ELUw44lJ7GlVCyvXtayNbq
         JLLt2BVAG2eJv2xGW6ohc8boCGguVQvff4MP4UUUDFHlIxl9edCWck3RSuw4sbSxYBDh
         i/UA==
X-Gm-Message-State: ABy/qLbCoPvZpk5jpMBXObmO6xs4JtYzISaLjDxHvkEzNQknLLJDr69Q
        LgTkne7mxYANGrUJJMwCURA=
X-Google-Smtp-Source: APBJJlGOrtV5hOsHEJUq5S+q2K6dI2JgqQtu82o3Vjh0U5YJbxX6e/q+RqfdVpeSjj/rqTPUsXDwYg==
X-Received: by 2002:a05:6a00:1582:b0:681:4274:eef0 with SMTP id u2-20020a056a00158200b006814274eef0mr1212636pfk.1.1689222103209;
        Wed, 12 Jul 2023 21:21:43 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:42 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 17/21] mm/zsmalloc: convert migrate_zspage() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:32 +0900
Message-ID: <20230713042037.980211-18-42.hyeyoo@gmail.com>
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
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index fd920b659b1d..db43a5d05233 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1746,14 +1746,14 @@ static void migrate_zspage(struct zs_pool *pool, struct zspage *src_zspage,
 	unsigned long used_obj, free_obj;
 	unsigned long handle;
 	int obj_idx = 0;
-	struct page *s_page = get_first_page(src_zspage);
+	struct zsdesc *s_zsdesc = get_first_zsdesc(src_zspage);
 	struct size_class *class = pool->size_class[src_zspage->class];
 
 	while (1) {
-		handle = find_alloced_obj(class, page_zsdesc(s_page), &obj_idx);
+		handle = find_alloced_obj(class, s_zsdesc, &obj_idx);
 		if (!handle) {
-			s_page = get_next_page(s_page);
-			if (!s_page)
+			s_zsdesc = get_next_zsdesc(s_zsdesc);
+			if (!s_zsdesc)
 				break;
 			obj_idx = 0;
 			continue;
-- 
2.41.0

