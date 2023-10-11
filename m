Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962C27C5352
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjJKMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346857AbjJKMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:12:39 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75110CB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:55 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c64a3c4912so4760911a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026178; x=1697630978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEInOcrGpkkZm6SAXLwwS2bVGzjJWfEHqZIWggTzZdM=;
        b=NyCg/sEAhkgP6TXyPML7Nax8Il/sML12zlxaK/qC8giHbkI5CfSIOuibjrb+pWCz/D
         WFENhPPlipvvDODIrmad2gmdCgYgfvD9PE2XUwMQN+XPkeehu3P4zQ8fmLYiwIINRTs1
         dnd07N7zX5M2B234H5csxFKKDNFtDvJdKkQlYKpQBXUuvE0ELpy9VptajXV0LeEaomPd
         DJoB80W0Q95NuQYlKa+XBsIRuh6yw9yYbvFpZHorJ/6Ixx2h/r0Z281367/ETWispVox
         0pz7K0+P6TR7C6a8IpVfGoctJoNEGytFgwwX2KNX2TMOa4JLyq2hvVc9vwr484DzMCW7
         Uamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026178; x=1697630978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEInOcrGpkkZm6SAXLwwS2bVGzjJWfEHqZIWggTzZdM=;
        b=u4B62lrV69ca55/mb5VaFnkFzA7vLpqOFR8Wn2fLXIkzKQ9aQxPsOYPFdTT6iZHUKc
         Yx+G1D1EqOGY5KzjCXVzCTpqAmT4FbCk7dXfHLeMZGFLlP1XySDwWEntYe1+mWbEf+TD
         aF4k5rbCx8rFcDq9OIEYG+4yam+bgDXDfLIAzy9oPP8rCSLxxf5saVv/rkWuzaSKFnrN
         KNvdkS6DltTbcejpYXjLRfh4es790+V1vtMZiite+p7C07qKyulFb6mjhHj7g/P4yTS6
         0Jgkdc8eEcZ0aF7IHhLob7zTybKqq5JgEemlDrLRjyhBopq46/KFkkskcqRV5sADmWzs
         FUcA==
X-Gm-Message-State: AOJu0YxEVpMOub5IFpPMfpBTYy0pwb6CfZqv0Qgro9YWcOwUazGC3Vw+
        G5AoD0td9ZIx2HcTN7QuEoYIpg==
X-Google-Smtp-Source: AGHT+IHjKHonnoI1BOIEGk/ad39WpPtoGe1DbtB+CwilEYav3IunLCBR8QAXvq6KrVW/oRgqBfRt/w==
X-Received: by 2002:a9d:75da:0:b0:6bd:af4:274d with SMTP id c26-20020a9d75da000000b006bd0af4274dmr23662697otl.8.1697026178764;
        Wed, 11 Oct 2023 05:09:38 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:38 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
Date:   Wed, 11 Oct 2023 20:08:56 +0800
Message-Id: <20231011120857.251943-8-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011120857.251943-1-zhouchuyi@bytedance.com>
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
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

The newly-added struct bpf_iter_task has a name collision with a selftest
for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
renamed in order to avoid the collision.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c        | 18 +++++++++---------
 .../{bpf_iter_task.c => bpf_iter_tasks.c}      |  0
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1f02168103dd..dc60e8e125cd 100644
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
 #include "bpf_iter_task_vma.skel.h"
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

