Return-Path: <linux-kernel+bounces-107402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2A287FBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D58284DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC17E76B;
	Tue, 19 Mar 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGR8xswj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DD7E56B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845071; cv=none; b=MQhvxrLfX+DMVgmRUi4i0R9JJJRf0svlEQvykmgX5lSrF6C7g9uiNKmrzEZ5gZS6ydDkbxrYpBp9sQLL7ejJ9lJG/6OwyR3GrXVclFoZrmKaH0dyvyNiz44W0adxt3v22DxeRhHDEET4G5V0FndSNZVvkPPCqL2cBZbvuMZoZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845071; c=relaxed/simple;
	bh=d7tiEHopGAl3cIz2XD2WOO3+d1hLbV9VFAs1Dhfjv2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D31EZXyaIEkrnxHdEQlFIuwbcbrOtNWWugUp0fLXOf74xbKoy2kJ5/G93FfnsvBukrlg6VBjcCkw5Jq3AqmMlBiR01Iu4mFMFjXghDNBjDAjHSMRrFsT43RH9yntSlOv6klercOAPbKtU8Y2Vt/YnCwpQ5Ud6JcLUzHe4BClckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGR8xswj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso66799466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710845068; x=1711449868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQ1yb6iGb3d17BmqG638lsarTHpqGq0a9mQ6hQHFbc8=;
        b=WGR8xswjzDNvHKDiOf10WFPVqKuhFsUcRjBoA9SQy/jenAD832ESrIaE1A2VnmTX4Y
         AQ2/4FmfHAXEYwoxZLWuwrVaJU7vDivYqhQkKX7u2ZWtFTlzHm0hBfwy23Eexa3wYmz5
         282TzrFNa4crejk8AxXeJCeHcUqL9+HsBicTrYTdydrPBY+I+oT+AErOiglMP+pmBuVa
         KUTsTv0TX8cL9BSgyaX1aXjaC5GgpDejK4L9JVrMP06Adiq06mYDE891AQk2cnDuSkfq
         OmoZM6eUQw/RUNmpzoDovzS4vKpg+Q3FPxzNfxvU5ixvqo5qKS38E/TKFPFSXplXsokj
         aQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845068; x=1711449868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQ1yb6iGb3d17BmqG638lsarTHpqGq0a9mQ6hQHFbc8=;
        b=BdJ4wGdNk5SWUPWWsl6G1gfBLNbBIigKQq9qU1En37iedkmd63xCJk3YNOQpk/o4i1
         tjTZvTu7Zvrp/BfMVBVwPPfew9jAzGr+i5w5pRwSyYY3l11cAb3wOYhRHOUuUoeC93C0
         klK0QCPfhiKnlyJpWLTaK7V+HzxRN6k/Ms4kAMNv70I7gV8hFrHSq+9XL20fEfKkMLBW
         l5MvgkfYea0Ux7OUQOcp11vSj6po2SHZuyMlTH/1LBmkFbTl+xwZGesI1FVb2KLkjj/0
         KreCQP58cQg7arQdViiYb6cMvvhgIJzrz4Ym3T3vzuNuFcFoASaX4uLDDTF5qkK3/m26
         iY0A==
X-Forwarded-Encrypted: i=1; AJvYcCU1iqIA0okk+IJikzIlidCF48ac3SBpP3VFLVoxdAtQFLLgpDamGWMnRyUlZvDLcVnFDgk/GpJs94Hm1CeVMpX4NTmk94TaBXc7dQ24
X-Gm-Message-State: AOJu0YySLdYehxYfk2DTgOt9ZV0nQass1UKxmgSYjPLT3luCbUxvcnxs
	/4CybZbZwAntk4rMXppscUowAXlOygrI91SCrkeOp5ynWmN5u5fF
X-Google-Smtp-Source: AGHT+IGG7cKhtzJvfiihETkYMGvT1No23quZLCmVUevI6w+biET3gRJt3h/Fi3eX38/WxTmTbyxorQ==
X-Received: by 2002:a17:907:33d3:b0:a46:1a14:3563 with SMTP id zk19-20020a17090733d300b00a461a143563mr10374480ejb.50.1710845067548;
        Tue, 19 Mar 2024 03:44:27 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm5882342ejb.82.2024.03.19.03.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH -tip 3/3] x86/asm: Use %a instead of %P operand modifier in asm templates
Date: Tue, 19 Mar 2024 11:40:14 +0100
Message-ID: <20240319104418.284519-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319104418.284519-1-ubizjak@gmail.com>
References: <20240319104418.284519-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "P" asm operand modifier is a x86 target-specific modifier.

For x86_64, when used with a symbol reference, the "%P" modifier
emits "sym" instead of "sym(%rip)". This property is currently
used to issue bare symbol reference.

The generic "a" operand modifier should be used instead. The "a"
asm operand modifier substitutes a memory reference, with the
actual operand treated as address.  For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym",
enabling shorter %rip-relative addressing.

Also note that unlike GCC, clang emits %rip-relative symbol
reference with "P" asm operand modifier, so the patch also unifies
symbol handling with both compilers.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpufeature.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index fa938ed96506..daae5c6e7d0e 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -172,7 +172,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
+		" testb %[bitnum], %a[cap_byte]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
 		".popsection\n"
-- 
2.44.0


