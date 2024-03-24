Return-Path: <linux-kernel+bounces-113024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987788880DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54321281B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE6139562;
	Sun, 24 Mar 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3gQNCL6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD21386B9;
	Sun, 24 Mar 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319835; cv=none; b=U7aiK2DiipgWxWwrss6WtnUttVdhhiDfo7zHlwXlD5yhe7nRaAqSswYI0AbZ/wZFcVqP1Bd18+7PqclKSoUSv5m2G3k/jFEthcVZ4Zcb8MZ+kTqakgp4Fu5U0s5zUkh9ymxTr+5B1tVsGrpUs0mce0QBMV9M/GT3dI6Q94XPC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319835; c=relaxed/simple;
	bh=gZBhs5OFS0aSII4De22PvYT5QM8kh5F/h4/+8pOfbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLQ8FXbwXhFwZZN70OPhYbAZd9h13IQOx6t9iRGxXUgCN1D/+JqZbM6dUyF2Bx2xgT23eiQEaBb5NWgJ+E5KWjFcnR7TkT1UrD+LExmfrNvhsLm8abwo/VIKkEvEZufme933WTkBJaQPM/bikkhX21BL1zvRAoUAssJ/h5kC28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3gQNCL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B0C43399;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319834;
	bh=gZBhs5OFS0aSII4De22PvYT5QM8kh5F/h4/+8pOfbgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3gQNCL6xcTXtpByWjaqIvxd3KNlwUvMkpn5aEx99rLL1QA5kDB54Tm8UjT32KTMI
	 hVjwvbQRpFlrxcTGsimT5zr5fxYJi9Qt9fm7nAf3GfK4sFBA4yfYEyOeuW41jfVSq3
	 bTGdqGNxcYquyBELgjq4n/Zq+p+BRt4qRZsgmf6BzJutLOLHmeuQQ+CFZWvuIjFael
	 lUj1hgRZQYR45Gvi1zQPqjSDY8UB4qRmftI0UXQ0jQ4r0m0jKsyUDLxKLxgVuVWHn6
	 0sj7siUlXXYgRqIRpGPNdOpb01QpfhEGWatB00/KmeotuywbU0Za46QeoEZbux6m2J
	 PhJjirEp+0IYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 137/715] bpf: don't emit warnings intended for global subprogs for static subprogs
Date: Sun, 24 Mar 2024 18:25:16 -0400
Message-ID: <20240324223455.1342824-138-sashal@kernel.org>
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

[ Upstream commit 1eb986746a67952df86eb2c50a36450ef103d01b ]

When btf_prepare_func_args() was generalized to handle both static and
global subprogs, a few warnings/errors that are meant only for global
subprog cases started to be emitted for static subprogs, where they are
sort of expected and irrelavant.

Stop polutting verifier logs with irrelevant scary-looking messages.

Fixes: e26080d0da87 ("bpf: prepare btf_prepare_func_args() for handling static subprogs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240202190529.2374377-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dbe7a590f565a..92aa3cf0396b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7009,6 +7009,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
 	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\n",
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
@@ -7018,6 +7020,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
 	if (!btf_type_is_int(t) && !btf_is_any_enum(t)) {
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log,
 			"Global function %s() doesn't return scalar. Only those are supported.\n",
 			tname);
@@ -7091,6 +7095,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			sub->args[i].arg_type = ARG_ANYTHING;
 			continue;
 		}
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
-- 
2.43.0


