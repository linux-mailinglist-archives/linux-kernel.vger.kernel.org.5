Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F751763
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjGMEWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjGMEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:22:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3041E2D56
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso161806b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222097; x=1691814097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEDSSIP+zt5V9XvZT+ict1746NWdOpkIhk/ClYlbKG8=;
        b=gDl0JF5e9zGpLRmEVQgEpzZ1YDB6JYSyOV9cQpeI18V9wzgjkAQF1WTsMsyU3VSoLf
         2e1cTn7O+bGR8vWOg52VMo87dUBAfJiYwc2XktidpZUMY8OfM7ngVE95TQkHX66SanQW
         dgpC/2e8PppNekV6zRbcREFOHsjqAgeaozdTGFKKnnpBYoeg5Fx0fhAYs2W/ui/9MoZh
         69aAO90DqMUuP75JGEeTXuZFg0xeVjbCPiw5v3qygq7ShgW2gTRi1GIszh84o4kPH8Qj
         0sUZz+95DRgGUeST8VzIXP7PSo/0vTH8boyycYF9NPSM14W03PRBlwUQO6t6BMR04X3p
         PekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222097; x=1691814097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEDSSIP+zt5V9XvZT+ict1746NWdOpkIhk/ClYlbKG8=;
        b=UE0ls98ud8iRRjdzwnWX+wXKZr7uZT3imrbxWy/8n+OO+CDXAzi71kCzh4iw4LkDfn
         Bucmrvg+pU1kfJoogZfwYWiOWuA7E8hMa95iDr7TCxY3NnFb1yyazQTeyTT1gI0dkoxb
         SYP8kiNY8LX3yYsl/KwW40awoOtWc2hH5BTpQ3B7NbmiEnhqYYnYlEE7y8GEdUPAvtOU
         AITlLL0XWi2MzLG/9TwFdycXz3rk7zAnvQNV47Isx17El998FzryHyIG17KruAgMsAIn
         WczBJWZ4bshM7OP+PMIs1kFbrZuX5BHmHzWQ7EIPdzhfMll7lMMi0dPw7VdOXdff/1Fb
         SZ4A==
X-Gm-Message-State: ABy/qLYXpffd47fcZuNdrrnbbWmUCYi9Q4EhdfXwTVVzpIQZn5eTNuyL
        LKr0qHGgFZyUrvECMpzo58U=
X-Google-Smtp-Source: APBJJlFlwg2pA2K3WdR4ybI758//TlSODxXQDA/TxlawtEXWCY8PW6IRxuTtLqAcqkjZbNPwiFTClw==
X-Received: by 2002:a05:6a00:1a8d:b0:681:919f:bf69 with SMTP id e13-20020a056a001a8d00b00681919fbf69mr1060619pfv.0.1689222097302;
        Wed, 12 Jul 2023 21:21:37 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:36 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 15/21] mm/zsmalloc: convert __free_zspage() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:30 +0900
Message-ID: <20230713042037.980211-16-42.hyeyoo@gmail.com>
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

Introduce zsdesc_is_locked() and convert __free_zspage() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9e4ced14e1eb..69bd497de35e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -336,6 +336,11 @@ static inline void unlock_zsdesc(struct zsdesc *zsdesc)
 	unlock_page(zsdesc_page(zsdesc));
 }
 
+static inline bool zsdesc_is_locked(struct zsdesc *zsdesc)
+{
+	return PageLocked(zsdesc_page(zsdesc));
+}
+
 static inline void wait_on_zsdesc_locked(struct zsdesc *zsdesc)
 {
 	wait_on_page_locked(zsdesc_page(zsdesc));
@@ -1007,7 +1012,7 @@ static int trylock_zspage(struct zspage *zspage)
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
-	struct page *page, *next;
+	struct zsdesc *zsdesc, *next;
 	int fg;
 	unsigned int class_idx;
 
@@ -1018,16 +1023,16 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
 
-	next = page = get_first_page(zspage);
+	next = zsdesc = get_first_zsdesc(zspage);
 	do {
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		next = get_next_page(page);
-		reset_zsdesc(page_zsdesc(page));
-		unlock_page(page);
-		dec_zone_page_state(page, NR_ZSPAGES);
-		put_page(page);
-		page = next;
-	} while (page != NULL);
+		VM_BUG_ON_PAGE(!zsdesc_is_locked(zsdesc), zsdesc_page(zsdesc));
+		next = get_next_zsdesc(zsdesc);
+		reset_zsdesc(zsdesc);
+		unlock_zsdesc(zsdesc);
+		zsdesc_dec_zone_page_state(zsdesc);
+		zsdesc_put(zsdesc);
+		zsdesc = next;
+	} while (zsdesc != NULL);
 
 	cache_free_zspage(pool, zspage);
 
-- 
2.41.0

