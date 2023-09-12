Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957C79C788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjILHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjILHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4347AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so35295345ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502136; x=1695106936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ7auXMwt2HG2eO79EZb79CGVaa+fy/IcLCkXgQTU2E=;
        b=gJntY8cV6wapICpdZfEIKXOai/sUbNM/O2PEKnDVSxn2gbWVIXA5t6cb7ba/zTwtwZ
         WPKEc9Sb6BUUld9t3MOlZYSn36CNY7tArLtbbMwnTUTx3Mf5iaTfiZltVlVMV5xD4xQY
         X0FW9FZVCyndsjXUA8mh1czh/TU1HNC0/w83YQ7H09Et5h9x0ZmpeyHEFeji9O+0Vmxl
         xlJ0cfto8eS7a4We7zUxCHvM91RjLFelbmxD1yMP5jZN/ZD7K0XFwIEDw+SW7VfCMNOT
         Jep7/hQOIfpGe4m+m5bjhWqY0GvnE9Fwk1FcBmB1GqSj2HWUlw3/QSPGHW5JjFwi6oqI
         xDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502136; x=1695106936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ7auXMwt2HG2eO79EZb79CGVaa+fy/IcLCkXgQTU2E=;
        b=Fv8wJ4ueJ6Hi+kcxAfo1obxMcUAFTShKxRFrUceNSO4yD8KEhlM5W2dE068gfoEDv+
         +zy1oE6P8bx7uN2ea6/sDZFSK0/Jdt/ImmDpnIfxLMo/DBCjNp2KrS/htRbpgdck4M4q
         WCpdGLwlaZcgBo9DsqZFfR0bqO87z4xPN+qzxAjNpqeuN3nSTO8ZWKRgNHPltRGLQTlc
         L6L2s7tAaZBlieF2vyO0g/q+YGTUXzSb2Q9DXKQNT1DyVXC9uDVnXh/ugzqARLUMQtzB
         6b/WRnsDsob326GQSf63scFzwoIdQ69Glbnfx1je65b1g9kTJh8PRcqLFSkg/+p7kw5h
         jVwQ==
X-Gm-Message-State: AOJu0YwP9kbOJH7IfwreSUNeeZKPu/UuRoOhp2xT6q8RIde1AQ5lxl/X
        xKx/07lVmUGipamV+1JROkqJTw==
X-Google-Smtp-Source: AGHT+IF1L3zszd0Qt7OImIjEsl7I2HCtreNc7f6XF9vPUvB7JGyRpTNFMRSxt9GUYpLv2X335et5TA==
X-Received: by 2002:a17:902:e883:b0:1bc:506a:58f2 with SMTP id w3-20020a170902e88300b001bc506a58f2mr10371670plg.46.1694502136153;
        Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:15 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
Date:   Tue, 12 Sep 2023 15:01:48 +0800
Message-Id: <20230912070149.969939-6-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

css_iter and process_iter should be used in rcu section. Specifically, in
sleepable progs explicit bpf_rcu_read_lock() is needed before use these
iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
use them directly.

This patch checks whether we are in rcu cs before we want to invoke
bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
let st->type = PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
reject if reg->type is UNTRUSTED.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2367483bf4c2..6a6827ba7a18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1172,7 +1172,13 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 
 static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 
+static bool in_rcu_cs(struct bpf_verifier_env *env);
+
+/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() */
+static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta);
+
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+				 struct bpf_kfunc_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
@@ -1193,6 +1199,12 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 
 		__mark_reg_known_zero(st);
 		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+		if (is_iter_need_rcu(meta)) {
+			if (in_rcu_cs(env))
+				st->type |= MEM_RCU;
+			else
+				st->type |= PTR_UNTRUSTED;
+		}
 		st->live |= REG_LIVE_WRITTEN;
 		st->ref_obj_id = i == 0 ? id : 0;
 		st->iter.btf = btf;
@@ -1281,6 +1293,8 @@ static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
+		if (st->type & PTR_UNTRUSTED)
+			return false;
 		/* only main (first) slot has ref_obj_id set */
 		if (i == 0 && !st->ref_obj_id)
 			return false;
@@ -7503,13 +7517,13 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 				return err;
 		}
 
-		err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
+		err = mark_stack_slots_iter(env, meta, reg, insn_idx, meta->btf, btf_id, nr_slots);
 		if (err)
 			return err;
 	} else {
 		/* iter_next() or iter_destroy() expect initialized iter state*/
 		if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
-			verbose(env, "expected an initialized iter_%s as arg #%d\n",
+			verbose(env, "expected an initialized iter_%s as arg #%d or without bpf_rcu_read_lock()\n",
 				iter_type_str(meta->btf, btf_id), regno);
 			return -EINVAL;
 		}
@@ -10382,6 +10396,18 @@ BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_iter_css_task_new)
 
+BTF_SET_START(rcu_protect_kfuns_set)
+BTF_ID(func, bpf_iter_process_new)
+BTF_ID(func, bpf_iter_css_pre_new)
+BTF_ID(func, bpf_iter_css_post_new)
+BTF_SET_END(rcu_protect_kfuns_set)
+
+static inline bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return btf_id_set_contains(&rcu_protect_kfuns_set, meta->func_id);
+}
+
+
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
 	if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
-- 
2.20.1

