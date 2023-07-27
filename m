Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4E764926
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjG0Hod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjG0HnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631008688
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:13 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bb29b9044dso579608a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443432; x=1691048232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFgH3qRamcsfut4sZg8cGFh78nFJgYUtbeqMHlI/23M=;
        b=dHR9kmWmcQ9le6M7YmaPbGgzg8LU1j88y2o2q+oGRZ09Fjo75XD675sOOoB3fiL7S/
         mvJy/2hkUTJRAHi6RATqiBH6JYJsnMtW6BK0jXCyn0bBEKPWYUF1jDM3izq7+igh1ObQ
         Y9kqSsKfoASH3X3PRcbfgEXdnXZOLsODsIA8MS/dvlAWCNQk5GD6lwZUKjQpttwZvN2o
         zmgFhVSWqHDWZCO9dNxMtAI2ybRcdpb8qFZsydXSWI3EN7l3qgaodQMhiNjXu62rcr4p
         YGPDZRKOb2HsGrtEJAIlVBHUd0ED8g4LSMQnivwL3n8AQr1iacPB/KkD20p7/XffTHFO
         79Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443432; x=1691048232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFgH3qRamcsfut4sZg8cGFh78nFJgYUtbeqMHlI/23M=;
        b=gwtzG8CsXqO8cRo2eD3yrKHKXs9fhnM69qWCr62EMfHf0u3FJcRaO4nGmcp5t6vD1G
         GC3oc4Zgmes4ttk9e+wfiZCZMVFzmVr3xDzM+mBIg7GroxtZ6wwyXn7wt20zsvkygjNN
         a0vO3oP1FeH3xixj91NT3k99e8lGrtDVUoI66i8n6tHDbtiZ1smPI3iuEJjiofhavsBz
         DN1YwwUAsNA71dnu3YgAAYOCT1yUWYgXnIPRuAYqQp5Jiik9+FB6sVzHaxS9BqDWChsT
         beVMs8y2rx1udo7NdDUh66V0p5g80nhlIgnFayYSSgbPQ2Bg3LE5BLWU4r+RXUQP11w/
         hYvg==
X-Gm-Message-State: ABy/qLbNZqwof/4CpRbsmoMA61tW9GCVQJrF9V1YDGpsCVpsUjS8m7RK
        iHPEhcsts8vZsLhbGsD3m+vXOg==
X-Google-Smtp-Source: APBJJlGUvwqFf9DYbCK3bVxj8P5XX4xs3RgcKahgwp5EZ9OT6YVjzzc8PVOv0eTLfpRrgsLixYnwjw==
X-Received: by 2002:a05:6358:9328:b0:135:4003:784c with SMTP id x40-20020a056358932800b001354003784cmr1695218rwa.17.1690443432576;
        Thu, 27 Jul 2023 00:37:12 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:12 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 1/5] bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
Date:   Thu, 27 Jul 2023 15:36:28 +0800
Message-Id: <20230727073632.44983-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a BPF_PROG_TYPE_OOM_POLICY program type. This
prog will be used to select a leaf memcg as victim from the memcg tree
when global oom is invoked.

The program takes two sibling cgroup's id as parameters and return a
comparison result indicating which one should be chosen as the victim.

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/bpf_oom.h   |  22 +++++
 include/linux/bpf_types.h |   2 +
 include/uapi/linux/bpf.h  |  14 ++++
 kernel/bpf/syscall.c      |  10 +++
 mm/oom_kill.c             | 168 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 216 insertions(+)
 create mode 100644 include/linux/bpf_oom.h

diff --git a/include/linux/bpf_oom.h b/include/linux/bpf_oom.h
new file mode 100644
index 000000000000..f4235a83d3bb
--- /dev/null
+++ b/include/linux/bpf_oom.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_OOM_H
+#define _BPF_OOM_H
+
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <uapi/linux/bpf.h>
+
+struct bpf_oom_policy {
+	struct bpf_prog_array __rcu	*progs;
+};
+
+int oom_policy_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int oom_policy_prog_detach(const union bpf_attr *attr);
+int oom_policy_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr);
+
+int __bpf_run_oom_policy(u64 cg_id_1, u64 cg_id_2);
+
+bool bpf_oom_policy_enabled(void);
+
+#endif
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..8ab6009b7dd9 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -83,6 +83,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
 BPF_PROG_TYPE(BPF_PROG_TYPE_NETFILTER, netfilter,
 	      struct bpf_nf_ctx, struct bpf_nf_ctx)
 #endif
