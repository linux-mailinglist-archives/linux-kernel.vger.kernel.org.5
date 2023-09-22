Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741577AAC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjIVI0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjIVIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:25:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2B8F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:25:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e1154756so27404817b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695371149; x=1695975949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIAAYaTevangAQtHpP5uU5ftp8AXloDBwmYe1UIN8vQ=;
        b=XBjbXg+OCwQRzWSTySzeE3xjrZNExAPDUkhbOvLO3oyemoMhg+n+/8OOQeFtp8zjtd
         NcZ3ngZPDetAfxubUT4T3c1GPJr8I0Nddh0dWkf80zfGvDegE2CnxRh+72pQ7AIvbs88
         8btKp3IZGxFzOC8uOHfXSeAcH08Mv3ky2Ebz6VMCS9sMET/7+w6IjMNQBJAIXcR/76fx
         fGh/11DdtjCr/tS+5l4GURiVu0p2Eavakt4072+jZlw8LUSZsH3rqq0e7n8Kb5YKscWh
         NOe8Ds6BFFjw1MAIB2W5695bokZTXu1o4tggtxZRq54TzLRr/IVijIsmKIVKamb6q+fH
         DdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371149; x=1695975949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIAAYaTevangAQtHpP5uU5ftp8AXloDBwmYe1UIN8vQ=;
        b=Iz9mEiI8mD0P0MV56qh927wz8Vkho8pAuPUQl0mrNuTbgJ4014il5XNNtfiL21pMTW
         NKO1beZqaigdkA4Ej9BLiIt+jFpmRalR7whQVA0jBgtI/BdH1cuonXXDMErBVNnWyrbV
         jgBvFryTAz5Mcpj7K+XJeCN+Rb+23AlN+T696RGn4bguHqSLqvF2Ot3yPZ2EM64olmjL
         XTaUSXZpkAJX1v4RZoTgBCwbya5u5WyLn4d8A0bHLiQeS6Pz8wOoHjwxsMvYuySQRyo0
         2Jk9ZEqGvfNda96e3n6nI1CbaSXRMtwagutCUTkrxOu00yMdydSflt0VzroO+O79xTI3
         JoDg==
X-Gm-Message-State: AOJu0YwZgBImAsDrpMmJwOrHYvMNKOFUKEq7OzYzfW4yHCCB2BTYHVVN
        RqBHt2tuOigZzCUIFIx85MkkcWd0pJfKMAc5
X-Google-Smtp-Source: AGHT+IH9FmhKpmE/aOSN1QtFpxWAOwHMroAGexQ2KmLhCy1SW/yq8LxLetuszbv2gMPyLfSx0b3BqtGGq80q2XS3
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:ac5a:0:b0:592:7a69:f61b with SMTP
 id z26-20020a81ac5a000000b005927a69f61bmr106372ywj.0.1695371149321; Fri, 22
 Sep 2023 01:25:49 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:25:42 +0000
In-Reply-To: <20230922082542.466579-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230922082542.466579-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922082542.466579-3-yosryahmed@google.com>
Subject: [PATCH 2/2] mm: memcg: normalize the value passed into memcg_rstat_updated()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_rstat_updated() uses the value of the state update to keep track
of the magnitude of pending updates, so that we only do a stats flush
when it's worth the work. Most values passed into memcg_rstat_updated()
are in pages, however, a few of them are actually in bytes or KBs.

To put this into perspective, a 512 byte slab allocation today would
look the same as allocating 512 pages. This may result in premature
flushes, which means unnecessary work and latency.

Normalize all the state values passed into memcg_rstat_updated() to
pages. Round up non-zero sub-page to 1 page, because
memcg_rstat_updated() ignores 0 page updates.

Fixes: 5b3be698a872 ("memcg: better bounds on the memcg stats updates")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 683aa8405c22..ea050908338a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -761,6 +761,22 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
+static int memcg_page_state_unit(int item);
+
+/*
+ * Normalize the value passed into memcg_rstat_updated() to be in pages. Round
+ * up non-zero sub-page updates to 1 page as zero page updates are ignored.
+ */
+static int memcg_state_val_in_pages(int idx, int val)
+{
+	int unit = memcg_page_state_unit(idx);
+
+	if (!val || unit == PAGE_SIZE)
+		return val;
+	else
+		return max(val * unit / PAGE_SIZE, 1UL);
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -773,7 +789,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -824,7 +840,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 	memcg_stats_unlock();
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

