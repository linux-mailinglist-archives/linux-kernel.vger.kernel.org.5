Return-Path: <linux-kernel+bounces-107001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F187F684
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2ED1F22597
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0540874;
	Tue, 19 Mar 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="OMRvrYg7"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175103FBAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710824676; cv=none; b=ahQC2V8de9cErp/sIHQczyApV3KYFX5cn7hqrkCaO8JjXn2Wp7A/oPe15Vwgik1hsc5XCGmdbKnNAbdctbZP/0F/9q88ikntrSNqLm6shTbaUQ5heebnIm+JOVT+x5p+hNXB77QV3yu1ZcYj49JS0sCGmByXwWFOA7bhH9LSX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710824676; c=relaxed/simple;
	bh=Lz2CrH8A7WjP27QDwUAd0Apjplhh1crikLeGS9SaF0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5dn7I+ogXqU1+XtynYNbtLCt9Y40uTu1KopNhIAY0m2kGEaJhSHcapb14/b/gEVU5eFZC3pgUGOQeG5PlOmoP5z9zJ0D9YiwZsDc6KFnb7k74+esaGtB+GciyMRFJdPHcPxhPKUcfAE/N63UrDHCoawksWy7R9IuroCAHNWbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=OMRvrYg7; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso4699916276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710824674; x=1711429474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+tjYLQhJo+BMVuUInD+N/p7F8UX37fJMVNt77Cc/o8=;
        b=OMRvrYg7HgBuIVmUkj1ch1iK0S0ygVW8fUtADWjIpylwb6Hxo3l66hHvDxyVbY7eoa
         221LGIRkuutwtnLCR6FLdS2PTXMf+ruKaVuZAn0yWT3ov0u/tQDXkwqNRtx+yf81aodF
         1IJEPTgS0ODyBAQ9uFkRyrmGgrh15Tb25B3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710824674; x=1711429474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+tjYLQhJo+BMVuUInD+N/p7F8UX37fJMVNt77Cc/o8=;
        b=Zc/AWUWV13Q7Z0mmfagRaH2LeG3xhgYwpiw39QC1q5CvNIUy/3LQ7JpYqpCkLyoS/l
         xHVKeLCTdDs850n04aUhvZMZKzCx1M6W8MCnPAm7gjR0QbMvTA34ZeVgq9DajxtDBhZb
         PL+Q7l8SEfD71x0InfgiNpjjfXUfDKukow/nRwrP33OrlUdtqVWyqiwq/yf7FlcDVuVV
         RajcpLPw2XicHcBzxYYOLbU5b536/Ug2plTrS3cwJOPsL0NmL+RhiCvtUu9dOWBuX6/e
         pXKY910g3qDKdEMDXsqQZ9yX7vx4+O/zkePYRnz0PyT8C3bbR7n+HKPRpjF2gXFf68Bm
         AhrA==
X-Forwarded-Encrypted: i=1; AJvYcCXWJsPI0G5I+9QRHtBQS1KgjxSA/MDmqT302a+oadw3ITTHmb+Y0/Lbr+Kg7Jph2KJmPh5AbDGEtQgLBgec1pqfO7iaPya4q2c+Hatl
X-Gm-Message-State: AOJu0YwiY7dIUd8/qFUOWfXbSnv5UKR97ah1d5GW9tXSFmGYMlD+Js6b
	pI0cD/mkkWVtCFAddjUrUoP6GAQRaT19/pGVQcu6jVmLJ4+sdGtRzLwOYZdyL/4=
X-Google-Smtp-Source: AGHT+IGKnEb1MFeHqBSw8vDsqBbEODWdU6GBl76O84BfZEbLJavR+eqn8sFeEHheRyEbc1ga1F6bAQ==
X-Received: by 2002:a25:6405:0:b0:dc6:deca:468f with SMTP id y5-20020a256405000000b00dc6deca468fmr9032612ybb.29.1710824673931;
        Mon, 18 Mar 2024 22:04:33 -0700 (PDT)
Received: from localhost ([12.220.158.163])
        by smtp.gmail.com with UTF8SMTPSA id t10-20020a25908a000000b00dcc0cbb0aeesm2023977ybl.27.2024.03.18.22.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:04:33 -0700 (PDT)
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
Subject: [PATCH V3 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
Date: Mon, 18 Mar 2024 23:03:01 -0600
Message-Id: <20240319050302.1085006-1-josef@netflix.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances the BPF helpers by adding a kfunc to retrieve the
cgroup v2 of a task, addressing a previous limitation where only
bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
particularly useful for scenarios where obtaining the cgroup ID of a
task other than the "current" one is necessary, which the existing
bpf_get_current_cgroup_id helper cannot accommodate. A specific use
case at Netflix involved the sched_switch tracepoint, where we had to
get the cgroup IDs of both the prev and next tasks.

The bpf_task_get_cgroup kfunc acquires and returns a reference to a
task's default cgroup, ensuring thread-safe access by correctly
implementing RCU read locking and unlocking. It leverages the existing
cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
V2 -> V3: No changes
V1 -> V2: Return a pointer to the cgroup instead of the cgroup ID

 kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a89587859571..bbd19d5eedb6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2266,6 +2266,31 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
 		return NULL;
 	return cgrp;
 }
+
+/**
+ * bpf_task_get_cgroup - Acquire a reference to the default cgroup of a task.
+ * @task: The target task
+ *
+ * This function returns the task's default cgroup, primarily
+ * designed for use with cgroup v2. In cgroup v1, the concept of default
+ * cgroup varies by subsystem, and while this function will work with
+ * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
+ * A cgroup returned by this kfunc which is not subsequently stored in a
+ * map, must be released by calling bpf_cgroup_release().
+ *
+ * Return: On success, the cgroup is returned. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *task)
+{
+	struct cgroup *cgrp;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(task);
+	if (!cgroup_tryget(cgrp))
+		cgrp = NULL;
+	rcu_read_unlock();
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2573,6 +2598,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)

base-commit: c733239f8f530872a1f80d8c45dcafbaff368737
-- 
2.40.1


