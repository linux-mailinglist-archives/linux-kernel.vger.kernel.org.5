Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF17CD463
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbjJRGXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjJRGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:22:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B019A8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9bca1d96cso44216315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609894; x=1698214694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQoEay4rhaVzIBrBvVhg11HsCpeS6HANzS4lkGBCuZ4=;
        b=FwW88olgJ5EWUU25m6KzuQ6R858GYT0Ra2cPUGTZ1aXWYsCvDvhXDm8o8rVYoKTPBO
         cL1bp9RR1NrR4Yrmr6bAhWa65Jw5Lm/dqivydvj4sIBy6HKRei2Axp/3sNBo3uMGw+Mf
         VXEnX7jM7x4BWA+QJhPZBKJYq3Dp8omZWV+EA4YGlBljDXex3jqHyCuAg+YcVHzViJ27
         hYXUj2SuaXJztjePmIJsU8CBievUhtZj7a3dcz4iI34lXhAco5vobbmRXjZ81hjgPuls
         TgFV6adRs5cqatgR68QofM/sD5ajefX8qR6RPEVDo1Xxe/jABtwLhJF2dSEMjeB6aNPb
         4g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609894; x=1698214694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQoEay4rhaVzIBrBvVhg11HsCpeS6HANzS4lkGBCuZ4=;
        b=J/RI20cokehsRudnRtKgD2sXP4pmdOP0kagFTFfOLW09a+aHn0Arbrwv4I0EZV65SA
         g6I/KFFeklXT/4OG/b/UDz9ZEYLXfufZXjIl6zfYMkaCOwaxI3PIfOPR0KPJsFdijcSO
         G5Y0S07JkRBi8mOM1hLjOlORxpfzDHynxs3ksb43k7BQ1QkR5FWiHGFMnpxt75hTga1W
         otJW3TafrGJe2gdFFYvvcDF+fKICAG4l240o9i3ORQvrKOnU9gkOE3xT6PwerecVHq41
         7fJzIodICw3MbEqFl7rF9u7c2xbC2HGoG9ji/ERIDaMvqfB4aaCet/yqVeSy52V0r3XO
         qjEw==
X-Gm-Message-State: AOJu0YwlgB0S0jNRRPIv+lGlbNptdmot66b88whPRO4vGgSDoRyMPoCA
        BrIOsiIlaAP0BUtx+ZpdVp7xNg==
X-Google-Smtp-Source: AGHT+IHe5ZdVnEzS5tjxpfZ8uEPb9SiEMM/KwW0ztO0tbDERHa84ynxNWv4YWxXpeDJgGfrzjTyw3A==
X-Received: by 2002:a17:902:ecc9:b0:1ca:1af1:681d with SMTP id a9-20020a170902ecc900b001ca1af1681dmr4504438plh.67.1697609894426;
        Tue, 17 Oct 2023 23:18:14 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:14 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
Date:   Wed, 18 Oct 2023 14:17:45 +0800
Message-Id: <20231018061746.111364-8-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly-added struct bpf_iter_task has a name collision with a selftest
for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
renamed in order to avoid the collision.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 18 +++++++++---------
 .../{bpf_iter_task.c => bpf_iter_tasks.c}      |  0
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 41aba139b20b..e3498f607b49 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -7,7 +7,7 @@
 #include "bpf_iter_ipv6_route.skel.h"
 #include "bpf_iter_netlink.skel.h"
 #include "bpf_iter_bpf_map.skel.h"
-#include "bpf_iter_task.skel.h"
+#include "bpf_iter_tasks.skel.h"
 #include "bpf_iter_task_stack.skel.h"
 #include "bpf_iter_task_file.skel.h"
 #include "bpf_iter_task_vmas.skel.h"
@@ -215,12 +215,12 @@ static void *do_nothing_wait(void *arg)
 static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 				     int *num_unknown, int *num_known)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 	pthread_t thread_id;
 	void *ret;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock");
@@ -239,7 +239,7 @@ static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
 	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
 		     "pthread_join");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_common(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)
@@ -307,10 +307,10 @@ static void test_task_pidfd(void)
 
 static void test_task_sleepable(void)
 {
-	struct bpf_iter_task *skel;
+	struct bpf_iter_tasks *skel;
 
-	skel = bpf_iter_task__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
+	skel = bpf_iter_tasks__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_task_sleepable);
@@ -320,7 +320,7 @@ static void test_task_sleepable(void)
 	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
 		  "num_success_copy_from_user_task");
 
-	bpf_iter_task__destroy(skel);
+	bpf_iter_tasks__destroy(skel);
 }
 
 static void test_task_stack(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/bpf_iter_task.c
rename to tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
-- 
2.20.1

