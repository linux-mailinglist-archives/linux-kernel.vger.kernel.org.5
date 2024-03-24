Return-Path: <linux-kernel+bounces-112971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E77888029
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B83E28152C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8F12A178;
	Sun, 24 Mar 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kltgbURj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24F12A163;
	Sun, 24 Mar 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319783; cv=none; b=jdMVUXQar8iXlOTRKFZVbrxmOOicW/kmkf/+o4JEFfVf4G8KYKBwmHq/SZsF7YGFx9UVPd1/Id37NZWqBCkkJj8VPV7GUr9gQKhQAcx/cj4Qa2bwS0ZciNwIuXeH+xJcadibzpUbFW1SWFiZn66lPiZl+0Ch56Jvv5wdTyqQLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319783; c=relaxed/simple;
	bh=S5lSRSEl+8Ri8IPAHVMzY1VhWNuSPB/Hjn9uxUE1cn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxPLAnwK0+iSSsuvL2F5nyLkPnCzxBOfDeByinP53L75n4QRHKpBguPnX5cS+xFkGl7cCNNSsaodfwEwcVDvc/2GMv5Ype5rFOoq5XsyOOarxGnxdPNm3Vpjhyuj9QLiGSs6qwgP8EgVJ4OCfFoN3kgiqMPZPc0ogPPjQvERQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kltgbURj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B33C43390;
	Sun, 24 Mar 2024 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319783;
	bh=S5lSRSEl+8Ri8IPAHVMzY1VhWNuSPB/Hjn9uxUE1cn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kltgbURjUKeboxIP1kBM8O1ZHWmCE/sqLWloRTlDeFhffeJ97j/43s2nTKPyaX1Pf
	 p2McEbfHzcjcwkgIIVeP8ZbCN0KLUphB4LNvchyzgz6nqmVFJJLDiV+BCxvBh2Yd5k
	 FNYE0SlvLlQyefmnVZ0KpSM+vJtLOTv6+0Otm29Wr7yBO5sUAj2SruFjLUXKWr4VKJ
	 B9nbU94c78168yLbr+4Qq1251c1xpGC4pcYzI7MCvDFkE9pD3qVSoVTvCt4jHYcOQz
	 mldvqBV5uYolCM6v7JczMHEblqht45cjJCmu+FAygghJRNPRjMv8RKRUTenGGTVkdW
	 O4PtQLbJxQ05w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Savkov <asavkov@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 084/715] selftests/bpf: Fix potential premature unload in bpf_testmod
Date: Sun, 24 Mar 2024 18:24:23 -0400
Message-ID: <20240324223455.1342824-85-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Artem Savkov <asavkov@redhat.com>

[ Upstream commit d177c1be06ce28aa8c8710ac55be1b5ad3f314c6 ]

It is possible for bpf_kfunc_call_test_release() to be called from
bpf_map_free_deferred() when bpf_testmod is already unloaded and
perf_test_stuct.cnt which it tries to decrease is no longer in memory.
This patch tries to fix the issue by waiting for all references to be
dropped in bpf_testmod_exit().

The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
synchronous grace periods urgently").

Fixes: 65eb006d85a2 ("bpf: Move kernel test kfuncs to bpf_testmod")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev
Link: https://lore.kernel.org/bpf/20240110085737.8895-1-asavkov@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f913..e7c9e1c7fde04 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Facebook */
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/delay.h>
 #include <linux/error-injection.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -544,6 +545,14 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+        /* Need to wait for all references to be dropped because
+         * bpf_kfunc_call_test_release() which currently resides in kernel can
+         * be called after bpf_testmod is unloaded. Once release function is
+         * moved into the module this wait can be removed.
+         */
+	while (refcount_read(&prog_test_struct.cnt) > 1)
+		msleep(20);
+
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
-- 
2.43.0


