Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32400751756
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjGMEVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjGMEVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:21:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46632106
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so313494b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222068; x=1691814068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhaPI5HZCviIKmkdgH7KFJDdrqT6GNzpynmu4YA1d+4=;
        b=Jt6o06lRegWfpT6s7u556O96jLXuVWenL3j7rdCJMMEZJSxbKfdLZdvetPddoF/DHX
         PAMG0XVW/6owS3g4G4hGDuiYl5Weo+v61dNqznEhQrdjvfHaNR0Uz3Xhg37UAFAsNb7U
         ZH7JKwt8s7tvmf6jfRAoe5445IXGboDowduaXGoJduEmrtA/Gs04jyb+QhdGq2tCblsB
         VilcMo/Li/bBOTmGNGKEK+fobdvYvHTEEULz0+R5qEX5V9BHphgzBgL0oa3cqLS5uL+S
         wcdF4m7jBn35fTjxbHwyr18gTW56GA0WU5LMGze94rRKwRwLwPSLNaPW6F1EdVP1tc72
         Ad2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222068; x=1691814068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhaPI5HZCviIKmkdgH7KFJDdrqT6GNzpynmu4YA1d+4=;
        b=EdRqp5IhNbmBu+0LOJuxkSHZkcZsPBuqw7UQEMIuFq6oezHrILPtfbO0ximUw0j+D1
         qygkVLZs0pNa+D+6Ik34C35HV78YQCZmWSqGU/rrr8/Tq/5zshLrL1XthVNrkQ1Nex5f
         dYg1iIBj1IRfCYF/vYEMeLyl4t5hneiYfq5J6vBbto47n1TIFmaUP5rTTNVK7rudFBe4
         2UJRypW+rV+tcAG+s5+RgOx4q6cO+UphEqFOk+P6I+HxKHAzy1WXviMpgUxFzL14aii2
         /Zr7xTu07aVhbgIZCXx4mWTdP4denpKf5ig04rLJQc7kpIY2yvU5IplbUjhUCUfCz1C7
         8rpQ==
X-Gm-Message-State: ABy/qLZvpeForXm1tKnOqDIbwfACnVj7R6IeVYwc2VOmVEaCUwYXdA9f
        R5qli9CU8JCddrNXk6bzB2Y=
X-Google-Smtp-Source: APBJJlEe7OIMuJtVjHfXHkehY78DJUMXlwp6taFHwT6PsouXRsh0IpuGtqw7vkbfdP9Ouwmze4dUZA==
X-Received: by 2002:a05:6a00:1692:b0:668:6445:8931 with SMTP id k18-20020a056a00169200b0066864458931mr807724pfc.29.1689222068309;
        Wed, 12 Jul 2023 21:21:08 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:07 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 05/21] mm/zsmalloc: convert {try,}lock_zspage() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:20 +0900
Message-ID: <20230713042037.980211-6-42.hyeyoo@gmail.com>
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

Introduce trylock_zsdesc(), unlock_zsdesc(), wait_on_zsdesc_locked()
and convert trylock_zspage() and lock_zspage() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 55 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f44a2d8a36b5..2cce76a19a1e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -326,6 +326,21 @@ static inline void zsdesc_put(struct zsdesc *zsdesc)
 	folio_put(folio);
 }
 
+static inline int trylock_zsdesc(struct zsdesc *zsdesc)
+{
+	return trylock_page(zsdesc_page(zsdesc));
+}
+
+static inline void unlock_zsdesc(struct zsdesc *zsdesc)
+{
+	unlock_page(zsdesc_page(zsdesc));
+}
+
+static inline void wait_on_zsdesc_locked(struct zsdesc *zsdesc)
+{
+	wait_on_page_locked(zsdesc_page(zsdesc));
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -911,11 +926,11 @@ static void reset_page(struct page *page)
 
 static int trylock_zspage(struct zspage *zspage)
 {
-	struct page *cursor, *fail;
+	struct zsdesc *cursor, *fail;
 
-	for (cursor = get_first_page(zspage); cursor != NULL; cursor =
-					get_next_page(cursor)) {
-		if (!trylock_page(cursor)) {
+	for (cursor = get_first_zsdesc(zspage); cursor != NULL; cursor =
+					get_next_zsdesc(cursor)) {
+		if (!trylock_zsdesc(cursor)) {
 			fail = cursor;
 			goto unlock;
 		}
@@ -923,9 +938,9 @@ static int trylock_zspage(struct zspage *zspage)
 
 	return 1;
 unlock:
-	for (cursor = get_first_page(zspage); cursor != fail; cursor =
-					get_next_page(cursor))
-		unlock_page(cursor);
+	for (cursor = get_first_zsdesc(zspage); cursor != fail; cursor =
+					get_next_zsdesc(cursor))
+		unlock_zsdesc(cursor);
 
 	return 0;
 }
@@ -1755,7 +1770,7 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
  */
 static void lock_zspage(struct zspage *zspage)
 {
-	struct page *curr_page, *page;
+	struct zsdesc *curr_zsdesc, *zsdesc;
 
 	/*
 	 * Pages we haven't locked yet can be migrated off the list while we're
@@ -1767,24 +1782,24 @@ static void lock_zspage(struct zspage *zspage)
 	 */
 	while (1) {
 		migrate_read_lock(zspage);
-		page = get_first_page(zspage);
-		if (trylock_page(page))
+		zsdesc = get_first_zsdesc(zspage);
+		if (trylock_zsdesc(zsdesc))
 			break;
-		get_page(page);
+		zsdesc_get(zsdesc);
 		migrate_read_unlock(zspage);
-		wait_on_page_locked(page);
-		put_page(page);
+		wait_on_zsdesc_locked(zsdesc);
+		zsdesc_put(zsdesc);
 	}
 
-	curr_page = page;
-	while ((page = get_next_page(curr_page))) {
-		if (trylock_page(page)) {
-			curr_page = page;
+	curr_zsdesc = zsdesc;
+	while ((zsdesc = get_next_zsdesc(curr_zsdesc))) {
+		if (trylock_zsdesc(zsdesc)) {
+			curr_zsdesc = zsdesc;
 		} else {
-			get_page(page);
+			zsdesc_get(zsdesc);
 			migrate_read_unlock(zspage);
-			wait_on_page_locked(page);
-			put_page(page);
+			wait_on_zsdesc_locked(zsdesc);
+			zsdesc_put(zsdesc);
 			migrate_read_lock(zspage);
 		}
 	}
-- 
2.41.0

