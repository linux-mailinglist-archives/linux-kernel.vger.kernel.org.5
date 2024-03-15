Return-Path: <linux-kernel+bounces-104155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7687C9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA1AB22E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08419175B1;
	Fri, 15 Mar 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoJ55ACG"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0917591
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490752; cv=none; b=oxYDAzv5rYCTMYlbb2ct1+mxxQUc5apcuwACagpHhk04GPNA+rhUtp1o46ZSBj3MzLIYx6pQHRv1zG0t//SNgBG/RQ5R1wOfTynRwTjYiNicQ30oxRDSViEx5q7dQ7TUF3LiDLVZkIcEfej6djTmOnryETXu9trTXaeYm2XkV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490752; c=relaxed/simple;
	bh=QLReNtxf2pTycQqTEDrM/vnM3jBtyBcgaOmg9m1IXI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spZYmsiOeNWqkLnmo76msW1n0xeCczcCOELNaxX/WlGbSnJMlTRCKEo9DJjDdaQ7DuLjNOH3Mmxo/gtyJgrZrMdyAncohmv+OU8eNJIlyZN+oB6ketU62iEG+FopU2PQuZ5wgYKfsztyVdPeTpQ3yh1L0WI/WSmzmD/D0z//K8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoJ55ACG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso204231266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710490749; x=1711095549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0rafbw8uTQz401R8sbA18M9Q4FSN4M4NI6BrpHcB8U=;
        b=IoJ55ACGuisqDzi/rfdHNmvblzSwTxCQ5rUx9OZvwwMusoxgGmapyX2INQ4CW87H9D
         TCjnfvNVBZkkkspA9usGHr29gdM0DByq07GWnrLy/EqBAhYMny8a4+HbiVZCx2eli5sn
         62IK84GbaLoqCjyQbjKredXhm7XLj4Z+a9mKAFXNeC7tHGZarMFL4L6DDcHOygsz/5v2
         rRimKP9dMuu5sxypuH1R/VCyEqRs3Y6EdevuXACBDcDXPxz5/04fteQARO0o55akx0ch
         y47J4ii6gGBGLoR4xJstYcJ968guZ3FkTsRNzb9SqnaXZcGmpnaQ2d2L/029DXMywKTx
         8BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710490749; x=1711095549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0rafbw8uTQz401R8sbA18M9Q4FSN4M4NI6BrpHcB8U=;
        b=qH4SBnWpHKbKGD6miYB19BEVDSwPgI0gsWxmWi0cCSyEJi8aricgQWD0ME1V9P23A9
         zEfgyTS0BZEd4wQYWttDIUQbqxY3knJWEqEScUWNvVgxEL1XGPhzpPPyaSW2+F892xTm
         qtcLolnvgyGSxlD9rFTHzyUn9UsFq9oVQgkOFan/iLu5rEgKUAxpo+M5AsXElSjuPPf/
         QDHgqwVL5FW3jauJht0ZVYNofhRsrUM3xYYxFuYNrMDqoPacf2NtR0uscZ0IRoTG0YgS
         q5hkS4hCMJf2Rv7VlA0trYT94Ug670pw7zW/qfbeMxLpbqkAV0xYOkNXYwUCGMY2tu0C
         Bg4g==
X-Forwarded-Encrypted: i=1; AJvYcCVmbDhUTer4h44c1HMY5hnLcXDxnTKQU2Ilq3gJURlBJhzdcRmWwLplI1Yx+b3XSWNqF+KCjR0Cetif+pUDvYRbS8sQuVPUbrrM6j5d
X-Gm-Message-State: AOJu0Yxa75ggNtyL7nHtKZNXKWTtpOXJCqjVfML1LjLL8tUBTqlbYStL
	Oo4DolRMdR5HEUSyTva3CLmeUW5VIdd6gZ6q3vzVLGDD2ZC0A9Ps
X-Google-Smtp-Source: AGHT+IFF9AKrZcdFQqQcgtwMmbd8y1SxdUbt5ZOFjXaoSKMsNKxUYmItOGA+MAP0iO8Q9AwGEdVyYA==
X-Received: by 2002:a17:906:c01:b0:a45:c931:5703 with SMTP id s1-20020a1709060c0100b00a45c9315703mr2187913ejf.70.1710490748507;
        Fri, 15 Mar 2024 01:19:08 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906049700b00a464efbb01fsm1468914eja.107.2024.03.15.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 01:19:08 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/fpu: Fix AMD X86_BUG_FXSAVE_LEAK fixup
Date: Fri, 15 Mar 2024 09:18:23 +0100
Message-ID: <20240315081849.5187-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assembly snippet in restore_fpregs_from_fpstate() that implements
X86_BUG_FXSAVE_LEAK fixup loads the value from a random variable,
preferably the one that is already in the L1 cache.

However, the access to fpinit_state via *fpstate pointer is not
implemented correctly. The "m" asm constraint requires dereferenced
pointer variable, otherwise the compiler just reloads the value
via temporary stack slot. The current asm code reflects this:

     mov    %rdi,(%rsp)
     ...
     fildl  (%rsp)

With dereferenced pointer variable, the code does what the
comment above the asm snippet says:

     fildl  (%rdi)

Also, remove the pointless %P operand modifier. The modifier is
ineffective on non-symbolic references - it was used to prevent
%rip-relative addresses in .altinstr sections, but FILDL in the
text section can use %rip-relative addresses without problems.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 520deb411a70..1209c7aebb21 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -145,8 +145,8 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 		asm volatile(
 			"fnclex\n\t"
 			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
+			"fildl %[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (*fpstate));
 	}
 
 	if (use_xsave()) {
-- 
2.44.0


