Return-Path: <linux-kernel+bounces-115358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CE8893B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E2D1C2E891
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2D15443C;
	Mon, 25 Mar 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC/aEY8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F570182DF;
	Sun, 24 Mar 2024 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320595; cv=none; b=Z0XgMTMBvuVrgTxb5QIAIYlu+gQlKmWAomASOeUjj9uz92gdLtaj/aBnYn1mOFZWqsDflXk8J8Cpa6ojYPqBQt6BqKTzoTrGelSLmZC/+SbGJYuM9OcFbmUEIWc6VaO49wjzX373EDt6jVEWU2V1j3pzH6BDHB3AM+g3CHIsFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320595; c=relaxed/simple;
	bh=S5lSRSEl+8Ri8IPAHVMzY1VhWNuSPB/Hjn9uxUE1cn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlyCmn4ED1CqR3eK19F0NG2dq/c68OHwZEi1hEMpuGFrrdSYF7+lPAUGGXNbysTNvQ/9WnAn5IeCPev/UIiRxXX7vlROTl402DCPoDME3QTIi7eyukwN6h/ZgCzvBYtbUluUXOSeYCfeHChF7/NUZg0WiNKP1Goii81Zi4c//O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC/aEY8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B00C43394;
	Sun, 24 Mar 2024 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320594;
	bh=S5lSRSEl+8Ri8IPAHVMzY1VhWNuSPB/Hjn9uxUE1cn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC/aEY8lSdrnpIP6cLq6i5HyxjezaskAUcdwH0QV2FJ8nu7sd1rkFLL3P9tafVVnn
	 Vw4yDBiQJ7Bz51YuoMEWO8eHAioqqX3XmqRqlLzrVzhvmnMkAx40oDLKFDH+MoJS7h
	 jzoYVMu/9rElf15lM5j7by4E2+G77SeiwZTt8Ilqy9jb5WpplbCR/8Uf9HjryolwKA
	 BZ3UYIxO7AQf70iwsot/OXf8GBKFBy7dIo+JjfAhEXAvY8MPzkCtpEiQDeE9UwTwQd
	 8GPsFdmukaU0uwIUyIA55woGDJ/+I5u+7vTy1rBOvyOxfamS7INb5NJHgAwOKNCIVx
	 EQYmmlVoFUTVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Savkov <asavkov@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 155/713] selftests/bpf: Fix potential premature unload in bpf_testmod
Date: Sun, 24 Mar 2024 18:38:01 -0400
Message-ID: <20240324224720.1345309-156-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


