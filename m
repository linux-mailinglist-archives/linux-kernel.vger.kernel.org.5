Return-Path: <linux-kernel+bounces-107399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8D87FBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCAE2845EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F356444;
	Tue, 19 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0/icrU+"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB74CE08
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845066; cv=none; b=jab+5xtTO4zb51w/WGFejw5u0v7sR+2LX4oqPOLYkMd2WUIaMkPZbG2DnKaAKcmgr1rWEtzJhDh/GEwyNl6Stu/zmaMLCt64wEAdtVkZ/jNM93/IHTEn1ap7d2mb4a9mgqP3aP0+rJBjRJ70kmTtxk4K61+Z1k40XdpX8YzE1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845066; c=relaxed/simple;
	bh=7LhSr5+k+GBVSUTqtH/lpjLZtcZyDsWwQPJKp5P9d9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYk8IAcUNXO2sbnv4e6xs7UTsf8eSgLCvwfaeNKt+8cBT6tnFFcDwZW6FLkydqFpSVPK0cno9dketPi+18T9Ls5ph1YmMrjW8rE3r7rAPhxYgdxKTTO0RnDTjUCBbDzJToa3LvdFhxjkAlvdIW6ospEmwXLhshMgjD3nfnr/0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0/icrU+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568a53d2ce0so6431813a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710845063; x=1711449863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKApB2VQZ41H14nOfmTeU37ZbkewUvI4J/KbtvIHGSo=;
        b=Q0/icrU+JRwARSbDm8WiC0DToeZdO3ReZrJtPUVIBLmXM0oUvM0rlm50Eu2VO1MY7q
         KWdwp+CUfNSYWrm/Nl4Hre83IFh6cyqk5PR500WT0bqLkurSpcPer6QKdsVA822CTYtA
         qy3/2i6O3sUWFLNZiaT9z0p7i6yKGqyNvul1EdtSo1fv8Hyo4ZFammi+CUM2EcvUrNiu
         q8omMh3/gQjTGCdXP7xlFJq8qyGDQ211icCKG/0BXQfy0F++LhjkZUZKcgPGArPHz091
         M2rtwytC2Swm1qsTeT6yWQv3wbvCAVF9rrYme8CTxTFuB/SHW7mg/K30uymdE+3ljvVa
         keYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845063; x=1711449863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKApB2VQZ41H14nOfmTeU37ZbkewUvI4J/KbtvIHGSo=;
        b=RV8hI6YSFEfRwKjHUl6eneIcb8NBrgy34WQwLKOzOjcRWJE+4L9gdFhBiD5fHSIVSs
         u+uywwK7JrdVj52feW3I5ybKGv8LI+jPaOEsEqDCbKbaEMEYjstq3l3gDlgPyjIgEvBL
         VNjEIbn6gTZTjndmfbG4C0JsHeSOjZH3Ojv32MyHxPetyP74qKV7KcB5jZVW2Fshn97/
         Fwm0qkAmDpJZaUWmH+aFTRiz9V1furV33pigM8yfJgHEE7Liyd9XuJV97gss75L52VS8
         TbzraWEcO4C3jaIz/f0yRnNIYuY0oJ5hpaBTgDiCd5/Cx3vzJIdEnE6gm3oVdAmQ4dIc
         Nspw==
X-Forwarded-Encrypted: i=1; AJvYcCWljsQBjGe3wr9rNwknZLEB7leLddYtwby9suU35W+LPl3T2TKok4O1HUoPqYLqEkjdEfeksV+BOMlRT4SU8bfGybyGn9UaH0axxGyH
X-Gm-Message-State: AOJu0YwP8rJXtv+lm/5v3WkdNsbmSqzzNqasWXn9r1wXTUvqQaVCtSVV
	ngMKbLWO2gsWfECHIdEEJbAw9/pssbyAFrAIlsCStr2tB8k//qDZTGY+v5g0Vec=
X-Google-Smtp-Source: AGHT+IFiOg2Ym/6DOZ9i+B7WKNVM7xgwYC1wSyMGcyKbuxBnwRN+BbqAM7drQIZ6fTBB8U8bda1AEA==
X-Received: by 2002:a17:906:40d0:b0:a46:5d40:eb97 with SMTP id a16-20020a17090640d000b00a465d40eb97mr8593785ejk.70.1710845062948;
        Tue, 19 Mar 2024 03:44:22 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm5882342ejb.82.2024.03.19.03.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:22 -0700 (PDT)
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
Subject: [PATCH -tip 0/3] x86/asm: Use generic asm operand modifiers instead of %P in asm templates
Date: Tue, 19 Mar 2024 11:40:11 +0100
Message-ID: <20240319104418.284519-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "P" asm operand modifier is a x86 target-specific modifier.

For x86_64, when used with a symbol reference, the "P" modifier
emits "sym" instead of "sym(%rip)". When used with a constant, the
"P" modifier emits "cst" instead of "$cst". This property is used to
emit bare symbol references and bare constants without all
syntax-specific prefixes.

The generic "c", "n" and "a" operand modifiers should be used instead.
The following table shows the modifiers supported by all targets and
their effects:

Modifier    Description
-----------------------------------------------------------
'c'         Require a constant operand and print the
            constant expression with no punctuation.
'n'         Like '%c' except that the value of the constant
            is negated before printing.
'a'         Substitute a memory reference, with the actual
            operand treated as the address.  This may be
            useful when outputting a "load address"
            instruction, because often the assembler syntax
            for such an instruction requires you to write
            the operand as if it were a memory reference.

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

Uros Bizjak (3):
  x86/asm: Remove %P operand modifier from altinstr asm templates
  x86/asm: Use %c/%n instead of %P operand modifier in asm templates
  x86/asm: Use %a instead of %P operand modifier in asm templates

 arch/x86/boot/main.c                 |  4 ++--
 arch/x86/include/asm/alternative.h   | 22 +++++++++++-----------
 arch/x86/include/asm/apic.h          |  2 +-
 arch/x86/include/asm/atomic64_32.h   |  2 +-
 arch/x86/include/asm/cpufeature.h    |  4 ++--
 arch/x86/include/asm/irq_stack.h     |  2 +-
 arch/x86/include/asm/processor.h     |  6 +++---
 arch/x86/include/asm/special_insns.h |  4 ++--
 arch/x86/include/asm/uaccess.h       |  4 ++--
 9 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.44.0


