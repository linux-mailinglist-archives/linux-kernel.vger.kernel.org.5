Return-Path: <linux-kernel+bounces-113006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C58880B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A962814B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECC130E40;
	Sun, 24 Mar 2024 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwUts/lI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F996130E23;
	Sun, 24 Mar 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319817; cv=none; b=LK3DRhayfdW555tto1wRYXNdUNlxbsAN6KbudqPWOOZ1Jghd9xb6UdsEzR7SjbG8qaXIUfaEFqQ3LVJHKBJmHPqwH/fJsP844rQxmPwMbJwpfOMp+cvXz16EzFuWME1rOQDH2BG6Y+EsvVpIU1QsW0tI3FSaOAEF1UV3mN/RHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319817; c=relaxed/simple;
	bh=x7MBC1LnLVlN1SIxN2lBwTgv8V2dAtUZ48xMLpKIpCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6iz7qOL7CBvwJs0mx3V2WEBLrOu0DDUqKBg6sV9nAX9CO/4dlBDbcR65iqvIFSgzgqSlBZ/nomWklzKuK0mmvbNJMZwt9Q7Q4wirLL/qlQMdmzVGXSuVVeso5EwA5t2TeZ8eoo8AxWIpWBEJDHAIT4yieeTevCpmLHvBDpcFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwUts/lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A0BC433C7;
	Sun, 24 Mar 2024 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319817;
	bh=x7MBC1LnLVlN1SIxN2lBwTgv8V2dAtUZ48xMLpKIpCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwUts/lIzI39a3Xe94iyzK0k6CmFD5m1XOs9MSZJnYDdUsFP9MEky+MQeGG+qHJJU
	 /K87vyTyfzsAUqT0uBeiwtdqIjk7q2bYcQxGu7jqOkGyFcYJiJRhbvc6Kq9HL9utIR
	 TlVP+iF9uv2vIoah5np75npC6XDcDJ4/osGipt8XKz4MCYkw8E8ZdhUT0svbkkQ5G3
	 tFv8ux8q4FQemNIg9Eui7oJDxdvBi4EOmh6kzgDUQrw/ghN5+nyOBuFT9F9b4pVQYF
	 0HxD2E2UyUHOXG1G/tmFHZTsEYiN8sMFVzqnjtdkAEokp3FlxNv1YcjaBFRI1oXm1I
	 FZZwuNSfqgazA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 119/715] libbpf: Add bpf_token_create() API
Date: Sun, 24 Mar 2024 18:24:58 -0400
Message-ID: <20240324223455.1342824-120-sashal@kernel.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 639ecd7d6247c48a0175f5b458b648f5d4b6dc34 ]

Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20240124022127.2379740-13-andrii@kernel.org
Stable-dep-of: c81a8ab196b5 ("libbpf: Add btf__new_split() API that was declared but not implemented")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
 tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 42 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dcf..d4019928a8646 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1287,3 +1287,20 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_token_create_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.token_create.bpffs_fd = bpffs_fd;
+	attr.token_create.flags = OPTS_GET(opts, flags, 0);
+
+	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index dad7917903d19..02b0810c8dece 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -640,6 +640,30 @@ struct bpf_test_run_opts {
 LIBBPF_API int bpf_prog_test_run_opts(int prog_fd,
 				      struct bpf_test_run_opts *opts);
 
+struct bpf_token_create_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_token_create_opts__last_field flags
+
+/**
+ * @brief **bpf_token_create()** creates a new instance of BPF token derived
+ * from specified BPF FS mount point.
+ *
+ * BPF token created with this API can be passed to bpf() syscall for
+ * commands like BPF_PROG_LOAD, BPF_MAP_CREATE, etc.
+ *
+ * @param bpffs_fd FD for BPF FS instance from which to derive a BPF token
+ * instance.
+ * @param opts optional BPF token creation options, can be NULL
+ *
+ * @return BPF token FD > 0, on success; negative error code, otherwise (errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_token_create(int bpffs_fd,
+				struct bpf_token_create_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 91c5aef7dae7d..d9e1f57534fa7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,4 +411,5 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+		bpf_token_create;
 } LIBBPF_1.3.0;
-- 
2.43.0


