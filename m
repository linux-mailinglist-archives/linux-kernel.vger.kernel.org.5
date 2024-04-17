Return-Path: <linux-kernel+bounces-149316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACA8A8F77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7061A1C20EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAF174EFB;
	Wed, 17 Apr 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDBpgtUN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D317332B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396966; cv=none; b=P4OZ2paNmiWFnaa5zYRbkAIC4CXOplGMsPzOYqJVg3SHvjCalcLT572LNt1RiSb58pMmfPA04mU7evPj2ticDvdzGHquAwlt/AkHPMxlJUKYNwcvX0kLkWmC+9IHpz52DkH1vcEy4ZSGi8UtxJYHjQg+VTLaGvbui42HNuDkmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396966; c=relaxed/simple;
	bh=V+M9lbNEUJleZ9jwUj7p1bm9mHKZtXda0Ha0YPTtYcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dcSQu0Zz14AfnpZuoVXuGgC7BVAcZiEVApf1MbUu17S38DxFzLaMqumvU37MtmoIdmeNDPuV2evOh6jgjIxdU3c9slPIkfo9LUEOKbRphwfqy9RMbQ5LMrmffG+bi0IHrSDxnEr1f1RHsqiagg0zlI2NRJQVSaiLdeCzBz3ZoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDBpgtUN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a72c717f84so407854a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713396964; x=1714001764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZPFdLERqgua7X2DfAhhcOttdh95F/zSosGx8JeMCe0=;
        b=CDBpgtUNZOLC4ppwGbusNUjA6q1nTccE0RFT64EpNs79jtxg0IkUYybF66IOCb08L0
         gioDza+pR51wHoVzeYR17g61jvDYYXg7ixc9yfmk6gqOvL6n9DkxYf+zG5rqjFkSq/fF
         1W3e4wYWVfd31ZEcjwDNoIsefyTmAPws39wOgQBfUVTibjBtUzokfFxxjp7ZDTnizjXz
         r/OfKAszywsAzvYC8Hiod2eMNCWDHJtWcggZ765ITsmG9DqJm6xa3/t5VQnZBhHM5kiW
         bjzfDkZsLzjoMopHD6zKiLqUN9+c1e6xqkfb7PKg+Gfqm3MvMZ90W0x94SGpwo2eq0gv
         lkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396964; x=1714001764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZPFdLERqgua7X2DfAhhcOttdh95F/zSosGx8JeMCe0=;
        b=WmOjj4S49Hvkt95DLMT50VQQZUlgwVp8qYUNBV2U4SwoER8kWwxvH//YYSoc9HhiP6
         LYGz5Ci4DQnVnLwp8scsSTQviOZOAEw6Vitz5HOrYTn72F5NCB10NkByvpioVyKFainz
         tDiQFDy4qYUO1xILxTBj6WRqCb+TT8FuZVyVC61Y6tKnQJ9byz+61qu5aT8B2wE1gIQW
         kdfSfXpWzZ5WJTj4/+47XO/PRZGxD65YHerYwEpRPyj89CnOc8m9dNDeVdQClNTI/mjx
         1Hg4KR08dd23WmWR2Xj7G7OEpsACP5o0wtg8Mg7oEi4buuRsItAIY7gJK41zD3btD/R9
         dBTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/+A57e9C2Dv4CnhSif5zB1O1YS1aMYLx5LApFaWpZPbR4Fy0Wl/OhC36HFVK5VxveAfuU34v4xa0ragBQxESDFz0kMsT3Z3Wmj9jP
X-Gm-Message-State: AOJu0YwZUqWT3lkegfQ64gzgWZ5wBnrTLnbgzdRqbiZ7V2jw2eV4ooA2
	VBlRl3iwL6YfDlCYzYIV1bjgfxhFDp/IDRXbbbP6BFcdu2FbwWoFbljhO0XCnZOU/roh0y3vxw5
	BKQ==
X-Google-Smtp-Source: AGHT+IFjU3HTTdyOOQBmNl77DxbsU6MPKkqbT58a4Si1tx3TQHOitDif6lkYZZvX3rUUYT5VrjdocrZCD/Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:2343:b0:1de:fa2c:fbb7 with SMTP id
 c3-20020a170903234300b001defa2cfbb7mr3636plh.7.1713396963657; Wed, 17 Apr
 2024 16:36:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:35:04 +0000
In-Reply-To: <20240417233517.3044316-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240417233517.3044316-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240417233517.3044316-3-edliaw@google.com>
Subject: [PATCH 5.15.y 2/5] bpf: Generalize check_ctx_reg for reuse with other types
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Generalize the check_ctx_reg() helper function into a more generic named one
so that it can be reused for other register types as well to check whether
their offset is non-zero. No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit be80a1d3f9dbe5aee79a325964f7037fe2d92f30)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3d04b48e502d..c0993b079ab5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -541,8 +541,8 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno);
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b02f074363dd..2f6dc3fd06bb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5553,7 +5553,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ctx_reg(env, reg, regno))
+			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
 			const struct btf_type *reg_ref_t;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c95d97e7aa5..61b8a9c69b1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3792,16 +3792,16 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno)
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
 {
-	/* Access to ctx or passing it to a helper is only allowed in
-	 * its original, unmodified form.
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
 	 */
 
 	if (reg->off) {
-		verbose(env, "dereference of modified ctx ptr R%d off=%d disallowed\n",
-			regno, reg->off);
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
 	}
 
@@ -3809,7 +3809,8 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable ctx access var_off=%s disallowed\n", tn_buf);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
@@ -4260,7 +4261,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 
@@ -5140,7 +5141,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (type == PTR_TO_CTX) {
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 	}
@@ -9348,7 +9349,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	err = check_ptr_off_reg(env, &regs[ctx_reg], ctx_reg);
 	if (err < 0)
 		return err;
 
-- 
2.44.0.769.g3c40516874-goog


