Return-Path: <linux-kernel+bounces-113008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF2D8880BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF91C21199
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AA131759;
	Sun, 24 Mar 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZunQo7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F013172A;
	Sun, 24 Mar 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319819; cv=none; b=gc8JcvbeqemEfhT3pPnvSvnMdnlH3jsrGLQPeJcJvb2RXyXLMLmi4AD9QrD2Uu2X9V68Xjx2BucQpJOpIvsRoKGsvjwpA6Y8lZ/rEnANIViVy2vvkPSNYX/UJ5VUTzo4sHw0iTwxYoBTf/Bn5AFRh6I9T98UI0VT0VB9795mAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319819; c=relaxed/simple;
	bh=ub5gTDg45u7ZTcHGkS5iJFn3fIXQKswUIcupG71O8js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs90tazKUNNiyISn4PdZQKusWu7yQINdYYYHkQ7CjGCRisiyqlXZX+7Hu8LX39nvxQpkvHke2AgRlbQNuZ3bjYhHDyKS+hXHQuW+9maUgLGZ5Q4Y6mIKcqPU6J5kf8CL9zSu8nI8o3ybgjKjZ2sdlbZwM3T4jrM0xHLUMM0a7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZunQo7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBADC433F1;
	Sun, 24 Mar 2024 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319819;
	bh=ub5gTDg45u7ZTcHGkS5iJFn3fIXQKswUIcupG71O8js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZunQo7ETtp8cYDeJ2Pa5JpKbidqe414BYoHJbwXOV3c+m5IOPpYWlbNY3A5cjLDI
	 kOXGBgAjLo0Usnt7wVP0iVDcdNjzSWJJbyGVWyl9LZmW12jrFyX1gh/umMJiYskG8L
	 0+9AcAx3APKGek+Iku6/BUKslDHTwWTDtpS1jRHfgwtme2EoSrA/nPjVNkJa6onCE4
	 nPmfA8WFYtE8oJqB3SFYaRZeZTL5PQSKG7OENClxnv23nN5Yh/rYFc61jkgQnIWjHy
	 mjmME/pPn8hDZao3PzV5LU9EhpkJ+NIRmAjbdmMowtw8Vo8hSXDk2hhPGBzY8gFjMv
	 GjzkMmq87qUGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 121/715] libbpf: Add missed btf_ext__raw_data() API
Date: Sun, 24 Mar 2024 18:25:00 -0400
Message-ID: <20240324223455.1342824-122-sashal@kernel.org>
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

[ Upstream commit b9551da8cf3ade01a50316df8a618fd945723ee0 ]

Another API that was declared in libbpf.map but actual implementation
was missing. btf_ext__get_raw_data() was intended as a discouraged alias
to consistently-named btf_ext__raw_data(), so make this an actuality.

Fixes: 20eccf29e297 ("libbpf: hide and discourage inconsistently named getters")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240201172027.604869-5-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf.c      | 6 +++++-
 tools/lib/bpf/libbpf.map | 2 +-
 tools/lib/bpf/linker.c   | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b61bc5d1009b7..119d45eadb2ed 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3044,12 +3044,16 @@ struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 	return btf_ext;
 }
 
-const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size)
+const void *btf_ext__raw_data(const struct btf_ext *btf_ext, __u32 *size)
 {
 	*size = btf_ext->data_size;
 	return btf_ext->data;
 }
 
+__attribute__((alias("btf_ext__raw_data")))
+const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext, __u32 *size);
+
+
 struct btf_dedup;
 
 static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 386964f572a8f..86804fd90dd1a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -325,7 +325,6 @@ LIBBPF_0.7.0 {
 		bpf_xdp_detach;
 		bpf_xdp_query;
 		bpf_xdp_query_id;
-		btf_ext__raw_data;
 		libbpf_probe_bpf_helper;
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
@@ -413,4 +412,5 @@ LIBBPF_1.4.0 {
 	global:
 		bpf_token_create;
 		btf__new_split;
+		btf_ext__raw_data;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 16bca56002ab3..0d4be829551b5 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2732,7 +2732,7 @@ static int finalize_btf(struct bpf_linker *linker)
 
 	/* Emit .BTF.ext section */
 	if (linker->btf_ext) {
-		raw_data = btf_ext__get_raw_data(linker->btf_ext, &raw_sz);
+		raw_data = btf_ext__raw_data(linker->btf_ext, &raw_sz);
 		if (!raw_data)
 			return -ENOMEM;
 
-- 
2.43.0


