Return-Path: <linux-kernel+bounces-34545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19560837EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4592988AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7513BE9B;
	Tue, 23 Jan 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCUf8pvh"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61ED13B79C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970764; cv=none; b=bfwqiSVnFv9sHSg8+Tp5dArjETVpRN5+LuKq1NrALfIhW8oledkKI7G1BQjWL++SOoTxy+wGg6R7J0et4/kczZO0qnHwCitWPI4A8bhSQ5kn/F+HON0XHPANVn5tDm5NwLhw613u47D0sFaqlaKpEOvtlcyGVWmjaNYvR3jihS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970764; c=relaxed/simple;
	bh=2wCmjbrcMRqWZC1sS4cD9WCoJa0FFJk9am0EA3arqac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVEw2X4kWVms0frjo3I3BIG+QXvjzZr2excYzSsL/p9n3VPCpgpFaQ9sh/dYXddFmseuLI/GV/AOfvq9do2kieURdTNvBBkqN2nJ/6ZAX0gzTmfYeCGu7/EAFfNT5rx9MNELCPaxnHXq5IqZSlnQGFGtDaCREKebv2Dx/s1YoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KCUf8pvh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dbd146c76cso1191894b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970762; x=1706575562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlB1so7iSYMMc+zMA5tTSobm4T+1cPSbyb1VsiUjWnA=;
        b=KCUf8pvhW5lDoA62Dg0ho5AAF7eES6N0E3wggigmWcLD4gBwfdHbAYU1jnQ/blWyf2
         gWy5xMKOy5dVNn41i1esbHP54VLr83dMOdMVv/vVGXE+dMib14/gz1MrdDASkEeqXoTP
         +e/1a6mSkwYNbTEdDngbGpncZDCe941m2vQNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970762; x=1706575562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlB1so7iSYMMc+zMA5tTSobm4T+1cPSbyb1VsiUjWnA=;
        b=XovwYxR4XH9rpZSqWZMcWb1bk6715gRctthHpDjljYyg1WJS3tkUlPva88JrLE9i3k
         U0yFK4/bK2nHLCLfQasJEsEjFaJS5dVp7Op5qpE21ySYXxOfw70UF9qYmpp0+coaLvdj
         Kxw3OagbNJ0/Aq4fuTCrPtqv0W9UDkLbo+Tpz9GBK8QZKapozz9dFYxiNkel7T1ahUZn
         1yEktWfD5Nt8exFStave8Vk0tGQlgcFKQDWFNMI1eXH+fnDOetHHZgxFMvjdsfM3HtfE
         T6cGUrqWBxnbAVfxWhbmsq/udajySJ7Q0VTL1ZDrBHUJ8aKNrsxNKxI+SpT/9HxACWl3
         Wk3w==
X-Gm-Message-State: AOJu0YyOXKpD6UZImCE8trS4uEL+0+W9rYdy3asyILBhbQsVIwjhKJvd
	bNrvm68oDHRLZ3iDkDZAi1b7pjElMkc5o3DxaAbKAs6sueREb3gNtJcWlGW6wQ==
X-Google-Smtp-Source: AGHT+IGLP4BXrSpgwzgnQ7nt1vcN3XnbCRvJoUd/AxaYE/OKu5/w3uVCiBcdhGtFLCuc5GzcLIDIDA==
X-Received: by 2002:a62:5342:0:b0:6da:dc40:8a20 with SMTP id h63-20020a625342000000b006dadc408a20mr2301791pfb.33.1705970762317;
        Mon, 22 Jan 2024 16:46:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ei5-20020a056a0080c500b006d9c1fb00c3sm10312922pfb.9.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/82] arm64: atomics: lse: Silence intentional wrapping addition
Date: Mon, 22 Jan 2024 16:26:46 -0800
Message-Id: <20240123002814.1396804-11-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=keescook@chromium.org;
 h=from:subject; bh=2wCmjbrcMRqWZC1sS4cD9WCoJa0FFJk9am0EA3arqac=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFuIsRbthegybO8MY9YK3hU2NvgRq1O2YBO
 IjKE+N7ASyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 JmSfD/4g1+DgHXHG72Hbmbb46rOcoRFhxRGXi7T5E+bZnxGlykSxPf0G1ANroXNNRfIaH6+o5qK
 35TXw+v7btBElrd4MhK4ZbF8bSpQvVhskXDNsG57NNiroN46LsPQA8rEzRHYhG5Eyc38fTe127A
 3uUz42N+LY2siqQGD2Ge2b4r0+8aGX/TL8kV/lNpzt3w6jnX9r7Z8vBrneYHiRSnfednC+Av3Pf
 RyCs0/HKJZcTjfnDEx1k3P3Fd18p2TW908PSpyBk06V72hx9SUZgSJ9SGH464OCpkN0xwipXw9+
 Nw+92WpGwHyD3dXcrFGs3E6SKlw14ZCPEccJAR+5CUKhOue2w42127aNFW4RDhqyYMWStyDHkCc
 8jLmwwWfs099pHTnMi6MvnMOljVyfXlkw8GdYMs2Lq/TXUAOMRpCTNnB4jgKK82LyeprXA1sOi2
 BVQVkAgQI0bQryBcaVLgoT3sRUmxuBKf/augjFVrSWSBXy2zdC0d0xxmMq4bCDtGucY1l/2xra7
 zAxQ6sOmpKKjLBiTo3y5+k90sf659nAJj8+4nIVWi+zKbtw/iOjer+EkTgQepBrzv/sgtu9EGTf
 KxBXUYWlM3yIUrnzexGV+3Ismg32ENElWW6xv1XZQUlvJr5IrgGwdbNbkzgTYRGZHPrDZjvzgWR m5rc8KKgBXxVe7A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Annotate atomic_add_return() and atomic_sub_return() to avoid signed
overflow instrumentation. They are expected to wrap around.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/atomic_lse.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 87f568a94e55..30572458d702 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -79,13 +79,13 @@ ATOMIC_FETCH_OP_SUB(        )
 #undef ATOMIC_FETCH_OP_SUB
 
 #define ATOMIC_OP_ADD_SUB_RETURN(name)					\
-static __always_inline int						\
+static __always_inline __signed_wrap int				\
 __lse_atomic_add_return##name(int i, atomic_t *v)			\
 {									\
 	return __lse_atomic_fetch_add##name(i, v) + i;			\
 }									\
 									\
-static __always_inline int						\
+static __always_inline __signed_wrap int				\
 __lse_atomic_sub_return##name(int i, atomic_t *v)			\
 {									\
 	return __lse_atomic_fetch_sub(i, v) - i;			\
@@ -186,13 +186,13 @@ ATOMIC64_FETCH_OP_SUB(        )
 #undef ATOMIC64_FETCH_OP_SUB
 
 #define ATOMIC64_OP_ADD_SUB_RETURN(name)				\
-static __always_inline long						\
+static __always_inline __signed_wrap long				\
 __lse_atomic64_add_return##name(s64 i, atomic64_t *v)			\
 {									\
 	return __lse_atomic64_fetch_add##name(i, v) + i;		\
 }									\
 									\
-static __always_inline long						\
+static __always_inline __signed_wrap long				\
 __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)			\
 {									\
 	return __lse_atomic64_fetch_sub##name(i, v) - i;		\
-- 
2.34.1


