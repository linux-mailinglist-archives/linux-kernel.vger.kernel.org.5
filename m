Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101747F0891
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKSTtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjKSTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC189D7A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb7951d713so352280b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423314; x=1701028114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C/w+GrPz4ktaqTeTQ4DmVKbN9IqMk3W+D3u9IVSxuMQ=;
        b=hWeuClbwt9dh9tON8JEyhbawHTrAbClV9oMYSRZp+VU1ZqxrXjtOSlT5yTqQ2SwFr1
         bFG9WkEqFygF8GH4CsSzOhyaq5QiUjeUN9w6BKZs8ne0PaC8LxqNd1d6FLPJa5MnUEPX
         SucgF4XXsth99wKI0POSRLrdtijBlSgrqPvjvBlPgg7ZWy/L+ZDWDYFxYbYtZ0WX3r9o
         mDS4IosmsloEDJu7no+e+KllNv6tR6c9p/+zcABzir6eL5XcH5BoKz4ngTYdmt8wXvQq
         rIiWHerw3FOjOrdZq9A/sk1/OpwVCgo3g3RsRtEZxN+NQ7eXyGUT3mx45HF+FWKL0x5o
         abfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423314; x=1701028114;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/w+GrPz4ktaqTeTQ4DmVKbN9IqMk3W+D3u9IVSxuMQ=;
        b=U0JYih8qxa8GHrkBp8HIf1dn4UH+tUajW6JwYTUtXBqKtzS85GFcio0kxGrlnGgoJC
         YpLE5pRL2wzPczaC+TZfAtiUV0GrICS7uyO4nirBPaPqBwTmtqIrRWDUvvUGBHU4+vi5
         P3Fo+jcX0q3uGaOyben5T00KSEITXYApPuPpb9m0P4Xm4LlinNUy4xAb4GyUNeu4Fbcc
         fb2l48Da/H9zj8jlRS5wh4v8b0DDuPAD68Wo57h1t276aOXA1etAz0G2E7/uNVUvRUtm
         QX8TJKm8bcfZKrV1lBO0YbEi4Knhsd9xu4k/0Aerlk0fWrdpmdP3MI/yXQk3kZjgspeT
         4qTg==
X-Gm-Message-State: AOJu0YwzhEngVfgAyDJAbUxtRXijO2ErFEkjRRQTk1oRce7TMSSahzVq
        kCviY83GJsS11m0f3WsxQow=
X-Google-Smtp-Source: AGHT+IEspsOv+B33e2KenQSEEY708IvBCJ1YaqljuBAeYVz5GS0a0k4ga/MiJ9KapiAUwb4LUSztpg==
X-Received: by 2002:a05:6a00:2e99:b0:6c9:88ee:1d87 with SMTP id fd25-20020a056a002e9900b006c988ee1d87mr19403560pfb.17.1700423314274;
        Sun, 19 Nov 2023 11:48:34 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:33 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 10/24] mm/swap: remove nr_rotate_swap and related code
Date:   Mon, 20 Nov 2023 03:47:26 +0800
Message-ID: <20231119194740.94101-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

No longer needed after we switched to per entry swap readhead policy.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 64a37819a9b3..cc83fb884757 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -454,7 +454,6 @@ extern void free_pages_and_swap_cache(struct encoded_page **, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
-extern atomic_t nr_rotate_swap;
 extern bool has_usable_swap(void);
 
 /* Swap 50% full? Release swapcache more aggressively.. */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e15a6c464a38..01c3f53b6521 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -104,8 +104,6 @@ static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
 /* Activity counter to indicate that a swapon or swapoff has occurred */
 static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
-atomic_t nr_rotate_swap = ATOMIC_INIT(0);
-
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
 	if (type >= MAX_SWAPFILES)
@@ -2486,9 +2484,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (p->flags & SWP_CONTINUED)
 		free_swap_count_continuations(p);
 
-	if (!p->bdev || !bdev_nonrot(p->bdev))
-		atomic_dec(&nr_rotate_swap);
-
 	mutex_lock(&swapon_mutex);
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
@@ -2990,7 +2985,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	struct swap_cluster_info *cluster_info = NULL;
 	struct page *page = NULL;
 	struct inode *inode = NULL;
-	bool inced_nr_rotate_swap = false;
 
 	if (swap_flags & ~SWAP_FLAGS_VALID)
 		return -EINVAL;
@@ -3112,9 +3106,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
 			cluster_set_null(&cluster->index);
 		}
-	} else {
-		atomic_inc(&nr_rotate_swap);
-		inced_nr_rotate_swap = true;
 	}
 
 	error = swap_cgroup_swapon(p->type, maxpages);
@@ -3218,8 +3209,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
 	kvfree(cluster_info);
-	if (inced_nr_rotate_swap)
-		atomic_dec(&nr_rotate_swap);
 	if (swap_file)
 		filp_close(swap_file, NULL);
 out:
-- 
2.42.0

