Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D075EB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGXGWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGXGWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:22:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA1B9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:22:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad356f03so19026855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690179730; x=1690784530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMxhq1yiZbeuYK1cuOPzx7JANSxn1juq0pUBihEL+Wk=;
        b=KFYjcOVLyGA1d4rfaoLPdLB/e6IjDH5icirSxJhNketSHU37mMtGFferynYbZDdVDr
         SBHHg1RIVmDI1fNLSXGw64oy5igBfOWadAkh1lGrBGeXMBa1ulxQGdtmi8/J7UhGyGZ5
         PEqbCcd8mvm1vPkw4Rr/lF18ynZhCmEe2Nseic1Cu+mBDAkH1xnTwwZWgykAo+8kBVSo
         K+5y+jfTjdVUDLBZ1x9Lr90D1oTQILAGJl5dG+myCccy2uIl1c+6SRN9JGvOolhslNK4
         nVA38dojo5rsWjEmeGe9RFjEZoFNh+SK6kqQBoGX1ixHQeZl5xBToafr9ey+tHo56CfZ
         eOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179730; x=1690784530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMxhq1yiZbeuYK1cuOPzx7JANSxn1juq0pUBihEL+Wk=;
        b=j5SqbRjlAxMeiCzQ+Y32dumE5KXWgXn2q/+HnNjhs82K7Ca+H/PUb/lNhsLqlRyMB/
         /AFNIPNjwyC0BcGAxb3v6mMQcqQIfeyBaTsupOWo+ZNkBPtHH9RuXj5fmrJLEgXKXmF3
         d5ccTf0ZmhQ6q/XwLPym9JaJFApbkmvSQ4cVUAdyTzzKPWH5spU/3gcq2gfjrO2rBqVF
         2WIeMym4CYutJJrdQ1v8moJggkDHWPiAOl4Tq/Pw74Bpz2K5YvGgUCNEqBrI+qZ0vGQt
         Aku4SQO7ko/NQRIm01kKIaz9+YUAXKNX/S9IQExEYf7LOzX+MevFvHkkng8tYq5nCCUb
         L5BQ==
X-Gm-Message-State: ABy/qLYYWMaoEdRKUcoXXpDJZ/kYBrGHZQz0dS6BX6/QD7rNV+GwvslK
        XLc+oIs+JsKvBcLXlAZBQ6VIBQ==
X-Google-Smtp-Source: APBJJlHWsnLRWbTHoG+BCImPXA8ex14v4jkicKDRgJKk7Nt/usxhGPfBJt1FuUdKcnDc5doUpcUiAQ==
X-Received: by 2002:a17:902:e995:b0:1b6:ab53:c7a5 with SMTP id f21-20020a170902e99500b001b6ab53c7a5mr6059293plb.46.1690179730618;
        Sun, 23 Jul 2023 23:22:10 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001b7e63cfa19sm7983504plg.234.2023.07.23.23.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:22:09 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH v2 1/2] memcg: Add support for zram object charge
Date:   Mon, 24 Jul 2023 14:22:02 +0800
Message-Id: <20230724062202.2244188-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM(ZRAM) is currently charged to kernel, not
to any memory cgroup, which can escape their cgroup memory
containment if the memory of a task is limited by memcgroup.
it will swap out the memory to zram swap device when the memory
is insufficient. In that case, the memory hard limit will be
invalidated. So, it should makes sense to charge the
compressed RAM to the page's memory cgroup.

As we know, zram can be used in two ways, direct and
indirect, this patchset can charge memory in both cases.
Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..24bac877bc83 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1819,6 +1819,9 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+					size_t size);
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size);
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1880,6 +1883,15 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+					size_t size)
+{
+	return 0;
+}
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..118544acf895 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3059,6 +3059,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	}
 	return objcg;
 }
+EXPORT_SYMBOL(get_obj_cgroup_from_page);
 
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
@@ -3409,6 +3410,29 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, gfp_t gfp,
+							size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return 0;
+
+	/*
+	 * Indirect zram usage in PF_MEMALLOC, charging must succeed.
+	 * Direct zram usage, charging  may failed.
+	 */
+	return obj_cgroup_charge(objcg, gfp, size);
+}
+EXPORT_SYMBOL(obj_cgroup_charge_zram);
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	obj_cgroup_uncharge(objcg, size);
+}
+EXPORT_SYMBOL(obj_cgroup_uncharge_zram);
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
-- 
2.25.1

