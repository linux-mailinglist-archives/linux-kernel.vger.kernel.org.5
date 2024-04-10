Return-Path: <linux-kernel+bounces-137988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F489EADE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB0E1C20DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E928376;
	Wed, 10 Apr 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+chPiqr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7E17BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730617; cv=none; b=si86lECQ1X/XHL2jOmZwzVNeOehlTk3fl2TSn3ckIwmx7BZxn+FWUMso8U7r9iPEipoP2mX+dvErfew6LFLA1kE3VBBqAr7gSihymKcKE8oS6pwPeN80vdALuXXZ0011GGUBbGNM/yc+kDZXkdtzp+hBmTvsrK/EhtDlxMlIcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730617; c=relaxed/simple;
	bh=Otkz9VxKv1AmngInYT0fy2HPyWY/dnaWtJxwZzJ8HVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCgsEhiKOF10Ss7Nf1CJJ+R3lKFfRi6uPVtH7RCuZNELYZxXEvikw3tL0sU2UjpVjS7aJ9qy0ijXnN13Y+ImtgXwm2JmkDrcDycP6MyVPFK4FDf90uz3diYmAOtN+yuZLsX8oF8QR5mvuKArRnM6wPlPF1c1IEwsiwvFNIxupkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+chPiqr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a80b190bso331188166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712730611; x=1713335411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAGoeR5uWamfDBsJ3kwTlmEZZs8wXAmwviK0FpBjRBA=;
        b=F+chPiqrJcgnCGHvlFyNaoDjUI9qw4od5zTXtvfEBmQp0mqE0t/VREWQQ2RnA/v0id
         SgQteVjdtf301/5sTSGqa4rOXaIG5XPsE3OiROdqHwDX06r1FF6flAAlkHESTTAM3wRh
         NydgJ6CrzVaGEgy02xhL880RS3/O0Rtb3NVUf+t2k3YTjBxNnWmjT9Udu0gc3OEXVPSD
         46YOYOCogFyb3FA1x7Mt2JZXy/gZOTRT9QEFN6Hj/1j9my3fnmD0e/G6+9V2w+zWpakC
         2bztpsFA2MarX25C9rtSjiigX7lppLGFN77vNCrdTdNIz3nqp3GwaLa3d9DHAOe1s4TN
         ehzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730611; x=1713335411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAGoeR5uWamfDBsJ3kwTlmEZZs8wXAmwviK0FpBjRBA=;
        b=H5xlhSyKgKj28KPaJXgsI8D1YH/hSVWm/Eda5Nbg+0AlCmUHQ6WhDa63gpsVjTXuNc
         OGIPE1l/lsiYM9xqUkyBT6AK4TWyHB5MfSfO51Juy5IpPjKkKnEZFtPFni4nMC/Wc6NX
         hTkKOMts7bcSF3BHkaqTio2bblPLjQenugU+GmLHcgubLsUmbkB1rBfvZGfOWLMF1RGQ
         CSJrJRrWiKgOlBExL235uqyWN0Ha1KvKdomfKPghp88e+qheMPb4OZ6W5bbOcql6ZJgd
         OQ4KCm2oRoegj1J5JjLjF34SHDBcEXefmq9YL1///lmXkd8TW9JFeUFt3AAqGJqDwAit
         xzbA==
X-Forwarded-Encrypted: i=1; AJvYcCXe7QSc8pdiHoGXDlnPQkJUlKI+TQwC9VE+pBN4GPfJ8URjtvdkESGr21a1MYxLaipKpGJJ2G33zXFj8q4fMXqiy2GufOqOqy6aEa+9
X-Gm-Message-State: AOJu0YydWZG5KzyIfHRKY4Yc8B8+NwloVhibLuX0mN2PEAhzrPgKoYGN
	RwZjeXUYUKnEoaj36PrzHV3hwgTm+fm9NPsYmv5YVlgArMpZeVh7
X-Google-Smtp-Source: AGHT+IHy/QKTJBrZRrq/FoaPVSWSaZyH9yHVBPeI1khM93luMfWK4+WSkyqxLpgtlLadDmODR8puHw==
X-Received: by 2002:a50:8a90:0:b0:56c:18b4:d2ab with SMTP id j16-20020a508a90000000b0056c18b4d2abmr1331493edj.42.1712730610563;
        Tue, 09 Apr 2024 23:30:10 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id c9-20020a0564021f8900b00568c613570dsm6129606edc.79.2024.04.09.23.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:30:10 -0700 (PDT)
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
Subject: [PATCH v3 1/4] locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg to x86_32
Date: Wed, 10 Apr 2024 08:29:33 +0200
Message-ID: <20240410062957.322614-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
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


