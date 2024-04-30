Return-Path: <linux-kernel+bounces-163656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E488B6E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB741F2428C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213891BED9E;
	Tue, 30 Apr 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkSXlvd9"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A01A38C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468734; cv=none; b=ODuejsMAD8aN32uFFvp6ImIahJNdi9SvxCqjGvAFPlj4fQjpSICMScBM6vuGnxGB0mUj9jSTudZ8BkSaMoUPx36FnG0Iuv4JmjdQW+nkVdomEw3twEuZVzIbTqqwf9b6OnjpLroTixWicDY+v61jDWTgk4pp5vV4e5EiSuPnXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468734; c=relaxed/simple;
	bh=6vCWF7Tfvr7FzBo6hwj6h7DuLM/a/FiiZZjBqdsOSYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOppsVYzC/jpBKYPTqY7XXidMtKGffJINHk/KPx+W3YAcu7WnoHi2sq9AVc6nZepI7XjXRsTvfPgQBCRAiUQKMO4J9y9JA9mE+Nt1swVulRPwiqEuYzZYKZ2X47BaUJEJj/5kUHjpFjw1JRPH7u9xk7JuqMyzMbNqQ5PN21D+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkSXlvd9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so62404141fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468730; x=1715073530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr4Ktmncw5KoRokZExfBuNW0/i+XS2TcRisLXwnWQEk=;
        b=WkSXlvd9cx2bZif5XVFib7qaIdAYGesTf63WuR/zufi2f+UMDiqXnYc3lZb3LWUjic
         X3mhYASZjxGUBvnYXcRbwfcG/l+BG0s/pYGLD3BIBpJziirjiCo/2gFWBj1QhuUHNfv9
         BI628rnFAsjlSuBI+QScfnNPqybLCHa/4+4jpQ6L2wNSmn8SYEs/41U1VNYMrydwwYfx
         NditLqZ7QZ3gD7rmN4wJr2X46M0KxH3bCyPUZ8Vs3CKUpgVO8UZARYhffzf15ZqOzmu6
         nsoi0GyThi0gC+7Ft2MDTDek/si7WeLm8CeZ5vQgXtzKmCo9Wwh4FzCKs2egLHHKVFBt
         NFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468730; x=1715073530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr4Ktmncw5KoRokZExfBuNW0/i+XS2TcRisLXwnWQEk=;
        b=j03EuTQ07RsJPo0+kMd/aaV+C1kxDBx54ieAhJgqE2EVWwvDVjf7vIDSyJRYA4b6EH
         1TkqAJgM3DJSQkmZ7tL9K3N83+2SsUHE4SZcpydNE47jt3UrnbKpwTMzqiLawuZFfVgH
         eqlIQp5WdqWHKzNx6Ey8/ux9FcepiKJ5XY2UzZWDnFpsdwbXWo7VWtsWbh6RKZQI2+px
         tRI4J+OA/zfF3flSRqWKWJaHG9TWhub6xZbvXPYrVIv03zaiPDqoUfCajqRos4Mu6V2n
         guvLwxd1Y33caYbeWwuNbHwl4RX3MwB3cwHYhcPPRrdkjwPGiJ75fxqf0QKpicPwEupx
         989g==
X-Forwarded-Encrypted: i=1; AJvYcCUMvSIOu/JOkfWeKin/yn3Asy5mfvSV+CriIgjLEuaycdMlXmmmR5fIWDW2G6uUHLVsLHJpi/2ul7LD44mC0mxBw0je6h2sntN6UEsw
X-Gm-Message-State: AOJu0YwOdXkx0M+b1gt/6WLSpe1UHtzK1Gqt9UK/hnKch096DMbiNBNU
	taRf8uicrPsfi54wts0cblkh4cVZm5+3fbFlOFY25r0kbR0E1Rl7
X-Google-Smtp-Source: AGHT+IEgcZkxWJQ/X9BGaoo2nA/DY+i16BPhCILU82zCnN3ZvUcWkRT6fQn4ObLSV/2V8M3VK80Xdw==
X-Received: by 2002:a05:651c:327:b0:2e1:18d:5b4f with SMTP id b7-20020a05651c032700b002e1018d5b4fmr640631ljp.42.1714468730125;
        Tue, 30 Apr 2024 02:18:50 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm26324458wmo.13.2024.04.30.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:18:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 5/5] x86/percpu: Fix operand constraint modifier in __raw_cpu_write()
Date: Tue, 30 Apr 2024 11:17:24 +0200
Message-ID: <20240430091833.196482-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430091833.196482-1-ubizjak@gmail.com>
References: <20240430091833.196482-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__raw_cpu_write() with !USE_X86_SEG_SUPPORT config uses read/write
operand constraint modifier "+" for its memory location. This signals
the compiler that the location is both read and written by the asm.
This is not true, because MOV insn only writes to the output.

Correct the modifier to "=" to inform the compiler that the memory
location is only written to. This also prevents the compiler from
value tracking the undefined value from the uninitialized memory.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index d20255138426..c77393cd0273 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -178,7 +178,7 @@ do {									\
 		(void)pto_tmp__;					\
 	}								\
 	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
-	    : [var] "+m" (__my_cpu_var(_var))				\
+	    : [var] "=m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
-- 
2.44.0


