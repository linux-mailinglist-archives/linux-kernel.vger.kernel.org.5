Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A15764925
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjG0Ho2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjG0Hnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2F6A4D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f94328a4so119405b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443442; x=1691048242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r//0VfNIsSS7LjEKz2w3sxhtDAhJR7x5LJkBswgmGuQ=;
        b=bvNQcm1txH3rhOO7bm1O9db1gBgcBMCQs09BOjh+n6R3VBja2J59RqrtgNWO9awRAF
         EmhJsX7mQDb9SHJfhSrkICHn+WQAe+gtR3inPpRAzBY6qQm1agnybe8DuKumdO5jlFKe
         3YHkH7nP76dnwLFRRldyNlJof4ZD7ZNlpVEshWiVntSoFuZJgffmlqMqIhPq7i/8LGKD
         cnP86b8NCN8urnuP2ojgUdnkOLytJMwGVrSs3Rp5ZqjCx+OJDr2iX6bR9VytoWWz39b+
         J/IBNZIBta/QlN/Xir19mHZ05UZLuiWy9NoVByRL9UYOatX6ERlOMwp7Y8Ubo90+OnSE
         +4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443442; x=1691048242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r//0VfNIsSS7LjEKz2w3sxhtDAhJR7x5LJkBswgmGuQ=;
        b=OmGrymshFZCAK5NDYY3SN9Yh0D89B1v7nwVMP6TEWxc5ymdCpgrPVMWRg1ld7V6Pjf
         hqi/3fCpWSXVw/M3twRbIC8bKf+QyK+Rn7EaIPjKX4Crya0zsNS7Rpj96oj5er8fd3MB
         FejwT8HyuYV2uWTQiTTyYVlZmAbOBOoH7wxGAJFQ/Kj73E5gSIfmruNVV6TXEDU0qMYL
         tlDGGtxtd6VnnvdBqOw3mGmkmlt2LSmY1ncUxghyxpSRJts+Py89eFLXTeHZcXBbdFoz
         BpN2cOIb36RB1Xthn/j+OKQvvlhWJ0v0UygrEQjFqt09zJyyVQ6VsfTo0afNhJUE75MX
         5Wjw==
X-Gm-Message-State: ABy/qLZ+pEGF4wdgBlGhGH1M6FK/k29PrWDe1hC3yjNaLzCExUfQDPV/
        cyiFEhtguBzI/RlgZm+RkerSCw==
X-Google-Smtp-Source: APBJJlG4+R4jPSCVEGlR6rgLCmNVhaHd81UbthPsy8RJlP61GxssPJqO3tI7kRrjB9mH7WDD/QMfIA==
X-Received: by 2002:a05:6a21:329d:b0:13a:cfdf:d7a1 with SMTP id yt29-20020a056a21329d00b0013acfdfd7a1mr2311681pzb.2.1690443442119;
        Thu, 27 Jul 2023 00:37:22 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:21 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
Date:   Thu, 27 Jul 2023 15:36:30 +0800
Message-Id: <20230727073632.44983-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 tools/bpf/bpftool/common.c     |  1 +
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 tools/lib/bpf/libbpf.c         |  3 +++
 tools/lib/bpf/libbpf_probes.c  |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..c5c311299c4a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_OOM_POLICY:			return "oom_policy";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..9da0d61cf703 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..10496bb9b3bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
 	[BPF_NETFILTER]			= "netfilter",
+	[BPF_OOM_POLICY]		= "oom_policy",
 };
 
 static const char * const link_type_name[] = {
@@ -204,6 +205,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_OOM_POLICY]		= "oom_policy",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -8738,6 +8740,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("oom_policy",       OOM_POLICY, BPF_OOM_POLICY, SEC_ATTACHABLE_OPT),
 };
 
 static size_t custom_sec_def_cnt;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..dbac3e98a2d7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -129,6 +129,8 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		opts.expected_attach_type = BPF_LIRC_MODE2;
 		break;
+	case BPF_PROG_TYPE_OOM_POLICY:
+		opts.expected_attach_type = BPF_OOM_POLICY;
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_LSM:
 		opts.log_buf = buf;
-- 
2.20.1

