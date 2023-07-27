Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E506764916
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjG0HoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjG0Hnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6E6A67
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3373211a1so583781b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443451; x=1691048251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GeXvqoGvKsq4eXzt40D65FoTpyg+BIztu+fO5t6OCk=;
        b=dB2YLL1oG+E1Gu38lWcd1QP/sEw5hL8k3plmGS+U5Al3NgCvB7aFDUnC/qLQqQvAyh
         kqM/U2FAMGOjzP7vlJ9n8P/SZJBYH4bfLW1EvEcQ8MCmw9uS6Hw3GeRrODYe0L60MU+f
         YwmG9B/u7gii5/6i9CQRybNJCrNZSbgvV6gFZSnnm/ALyvFAo1eRCOpOrG5Uf3Y0sXmh
         2I3HOZMpRa4VcT9RhhSZBKD/SwgNZyOHYpzTl1svA95LuQvNwJAifna4peCdWQqysLF3
         X77a4V5GbW5Mh0b4YJ/zyr4l1aEKHsoaGgzHv09uKleh4kLjbrbougScHwlnxloBfpmd
         EACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443451; x=1691048251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GeXvqoGvKsq4eXzt40D65FoTpyg+BIztu+fO5t6OCk=;
        b=AJ0+h33SL2TSPHTqxbcx8mfNGMOkXE8mu7conpJ7QkYwP7a/ZSV5pgg1nbvAwwtvw+
         +a9OBUI5FOIYgr4bO2dXqEXw3lmoxCqW5NLDIAK8/7cFKG+PjY9KFMQS41z1dzuR63b2
         PTbF+7OD9P17EfXy1DeeMuLjHNS5Fo6+RvU+u6hZQL6wBT1rqy9DcEBG6wAebIuLB0Pd
         SJZboSnXwArMWG26LdiK10IA/Pgz0+Hz9xHvTGndF1b/f/YbJXgbiBnJ+kAkb3S1Mwjc
         JfscHierso2GnSl8P+9IK5rUr+JHH4FEoCodGS1RDepXY4Fq+yXvYjLWvTskTh0ToRjO
         CaSA==
X-Gm-Message-State: ABy/qLY5+dndp+AxpL3E1hEY/Z+BzoVMX6AlL5mT27JL+ParoY96a6az
        DT+haiiuq1U95vSOIgGg7NtPuQ==
X-Google-Smtp-Source: APBJJlEbdWM9h+ozFiIR+UT3VqWYJ9e/huCVjkTvSArCpkIMxLuORDHlL2TxsP9+6Q1hh5HBiDtCJQ==
X-Received: by 2002:aca:1a16:0:b0:3a1:acef:7e2c with SMTP id a22-20020aca1a16000000b003a1acef7e2cmr1775792oia.58.1690443451584;
        Thu, 27 Jul 2023 00:37:31 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:31 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 5/5] bpf: Sample BPF program to set oom policy
Date:   Thu, 27 Jul 2023 15:36:32 +0800
Message-Id: <20230727073632.44983-6-zhouchuyi@bytedance.com>
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

This patch adds a sample showing how to set a OOM victim selection policy
to protect certain cgroups.

The BPF program, oom_kern.c, compares the score of two sibling memcg and
selects the larger one. The userspace program oom_user.c maintains a score
map by using cgroup inode number as the keys and the scores as the values.
Users can set lower score for some cgroups compared to their siblings to
avoid being selected.

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 samples/bpf/Makefile   |   3 +
 samples/bpf/oom_kern.c |  42 ++++++++++++++
 samples/bpf/oom_user.c | 128 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 samples/bpf/oom_kern.c
 create mode 100644 samples/bpf/oom_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..09dbdec22dad 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -56,6 +56,7 @@ tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
