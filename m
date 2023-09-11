Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47579B079
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376864AbjIKWUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjIKJ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6133CA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3c4eafe95so432655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694424383; x=1695029183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7bwmZAFhPRfqsSPFwB3IV8LJcvLn4gI9V7ELWjZ+Dw=;
        b=dSjSSDIGszy2Ip6p2OLeUev/dZL97ggpE7AdRgmIknjUrlYvDguCRnWBh+Qm0LuVwe
         7dQHvXGy24bCl69cgBKthxcFDkDq0vMbYcUgZ4FxlesFvaTrg9p7xTxHpaf/acjm/scl
         CHBIdJRFpUpgQcXi5rmS75V2e1+UVXNlck7F1sE2tIPz8YM47GXTQdOblGN0//YgCO7R
         /f+j0sDes/QnZkeQ5qaa42yb++O/9a4Mr5gcXV1zpnq+6yn+sCz1I1VFAOkznnHXy201
         QJsxT6ap6wqabWGxWskVTJfp5QPG26RCTC5kgdUXWGx3i/eWLzt9+IcpxRy98+jHdghi
         xUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424383; x=1695029183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7bwmZAFhPRfqsSPFwB3IV8LJcvLn4gI9V7ELWjZ+Dw=;
        b=wfmaVYhW8pNcHlaGPfAtI8SdmymPhElUUIMGxrjDVXzqrq0r24TlbIq7ekE3ReD7LD
         AIEZbUTl2ASa/+BGIMt6L+oxYFszc+/4BrdoWEAgZTh0lqtbLV5Bs/3Ka4p465wvG4LV
         44jI66J6plfL72ndtkd4mjjOCVTqnm7eMo0XjcNR0Mj06IeHgKHzc1q6DkzFqN2DmsLu
         im4rFe56n8tJyVRG2/xQpSfXtd7jmK872Y+tkdATLUL0bEZxf0NtmeTCCSXxzM6D0WFy
         4xvFCplI/8rucEBfCE/lDpDv/YjX28wD08Cw5OOMs5jqK6EbE0gjuLKFprQ2ZWPfFngk
         Yh8A==
X-Gm-Message-State: AOJu0YxQGj8NBTI3aMx9OnXZN2VWVnxpRu9iRR5644Hb310+OH4pzqux
        ra7K6oGdGFQ+xuhPi8RQm+CaNw==
X-Google-Smtp-Source: AGHT+IGuwOOmOTYHUBi51KVf+G2IH+LqVvZcIpa/lkU6FOZxO8pwy9QvfijhxoNvFM1VAXL8ZDsGDA==
X-Received: by 2002:a17:902:e546:b0:1bb:9e6e:a9f3 with SMTP id n6-20020a170902e54600b001bb9e6ea9f3mr10956272plf.4.1694424383369;
        Mon, 11 Sep 2023 02:26:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001b89466a5f4sm5964623pll.105.2023.09.11.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:26:23 -0700 (PDT)
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
Subject: [PATCH v4 3/4] mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
Date:   Mon, 11 Sep 2023 17:25:16 +0800
Message-Id: <20230911092517.64141-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
References: <20230911092517.64141-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index ee0cddb4530f..e4ce509f619e 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -51,17 +51,12 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
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
@@ -94,7 +89,6 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	rcu_read_unlock();
-	up_read(&shrinker_rwsem);
 
 	kfree(count_per_node);
 	return ret;
@@ -119,7 +113,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	struct mem_cgroup *memcg = NULL;
 	int nid;
 	char kbuf[72];
-	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -148,12 +141,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
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
@@ -161,7 +148,6 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	up_read(&shrinker_rwsem);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.30.2

