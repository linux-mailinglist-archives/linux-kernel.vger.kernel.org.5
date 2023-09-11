Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C479B4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354748AbjIKVzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjIKJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353EAEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0efe0c4acso7048175ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694424364; x=1695029164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVUG22g942iaUGLhRJT9/n3ewjgJXrVN0CQoxG9CnOE=;
        b=JvdmkboILXIiLr520zovaXU3qjKBueqOBmWWskSQZ+sYuXoDSb1xjY1SYRyU/0Ms17
         CK5u6JiEAqLYhFGX4tV1En5ZFgpjl7zZSqebj3ltSjS5M/qTA6YaIC0/6E6TbPZWuczs
         fsnoyYZ4g+2ZjOAMkagyq3G6gKrC/vS1v/h8Hjk9Lsl0X8yJmvhxv104err3KJvpq/0d
         QKYV0oJPz0m8fW4dJLB3tWfRh/dJWcVXqXV5CZ0aCzEvMSQHHvDieYjxLBeSS2IhV3Le
         1LKtSj9yCexSZffHXRDPxhob+rcqz1/yjfZYcOXUcGgGYYxNm8+HTMKBHdqL5NRi08/x
         vD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424364; x=1695029164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVUG22g942iaUGLhRJT9/n3ewjgJXrVN0CQoxG9CnOE=;
        b=rXxphc1NeQxKBp9N23++vgfqSl/89rISMpThrqpaUAOTX4QXLL3LMh+m3bSsD//Dov
         3baRwj4ILlfNDMPIAUpRcFNRIhXX4Dx6J5GEUwgKxLolMJn+Cf3M69K7DdeAQtsV3EVt
         mcJKMs2B8+X5gkTPcUU3H5qjMmldZEY/Rs6h3383qs6XHrtDTFHqFAwcKLAwGGWdmSkp
         5xmW7EEWfyQ7LFsYmmNikQCmquxPaUjzvkBp0TPzidpbx9wlnWiRXpJJbG2yLjEKIdcl
         RtP0PHe/oK89sw/YqWKIhUIi7t0UEGXK51aGha3gV2l8NQFqBPI1zMGZLneDD1bPvE7C
         Ig0g==
X-Gm-Message-State: AOJu0YyyxwoznUkNqByjwaQEXxXdanY+Z6HT1jAlX5y5Zko//rRFS1SI
        kl5omCdsRscGTAVBt9LoUCYIyQ==
X-Google-Smtp-Source: AGHT+IHQSEcQxQoGnVdTYUbsGDGOAGAYnAIRXR25DjqxYRB9VkIgyzJPkhDpA3YnQ1A5pX3r19YoNA==
X-Received: by 2002:a17:902:e750:b0:1c1:fbec:bc3f with SMTP id p16-20020a170902e75000b001c1fbecbc3fmr11475221plf.5.1694424364727;
        Mon, 11 Sep 2023 02:26:04 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001b89466a5f4sm5964623pll.105.2023.09.11.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:26:04 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/4] mm: move some shrinker-related function declarations to mm/internal.h
Date:   Mon, 11 Sep 2023 17:25:14 +0800
Message-Id: <20230911092517.64141-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
References: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions are only used inside the mm subsystem, so it's
better to move their declarations to the mm/internal.h file.

1. shrinker_debugfs_add()
2. shrinker_debugfs_detach()
3. shrinker_debugfs_remove()

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/shrinker.h | 19 -------------------
 mm/internal.h            | 26 ++++++++++++++++++++++++++
 mm/shrinker_debug.c      |  2 ++
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..8dc15aa37410 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -106,28 +106,9 @@ extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
 
 #ifdef CONFIG_SHRINKER_DEBUG
-extern int shrinker_debugfs_add(struct shrinker *shrinker);
-extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-					      int *debugfs_id);
-extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-				    int debugfs_id);
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
-static inline int shrinker_debugfs_add(struct shrinker *shrinker)
-{
-	return 0;
-}
-static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
-						     int *debugfs_id)
-{
-	*debugfs_id = -1;
-	return NULL;
-}
-static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
-					   int debugfs_id)
-{
-}
 static inline __printf(2, 3)
 int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..939d1227a527 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1154,4 +1154,30 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/* shrinker related functions */
+
+#ifdef CONFIG_SHRINKER_DEBUG
+extern int shrinker_debugfs_add(struct shrinker *shrinker);
+extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+					      int *debugfs_id);
+extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+				    int debugfs_id);
+#else /* CONFIG_SHRINKER_DEBUG */
+static inline int shrinker_debugfs_add(struct shrinker *shrinker)
+{
+	return 0;
+}
+static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
+						     int *debugfs_id)
+{
+	*debugfs_id = -1;
+	return NULL;
+}
+static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
+					   int debugfs_id)
+{
+}
+#endif /* CONFIG_SHRINKER_DEBUG */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3ab53fad8876..ee0cddb4530f 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -6,6 +6,8 @@
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
 
+#include "internal.h"
+
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
-- 
2.30.2

