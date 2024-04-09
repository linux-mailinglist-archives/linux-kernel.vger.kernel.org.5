Return-Path: <linux-kernel+bounces-136623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D889D63E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EB21F21945
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929C81AA1;
	Tue,  9 Apr 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+8CqoNL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41061272AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657111; cv=none; b=jyYBLN8Hi6EhXmAYsMZG/yFVimmFdsJp4fZylabLBRdlwWbWGQTUWWd7Z3wm289maVWlrRgaRm7zsDsyuC2xJ3Gm2wzG/te8EQQXCQnlxjcFvmaRqMOZQkbp+qNZ7bDpQwwfmtTmORVgS9GV/D+3YdWWkWctJIw9mn8nEdNL8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657111; c=relaxed/simple;
	bh=Otkz9VxKv1AmngInYT0fy2HPyWY/dnaWtJxwZzJ8HVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MphixTJQWnMiTx6BISTH5m95ZnOR5Gk0935L/39nQfItMwRBm1ddwsf00Sp+9zN9LcEqTMorjDcnyu3DycPOEzgbcBf68r9+8OwMVjR+dTpm0uzvsyGwIHsg0OuVvpTnloUJEkdkBINJEIK33omNtrfcGtGUGp7j7mwE25/i974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+8CqoNL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a450bedffdfso758466266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657108; x=1713261908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAGoeR5uWamfDBsJ3kwTlmEZZs8wXAmwviK0FpBjRBA=;
        b=m+8CqoNLgsHh4knfz4w6azklxs4BBd/8d7xKDdcgEQWBfjgCHOuBK5kLz/21nlVCqo
         Qi38/qrv7KCMNzHGiQTjwbuTCD7kksfg/+V4P+RvJhm7P2yayTldQNvmMWILw7XNdeH1
         srZFsXM9E51Pfj7N6pJHq5tMZIRi6RSts91jGpibwOLxm6O33uAIqFUBYvyqFmyHAY/z
         8xXWNKbEaYHVkVRI/BYxxbzmmro50k7PBiBFObtSavMx2tHRN/K/kA/+xBu77ixR95Qf
         wgy3hZ5hpJjn2kI0a6TkHggepjpcEc9M/jukdzHz4ZcwW2sF8bGo9Yt1w06lSu8fDBaO
         msew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657108; x=1713261908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAGoeR5uWamfDBsJ3kwTlmEZZs8wXAmwviK0FpBjRBA=;
        b=B7FdOJVIhP7efAqCFvCI66a5tjMLw7ck89WqGB1ZsBlBi93TjKqKnESbUiqh7pB37U
         QVHSmcgYUwbV/GzPgDHrLoyuSzXcO3UJQIicMyuxDLMRngx9Ev1M9SavdpMVRgiUtbvg
         UkDWO9rymyoT0SZ85YrBregMlwjTT4SjiO1BN2LC/BvUMf6YnxoTQWEakgsxrAu4rD/X
         BM4naCSR4ges8JUu445P95T2Oh5mQMlvH18J6ThLWGxjyn3+rMm7EmhBiiFP9E/+gXFa
         eT+lisWdHEa8eNqj1RkV97bgKE6cbkm7qvOWS0hll2m9rgw7iVKF6SojLHmwFh5X6nQa
         5b+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKT56Sl/9+qDtPA+JbB3xSu+R24KI50zFayKP5mqlG3JQnutEaidhDMzZR+r4BnfPBvpMRjDQsoLIqSofi6jXCs8ZZoiquJlKi9jOe
X-Gm-Message-State: AOJu0Ywutw4h9kLhrwoT0ENfaRHsQhCeIVgBM0Zi6ofS/Gd+urN8urto
	t3aqGKi2B23D045bt5P/vJCcfh3h4CaTOVVu1K43Dopjns1/fOhv
X-Google-Smtp-Source: AGHT+IG8Nl6vjVWOGS3WZO62fvd41W0VNuc+nkbgDwo1+KvpOPZZhfSRDaKJaeHTxttw0I9PiPrZHQ==
X-Received: by 2002:a17:907:80a:b0:a51:f63d:84d0 with SMTP id wv10-20020a170907080a00b00a51f63d84d0mr1086765ejb.64.1712657107776;
        Tue, 09 Apr 2024 03:05:07 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:07 -0700 (PDT)
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
Subject: [PATCH 1/6] locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg to x86_32
Date: Tue,  9 Apr 2024 12:03:52 +0200
Message-ID: <20240409100503.274629-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409100503.274629-1-ubizjak@gmail.com>
References: <20240409100503.274629-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_atomic64_try_cmpxchg for 32-bit targets to use
optimized target specific implementation instead of a generic one.
This implementation eliminates dual-word compare after
cmpxchg8b instruction and improves generated asm code from:

    2273:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2277:	8b 74 24 2c          	mov    0x2c(%esp),%esi
    227b:	89 d3                	mov    %edx,%ebx
    227d:	89 c2                	mov    %eax,%edx
    227f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    2283:	8b 7c 24 30          	mov    0x30(%esp),%edi
    2287:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    228b:	31 f2                	xor    %esi,%edx
    228d:	89 d0                	mov    %edx,%eax
    228f:	89 da                	mov    %ebx,%edx
    2291:	31 fa                	xor    %edi,%edx
    2293:	09 d0                	or     %edx,%eax
    2295:	0f 85 a5 00 00 00    	jne    2340 <...>

to:

    2270:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2274:	0f 85 a6 00 00 00    	jne    2320 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index d510405e4e1d..11e817dab44a 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -61,12 +61,18 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg64(&v->counter, o, n);
+	return arch_cmpxchg64(&v->counter, old, new);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
+static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_try_cmpxchg64(&v->counter, old, new);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
-- 
2.44.0


