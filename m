Return-Path: <linux-kernel+bounces-113036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBAD8880F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0E928131C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F32113DB8D;
	Sun, 24 Mar 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tduXeUpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54313B2AD;
	Sun, 24 Mar 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319846; cv=none; b=ZXD+QfMPnQKdUv/EDC9MyOd7EpPsl++EU1pVgsPthqOwYjFTeKILBgFn5xFFjezimUneRJo/cjsTkDBqxIF6exstnOvj0slh+VRESsNXgKR/RhFYXUawSt4/OkJ+pgiT6q1ue7GCyJ+vfef8YHHAvGcQhtE0rRje8f2h3q9WFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319846; c=relaxed/simple;
	bh=RS261kmGXJYyPUvad40D15vQBBgpG6lBChV7vQ11Syw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoxPIbQ8jOwBA302NCKLz9091A6sSXyjnr58la815u7c+cesq4GvSvLLNrGf7v0wrUq9Igx5iTgSKjNXUkt0q9nW7xeM3ErXHj6acvAzVn6MLxvFPpdRMFC30Stbs4Tp1guye2LlGmJYOH9yXmXXHNL9TJ9V7OggIQNip0CjioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tduXeUpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD6C43390;
	Sun, 24 Mar 2024 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319846;
	bh=RS261kmGXJYyPUvad40D15vQBBgpG6lBChV7vQ11Syw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tduXeUpWfQkM6SaKmZC21L0DyY4e4a2SkBfbTZ/jnN8D25W5ALyQHOkO/3DRHrdXj
	 QR2xYmaxoGLey1MG0OeFX1Swvn5kpuwJiqERidE+QIsRpcTHr1Amkau6beImI1DuLG
	 9YjO4pqemMcwF+NyBSQpPzlwbfTJsjdFwfg+jp3BTXcipdR3Ocn3cmf6gFrj2v31hL
	 kttPJLeukH7rhGRuDc1PFAVDduC39hImrl8nZSxezGOYsvZcl8AO9YmKBG7RWx/kVx
	 FW1uY14YJJuzR1pAviG12vFzkDTxBQId5E8cAQPTpYtWWUfT9Woe4pjvUCciTtF3Fi
	 sPPdhuElMb4Yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 149/715] libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check
Date: Sun, 24 Mar 2024 18:25:28 -0400
Message-ID: <20240324223455.1342824-150-sashal@kernel.org>
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

[ Upstream commit d7bc416aa5cc183691287e8f0b1d5b182a7ce9c3 ]

If PERF_EVENT program has __arg_ctx argument with matching
architecture-specific pt_regs/user_pt_regs/user_regs_struct pointer
type, libbpf should still perform type rewrite for old kernels, but not
emit the warning. Fix copy/paste from kernel code where 0 is meant to
signify "no error" condition. For libbpf we need to return "true" to
proceed with type rewrite (which for PERF_EVENT program will be
a canonical `struct bpf_perf_event_data *` type).

Fixes: 9eea8fafe33e ("libbpf: fix __arg_ctx type enforcement for perf_event programs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240206002243.1439450-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 910f72c9e6a49..92bca96587a4a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6755,13 +6755,13 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
 	case BPF_PROG_TYPE_PERF_EVENT:
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
 		    btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
-			return 0;
+			return true;
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs) &&
 		    btf_is_struct(t) && strcmp(tname, "user_pt_regs") == 0)
-			return 0;
+			return true;
 		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
 		    btf_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
-			return 0;
+			return true;
 		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
-- 
2.43.0


