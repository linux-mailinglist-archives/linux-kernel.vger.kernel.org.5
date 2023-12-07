Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753B0809320
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443959AbjLGVJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443943AbjLGVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:08:53 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F03E9;
        Thu,  7 Dec 2023 13:08:59 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b6fe5d67d4so31815339f.3;
        Thu, 07 Dec 2023 13:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983338; x=1702588138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U46t7VRKkzRri+us8kqzfYBSLxC0cBypP0Rhwiulss=;
        b=JKfR4YEDy4v1K5xE6KDhWJXOLK59xw7pgUDObgM5XjeijOTuGeQ64sOjpCwA6sr9WK
         QGeqw3ucscEb/UUSX1YKjh5h7qDclRCqW8sAKj51pCKEhGxjZhGdxzU1LL8UOJgm/Nyy
         342GtBN1XywZQ1SihxepR6sCrLtIUZwGG2HUrwuuToqcpUyKqIEa271AJsv3Ry5Ey9gu
         q8gT9IWMd+iMucJfhai6UY2LAbWnmDUi6vZ817/+kOJQbqZUJjJtNgXgZnY3AVWdrnsv
         NcyAsJ7bjkMLqNT0Nui4N86SgWVn0IgICz/dp/Vupbo/vEWgV6z5GAwPbPb2PkwKKG45
         bZpw==
X-Gm-Message-State: AOJu0YxSt033rAQ83AlaZxvNs99XyNC75wJqupWyKo4PGy7R8thJDS9l
        RN9lsmP3YJjAumLgoe5S4fUYozQhqzIsfr57
X-Google-Smtp-Source: AGHT+IFYYCyWTIi4d9eKIBiaWLyNDTli9Yl/aUGYGxCHdfpzst91EtyP3AdYmx0GXlZDFT2yjx5OSg==
X-Received: by 2002:a5d:9ec2:0:b0:77e:3598:e516 with SMTP id a2-20020a5d9ec2000000b0077e3598e516mr3701688ioe.2.1701983338323;
        Thu, 07 Dec 2023 13:08:58 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v3-20020a023843000000b00466b43f6b54sm117902jae.156.2023.12.07.13.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:08:57 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for bpf_cpumask_weight() kfunc
Date:   Thu,  7 Dec 2023 15:08:43 -0600
Message-ID: <20231207210843.168466-3-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231207210843.168466-1-void@manifault.com>
References: <20231207210843.168466-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new bpf_cpumask_weight() kfunc can be used to count the number of
bits that are set in a struct cpumask* kptr. Let's add a selftest to
verify its behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_common.h      |  1 +
 .../selftests/bpf/progs/cpumask_success.c     | 43 +++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 756ea8b590b6..c2e886399e3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -18,6 +18,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_insert_leave",
 	"test_insert_remove_release",
 	"test_global_mask_rcu",
+	"test_cpumask_weight",
 };
 
 static void verify_success(const char *prog_name)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index b15c588ace15..0cd4aebb97cf 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -54,6 +54,7 @@ bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym;
 void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 674a63424dee..fc3666edf456 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -460,6 +460,49 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local;
+
+	if (!is_test_task())
+		return 0;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	if (bpf_cpumask_weight(cast(local)) != 0) {
+		err = 3;
+		goto out;
+	}
+
+	bpf_cpumask_set_cpu(0, local);
+	if (bpf_cpumask_weight(cast(local)) != 1) {
+		err = 4;
+		goto out;
+	}
+
+	/*
+	 * Make sure that adding additional CPUs changes the weight. Test to
+	 * see whether the CPU was set to account for running on UP machines.
+	 */
+	bpf_cpumask_set_cpu(1, local);
+	if (bpf_cpumask_test_cpu(1, cast(local)) && bpf_cpumask_weight(cast(local)) != 2) {
+		err = 5;
+		goto out;
+	}
+
+	bpf_cpumask_clear(local);
+	if (bpf_cpumask_weight(cast(local)) != 0) {
+		err = 6;
+		goto out;
+	}
+out:
+	bpf_cpumask_release(local);
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 __success
 int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_flags)
-- 
2.42.1