+tprogs-y += oom
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -118,6 +119,7 @@ xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
+oom-objs := oom_user.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -173,6 +175,7 @@ always-y += xdp_sample_pkts_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += oom_kern.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/oom_kern.c b/samples/bpf/oom_kern.c
new file mode 100644
index 000000000000..1e0e2de1e06e
--- /dev/null
+++ b/samples/bpf/oom_kern.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <uapi/linux/bpf.h>
+#include <linux/version.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1024);
+	__type(key, u64);
+	__type(value, u32);
+} sc_map SEC(".maps");
+
+SEC("oom_policy")
+int bpf_prog1(struct bpf_oom_ctx *ctx)
+{
+	u64 cg_ino_1, cg_ino_2;
+	u32 cs_1, sc_2;
+	u32 *value;
+
+	cs_1 = sc_2 = 250;
+	cg_ino_1 = bpf_get_ino_from_cgroup_id(ctx->cg_id_1);
+	cg_ino_2 = bpf_get_ino_from_cgroup_id(ctx->cg_id_2);
+
+	value = bpf_map_lookup_elem(&sc_map, &cg_ino_1);
+	if (value)
+		cs_1 = *value;
+
+	value = bpf_map_lookup_elem(&sc_map, &cg_ino_2);
+	if (value)
+		sc_2 = *value;
+
+	if (cs_1 > sc_2)
+		ctx->cmp_ret = BPF_OOM_CMP_GREATER;
+	else if (cs_1 < sc_2)
+		ctx->cmp_ret = BPF_OOM_CMP_LESS;
+	else
+		ctx->cmp_ret = BPF_OOM_CMP_EQUAL;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/oom_user.c b/samples/bpf/oom_user.c
new file mode 100644
index 000000000000..7bd2d56ba910
--- /dev/null
+++ b/samples/bpf/oom_user.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include "trace_helpers.h"
+
+static int map_fd, prog_fd;
+
+static unsigned long long get_cgroup_inode(const char *path)
+{
+	unsigned long long inode;
+	struct stat file_stat;
+	int fd, ret;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	ret = fstat(fd, &file_stat);
+	if (ret < 0)
+		return 0;
+
+	inode = file_stat.st_ino;
+	close(fd);
+	return inode;
+}
+
+static int set_cgroup_oom_score(const char *cg_path, int score)
+{
+	unsigned long long ino = get_cgroup_inode(cg_path);
+
+	if (!ino) {
+		fprintf(stderr, "ERROR: get inode for %s failed\n", cg_path);
+		return 1;
+	}
+	if (bpf_map_update_elem(map_fd, &ino, &score, BPF_ANY)) {
+		fprintf(stderr, "ERROR: update map failed\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * A simple sample of prefer select /root/blue/instance_1 as victim memcg
+ * and protect /root/blue/instance_2
+ *           root
+ *       /         \
+ *     user ...    blue
+ *     /  \        /     \
+ *     ..     instance_1  instance_2
+ */
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
+	int target_fd = 0;
+	unsigned int prog_cnt;
+
+	obj = bpf_object__open_file("oom_kern.o", NULL);
+	if (libbpf_get_error(obj)) {
+		fprintf(stderr, "ERROR: opening BPF object file failed\n");
+		obj = NULL;
+		goto cleanup;
+	}
+
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_OOM_POLICY);
+	/* load BPF program */
+	if (bpf_object__load(obj)) {
+		fprintf(stderr, "ERROR: loading BPF object file failed\n");
+		goto cleanup;
+	}
+
+	map_fd = bpf_object__find_map_fd_by_name(obj, "sc_map");
+
+	if (map_fd < 0) {
+		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
+		goto cleanup;
+	}
+
+    /*
+     *  In this sample, default score is 250 (see oom_kern.c).
+     *  set high score for /blue and /blue/instance_1,
+     *  so when global oom happened, /blue/instance_1 would
+     *  be chosed as victim memcg
+     */
+	if (set_cgroup_oom_score("/sys/fs/cgroup/blue/", 500)) {
+		fprintf(stderr, "ERROR: set score for /blue failed\n");
+		goto cleanup;
+	}
+	if (set_cgroup_oom_score("/sys/fs/cgroup/blue/instance_1", 500)) {
+		fprintf(stderr, "ERROR: set score for /blue/instance_2 failed\n");
+		goto cleanup;
+	}
+
+	/* set low score to protect /blue/instance_2 */
+	if (set_cgroup_oom_score("/sys/fs/cgroup/blue/instance_2", 100)) {
+		fprintf(stderr, "ERROR: set score for /blue/instance_1 failed\n");
+		goto cleanup;
+	}
+
+	prog_fd = bpf_program__fd(prog);
+
+	/* Attach bpf program */
+	if (bpf_prog_attach(prog_fd, target_fd, BPF_OOM_POLICY, 0)) {
+		fprintf(stderr, "Failed to attach BPF_OOM_POLICY program");
+		goto cleanup;
+	}
+	if (bpf_prog_query(target_fd, BPF_OOM_POLICY, 0, NULL, NULL, &prog_cnt)) {
+		fprintf(stderr, "Failed to query attached programs\n");
+		goto cleanup;
+	}
+	printf("prog_cnt: %d\n", prog_cnt);
+
+cleanup:
+	bpf_object__close(obj);
+	return 0;
+}
-- 
2.20.1

