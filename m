Return-Path: <linux-kernel+bounces-113023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0368880D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBE31C204DB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428E1386AD;
	Sun, 24 Mar 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLtzu5Y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6D1384AB;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319834; cv=none; b=OszU8U5myae8IcmvaB+f8OTDnLtSM8q9cjp2XCRADr74y8lMngu+H5+EwGLChVxGsM8kMRvThXqrLPMNMUqIRgTa/AVPvKteOVwre12HkH13TWsUhs8K2Y4WRFchecU6PFX96cuNrtVM9qDi/aQO1n6kahNr9tElXcNQC427SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319834; c=relaxed/simple;
	bh=suxZku+fuSyERt5pEGR0WhhSb5rTWiSWM7+czOYqsSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRqzSyNnCk7Y+jjlUp1mllx4bGE6XMTuyXliwlU2PK+Euxdruthy1/LUQsJ3GTtVpofeRQOWQjE1fWaiRxK5osPudAJ8vbNja/2ydt33vRoD4bXvAXKRrJ8EozqOLZeQBpiGmdohUxSr7rGwtieJcEj7UbO47KfBcYUhpA17Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLtzu5Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16541C433A6;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319833;
	bh=suxZku+fuSyERt5pEGR0WhhSb5rTWiSWM7+czOYqsSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLtzu5Y4qhA97ExDx+hkGQWitIHvExMBwl6leRxRqSpaaPROM3SwGYtjcqSvoU0H1
	 ZVUZpmQ42BUTHwY5KXg8Kdslrhb6Zfc4/YM7QrC8GVmNYJGZyKlQpXgzGmSgWcTAap
	 GpphYLzLSY8cJ7bzuqCi9j6Mb7kQttVRj19579BY3i+4l9Vck5xzHlS02gSGjCHzAD
	 Sdkn0s8PRYaTNmmte3ks+O5/Dvujj9hwgT2mWIDXzJAsm9BNHvnEXpWWgRFhr5mowC
	 62zIg7KJ46/P3Vz9VYIBPn9NDMbO5JYl5RX2c77FdE2k+N+p/0bGNof0LwNcpbVVX5
	 wRu7Dr73T2TcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 136/715] bpf: make sure scalar args don't accept __arg_nonnull tag
Date: Sun, 24 Mar 2024 18:25:15 -0400
Message-ID: <20240324223455.1342824-137-sashal@kernel.org>
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

[ Upstream commit 18810ad3929ff6b5d8e67e3adc40d690bd780fd6 ]

Move scalar arg processing in btf_prepare_func_args() after all pointer
arg processing is done. This makes it easier to do validation. One
example of unintended behavior right now is ability to specify
__arg_nonnull for integer/enum arguments. This patch fixes this.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240105000909.2818934-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 1eb986746a67 ("bpf: don't emit warnings intended for global subprogs for static subprogs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5964711891767..dbe7a590f565a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7058,10 +7058,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 
 		while (btf_type_is_modifier(t))
 			t = btf_type_by_id(btf, t->type);
-		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type = ARG_ANYTHING;
-			continue;
-		}
 		if (btf_type_is_ptr(t) && btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
 			sub->args[i].arg_type = ARG_PTR_TO_CTX;
 			continue;
@@ -7091,6 +7087,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			bpf_log(log, "arg#%d marked as non-null, but is not a pointer type\n", i);
 			return -EINVAL;
 		}
+		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
+			sub->args[i].arg_type = ARG_ANYTHING;
+			continue;
+		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
-- 
2.43.0


