Return-Path: <linux-kernel+bounces-107002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC287F687
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317EC2822E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F3446B2;
	Tue, 19 Mar 2024 05:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="SCC4OIgN"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F73FBB7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824686; cv=none; b=slI6DgN8QBDDVTJJwgTFf1UsJ333XyFJXBNNDWrsmEUOcqyxnF1VoH6gJdqU/rGUm1DojKlBDTfx20yiNvw/ugl9EpRiOvNUuYf6NYE7ryc6K4OsrhN/1PeeGQIpkrBot9N8A1ximy8s2UmVN/c8397FXv04bAlQk5jUe43CzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824686; c=relaxed/simple;
	bh=o66rBTTTN9Bz/2JCsO8MOAFQm7PEkrdPPz3CiJGnfAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhRKPMhCZ6HIPxQSaOoo2poQ3yAskJP2BIV3W6DDRyMIqvBIb4c0Ixz2ZZV4hO5b6zWmFTOHPShwWIL8rONtbkTtiQHiP0eyBErAs924utmJlPkiApt7P5ekdSHLPQ8TEZKgQiuDEP3KTO4GWoj3kZ5eZ8KU5cjNf2N9rSxdQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=SCC4OIgN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a0579a955so60854237b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710824682; x=1711429482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNBNaRHZ6AfjwYMq1bFzdzJMJiPnkD5V98EDpDv4hWA=;
        b=SCC4OIgNjdzwhsm7MxjAGgVH/THmjIQ4RiL3DZsbnenpw1c30+uz+rAHeXEp1eDfwE
         hIF8k95Jzj2N3JCynE43EnRJSjQr25a6W39KfDzz0g2xYD/axXltnU5dh7vW+vpw2Ms0
         9Zyzs9+GVKoBOBMqhsKbqTaVjju9xOEjR2sOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824682; x=1711429482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNBNaRHZ6AfjwYMq1bFzdzJMJiPnkD5V98EDpDv4hWA=;
        b=chGKNEErGnIbKPYa/RxuTOQ4Pgj726WEnDqzcKIGdeqLpp//zVDlU0y5lrrj6uOzVQ
         qcnpJ/Z2qAU+BNA/jBjNhurXhiOdL6w14YwOq/W76esx5LR+dlZmVwkAo3FC8MLVJbT0
         QbKrXmVFk2CIxpco6rrK2YVawc6nnCutGby7TLucH8c7q2qKOcsCazZIoRLw2Dg2fSny
         3EiQkL1uZql8Ze8qIsO96qEr+xw6dtU14g4+79z52H1mYNAGbSEVnZUr5xpvwcwbAIns
         G0CQykFt2AaGHsJn0XVdsZEVb+mL1Wqfz9dYXcQxnBGmPsy+UyL8jCkJq4W02/TjaYOS
         ULIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpVDjiWsFGyP0NkmuNyztMWgBoY1cZ5iFGby8dGOcq6bhEUr1Qwon+h9x/JHnvK06X1ZwEBzSZbURJMQX83Uc9bFynUXDcgqK3Kotq
X-Gm-Message-State: AOJu0YysF1k0DWGCiUVd8bldIPVTfhApJX7u/0UgsJJYwzYVMbEyFIXS
	Kzqn8oztay38qt6F+7X+EkwML+MkTFpwaO743bFgnM+hSoGvquaFk63inIoEIbo=
X-Google-Smtp-Source: AGHT+IGUcPg4y8TA8iAfSq3V63mc8bIMbNH87magc9JoKtuTwKmArOL4jXrrqj2sJVI43B2iEtlmoA==
X-Received: by 2002:a0d:db87:0:b0:609:18e2:91b2 with SMTP id d129-20020a0ddb87000000b0060918e291b2mr1836326ywe.32.1710824682582;
        Mon, 18 Mar 2024 22:04:42 -0700 (PDT)
Received: from localhost ([12.220.158.163])
        by smtp.gmail.com with UTF8SMTPSA id eq4-20020a05690c2d0400b00609f4170662sm2181268ywb.54.2024.03.18.22.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:04:42 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH V3 bpf-next 2/2] selftests/bpf: add selftest for bpf_task_get_cgroup
Date: Mon, 18 Mar 2024 23:03:02 -0600
Message-Id: <20240319050302.1085006-2-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240319050302.1085006-1-josef@netflix.com>
References: <20240319050302.1085006-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a selftest for the `bpf_task_get_cgroup` kfunc. The test
focuses on the use case of obtaining the cgroup ID of the previous task
in a `sched_switch` tracepoint.

The selftest involves creating a test cgroup, attaching a BPF program
that utilizes the `bpf_task_get_cgroup` during a `sched_switch`
tracepoint, and validating that the obtained cgroup ID for the previous
task matches the expected cgroup ID.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
V2 -> v3: Use _open_and_load(), usleep helper, and drop map usage
V1 -> V2: Refactor test to work with a cgroup pointer instead of the ID

 .../bpf/prog_tests/task_get_cgroup.c          | 43 +++++++++++++++++++
 .../bpf/progs/test_task_get_cgroup.c          | 32 ++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_get_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
new file mode 100644
index 000000000000..031623067e7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_get_cgroup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include <test_progs.h>
+#include <cgroup_helpers.h>
+#include "test_task_get_cgroup.skel.h"
+#include <unistd.h>
+
+#define TEST_CGROUP "/test-task-get-cgroup/"
+
+void test_task_get_cgroup(void)
+{
+	struct test_task_get_cgroup *skel;
+	int err, fd;
+	__u64 expected_cgroup_id;
+
+	fd = test__join_cgroup(TEST_CGROUP);
+	if (!ASSERT_OK(fd < 0, "test_join_cgroup_TEST_CGROUP"))
+		return;
+
+	skel = test_task_get_cgroup__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_task_get_cgroup__open_and_load"))
+		goto cleanup;
+
+	err = test_task_get_cgroup__attach(skel);
+	if (!ASSERT_OK(err, "test_task_get_cgroup__attach"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+	expected_cgroup_id = get_cgroup_id(TEST_CGROUP);
+	if (!ASSERT_GT(expected_cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
+
+	/* Trigger nanosleep to enter the sched_switch tracepoint */
+	/* The previous task should be this process */
+	usleep(100);
+
+	ASSERT_EQ(skel->bss->cgroup_id, expected_cgroup_id, "cgroup_id");
+
+cleanup:
+	test_task_get_cgroup__destroy(skel);
+	close(fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
new file mode 100644
index 000000000000..30d4499c6bc5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_get_cgroup.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2024 Netflix, Inc.
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct cgroup *bpf_task_get_cgroup(struct task_struct *task) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+int pid = 0;
+u64 cgroup_id = 0;
+
+SEC("tp_btf/sched_switch")
+int BPF_PROG(sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next)
+{
+	struct cgroup *cgrp;
+
+	if (prev->pid != pid)
+		return 0;
+
+	cgrp = bpf_task_get_cgroup(prev);
+	if (cgrp == NULL)
+		return 0;
+	cgroup_id = cgrp->kn->id;
+
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


