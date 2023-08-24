Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2578666B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbjHXDxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjHXDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:52:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60DC1BFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a84c94f8ebso490852b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848992; x=1693453792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6aUUwbyOkHscZNyA7A7465dhx8LWjbNO2ZyHEt0HP8=;
        b=RZIGD3XIyyCZko58S15TEuM+V4uZ9q/nJiTp+ASHyEqDdnHKI2VFdiaK1aK7MoBgqf
         wdxtyAAvH4GiFgfBTLw1NPiwv/vkKcXTVcQTbLW54mHyckLvZuEctVxqt8DDdrPpaslE
         Ol7Ntjo6pp6tJCg9DKAxClGqr/9qupnwU3ZjiWqQNPlUqASiZztTSjrB3UsJA1JbVEUv
         CXL0qdpDcTzF+QC8NW0RGvQLHkAS2pUVF65iSlUw78Ld72cAZJ/of4Q3IJraeFXBOiTB
         /Td9mKt9yiMQ3tJOlkOUGNssP0ntVYTqf9BGOz/QEowzwJow3yewwXQKQe65AdqCGZsY
         zwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848992; x=1693453792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6aUUwbyOkHscZNyA7A7465dhx8LWjbNO2ZyHEt0HP8=;
        b=Ck+4EreFl9XfrgdQWgoCfsqfLvLsIC4KAsrlymnFs1JdpuJcOzV12A1kHAImXC4hRY
         DMSy1E7D/FjV3wGd0+Ud4w9O/wcCIz6qi8UVrYRcp+5zNOrCUcAgxPLpwY5tuYFKnxcp
         Z3GqEBAdnUfojGa2RsDdFnh+MxL9XQJRYK+uNMMyVT562B0GWVk28gJbGSqAkvzmL/s2
         FpBtHVyMVY7OAbvfVgQIBBw3OFMEp8WyXqcqLtZ5u74FjH57eyW2lSXYAzgk/X8JXvW7
         4Y7mYX+sYpVw1rxNXgP/9fUH7ZGPXlFqlvWB+DsK2yHsVXxHlHZD3JHzqdP5xBSQpsWa
         7ecA==
X-Gm-Message-State: AOJu0YxrKIrHAV3EDkzG9l77JxeJ9CvV9h830dd7rcsnNYChBp/AYkoC
        NQyJnnJB/OSofpOf1RdojSmV8Q==
X-Google-Smtp-Source: AGHT+IHd58HOT5xsJFcKqSa59ChLI854M/dKR1Ww2SFEZwh4duvj6hOPZTfKws4370umVNWgT0imeQ==
X-Received: by 2002:a05:6808:21a0:b0:3a3:37dd:e052 with SMTP id be32-20020a05680821a000b003a337dde052mr16581058oib.5.1692848992336;
        Wed, 23 Aug 2023 20:49:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:49:51 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 41/45] mm: shrinker: rename {prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}()
Date:   Thu, 24 Aug 2023 11:43:00 +0800
Message-Id: <20230824034304.37411-42-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new shrinker APIs, there is no action such as prealloc, so rename
{prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}(),
which corresponds to the idr_{alloc|remove}() inside the function.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index 8fb94cda86ef..578599c9e12e 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -209,7 +209,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 static DEFINE_IDR(shrinker_idr);
 
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
@@ -235,7 +235,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	return ret;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 	int id = shrinker->id;
 
@@ -297,12 +297,12 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	up_read(&shrinker_rwsem);
 }
 #else
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+static int shrinker_memcg_alloc(struct shrinker *shrinker)
 {
 	return -ENOSYS;
 }
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
+static void shrinker_memcg_remove(struct shrinker *shrinker)
 {
 }
 
@@ -627,7 +627,7 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...)
 	shrinker->flags = flags | SHRINKER_ALLOCATED;
 
 	if (flags & SHRINKER_MEMCG_AWARE) {
-		err = prealloc_memcg_shrinker(shrinker);
+		err = shrinker_memcg_alloc(shrinker);
 		if (err == -ENOSYS)
 			shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
 		else if (err == 0)
@@ -695,7 +695,7 @@ void shrinker_free(struct shrinker *shrinker)
 	}
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		shrinker_memcg_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
 	if (debugfs_entry)
-- 
2.30.2

