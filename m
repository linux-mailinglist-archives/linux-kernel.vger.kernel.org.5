Return-Path: <linux-kernel+bounces-115277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F0889C97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB41F361EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886115B542;
	Mon, 25 Mar 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzXw+NfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC127EF0F;
	Sun, 24 Mar 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320471; cv=none; b=VFRG/V5RZP0q7M05+0yGdaxBI8/4pN4t9eYautJR9eI7tk2pTsYcCm3j6ry+RQVeJcJZmFx0uozdD7Wf1wF1LvKr2D9SveYd+ytj5kXaKvoOez+R0gxUFfAPKHUmrrkE5zieou1atsIYL5WvN6XrviotVURxPSkOGOLGk3eDGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320471; c=relaxed/simple;
	bh=H02y0RGDOkwRPBjwHsYqNibSOi4L7LTOH0o83ixsYvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/WIH8bmwkKhd/yDF1pphkb/xTS7ea6ecIgHbRSGbQ9sBjMhnBqKV2s9qwj56fyzvqdFHHgbMQkcoqm9V//spxjtfiuaVjb9E0jeJ9JkoCgPzUFE55pm84FmPQ1mMdiyjjaNDctmkRWyYEaue9ynk1IJZr2sJ/RlqZQoTJD/Q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzXw+NfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F98C433F1;
	Sun, 24 Mar 2024 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320471;
	bh=H02y0RGDOkwRPBjwHsYqNibSOi4L7LTOH0o83ixsYvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzXw+NfYXtEAMTtVt+zD+5bJmC41KC3IbV2R7xdY3xOof0IXuqrXmJWHNNuy7VMYT
	 KsieYObx8s1cWTXFq4+5MXWOEmF5wbuGOqdCh7fHk44iZDTQlCRN+Zuy1fuhFpNTfH
	 0f04VDSdU5Yq8IKTlKjvJ0OW7AbacANkidS4lQ2blzebnMcszBUNxRX0mUbZ98Mj3t
	 DrThSXY467M+NDK1QD8dGO5/olHTUBKNBOJlE8fzqAE17hyqmf1l7NGWONm1/Ux7RC
	 B05gEl37wVZMRj/9zQ2JTly7DnKrWNQQAMZciQiULKAt+risgJiXSf27XBMHPTPRbK
	 lsqIKKtVqdbRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	David Vernet <void@manifault.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 030/713] bpf: Fix warning for bpf_cpumask in verifier
Date: Sun, 24 Mar 2024 18:35:56 -0400
Message-ID: <20240324224720.1345309-31-sashal@kernel.org>
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

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 11f522256e9043b0fcd2f994278645d3e201d20c ]

Compiling with CONFIG_BPF_SYSCALL & !CONFIG_BPF_JIT throws the below
warning:

  "WARN: resolve_btfids: unresolved symbol bpf_cpumask"

Fix it by adding the appropriate #ifdef.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: David Vernet <void@manifault.com>
Link: https://lore.kernel.org/bpf/20240208100115.602172-1-hbathini@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9698e93d48c6e..890d4c4bf9972 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5445,7 +5445,9 @@ BTF_ID(struct, prog_test_ref_kfunc)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 #endif
+#ifdef CONFIG_BPF_JIT
 BTF_ID(struct, bpf_cpumask)
+#endif
 BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
 
-- 
2.43.0


