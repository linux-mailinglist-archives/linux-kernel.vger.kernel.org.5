Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7F377DC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbjHPIik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbjHPIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:37:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86E30F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:36:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68844c0af5dso553843b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692174962; x=1692779762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v13l7IPlOPgFsnMxGKXfyNRR5BVZeBzBNEaAsOIHoYU=;
        b=Cya0FxlqQyLZEroXNZk/xmAruZD4t2yH2du/O66Ed0VRPZDEOyZPRffBcEvP7HuEOA
         LBh84tW86g14ySan22a5QNsb0cry8ZMRVhKdpQ7IwM6x6CXd+aHB1uLMFM7LKnBIEidW
         MxKYco8X9KuAaEu/tQZmOH7YKbH1kkg+D4smGVZHtQo4/2ttPh2MOdtMrmR6FWZ71O5C
         hxTJnXYDLk9lIPZ5IpP3Xo1WYZhQHzfJJDwDlHN+js+BDpEOp9bf7emx7MSjJ4NzGyId
         DfLKmdnvHJtnO3OOV1eURaCwflNGnEsTjNw1DynpEsLeKdmNr/5gemJjZDlP6LR1sQGo
         VwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692174962; x=1692779762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v13l7IPlOPgFsnMxGKXfyNRR5BVZeBzBNEaAsOIHoYU=;
        b=JAbTGDPE5w8tL+z/MG907/U52ojpTQ/NO6qF+fTW5Y75wjhSL5upzKKOydfhQHSrnG
         AatVGqafkzLhzBY8lVM3MKeqXmn3/6UrgniHcGIh5hajqomwW0q2Y4hSmW/aChwnh1gR
         BSOl+QlQ05b0rB9njKgdS7zb51HLuw4k9bsZ16OHLE8n/MLHSpLCJEFK2iJ8qa20bY+Q
         ND5vwUUWT95W7mgGqeukksilroaFhkpa9NOMeUrdj9Pgo6BAf+UCFaoCuqoB8xKJ0hW2
         K6dzEqopXvZmvze/agN95nFOSbAJsR2Idptjz4utuksLAUZAgHAiYxl1NoO51ftcgoiE
         onUA==
X-Gm-Message-State: AOJu0Yzvym1aJU4xyuAsqhYJLtjX8YwvtfNcJj9KJK3/kNUO5SmTrAK6
        3OLPJ5Q+L1yz7g6sXjW3CyEI6A==
X-Google-Smtp-Source: AGHT+IE+pqjEsxtDBKCnfOYW5hSpBYIW97yeRg+vb7eGqw4ZPe5gd676obnQEAvZzfvbXIOzGXycpA==
X-Received: by 2002:a05:6a20:4281:b0:145:3bd9:1377 with SMTP id o1-20020a056a20428100b001453bd91377mr2045479pzj.5.1692174962033;
        Wed, 16 Aug 2023 01:36:02 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p16-20020a639510000000b005658d3a46d7sm7506333pgd.84.2023.08.16.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:36:01 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, joel@joelfernandes.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/5] mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
Date:   Wed, 16 Aug 2023 16:34:17 +0800
Message-Id: <20230816083419.41088-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230816083419.41088-1-zhengqi.arch@bytedance.com>
References: <20230816083419.41088-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_remove_recursive() will wait for debugfs_file_put() to return,
so the shrinker will not be freed when doing debugfs operations (such as
shrinker_debugfs_count_show() and shrinker_debugfs_scan_write()), so there
is no need to hold shrinker_rwsem during debugfs operations.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/shrinker_debug.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 3ab53fad8876..61702bdc1af4 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -49,17 +49,12 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	struct mem_cgroup *memcg;
 	unsigned long total;
 	bool memcg_aware;
-	int ret, nid;
+	int ret = 0, nid;
 
 	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
 	if (!count_per_node)
 		return -ENOMEM;
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		kfree(count_per_node);
-		return ret;
-	}
 	rcu_read_lock();
 
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
@@ -92,7 +87,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
 
 	kfree(count_per_node);
 	return ret;
@@ -117,7 +111,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	struct mem_cgroup *memcg = NULL;
 	int nid;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -146,12 +139,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	ret = down_read_killable(&shrinker_rwsem);
-	if (ret) {
-		mem_cgroup_put(memcg);
-		return ret;
-	}
-
 	sc.nid = nid;
 	sc.memcg = memcg;
 	sc.nr_to_scan = nr_to_scan;
@@ -159,7 +146,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.30.2

