Return-Path: <linux-kernel+bounces-135127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139D89BB6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBE1F21EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA594E1DC;
	Mon,  8 Apr 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1kAwpE8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD334C61F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567758; cv=none; b=l2MkoCLgUnxtz8zHncRSAXjOrHOjCbW+5jT0lsL6HOob8CV8h/++jPkDuGyi5gEvwohljFC06Vb+Klgf3kfVsKAuaGTWWEgr4OYBR5krRgXWOpaam/ruHYxJaF2ME6TYtxCcfla8UVm0kBXfASzDOs3nTeWiFFuHKVGTydGHQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567758; c=relaxed/simple;
	bh=+l84a63zQDa3KCQZBJ4TJN5KeUrb8PGLNV0AJ96geus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X56yuT8mUpNzTZMkpLxVb792wVZCBI1eDrfa6TdgHbcRUsc4p817MT2FjKOIynG9pXBNRcK1m5mjfkbsqgLFYv9pGu6rFuzxTYc45XVtG7Wu3l/QQporE688dRDWdTNlgzEyXuc7LncWsmdOIrXMNlvt8GSyRlluWv+l4L2l+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1kAwpE8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso2220723a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567755; x=1713172555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOdMmskLhpoulw50kdQ3gfPaoFiHiAEoT4mUXvHBa/M=;
        b=F1kAwpE8ebOc6jF9LVlYe6Tu5cDedi+bln5+78s6k06sS+q7gwOR4sOOMrxEIgZfT6
         yg0Sfr1zUbUkKoZK+M2sixYWzWZLv4AxzqrAhFGlmJDNy7t2ntV4GN9LKHRa4C4VM72s
         jGyvVy9ntxIOwlgf7PdJ8eNzbIeJDr3/cYZCF8Zz2bbWUjFByXcEKYAcP1aGQcXKz/WW
         NGchpEcmuPqTJBlKMkWGEPjebzoyOoyta3LMotGHVJIRZsR6Qj+cwnYXUyjFHdqxHn2B
         Cnjnzk7FahyxpTFHlL9s0F5ImLDAvbwsSmSZKiq+vmGElpWeXLUiJhZxO/Og0c6VDhUq
         r6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567755; x=1713172555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOdMmskLhpoulw50kdQ3gfPaoFiHiAEoT4mUXvHBa/M=;
        b=K8S7dpo4Bzuh3SqbfpRLNK+HeqRnLXwWaqtMR5j8vv3Qp+q4JtTabhUFUELpdulID/
         xtFVipV9CvOiJ693ZrRJw/TKLFWeudbjDAYxJVU2JAY9o1TNJt58Ks3cMfyRE9sIPmSW
         c2O4yUw7+wKyamiq76ImbXxgSNiyvcgKAa+yQXFswLe0PN5XuKJGg+AhN9TW3Eep7iQM
         KLXrXjaYSTTKHArVnE3Tx8ttYxxhw23kxLXiw9+bT5MMcXQ+0ZLQPSWEPWE8Tza+YGhL
         /futn5Gc36LJWw7Ra/24Z5C1IsUc8Of7pJic/YCTwbsi+1hVFzoeckd/9BNuqwlQdZjE
         FeOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYx2310W3R67Uhy3AQ4J99zw7pu6hwFeTNL5QBlpIb19EvnJVhPaqGslszaJGPI47qOQoxa1IVI7RN5itJKGV5ePukG6wzKDVYTIhQ
X-Gm-Message-State: AOJu0YwrBPDJwJdw7L2SUtb2eUBM7O68jfgXGG9yAy3EUBscsEtS2nKG
	fwMcL5naP+YPkGaVRwyKSs7fjFENpIHfgquc0b1TMwOMsZXVYW9/
X-Google-Smtp-Source: AGHT+IG+R/qhW/X2ZQ+8rlioxyUiO/2xWxmNPBfrDICBrlzwOpQqKoIeO5q9NsrSWbaxtnFPp5HW4w==
X-Received: by 2002:a50:ab50:0:b0:568:c6a2:f427 with SMTP id t16-20020a50ab50000000b00568c6a2f427mr5624423edc.27.1712567754711;
        Mon, 08 Apr 2024 02:15:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id n2-20020a056402434200b0056de7bee45bsm3854201edc.18.2024.04.08.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:15:53 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] locking/atomic/x86: Introduce arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64
Date: Mon,  8 Apr 2024 11:13:58 +0200
Message-ID: <20240408091547.90111-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408091547.90111-1-ubizjak@gmail.com>
References: <20240408091547.90111-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit:

  6d12c8d308e68 ("percpu: Wire up cmpxchg128")

improved emulated cmpxchg8b_emu() library function to return
success/failure in a ZF flag.

Define arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64 targets
to override the generic archy_try_cmpxchg() with an optimized
target specific implementation that handles ZF flag.

The assembly code at the call sites improves from:

   bf56d:	e8 fc ff ff ff       	call   cmpxchg8b_emu
   bf572:	8b 74 24 28          	mov    0x28(%esp),%esi
   bf576:	89 c3                	mov    %eax,%ebx
   bf578:	89 d1                	mov    %edx,%ecx
   bf57a:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
   bf57e:	89 f0                	mov    %esi,%eax
   bf580:	89 fa                	mov    %edi,%edx
   bf582:	31 d8                	xor    %ebx,%eax
   bf584:	31 ca                	xor    %ecx,%edx
   bf586:	09 d0                	or     %edx,%eax
   bf588:	0f 84 e3 01 00 00    	je     bf771 <...>

to:

   bf572:	e8 fc ff ff ff       	call   cmpxchg8b_emu
   bf577:	0f 84 b6 01 00 00    	je     bf733 <...>

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_32.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fe40d0681ea8..9e0d330dd5d0 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -122,6 +122,34 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 }
 #define arch_cmpxchg64_local arch_cmpxchg64_local
 
+#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new)			\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+				 "call cmpxchg8b_emu",			\
+				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new);
+}
+#define arch_try_cmpxchg64 arch_try_cmpxchg64
+
 #endif
 
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
-- 
2.44.0


