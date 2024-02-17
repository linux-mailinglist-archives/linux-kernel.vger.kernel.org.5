Return-Path: <linux-kernel+bounces-69867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCC858F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3DE2828D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668E17A73A;
	Sat, 17 Feb 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkyKN8Ya"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9365BCA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175616; cv=none; b=WHo+p1qhN68d8XhDB3qo728kcdcPsBH5z+lpNDgGeMi9rG/Q2KPg4SlePF8xUOsrgmD3wwQ0/h2Sp6YvyTC1m94kWzlFEKEY0dzojQzQunQyC0FH7eHpVe5UB9EMauTDhRJdAZJjAkU2WhcFWhlp7d792DUP0j/aDB3UY8Zzo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175616; c=relaxed/simple;
	bh=8xpg6RGQXhDkzu/ru9pkjVFMLNF2TUGuHPq7YIGkRCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qfDcT4rFggdZtbx0PIN+2zmeg+rMucOEBGxKxlAA7yIXdrJO3/efyZFmN59/cVEvwF5XsSWN6ilOSb4I8MoBSThX6VK2CJQkwZfjAs1GvpkgSSV7S6Iz+FDevqggBu/0W4CTKUgZoz5J2KraRcp6uqEVugn2xtpzuRVCmu2NwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkyKN8Ya; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-298c59f0109so2756270a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175614; x=1708780414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyeLrRd9CLe7Hw11wYIs8TpWMeWxDTUtralQA0dQ0yM=;
        b=rkyKN8YaAmP5p1vzwUaJDktfJ+iVNohWs5FI6A5ls8L6oOGrhLJnsXsSE1l+tjiZho
         F3vCi+vIjBm+2xPM4PusNpRdkmiS0A7IurI9EnIh3/L6q6+h5hANlUbDLqbP/pbs7TR/
         bvsB/cQxq8H94Swhy/yJPgeTFD9gzqb1gZpYWqiA/kev6UkN8tHXjIWmV7HmX4M0Kf9S
         cJ3G1mhnR6JzQsExu1IVIzPDZFBRhuFIg7UkOsiJoGQZURNFQ+4f2bOjO7RnraVc8nGG
         1iWyq7T/EcLcGGTcSisw5pAVfipIqyWbMSsed3uLzeSxouGP5f1qMY2anO35Emqr5SWX
         EqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175614; x=1708780414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyeLrRd9CLe7Hw11wYIs8TpWMeWxDTUtralQA0dQ0yM=;
        b=neSz1sQsCRpC9s6OVRS5QLCAszpkET3kx8Xea9YKyvo6S0zMRpRPYVmQ+c3qqR/huI
         t2C4ceuZghHnFzZ9IZIwnPMpt/c83Owa2mTclh3STSMIQddkDy5fIn/LYwYu59qIXZaU
         FByPN4t9RWQNLf40M3tFC8AMXB4+tb6bdA//IgiR6nXVBR+XQe7j8sd0cRK+dRAvTChV
         ryZVGpdvG7Xjz9yGECG3vMtQxAlxrIEy93WOjR7y041iVln1wMytvupLWy83BAWLB1pE
         A5yWq+fFS45Ctds+HTZOlgpdf8J1JO0KN+3pfk58CMxJFNjftDbC21fzPldm1eovr+dC
         xW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrBxI7eYA7mu23Xgb8wQkDPwxLZJXOA4gR3S7oGhMzIkl7H6ITkbpGiGx5wHimZs9TPMCR6ZAA0Q5qpC8H/4hpf5JFTPQwF/va9j35
X-Gm-Message-State: AOJu0YxxqBsGb9UK9qUx8yxY1yH5RofTaPmsgyiunom1anliUYfIEMpm
	ajb/07k0zq1KAGXo2XqZ+CkKvYXyLp7OG38WG4Ld99a1D/etLgA6jWglejP0uWZFUsQ1OmzcrXe
	/o14K0WBqzZmFBesIHQ==
X-Google-Smtp-Source: AGHT+IGcUSK2w2TzNdsgkFOUkK1bgKsf9p0KE7Ve3nXJ/cAI8GO3AnK/s3oB+wJsI9lmgIka5VRKg+dZ3U/FZtlY
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a17:90b:3a4e:b0:298:eacc:658d with SMTP
 id oh14-20020a17090b3a4e00b00298eacc658dmr99799pjb.3.1708175614576; Sat, 17
 Feb 2024 05:13:34 -0800 (PST)
Date: Sat, 17 Feb 2024 13:13:28 +0000
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217131206.3667544-1-ericchancf@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217131328.3669364-1-ericchancf@google.com>
Subject: [PATCH v6 4/4] riscv/barrier: Add missing space after ','
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com, conor.dooley@microchip.com, parri.andrea@gmail.com, 
	emil.renner.berthing@canonical.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"

The past form of RISCV_FENCE would cause checkpatch.pl to issue
error messages, the example is as follows:
ERROR: space required after that ',' (ctx:VxV)
26: FILE: arch/riscv/include/asm/barrier.h:27:
+#define __smp_mb()         RISCV_FENCE(rw,rw)
                                          ^
fix the remaining of RISCV_FENCE.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v5 -> v6: change the error message example in commit message to make it
more relevant

 arch/riscv/include/asm/barrier.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 15857dbc2279..880b56d8480d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -24,14 +24,14 @@
 #define __wmb()		RISCV_FENCE(ow, ow)

 /* These barriers do not need to enforce ordering on devices, just memory. */
-#define __smp_mb()	RISCV_FENCE(rw,rw)
-#define __smp_rmb()	RISCV_FENCE(r,r)
-#define __smp_wmb()	RISCV_FENCE(w,w)
+#define __smp_mb()	RISCV_FENCE(rw, rw)
+#define __smp_rmb()	RISCV_FENCE(r, r)
+#define __smp_wmb()	RISCV_FENCE(w, w)

 #define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw,w);						\
+	RISCV_FENCE(rw, w);						\
 	WRITE_ONCE(*p, v);						\
 } while (0)

@@ -39,7 +39,7 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r,rw);						\
+	RISCV_FENCE(r, rw);						\
 	___p1;								\
 })

@@ -68,7 +68,7 @@ do {									\
  * instances the scheduler pairs this with an mb(), so nothing is necessary on
  * the new hart.
  */
-#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
+#define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)

 #include <asm-generic/barrier.h>

--
2.44.0.rc0.258.g7320e95886-goog

