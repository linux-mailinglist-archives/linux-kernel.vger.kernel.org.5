Return-Path: <linux-kernel+bounces-137986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFB89EADC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61BF1F21EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB109A951;
	Wed, 10 Apr 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNqWZuF3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707781FA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730616; cv=none; b=XVuaKWxFcar2nahdinSlaJbZxqDnYaGT9CHIOl5qfCyYDLyj1orge/QfjlLK7NQnd98+8UcCEEsFJKiNV24PRRF+UFbVHYzyas4yaF3QpAbFa8VR8zTPU1vUpx46JnDwXfSfT2yJXkcBH0q/24JkP83FmZUVYdQVdKGvj0QqTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730616; c=relaxed/simple;
	bh=jcxV2p080sbrvfQHeja2QQYkPZ861iyTSCgOw2bY3Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgbjuovcQomPBbN5iTbg2l+IxBPPmmWqNKxnYhHX39VCMGo+lQHd1dg2kcTwZtl2QrF1dYTgJJTVr1pnC5AP+aOrQU32fI7gd8Qp2ty8KFIB6JfyEq/zzaykRxDb7X33PvZdknvZyZhDjPu6vqbj1HmILN6GnRq2eTf+FK2QDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNqWZuF3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so174844a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712730613; x=1713335413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2rG0To1UI/uRBDvy7dklB3Wp9poBDO+Fe77OPJHkjs=;
        b=eNqWZuF3ABjyxQPPDhTtB1veAj4I1cQX22mjiGqFQEHOhfHLl3+cDNPqzdRv5b43ej
         bgn+u3vtP/Qqr6Jn3Vk9Jsp1S5V2d5o44qe/qRIEDrYSqpDQ6+2cJPx3yqK97zlt/LAi
         q1JZonMdHHjhjAt05jYZbsDLpFjDHnAETf4ATS8FoKK7J/5QlKqLh/aIyR1OFxQeLbME
         lt9uEA95EshFb9WDoAjfmHGGrC6OKfw6hV+FTewKUCyS+Kd8GvxkmVCzHx9TX/pOvvCU
         dyrwjIASr/H692hA+ikcEHqJRvDgg5Df8Ond/79LoRLBXR4xUbOYezFYiWj1UajLLkKF
         /EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730613; x=1713335413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2rG0To1UI/uRBDvy7dklB3Wp9poBDO+Fe77OPJHkjs=;
        b=UD0n+IGhrHATrm2aETjBT/2r683zQMPRJYlVdjkh6zMas8OWt5xL0EWCAvLHTCg8VZ
         X6b1BCyanTGguVoQezrfqECW+LrqdJo4NpyKlvYp7co2eP8AEMtuZlFBwy8+8wE8INlJ
         4yvs5wneHx4Gcf0WlkbxYdlI/DWsQQsqQUFK+9GzZqnN83u7V+6G04hnPe1KU6vAk9Tx
         mNwqlblvaITeG/DPSqHegh8XBvTktIbn8El5RZcz5EjE3tqDMdc+LDXqbvW3sOq6C2iu
         J4LeT9qOhhzlboQbswbM0WurqoYFMVKuNqFpDEGmvMPkcaN8C9GP0ozzj6sz/RQ2opfm
         Yrew==
X-Forwarded-Encrypted: i=1; AJvYcCWLcw949sK/ZoGFiLx2thz0WUY1FEea5BEsLQC9gBxBmZdddbPNrDOd5gEzHb0WJVakZKQKJUq4cg3SeH2glxNJSR7YdShUOfMlW8WL
X-Gm-Message-State: AOJu0YySh2AOEV56cbyXxnGIlbseRqLmFn6l+gWi+uJjsmIjkFwJ1S3T
	v0NzBUjxbld3eFh98ObSbCl6heEQkuay0Pf0kpxLpbOLQQsmpW+6
X-Google-Smtp-Source: AGHT+IGNxGxXeWR7fLpJd5D9sg8tO3PHq41PN3O1IwFeH33ylxhy/k6rIDQIBHyqA74XS43tawofMQ==
X-Received: by 2002:a50:d795:0:b0:568:a9f3:b3fb with SMTP id w21-20020a50d795000000b00568a9f3b3fbmr945879edi.8.1712730612424;
        Tue, 09 Apr 2024 23:30:12 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id c9-20020a0564021f8900b00568c613570dsm6129606edc.79.2024.04.09.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:30:11 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 2/4] locking/atomic/x86: Introduce arch_atomic64_read_nonatomic to x86_32
Date: Wed, 10 Apr 2024 08:29:34 +0200
Message-ID: <20240410062957.322614-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410062957.322614-1-ubizjak@gmail.com>
References: <20240410062957.322614-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_atomic64_read_nonatomic for 32-bit targets to load
the value from atomic64_t location in a non-atomic way. This
function is intended to be used in cases where a subsequent atomic
operation will handle the torn value, and can be used to prime the
first iteration of unconditional try_cmpxchg() loops.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v2: New patch.
v3: Expand function comment.
---
 arch/x86/include/asm/atomic64_32.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 11e817dab44a..bc76a88ae481 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -14,6 +14,32 @@ typedef struct {
 
 #define ATOMIC64_INIT(val)	{ (val) }
 
+/*
+ * Read an atomic64_t non-atomically.
+ *
+ * This is intended to be used in cases where a subsequent atomic operation
+ * will handle the torn value, and can be used to prime the first iteration
+ * of unconditional try_cmpxchg() loops, e.g.:
+ *
+ * 	s64 val = arch_atomic64_read_nonatomic(v);
+ * 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val OP i);
+ *
+ * This is NOT safe to use where the value is not always checked by a
+ * subsequent atomic operation, such as in conditional try_cmpxchg() loops
+ * that can break before the atomic operation, e.g.:
+ *
+ * 	s64 val = arch_atomic64_read_nonatomic(v);
+ * 	do {
+ * 		if (condition(val))
+ * 			break;
+ * 	} while (!arch_atomic64_try_cmpxchg(v, &val, val OP i);
+ */
+static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
+{
+	/* See comment in arch_atomic_read(). */
+	return __READ_ONCE(v->counter);
+}
+
 #define __ATOMIC64_DECL(sym) void atomic64_##sym(atomic64_t *, ...)
 #ifndef ATOMIC64_EXPORT
 #define ATOMIC64_DECL_ONE __ATOMIC64_DECL
-- 
2.44.0