+BPF_PROG_TYPE(BPF_PROG_TYPE_OOM_POLICY, oom_policy,
+		  struct bpf_oom_ctx, struct bpf_oom_ctx)
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..9da0d61cf703 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -987,6 +987,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_OOM_POLICY,
 };
 
 enum bpf_attach_type {
@@ -1036,6 +1037,7 @@ enum bpf_attach_type {
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
 	BPF_NETFILTER,
+	BPF_OOM_POLICY,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -6825,6 +6827,18 @@ struct bpf_cgroup_dev_ctx {
 	__u32 minor;
 };
 
+enum {
+	BPF_OOM_CMP_EQUAL   = (1ULL << 0),
+	BPF_OOM_CMP_GREATER = (1ULL << 1),
+	BPF_OOM_CMP_LESS    = (1ULL << 2),
+};
+
+struct bpf_oom_ctx {
+	__u64 cg_id_1;
+	__u64 cg_id_2;
+	__u8  cmp_ret;
+};
+
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..fb6fb6294eba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5,6 +5,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
+#include <linux/bpf_oom.h>
 #include <linux/bpf_verifier.h>
 #include <linux/bsearch.h>
 #include <linux/btf.h>
@@ -3588,6 +3589,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_XDP;
 	case BPF_LSM_CGROUP:
 		return BPF_PROG_TYPE_LSM;
+	case BPF_OOM_POLICY:
+		return BPF_PROG_TYPE_OOM_POLICY;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -3634,6 +3637,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		ret = netns_bpf_prog_attach(attr, prog);
 		break;
+	case BPF_PROG_TYPE_OOM_POLICY:
+		ret = oom_policy_prog_attach(attr, prog);
+		break;
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
@@ -3676,6 +3682,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 		return lirc_prog_detach(attr);
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 		return netns_bpf_prog_detach(attr, ptype);
+	case BPF_PROG_TYPE_OOM_POLICY:
+		return oom_policy_prog_detach(attr);
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
@@ -3733,6 +3741,8 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_FLOW_DISSECTOR:
 	case BPF_SK_LOOKUP:
 		return netns_bpf_prog_query(attr, uattr);
+	case BPF_OOM_POLICY:
+		return oom_policy_prog_query(attr, uattr);
 	case BPF_SK_SKB_STREAM_PARSER:
 	case BPF_SK_SKB_STREAM_VERDICT:
 	case BPF_SK_MSG_VERDICT:
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 612b5597d3af..01af8adaa16c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/oom.h>
+#include <linux/bpf_oom.h>
 #include <linux/mm.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
@@ -73,6 +74,9 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 	return oc->memcg != NULL;
 }
 
+DEFINE_MUTEX(oom_policy_lock);
+static struct bpf_oom_policy global_oom_policy;
+
 #ifdef CONFIG_NUMA
 /**
  * oom_cpuset_eligible() - check task eligibility for kill
@@ -1258,3 +1262,167 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+const struct bpf_prog_ops oom_policy_prog_ops = {
+};
+
+static const struct bpf_func_proto *
+oom_policy_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+static bool oom_policy_is_valid_access(int off, int size,
+						enum bpf_access_type type,
+						const struct bpf_prog *prog,
+						struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off + size > sizeof(struct bpf_oom_ctx) || off % size)
+		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_oom_ctx, cg_id_1):
+	case bpf_ctx_range(struct bpf_oom_ctx, cg_id_2):
+		if (type != BPF_READ)
+			return false;
+		bpf_ctx_record_field_size(info, sizeof(__u64));
+		return bpf_ctx_narrow_access_ok(off, size, sizeof(__u64));
+	case bpf_ctx_range(struct bpf_oom_ctx, cmp_ret):
+		if (type == BPF_READ) {
+			bpf_ctx_record_field_size(info, sizeof(__u8));
+			return bpf_ctx_narrow_access_ok(off, size, sizeof(__u8));
+		} else {
+			return size == sizeof(__u8);
+		}
+	default:
+		return false;
+	}
+}
+
+const struct bpf_verifier_ops oom_policy_verifier_ops = {
+	.get_func_proto		= oom_policy_func_proto,
+	.is_valid_access	= oom_policy_is_valid_access,
+};
+
+#define BPF_MAX_PROGS 10
+
+int oom_policy_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_prog_array *old_array;
+	struct bpf_prog_array *new_array;
+	int ret;
+
+	mutex_lock(&oom_policy_lock);
+	old_array = rcu_dereference(global_oom_policy.progs);
+	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
+		ret = -E2BIG;
+		goto unlock;
+	}
+	ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
+	if (ret < 0)
+		goto unlock;
+
+	rcu_assign_pointer(global_oom_policy.progs, new_array);
+	bpf_prog_array_free(old_array);
+
+unlock:
+	mutex_unlock(&oom_policy_lock);
+	return ret;
+}
+
+static int detach_prog(struct bpf_prog *prog)
+{
+	struct bpf_prog_array *old_array;
+	struct bpf_prog_array *new_array;
+	int ret;
+
+	mutex_lock(&oom_policy_lock);
+	old_array = rcu_dereference(global_oom_policy.progs);
+	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
+
+	if (ret)
+		goto unlock;
+
+	rcu_assign_pointer(global_oom_policy.progs, new_array);
+	bpf_prog_array_free(old_array);
+	bpf_prog_put(prog);
+unlock:
+	mutex_unlock(&oom_policy_lock);
+	return ret;
+}
+
+int oom_policy_prog_detach(const union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	int ret;
+
+	if (attr->attach_flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get_type(attr->attach_bpf_fd,
+					BPF_PROG_TYPE_OOM_POLICY);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	ret = detach_prog(prog);
+	bpf_prog_put(prog);
+
+	return ret;
+}
+
+int oom_policy_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	struct bpf_prog_array *progs;
+	u32 cnt, flags;
+	int ret = 0;
+
+	if (attr->query.query_flags)
+		return -EINVAL;
+
+	mutex_lock(&oom_policy_lock);
+	progs = rcu_dereference(global_oom_policy.progs);
+	cnt = progs ? bpf_prog_array_length(progs) : 0;
+	if (copy_to_user(&uattr->query.prog_cnt, &cnt, sizeof(cnt))) {
+		ret = -EFAULT;
+		goto unlock;
+	}
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
+		ret = -EFAULT;
+		goto unlock;
+	}
+	if (attr->query.prog_cnt != 0 && prog_ids && cnt)
+		ret = bpf_prog_array_copy_to_user(progs, prog_ids,
+						  attr->query.prog_cnt);
+
+unlock:
+	mutex_unlock(&oom_policy_lock);
+	return ret;
+}
+
+int __bpf_run_oom_policy(u64 cg_id_1, u64 cg_id_2)
+{
+	struct bpf_oom_ctx ctx = {
+		.cg_id_1 = cg_id_1,
+		.cg_id_2 = cg_id_2,
+		.cmp_ret = BPF_OOM_CMP_EQUAL,
+	};
+	rcu_read_lock();
+	bpf_prog_run_array(rcu_dereference(global_oom_policy.progs),
+						&ctx, bpf_prog_run);
+	rcu_read_unlock();
+	return ctx.cmp_ret;
+}
+
+bool bpf_oom_policy_enabled(void)
+{
+	struct bpf_prog_array *prog_array;
+	bool empty = true;
+
+	rcu_read_lock();
+	prog_array = rcu_dereference(global_oom_policy.progs);
+	if (prog_array)
+		empty = bpf_prog_array_is_empty(prog_array);
+	rcu_read_unlock();
+	return !empty;
+}
-- 
2.20.1

