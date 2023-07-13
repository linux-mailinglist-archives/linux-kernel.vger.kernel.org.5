Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F883751767
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjGMEXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjGMEXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:23:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97A3581
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecb21f86so296704b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689222109; x=1691814109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtrw/YzOEDonF+rRVmBrlDfCDCMTeOToGRvD9RY+bgk=;
        b=DNDzJeH6+uO2QRQUtNKhlz1aZsrdHRQc3v19UspNEVteBUbKa34CxMu1dDwP8iKgHU
         8KF0nWm/6lmyuE7xNphIGmx+lEgQI/KoUbLErDlzkhdMtelyMl9ecW/RcTK1ebr6VO9h
         WLouJWDpvzbelCRzOX01QxQExmmdG+26259mTxI+kZ14UISGq5hYvhWEt10B4jTr9Y8S
         E6P23Iy6hI+jrHrFx0fKwUEJQj40SaSOGcqSGfe3z9n/47iE46lajWhiuXM0lGeG7iM2
         7WUKg2qQ+SjwVM/EDeGVwxsBI84kTuo9LnBmXX1lcyGbwIdXJ3ckrlw/RMp4VBjFps8m
         S7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689222109; x=1691814109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtrw/YzOEDonF+rRVmBrlDfCDCMTeOToGRvD9RY+bgk=;
        b=LX+At9Hguey0g+GW3niNd0PAv5DG5sV7yQ1z6fBWUH/izD1L87Cl38UXA9vMr5OQ8p
         OV/8aIeVm9XD3kndx/0R1YQ/aONvqDiWumIRQF9ojqXQNC689xpVNIdW28BOgANueHnf
         YBryPSneTZN86ptzCiUl0xKHRgpeXAmfoYj9S/31htJ29Jhs75lSLajQOqE4UJw0vQJB
         ExumhGohvx+8OL8fjGyMvincfw5PJi3poQ9L/hNGycL2J0aFAev+xc+4KBPdzuE4kClr
         x5MVsh1bgxHz7yChXZG7xpqwFsPhWM3F/nXWsA0dKsEC+LcTMkgb6yegT4drPfoBEVza
         bo6g==
X-Gm-Message-State: ABy/qLZRMvyQf0icpoVR8VFxWpbMdXrlifp+091SVpeTCaWmi5Yu6F3r
        +HeaGrcEd1ekg6c7Ao5o6dU=
X-Google-Smtp-Source: APBJJlEipD62xqeH0pCFWBwE+nqF39ivhCrGaqzTXzT0L0e7T5j9i8QrgvKnwAX+1UqrENQc5Txtlw==
X-Received: by 2002:a05:6a20:2585:b0:12f:aac7:6f83 with SMTP id k5-20020a056a20258500b0012faac76f83mr419599pzd.42.1689222108958;
        Wed, 12 Jul 2023 21:21:48 -0700 (PDT)
Received: from fedora.. ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm4346601pfm.138.2023.07.12.21.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:21:48 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH v2 19/21] mm/zsmalloc: convert SetZsPageMovable() to use zsdesc
Date:   Thu, 13 Jul 2023 13:20:34 +0900
Message-ID: <20230713042037.980211-20-42.hyeyoo@gmail.com>
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

Convert SetZsPageMovable() to use zsdesc.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zsmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6cb216b8564a..5f07e3d92a99 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2117,13 +2117,13 @@ static void init_deferred_free(struct zs_pool *pool)
 
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
 {
-	struct page *page = get_first_page(zspage);
+	struct zsdesc *zsdesc = get_first_zsdesc(zspage);
 
 	do {
-		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, &zsmalloc_mops);
-		unlock_page(page);
-	} while ((page = get_next_page(page)) != NULL);
+		WARN_ON(!trylock_zsdesc(zsdesc));
+		zsdesc_set_movable(zsdesc);
+		unlock_zsdesc(zsdesc);
+	} while ((zsdesc = get_next_zsdesc(zsdesc)) != NULL);
 }
 #else
 static inline void zs_flush_migration(struct zs_pool *pool) { }
-- 
2.41.0

