Return-Path: <linux-kernel+bounces-107400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77587FBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA72284654
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A35811E;
	Tue, 19 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBPvBDxZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7164F8A9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845067; cv=none; b=bqcnUnSGWnMAWBLD9TZcT77VAjAPGh5Xi65IruL9VuxZU6GODf5fg9FCj2Qldxx58C6W1qszZqmbTUdIJZAZ/0U3WX8mrCJxXdh1EBNDKHbRD+A7sxjsTAZPKYvS+nKGnEIlMIt/VuhibIDv2IVH/tfp3og0h2ONVbwYKybB2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845067; c=relaxed/simple;
	bh=KuDN4TsJpUA7qIqTogBLloXUjF1n1mIpLiEi18h60Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYbmKsbidwhFs17nJEiTlQq+0wYLsxl/Ns7H9lHqGQfi4b8gcUEB1EJPm8iIX5736MqlasBUvRU4Im5ShwmFnMs25T3ltdbG4a7aF3en1x6zsoFvV4i90q6b6BdVb+Q1SRh1HRvejPL2ALJECSaC/PYPjJj9J77oiJBfr81kZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBPvBDxZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a468004667aso569411666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710845064; x=1711449864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdmJkAnOt/DPnv0ghrf21igOWcX5RWrVVUPHV7j2y1Q=;
        b=lBPvBDxZi58xvgqaL/4iuC4pJ6EdoA309xrZGfo/pijV+Hivx6OUckpj3pKywvgFbL
         5+1yGpYY7L3BJxN+esTUbW1GnLNGKUBAP6ZsGSeHnbdxAxabRaXn+quvcPO9yKiOR7/J
         xWkTeqm86BoI5B266aSu2/vLuvF1zBLRDVZJrnwq8Rd6OEf9Jg7i1FnBexj/Uz1wLu6K
         4InAcG7mvke+q8tiFV4lvExZK0sKuO+HTR+62V1QWfRdkH8Qlax7K+ESMS7nX5FbutlS
         GOyM8Me3CeyQ8DWrR1BVgpPbs1lfa9osL2jXyOiCnzggQ6pV+hxkFOJ5XmeJWOVOfiWU
         L1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845064; x=1711449864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdmJkAnOt/DPnv0ghrf21igOWcX5RWrVVUPHV7j2y1Q=;
        b=ePLtSGyDp9N3zzmc2drwv8VXow2iHCwppRTDqLa3gECfxCdVNNkZKWtQ1OxaD2kxu8
         XdHKALz9qyrU8D0aaE/eVaSmaVBMi/9ROzx2OnuvYAWr1cm1+oz/YCimhQx7LcavnIvM
         LrpytYzFJCUGvldoNOE7Sysg/LNn+9c+gsx8bUTFIq+yf4IMCbikR1uTmKPekTr/vUAc
         miU1JxslKOxZ1NUo/vfKWO/XqXqJ3ahz8+PjBQil2xkJDPM1qNsuIPl4qU+8je0chDbE
         vOStyqRQBXMZqP/VibH54mLlbDbE6+ryH7/RttZv/A/pgppgVvIr328s53Da9bm5Fakk
         Yi/g==
X-Forwarded-Encrypted: i=1; AJvYcCXb+hSQRgYl61M56wUMAJr07JoRaJmZK4XbtG4aP0/MimqOKrOSUEiD8hOesCvn4ECuzctme03oYdyek6r6VRDw4uOK0oEKejI61sJF
X-Gm-Message-State: AOJu0YwIhVv0LOCsFVz8AgR7xYkhyXIrlslWsSq9cfrfMhJb8YN+i7rr
	3ha+C3BGp3SQRlq343AbbpEvZoclX8dGxUgRJRSAKZJCWQ9a6Pm+
X-Google-Smtp-Source: AGHT+IG7PuX41Vf/F1NEg49SK0Z8URKAy38lrXj4zNIU6IR7OlBypZ2i8PPydttdc/lAcG9C2UYgDg==
X-Received: by 2002:a17:906:4944:b0:a46:2c48:664d with SMTP id f4-20020a170906494400b00a462c48664dmr9473452ejt.8.1710845063754;
        Tue, 19 Mar 2024 03:44:23 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm5882342ejb.82.2024.03.19.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:23 -0700 (PDT)
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
Subject: [PATCH -tip 1/3] x86/asm: Remove %P operand modifier from altinstr asm templates
Date: Tue, 19 Mar 2024 11:40:12 +0100
Message-ID: <20240319104418.284519-2-ubizjak@gmail.com>
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
used to prevent %RIP-relative addressing in .altinstr sections.

%RIP-relative addresses are nowadays correctly handled in .altinstr
sections, so remove %P operand modifier from altinstr asm templates.

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
 arch/x86/include/asm/apic.h          | 2 +-
 arch/x86/include/asm/processor.h     | 6 +++---
 arch/x86/include/asm/special_insns.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 94ce0f7c9d3a..fa2e4244654e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -91,7 +91,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 {
 	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
 
-	alternative_io("movl %0, %P1", "xchgl %0, %P1", X86_BUG_11AP,
+	alternative_io("movl %0, %1", "xchgl %0, %1", X86_BUG_11AP,
 		       ASM_OUTPUT2("=r" (v), "=m" (*addr)),
 		       ASM_OUTPUT2("0" (v), "m" (*addr)));
 }
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..438c0c8f596a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -587,7 +587,7 @@ extern char			ignore_fpu_irq;
 # define BASE_PREFETCH		""
 # define ARCH_HAS_PREFETCH
 #else
-# define BASE_PREFETCH		"prefetcht0 %P1"
+# define BASE_PREFETCH		"prefetcht0 %1"
 #endif
 
 /*
@@ -598,7 +598,7 @@ extern char			ignore_fpu_irq;
  */
 static inline void prefetch(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchnta %P1",
+	alternative_input(BASE_PREFETCH, "prefetchnta %1",
 			  X86_FEATURE_XMM,
 			  "m" (*(const char *)x));
 }
@@ -610,7 +610,7 @@ static inline void prefetch(const void *x)
  */
 static __always_inline void prefetchw(const void *x)
 {
-	alternative_input(BASE_PREFETCH, "prefetchw %P1",
+	alternative_input(BASE_PREFETCH, "prefetchw %1",
 			  X86_FEATURE_3DNOWPREFETCH,
 			  "m" (*(const char *)x));
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2e9fc5c400cd..0ee2ba589492 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -182,8 +182,8 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %P0",
-		       ".byte 0x66; clflush %P0",
+	alternative_io(".byte 0x3e; clflush %0",
+		       ".byte 0x66; clflush %0",
 		       X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
 }
-- 
2.44.0


