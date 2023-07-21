Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E675CAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGUO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGUO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:57:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C14134
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:57:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso16923045e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689951428; x=1690556228;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2neACeDJ1+U5hIJSVUczEa3DOnNyGY7zXGD+yxpeF8=;
        b=QzPiB2fuOh3QbLglcuzUYmvpmwOadloHNR7KNKK4YP99C1z0LBvNqNC4tejkfjEbwF
         iQ9wuiCxVxESyxtmOyPi4jyorV8tlAaH95aMiogz4/TGd0yYFwvf3dqKpPow5DgOQEE3
         xb4cXBZoaP1waE/hWOoJPs8VS30z7Kor+mIoP1OpwyZsN31Dc8xVYSUwRNCD6tU76LiB
         sbxezuv/I5ZEjFuanb8Ek+cconJ5Rj0IrnmJqV+XeZZBZ3SdvUgYcDQUKLRcavSzXB6v
         C528YcUr3YO+1axe9o+kY7r7HGVLsu7rNnkbZjlo9kmX4w+DAvIzWAswnTKbgGi3y4Q+
         mqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951428; x=1690556228;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2neACeDJ1+U5hIJSVUczEa3DOnNyGY7zXGD+yxpeF8=;
        b=Zm7EO8u0hUKYrVZYvXRt/+AovsnZdMuBNR8mRsW5DpJFMmxKXlRfGUMzl2/ge0swyJ
         SBhFPNJx+kvyI5O2mkghxL5VDCX+RcLjL4TM25qdrSxQTkoxhvTBNS7BsMEs6BdYPc24
         gtUrCcYNVpEiYs2c5U+ptBW8rJQTXsMfJ5C00eu4kGiLvE+rLLcp7v6DctM3v9IZgQxG
         F6CsHm0sTzGGxHlwx7qlphEQvrmyHc7la3VdQ7XcJDW87cGn60pwxRMPOQvHqlzs2pjP
         TyTfcvviZPAM+zT3nHEzWWWvsgY6zF23nbwhDJo4tuoy22qCdUe4R+PiVYIur5n1v5Cm
         Pl9Q==
X-Gm-Message-State: ABy/qLZhVZsomnJzmKnZ+/vI5YOfDhacrNoJx1nmOuhvOGHkHnIUNxwH
        nSjYeyE6TD1pGHLDaIvSRJpOHw==
X-Google-Smtp-Source: APBJJlGq/aGXjkznIOcKk++s4dtisq1UBY7w99M0yyYBzEt+liwyMDx2zN7betLEG6qstAAeZxjK1A==
X-Received: by 2002:a1c:7903:0:b0:3fb:ab7d:ad95 with SMTP id l3-20020a1c7903000000b003fbab7dad95mr1608352wme.4.1689951428639;
        Fri, 21 Jul 2023 07:57:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbe791a0e8sm3469484wme.0.2023.07.21.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:57:06 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:57:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lib/string_helpers: Use passed in GFP_ flags
Message-ID: <df051844-0a73-4cf9-9719-a6001f1c9d5c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't affect runtime because all the callers pass GFP_KERNEL
as the allocation flags.  However, it should use the passed in "gfp" as
the allocation flags.

Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index d3b1dd718daf..be517c25737d 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -668,7 +668,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
 	char *buffer, *quoted;
 	int i, res;
 
-	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, gfp);
 	if (!buffer)
 		return NULL;
 
@@ -704,7 +704,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
 		return kstrdup("<unknown>", gfp);
 
 	/* We add 11 spaces for ' (deleted)' to be appended */
-	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
+	temp = kmalloc(PATH_MAX + 11, gfp);
 	if (!temp)
 		return kstrdup("<no_memory>", gfp);
 
-- 
2.39.2

