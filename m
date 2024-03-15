Return-Path: <linux-kernel+bounces-104784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724C87D392
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF56B23705
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994C4DA1F;
	Fri, 15 Mar 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="fkMPeTfX"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF34D9FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527334; cv=none; b=c9kQxtbqxG3PxkutBmNM50pZBIVKBwOkgu5/svSrmKl5V25QyTAbbrCxuOH0JIqq4mIi+mLVQNfXF1wjrYVC8K2rSc+VA7tiawapXSbWf3AaChv3UVTWzCylkcJqAygVWHTef/PqQqCMU7dRa4/0x+efBdFJ5Yf5dYlq/25JwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527334; c=relaxed/simple;
	bh=lWf98zPH7AshEAfiihgiLaljEiVmaYNX6Bsa9pdVB3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rnzQsm6hNogX8nTpC+/7p8nJkLE7k6bML1LQiTqIN0VGhBeEP7Zf+uPfXGLF8I2tlj+8RX3oYiU02Lvh2xez8DJtQWPqgqiCEsIWoilzi6ol3nBvY6sqbLT41RRglrlUKoNQjqmXcLT7yMKnZLc09AqBUgrJEJrienYuidtR578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=fkMPeTfX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8d3da056aso39262739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710527329; x=1711132129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgfh3Sxm/BV+pCR26EGSXvQQ7SOcSkk18NjS+RmHtA=;
        b=fkMPeTfXdww4tYqDlvBxrFDh4WXGOgfIsQ4XeTXXCCzBD1jXRy+CIsK521iYLfcmNA
         D6rf+ZmZqeqH+RZFa9pmr44vr5hljIw9aEVbb6R5uiqs0oF2j9NwbhiVaMEDCl/uRhui
         KpvrSY6oZ29LOLP23D06QZLwkD+wdAQcKbBxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527329; x=1711132129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCgfh3Sxm/BV+pCR26EGSXvQQ7SOcSkk18NjS+RmHtA=;
        b=ZmNOBr51ClPRJpDGmNvhXZ4jp2jUtAhBrzvjkPKLrsvH8EqVOOUyvFtOFPzBIUJUy0
         WtLhCjbAzRdeNDIfI8ao2oVtESyqIBRZxrqL8nitGoMgVgDCQ117EqqW6FVxC91sltwc
         HfCEPLEq7mjlUjE02sCBByt/5VQybP05vqJXCb55UcYLIfVVKa5R06N4oomoRxgU91rl
         78RdKzlcLAlyF1MIc6t+h8K2PaC2QrWJ/R8ULb7LzWAG9FSOVYzgP4Ak5cBjqvOUceOE
         BJ/6BNX9x9ddbzwyqAjJKookY6Hwhr4bIPOdCPsLVUgimOHpqWnLRHqBJ5PvxNhgDdZj
         IX4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJPldN8IsDTNofNQg6dOXZKwMC+uUpGWwbaZvu7czU6KeuXE6vqjbADC1DhAW8A1NAT+v6oQhnj9HTUHFU+k5iq/oSs5MC/jVxpk1R
X-Gm-Message-State: AOJu0Yw7QBkBXrLNXYVw+e2Qhvgfn7rLSwo+t9DI7E0hUtUXAB5FE3sd
	IMsvN8OpsJDs/BGSugfEhdwqPKtRVDeP+mP1mJ166HvjySyruQK0Ibmz87q3k4U=
X-Google-Smtp-Source: AGHT+IGbfe1+m911z4rDE0JLVaBIDIJ1kWDx4d7pMYs3vMUJE4YT+724SXKHssUqJerD08G4ekyvPw==
X-Received: by 2002:a05:6602:184b:b0:7ca:ebbc:ee27 with SMTP id d11-20020a056602184b00b007caebbcee27mr5832106ioi.21.1710527329584;
        Fri, 15 Mar 2024 11:28:49 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:c760:7c0b:344d:cd33])
        by smtp.gmail.com with UTF8SMTPSA id dl22-20020a056638279600b00477b9971a45sm185526jab.17.2024.03.15.11.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:28:49 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: add btf_task_get_cgroup_id kfunc
Date: Fri, 15 Mar 2024 12:28:03 -0600
Message-Id: <20240315182804.216081-1-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the BPF helpers by adding a kfunc to retrieve the
cgroup v2 ID of a specific task, addressing a previous limitation where
only bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
particularly useful for scenarios where obtaining the cgroup ID of a
task other than the "current" one is necessary, which the existing
bpf_get_current_cgroup_id helper cannot accommodate. A specific use case
at Netflix involved the sched_switch tracepoint, where we had to get
the cgroup IDs of both the previous and next tasks.

The bpf_task_get_cgroup_id kfunc returns a task's cgroup ID, correctly
implementing RCU read locking and unlocking for safe data access, and
leverages existing cgroup.h helpers to fetch the cgroup and its ID.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..8038b2bd3488 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2266,6 +2266,27 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_get_cgroup_id - Get the cgroup ID of a task.
+ * @task: The target task
+ *
+ * This function returns the ID of the task's default cgroup, primarily
+ * designed for use with cgroup v2. In cgroup v1, the concept of default
+ * cgroup varies by subsystem, and while this function will work with
+ * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
+ */
+__bpf_kfunc u64 bpf_task_get_cgroup_id(struct task_struct *task)
+{
+	struct cgroup *cgrp;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	cgrp_id = cgroup_id(cgrp);
+	rcu_read_unlock();
+	return cgrp_id;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2573,6 +2594,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup_id, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.40.1


