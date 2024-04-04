Return-Path: <linux-kernel+bounces-131198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B089845A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F4A1F247B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861B745F4;
	Thu,  4 Apr 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuX1qgaA"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187B74437
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223745; cv=none; b=tERklNZtuah4obAUHkAf4GmL6kmNNB3F5igxt9OyO6YaWTYW4brDVGJm/T0j3ELA+a+VuAD6HaC0snDnrosN5A5qR0Cs7yTz3I26c3NIHT3UE6vHb83Uk7ErK9QFX9p+iprXR0GneXKQnxE8PzxY2fGKFCg1cePm2erfK9lusTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223745; c=relaxed/simple;
	bh=48fh0II5kKEbt+TfWTXG1a6CIatXnzXJEE8M3I0OS8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUfyO/AFh1GtRA+qhvgV5zgX/GY79sIiIqw3DjUKTij944xw0I1UUjkqqGErcxQNcAFhoMQFyz9i2LPWl4UpdWXwUyfTlpxhs+a+hIbznkkqCMjsbQ757v615F4KfwvluSWS8m1belPrDr0NZHApJ7Xq1flubziobc3TnGCUtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuX1qgaA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e0f359240so953427a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223742; x=1712828542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjTddw2RcRfhhvnfv1p+DmU8UHIXO4Fbo1olKvzN4aA=;
        b=FuX1qgaA/e7J/qMDsI9zQxA6wtfLlMZ3oeXiscFsjP0atkL0/pFxqYNkzeEoPr4Ekx
         1ROgH91AQbQTfEu7CgX0v2m3Gm47lIGHVhi0vSsVfwgLN2Ra0okWFCFXAHaZ6ZqCI7V8
         2rP3ZqYyjZdnXQ88qhrKRfSw6O4pouZXXFcvbWj8dptZ2r0olOOjWkkvfO0g7jZUo/LR
         a6sDQ8h6OuVnptt0aO5Vd84yuKLuAzfAliWoEuBa6R9F6OETR7WZBdLcNbMyXvjnw46i
         9kDp4eDkZ88bUV9denjbye/2TqIqG5HZDq/JnJ0/hnN9zyPuRoz4pPYPkvPbpbYf+DVo
         IuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223742; x=1712828542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjTddw2RcRfhhvnfv1p+DmU8UHIXO4Fbo1olKvzN4aA=;
        b=ZRMff9507MJJpdOj4ET/h/OM/9KlbE+pZrK3pGL0+essa6g88zPWlGLKl/TsUDbgMZ
         PJi5g1/LymnZeSoaiin8rmK39auYedbGZDaJ3E1AsEK7E9dqkRIS/V6Hi+jigSZaB2BR
         TyczzRDO00kKH3Zr42dHk7mRM+ZvlID2+to1/b1Ej5wTyeF2g/UjXIIBD15nDDz9CouD
         cnLeg7ZiQJyqXrTokI9BbxhTD0Q/34j2C6TdbeWOVwVUkqnml7zjYdWq/f6c/ahz0OH2
         09Yg+8hJJiNE2ZmqbQmNWwftyDcH7Eb6HLWyR/ZAptB9nAWlyPC/NGJFSrlxRc5Kk/o2
         oTaA==
X-Forwarded-Encrypted: i=1; AJvYcCXiWMz5+YIougI5MQfxi7tIZu3u+jLX7ZHgTHykqVHjdgvKxC/rA+6yW4PuTkda0sGoyCXPtNa442WRVuP7VctwOUkUggGIo2bGcANk
X-Gm-Message-State: AOJu0Yyet6Dp/RarDTRyURR0a+K/yd6azOGKqAI4ahP0vGDRLErN2uS/
	QeZj9TmtKS37yfl6gThLlpKjKfLZtb4Cv7Hgjx1idZWni+44GPc3au0cDW71/DJdNQ==
X-Google-Smtp-Source: AGHT+IF8IcZzcekBALw9015GuB3wElHDNB6cUG/bScEHNYGPY/c39xctfKlW46a6hWH5bHIGwtXl4w==
X-Received: by 2002:a17:906:6d4f:b0:a51:8540:c671 with SMTP id a15-20020a1709066d4f00b00a518540c671mr1209247ejt.50.1712223741971;
        Thu, 04 Apr 2024 02:42:21 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709061c4100b00a5194b5b932sm62362ejg.16.2024.04.04.02.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:21 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 1/3] x86/percpu: Fix x86_this_cpu_variable_test_bit() asm template
Date: Thu,  4 Apr 2024 11:42:01 +0200
Message-ID: <20240404094218.448963-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix x86_this_cpu_variable_test_bit(), which is implemented with
wrong asm template, where argument 2 (count argument) is considered
as percpu variable. However, x86_this_cpu_test_bit() is currently
used exclusively with constant bit number argument, so the called
x86_this_cpu_variable_test_bit() function is never instantiated.
The fix introduces named assembler operands to prevent this kind
of errors.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2: Split from the original v1 patch.
---
 arch/x86/include/asm/percpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20696df5d567..cbfbbe836ee2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -586,10 +586,11 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 {
 	bool oldbit;
 
-	asm volatile("btl "__percpu_arg(2)",%1"
+	asm volatile("btl %[nr], " __percpu_arg([var])
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
-			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
+			: [var] "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))),
+			  [nr] "Ir" (nr));
 
 	return oldbit;
 }
-- 
2.44.0


