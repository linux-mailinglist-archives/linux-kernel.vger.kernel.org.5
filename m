Return-Path: <linux-kernel+bounces-149380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC78A905B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A8E1F21A19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2C548E9;
	Thu, 18 Apr 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHH1q+NA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDF5CB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402468; cv=none; b=XTDH/QcTa1fN2Da+zkZYOCwAzPSoe1CEasuq5HaUfdtHoRcK9uB5shJCaI/3X3unvnwdxULA0T/e1Cr3spHwC3in0apG/Lq4NjPwPch6caSNOaqremYm2a6P3R0cv4kCqMRMuoeJeLQtpdALjYVVqyEVPUgp43JF6MKAWUuSap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402468; c=relaxed/simple;
	bh=vjRJ1U7DKOKEv8zqHNl/1MSWTfJ+WAHC2urS1kF08ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYqYShhf/jcVHCfE/51JcSjV7OBohafPXtSibPDjOGh8XLBrJkDPZJdiSHmLOSljE8StilWEOhYbzTC/artu0tUwptlNik1uNxC8fbddv/fnpF/XzQq9/xK6YOTPVws/tJeaiOuTMHgjfwPZuZ2mLixioy1hGGmWNRKT1WrQ4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHH1q+NA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2abc5b4f3c7so217590a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402465; x=1714007265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuQpI8q1wJxBD6X4kJwl22uAmYchmA+XE2ed6Sx/XW8=;
        b=UHH1q+NAnkAIYmnfTLZbtjKDEB1MeEw/V2YGrHVRgkHNgViYvAcYhGbanCgx1+KyUa
         mSFsJiFUEggS3i6hBRDxT46S58f8JmbGkcG2+T6NZgnCroX2zcULVWzY3/li6YgWQ88c
         i9wVom7OjPQSWru/F65Mz3S5CRweovRex77GgbLdeL8p8NR+IzqCAXXPifjv2N1DsmJ4
         1xInCgPaK2AApo/85qAuAntj6NYPfJevmg8A88Nbb0i5eTA/i9VXByge+sJ6GkNCmjKR
         aE3YIbAzCIcSVa4vBW805BJ2xJzSPFdm4WKMv37NanPYvfCqHK9FPMLPFlhb4ZIMvA/+
         oyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402465; x=1714007265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuQpI8q1wJxBD6X4kJwl22uAmYchmA+XE2ed6Sx/XW8=;
        b=ZRxkbQuoRbMANT0wATmWBUCIdD4pkN0rIr4EBPEUPEve7DVlUI+d/mpuaYx8wrRJBK
         klaCvMN71ro2m+FOXqfEP2+vFwV0Teub9WDIAyO1hkAh+2UjeR+7206uCuBuocyzer0X
         n0cASJoUiWkYifP0st/obSo79fOjDdI/fJq7ga+M0B4MpdAPinQ+WAFcDuo/xhf4ByPE
         GCKwdlDaoFtIM8UAHuXZS3Tx9jTOO3lhxxl3A2YJdgNlhkQggVeXdgCd4dnaiYtwDRPG
         e54SONtFZe+fnfUHGPXnMMeh5GelntpjGzq5eFv3pAdrsQpTfTNMpOFmpJmk0ll6pSbq
         RJjA==
X-Forwarded-Encrypted: i=1; AJvYcCVW/bgWDjH5Mt9kNUIKsQ6FBkChnUFh0GoFZPP/0ejr6sHE5Xg9FZH8uUool6vGoqS1WktdTbKDASDbMBFW6e9tdVT+BFlOE6fxj9Tn
X-Gm-Message-State: AOJu0YxS6O0uKv9UEwEeVZKwZ6T/9mPDaLwFl+YLy2RvuA3AOmEkvsOt
	3gK1W4717BOAPo8DEyRfxByCB1PmEh9sVbp7eRpczOaHqNCYT1wqWPuEenlOECdLvsEl0gh2WOT
	lAQ==
X-Google-Smtp-Source: AGHT+IHGZwUXxnIi8umgtcmk1AYnoU9sLsjsWPwJKD9HL4ufshZxqeVmZB8Cu9P+R7pMCrRGbgVEpjMIq+c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:d081:b0:2a2:5697:f90d with SMTP id
 k1-20020a17090ad08100b002a25697f90dmr2975pju.6.1713402463538; Wed, 17 Apr
 2024 18:07:43 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:14 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-6-edliaw@google.com>
Subject: [PATCH 5.15.y v2 5/5] bpf: Fix ringbuf memory type confusion when
 passing to helpers
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

The bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument, and thus both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

While the non-NULL memory from bpf_ringbuf_reserve() can be passed to other
helpers, the two sinks (bpf_ringbuf_submit(), bpf_ringbuf_discard()) right now
only enforce a register type of PTR_TO_MEM.

This can lead to potential type confusion since it would allow other PTR_TO_MEM
memory to be passed into the two sinks which did not come from bpf_ringbuf_reserve().

Add a new MEM_ALLOC composable type attribute for PTR_TO_MEM, and enforce that:

 - bpf_ringbuf_reserve() returns NULL or PTR_TO_MEM | MEM_ALLOC
 - bpf_ringbuf_submit() and bpf_ringbuf_discard() only take PTR_TO_MEM | MEM_ALLOC
   but not plain PTR_TO_MEM arguments via ARG_PTR_TO_ALLOC_MEM
 - however, other helpers might treat PTR_TO_MEM | MEM_ALLOC as plain PTR_TO_MEM
   to populate the memory area when they use ARG_PTR_TO_{UNINIT_,}MEM in their
   func proto description

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit a672b2e36a648afb04ad3bda93b6bda947a479a5)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf.h   | 9 +++++++--
 kernel/bpf/verifier.c | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 84efd8dd139d..96b2aa567d23 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -312,7 +312,12 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
+	/* MEM was "allocated" from a different helper, and cannot be mixed
+	 * with regular non-MEM_ALLOC'ed MEM types.
+	 */
+	MEM_ALLOC		= BIT(2 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_ALLOC,
 };
 
 /* Max number of base types. */
@@ -396,7 +401,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3dfc45ed428a..6162ba31a89e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 16);
+	if (type & MEM_ALLOC)
+		strncpy(prefix, "alloc_", 16);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -4970,6 +4972,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
+		PTR_TO_MEM | MEM_ALLOC,
 		PTR_TO_BUF,
 	},
 };
@@ -4987,7 +4990,7 @@ static const struct bpf_reg_types int_ptr_types = {
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
-static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM } };
+static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5150,6 +5153,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
-- 
2.44.0.769.g3c40516874-goog


