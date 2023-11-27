Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137EC7FAEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjK0XqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjK0Xp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:45:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986B1B6;
        Mon, 27 Nov 2023 15:46:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfc3f50504so15148395ad.3;
        Mon, 27 Nov 2023 15:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701128763; x=1701733563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvxvLBlp9fV8n96zZT2Ez0ns0pnZxld9OCN8MtepcpQ=;
        b=NdYYdNoUqcFgDD1XreOzzSy4sZVc2MqDQsK2+y1Du34+I07vGndVbfuopiP5OWsML0
         kg/1gNPwVZSJAcoC5PzG+BB7PU6VZM0e4s49kXhm4n+gedLSYw8d28SetjzO5ZU2SAmA
         +PMkZZkGR5TAj55g/u1iW5TCSHweZni2b1sCdGXTzHyvcMsIElFVtoZcD52xWmhkDxrp
         CEY+IgonLsE8Rr+LLyyBsSBAX8shgKgx1YYTmgt6ctvpSzbVT8WF1f46SnV58kQTxOTh
         X/ynxOsz++uGYkLZK+dxRgykOSoezIR6ITlDi1ggX20TuX4konCN/1vrA7jMrYvWkyHg
         dVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128763; x=1701733563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvxvLBlp9fV8n96zZT2Ez0ns0pnZxld9OCN8MtepcpQ=;
        b=Y/WYSlOtLl6gXj/u2XV4Xfvi3wKr0Dw5wVnCMnWzSX6iihwxFsBIAlPEKWwq/QsLTU
         2pDmZqwKjfaTJXLAsequLgeOKiWAed8C6AQP5jiG9Dm2SpXyvSC1bQVQukNUUWp+sXrH
         RBu97KJHT/l0suoW8FKDJo3GCVJ8myu6qDavor/gaUyU3CND18Fc5QzpWuVOicB7SVYg
         JZoKskLz0gt8Y+8cKXC5A5uHunQYahxHSDZyT1kYKHPCoIqpvYNGzmG4WEntJMvganZc
         xoUsVFNYHM90i80WmBJvHs7SNH+d4ovlPfQaP9PWoOJOvRgY5OMTxt7Ozlpz8wb2oI2h
         EfTg==
X-Gm-Message-State: AOJu0Yx9Qjku4wd9BnZ8Vyv1XB8Ab6/+ZgGjpXbw1LPzofGiUOsDS17p
        9lE5FQNYNGFcP4KhCPDxsX4=
X-Google-Smtp-Source: AGHT+IFWjPsb6Vx9KPkJs2Zvxm9Rkb4xtPIG7tu2HUUPcSPyQQtnOlcCh2kiefVKGXuca/ewhsPVLw==
X-Received: by 2002:a17:902:b28c:b0:1cc:3fc9:1802 with SMTP id u12-20020a170902b28c00b001cc3fc91802mr11577380plr.61.1701128762852;
        Mon, 27 Nov 2023 15:46:02 -0800 (PST)
Received: from localhost (fwdproxy-prn-011.fbsv.net. [2a03:2880:ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001cfb14a09a4sm5507314plg.126.2023.11.27.15.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:46:02 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v7 2/6] memcontrol: add a new function to traverse online-only memcg hierarchy
Date:   Mon, 27 Nov 2023 15:45:56 -0800
Message-Id: <20231127234600.2971029-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127234600.2971029-1-nphamcs@gmail.com>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new zswap writeback scheme requires an online-only memcg hierarchy
traversal. Add this functionality via the new mem_cgroup_iter_online()
function - the old mem_cgroup_iter() is a special case of this new
function.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h | 13 +++++++++++++
 mm/memcontrol.c            | 29 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7bdcf3020d7a..5bfe41840e80 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -833,6 +833,10 @@ static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
 				   struct mem_cgroup_reclaim_cookie *);
+struct mem_cgroup *mem_cgroup_iter_online(struct mem_cgroup *root,
+				   struct mem_cgroup *prev,
+				   struct mem_cgroup_reclaim_cookie *reclaim,
+				   bool online);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);
@@ -1386,6 +1390,15 @@ mem_cgroup_iter(struct mem_cgroup *root,
 	return NULL;
 }
 
+static inline struct mem_cgroup *
+mem_cgroup_iter_online(struct mem_cgroup *root,
+		struct mem_cgroup *prev,
+		struct mem_cgroup_reclaim_cookie *reclaim,
+		bool online)
+{
+	return NULL;
+}
+
 static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 					 struct mem_cgroup *prev)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 470821d1ba1a..b1fb96233fa1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1111,10 +1111,11 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 }
 
 /**
- * mem_cgroup_iter - iterate over memory cgroup hierarchy
+ * mem_cgroup_iter_online - iterate over memory cgroup hierarchy
  * @root: hierarchy root
  * @prev: previously returned memcg, NULL on first invocation
  * @reclaim: cookie for shared reclaim walks, NULL for full walks
+ * @online: whether to skip offline memcgs
  *
  * Returns references to children of the hierarchy below @root, or
  * @root itself, or %NULL after a full round-trip.
@@ -1123,13 +1124,16 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
  * invocations for reference counting, or use mem_cgroup_iter_break()
  * to cancel a hierarchy walk before the round-trip is complete.
  *
+ * Caller can skip offline memcgs by passing true for @online.
+ *
  * Reclaimers can specify a node in @reclaim to divide up the memcgs
  * in the hierarchy among all concurrent reclaimers operating on the
  * same node.
  */
-struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
+struct mem_cgroup *mem_cgroup_iter_online(struct mem_cgroup *root,
 				   struct mem_cgroup *prev,
-				   struct mem_cgroup_reclaim_cookie *reclaim)
+				   struct mem_cgroup_reclaim_cookie *reclaim,
+				   bool online)
 {
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
@@ -1199,7 +1203,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 * is provided by the caller, so we know it's alive
 		 * and kicking, and don't take an extra reference.
 		 */
-		if (css == &root->css || css_tryget(css)) {
+		if (css == &root->css || (!online && css_tryget(css)) ||
+				css_tryget_online(css)) {
 			memcg = mem_cgroup_from_css(css);
 			break;
 		}
@@ -1228,6 +1233,22 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	return memcg;
 }
 
+/**
+ * mem_cgroup_iter - iterate over memory cgroup hierarchy
+ * @root: hierarchy root
+ * @prev: previously returned memcg, NULL on first invocation
+ * @reclaim: cookie for shared reclaim walks, NULL for full walks
+ *
+ * Perform an iteration on the memory cgroup hierarchy without skipping
+ * offline memcgs.
+ */
+struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
+				   struct mem_cgroup *prev,
+				   struct mem_cgroup_reclaim_cookie *reclaim)
+{
+	return mem_cgroup_iter_online(root, prev, reclaim, false);
+}
+
 /**
  * mem_cgroup_iter_break - abort a hierarchy walk prematurely
  * @root: hierarchy root
-- 
2.34.1
