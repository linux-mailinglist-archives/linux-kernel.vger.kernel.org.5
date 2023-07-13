Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00846751753
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjGMEVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjGMEVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521219BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668704a5b5bso331888b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222059; x=1691814059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uyb10W8xRjD9R6Hckb+QVobZc3eb265x7Mbz+pRkDU=;
        b=YRSuxrIH8XKdAW0kQO3SmDGmJ+pvEqfPMHAcG7+sFafS/d+jT6N/m/StdjuFthkODl
         J9x6h1BvoAUJ2/0Py77CgQKA0V45/7UT3CCDyVErHqZgssLwbka39ahmK//VnFw5/Orb
         u0FUM5IpQcO6CKHS4DkgDUp2nPGIBzpSrAY+ckKGMG4p38UniHiXjXuVMY+sZQxK+UZx
         vqyB7eU1ay5ZD3cGjO/STbrR2/GjTvwsX3rqjh6UdhYbBju5LjFgBHJsB+MbMl4166hd
         6hKN3Duy7Ko+5Jjf6CxkWYuosaPbu1WsOpO+6fO+x22OsbfGPNaUxGejvj3lD+1UlVTN
         +AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222059; x=1691814059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uyb10W8xRjD9R6Hckb+QVobZc3eb265x7Mbz+pRkDU=;
        b=jQX5baY9mn96GctUux8uD+5I4G2x3DbyW/FdtCsyKmXJPoxCfigyJADsIw9uqRAAcz
         52coL8yk19SuYpVbMCWbK2kkX7DwpdHd4oJKBzs8BR/RaPcb6u2Mk4Kywqdk4ape1RCZ
         lmWjLGhVWsStm2CQfMvmiVUQA12IGK88doJLa7RBhV2B/aZZirVHCyzceB/Psyb11p6n
         aqpTKMzcRtzqi1+aVwED9vnHDXfvCEghrCwmCq8/AOXP1Q8tB6Mx+q6/qA3NrIyFD3YF
         2tZdA9yn+z656TZugilPglsM+FIE4sWF0VtklV4zPiTncDkq/1QnRPPlkcgbG2m3p4fO
         n5GA==
X-Gm-Message-State: ABy/qLYXeNSXPkxr3vfHhOHVRt8giIAxB/kTNN0Zc+P0VorrUEisoYmJ
        dJJmYwTCbC9qL8EWgyR6jOc=
X-Google-Smtp-Source: APBJJlFngfTCIZX6kEzbBCWxzo+TpDlnPYvBK4wEL/QFsnQzudRdGVDSAK30ILKKi++2X8hEX7YykA==
X-Received: by 2002:a05:6a20:4291:b0:133:21c3:115e with SMTP id o17-20020a056a20429100b0013321c3115emr442265pzj.48.1689222059554;
        Wed, 12 Jul 2023 21:20:59 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:20:58 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 02/21] mm/zsmalloc: add utility functions for zsdesc
Date:   Thu, 13 Jul 2023 13:20:17 +0900
Message-ID: <20230713042037.980211-3-42.hyeyoo@gmail.com>
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

Introduce basic utility functions for zsdesc to avoid directly accessing
fields of struct page. More helpers will be defined later.

zsdesc_page() is defined with _Generic to preserve constness.
page_zsdesc() does not call compound_head() because zsdesc is always
a base page.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2204bea4f289..11c203e79c39 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -293,6 +293,39 @@ ZSDESC_MATCH(_refcount, _refcount);
 #undef ZSDESC_MATCH
 static_assert(sizeof(struct zsdesc) <= sizeof(struct page));
 
+#define zsdesc_page(zdesc) (_Generic((zdesc),				\
+		const struct zsdesc *:	(const struct page *)zdesc,	\
+		struct zsdesc *:	(struct page *)zdesc))
+
+static inline struct zsdesc *page_zsdesc(struct page *page)
+{
+	return (struct zsdesc *)page;
+}
+
+static inline unsigned long zsdesc_pfn(const struct zsdesc *zsdesc)
+{
+	return page_to_pfn(zsdesc_page(zsdesc));
+}
+
+static inline struct zsdesc *pfn_zsdesc(unsigned long pfn)
+{
+	return page_zsdesc(pfn_to_page(pfn));
+}
+
+static inline void zsdesc_get(struct zsdesc *zsdesc)
+{
+	struct folio *folio = (struct folio *)zsdesc;
+
+	folio_get(folio);
+}
+
+static inline void zsdesc_put(struct zsdesc *zsdesc)
+{
+	struct folio *folio = (struct folio *)zsdesc;
+
+	folio_put(folio);
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
-- 
2.41.0

