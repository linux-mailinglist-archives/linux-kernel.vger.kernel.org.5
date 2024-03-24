Return-Path: <linux-kernel+bounces-114111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8835A88887A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EB11C273D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71B23CB6F;
	Sun, 24 Mar 2024 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ3BkXPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEA1E7DFA;
	Sun, 24 Mar 2024 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321413; cv=none; b=Mi87vYeqs6JFSWw0oItQb3XcpkzveHIFXXXbH1rl58GWM1Qo43lGNwolJfSgu53n8vkVLQHTOKAOYCeIMcR2HGxqVT+fQjVlYPxqdXv9UVfnHtYCfKoCF3X1R6mcjdwmk6h/Ob/qEX8AkWJLnJ4R+xYj4BMH+t7qY3WwP1Rk+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321413; c=relaxed/simple;
	bh=7Dr+Ll8d67dEAoULtrMbU5o/YUvZsxpqU78n5IU0YrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSvjKIqQkTmnD14p/IJoMKE+xZrzVF9H1TiusfszE6HFoInv/gDrvR8D1Lo31PVDHeLh3LnjApSY7Sa2GTwSpCLU8No3ysy0pxfnzJ2XfwXDRN0nQy3pN3koqnlVmBvOWqCxL9FbZ55PvH4MyX9BKY9Sw0w0HH/T85tgfKM0FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ3BkXPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612C1C43399;
	Sun, 24 Mar 2024 23:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321413;
	bh=7Dr+Ll8d67dEAoULtrMbU5o/YUvZsxpqU78n5IU0YrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZ3BkXPiVBINi0l9xy5yw4jx4bqywDYOFn5KBWh9lvsIy08kpRTWXrYXYBmZd5zre
	 8zgL1WqgCCaMgFJLR4UAJBnSTLEqsq1vIJbNrQiq72OQ6Zt3i2GOp9ctyMnXzZLhMM
	 PTP6EfCWSkYqX1uk+0Y1EdUHfIqRQjPpcDtS8mEaXBqE1nmQmGEi+H6HTpDf2ATOgg
	 VtwL2/UR01rAzLAvVfmY3xtLPw3cKIYtNlok78gg/mGVWONSb41uCmGpe5CAduN+aD
	 TAJFdaxGzQlxbXT5acvyu3iz0M8Fhzjt0bcCdBFzOzJBzH3oAmkCQukXU6BMH9se6K
	 r+U0iRf7D2X6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Savkov <asavkov@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 137/638] selftests/bpf: Fix potential premature unload in bpf_testmod
Date: Sun, 24 Mar 2024 18:52:54 -0400
Message-ID: <20240324230116.1348576-138-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index cefc5dd72573c..2e8adf059fa3b 100644
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
@@ -541,6 +542,14 @@ static int bpf_testmod_init(void)
 
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


