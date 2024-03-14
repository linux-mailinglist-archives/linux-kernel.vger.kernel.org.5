Return-Path: <linux-kernel+bounces-103635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E887C239
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26FD2837D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5074BF2;
	Thu, 14 Mar 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ0dkRqX"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87841C6D;
	Thu, 14 Mar 2024 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438579; cv=none; b=XPslvN4Fn+SLgTBGtC++/+mXE/WfELJnYLL/KiO4f0xkWOZhDEVRCRDLxBtZwd1miyXeUEfgNSZw8or1qstpMw4y7+1q/YF5dClVOJT+gCz0rE0VGkNzUAAq+3dFAuvUvTNiLChSl4GTyv5HQ6pFtE9phOPDvi7zn1yR/1/p7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438579; c=relaxed/simple;
	bh=mM+v1kmQ3/Nx0Xb+0QIWcpLvojmmSfnlNtCYXhBw2WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cq8ryi8Hg+22FoMmKB10RhSBAjTSXIfI+Y+Ux/Kik+ekboNDcmf83GDH/15FT79KmH/4NtDRRv6N+itgGIqoI2+XkTkIlPSM9LeM9gp/N8aLKiC+yBGNrtrFJYPy2FCNplNHsctfJruhC5IYzLJhUg+VtGy5Ptkd+kHv2XMpwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ0dkRqX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413feb4d7b4so859075e9.3;
        Thu, 14 Mar 2024 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710438576; x=1711043376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sTrFM/7u+qguknxAtmm7g0jvXeK16BxRSJMHNHbRBI=;
        b=UQ0dkRqXxVUtrBFJ1J6W21YGErNR2Gz43drOmf9JTE73LGDfIOC2AyTogtj1kR8OkZ
         qcgCH01Fyuxm71bt2/8p2XmM+hbP03EG4PZk+BYhk0NmXkEqSwsq7tsHPCLzZbY6Nbun
         S7P+fJwtyizzn3U9DzZkH2M/6Yua80Jg/lTS5+uNNH4Lekb4KCK2B7ZiujfaBfmmzA0m
         /N3VS56v4MmHDxA1NgVU4iBE/IrIu23bkgD17LSbGirhDOE/lT075m8GRjGhUhTMr2EF
         VhtGp/+3J66N9Vej4cxx0ng6pNkTXQI6CVVulzq1/2OpJUwxpaZg2hx72191G8tehwnO
         JdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438576; x=1711043376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sTrFM/7u+qguknxAtmm7g0jvXeK16BxRSJMHNHbRBI=;
        b=auCepSmUJ+CbKsOuY/qzaw0/5G5hVPaCs3w8hS1szEtL3w5ZlayK3wUMqmk0x6EV5D
         uP9GmKJiCg7Khz10ZMfa6JwFeulyEdSKhA7GTPQUlZDzs3yXU5/+S5xPij9jMoYBV/0H
         tH6VSChCFmRFtetqPekjEQJK0/+K7u29Yyp2LqxRRd/P4wme/a/mH4jA0pcZOYMLQGdG
         gegF8Lq7sb24QzIhnl5IUmtRNN2M4VapF6XrjBbqLPkpODaR9ejs/k/KS5ICkuvTzgUD
         FxM6eouEjVU5h8eZi0fMGC/wQhAhR6k4CWWQCCqhrH2Nvf1sEXLh+oeK/+0hqlxD2O+6
         ULxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0J8kq3uE1G4Pdb5sU32c9bBX6jzeJ3mcjI9X63yH9ctJjkOkL7FSP/DSRE6yjFckKCXPlnX6N2qD4IbbxcGJNfoBGdBiIigNXzfVJtJHCql1t7TxMfvKu1QZfCxhD9wl3
X-Gm-Message-State: AOJu0YzasF3g/nq9DzDuhr2Y8l574RHEQgtHZiKIFaBRnIj/I8zgoqp/
	u9FNWY+lYXLPC+zwrDBnrPmgapjm/fO4S5uriV0sS3r3xa4nRYhD
X-Google-Smtp-Source: AGHT+IFwDo2oxGv3fi6pQfCDt86GQFWWZq1JkZ63g8IYl12nLb24vmG4t5kqzxFgYmIluoYNvJBPXw==
X-Received: by 2002:a05:600c:358a:b0:413:1872:6ad7 with SMTP id p10-20020a05600c358a00b0041318726ad7mr576116wmq.29.1710438575901;
        Thu, 14 Mar 2024 10:49:35 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00413e6465413sm6199472wmq.27.2024.03.14.10.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:49:35 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] bpf: Temporarily disable atomic operations in BPF arena
Date: Thu, 14 Mar 2024 17:49:31 +0000
Message-Id: <20240314174931.98702-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the x86 JIT handling PROBE_MEM32 tagged accesses is not
equipped to handle atomic accesses into PTR_TO_ARENA, as no PROBE_MEM32
tagging is performed and no handling is enabled for them.

This will lead to unsafety as the offset into arena will dereferenced
directly without turning it into a base + offset access into the arena
region.

Since the changes to the x86 JIT will be fairly involved, for now,
temporarily disallow use of PTR_TO_ARENA as the destination operand for
atomics until support is added to the JIT backend.

Fixes: 2fe99eb0ccf2 ("bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63749ad5ac6b..1dd3b99d1bb9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5682,6 +5682,13 @@ static bool is_flow_key_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_FLOW_KEYS;
 }
 
+static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
+{
+	const struct bpf_reg_state *reg = reg_state(env, regno);
+
+	return reg->type == PTR_TO_ARENA;
+}
+
 static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #ifdef CONFIG_NET
 	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
@@ -7019,7 +7026,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (is_ctx_reg(env, insn->dst_reg) ||
 	    is_pkt_reg(env, insn->dst_reg) ||
 	    is_flow_key_reg(env, insn->dst_reg) ||
-	    is_sk_reg(env, insn->dst_reg)) {
+	    is_sk_reg(env, insn->dst_reg) ||
+	    is_arena_reg(env, insn->dst_reg)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
-- 
2.40.1


