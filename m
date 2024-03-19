Return-Path: <linux-kernel+bounces-107899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D262880341
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF88B1C22668
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33918C22;
	Tue, 19 Mar 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPgmo564"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C917BA4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868648; cv=none; b=T6bH5HUirSABbSBMyfC4NocdYXIN9HK9JkBazl4tikKsMbzK6pRmXbZ/4VovUC37wubKIyDTgMJQ+bX1q8IpWI2CKOSOfLvVNfqn1K7RS6XxrJBGzEHzAkH9IljpjiTnlD0Azc459H4NJhVsgrBcIz2E9NzfnjxxvbzPu/km6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868648; c=relaxed/simple;
	bh=bgwqTr4nlifBTYhGttDJCHc1FBPJwCOru4AZ5rj/2w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+34GfCh6BOpoz/L2QMutKpmoIKyWh069lae1K0CBt7nuLni9BVs6Zh87CwDmZaofOV7Uz7trI5KMSWSBQ/7Y2b+N9FFWtFqvvOwonUdUXLof7lEH91OitfZaBA5CK9Ag9JIxk0lP4zL2rbr0/5Ay7UbUSCIobvN5hEaO6j3fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPgmo564; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-414618e6820so11069855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710868645; x=1711473445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxqm8/EZRiXdqePPsUMAdmikjSenJoLeHvQVeRnTxm0=;
        b=JPgmo564dWOZgETG7BJ5kYT5/BOVB0SEgBUTOB9a2DHiB2DZPK3NXq2PLPBjpDtTEB
         r/7FcrSNH6yaz7ciwD852ctwjBNsBtOwCvtBsfx4pt6yeMcQBopAcfohuAs9N85NfRQA
         juw+84S9IgaUy4ZQqDbU5Lzhjy22gGx/J4R976JacXR84wncAohY8G+Prp/fNWqPZDAk
         K0tVcdAmG7zGZePMzFCKGpOPTDu9YAWCg8uLhdU/oYNyjtFakBYjU81Lhw/qKi4/z4PS
         KuRLH8AIIr1oZo+iRs/k78lodm71470rZH57K8HQGTLEMs76DRfnoVXv2ywNUfn65cBU
         RTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868645; x=1711473445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxqm8/EZRiXdqePPsUMAdmikjSenJoLeHvQVeRnTxm0=;
        b=kxWGwA2WytJ5+Fu1i2xcaQxsUE8bl1ANs4hzag85XjRazz+QeqO+wUirIt/oetv/i2
         AsnxBbXsP8fQZ/1GhoUCuZmLhmfyLDGjJ81e2KeMlmdfX8VtDVvLFGyhdBTlaQ9E7lG9
         jitMGJA+qkBedFhP4OpStSAlG3NBEKegZYOmIBnz89pS5UJGcj/s/C+Q7IKJzL2lT1Qn
         B9lwOJdQF9tjv2wC0AJiaN+yDnPNZRsauvlEWbyFym6WcXVAOSZlZK9ASXQ4DVn84906
         tNmPN/luqrkyyN2TtX6b5Z/qwwXCRcHro42dOv1K2bPg8wuYhwidxVlA49m0yPseLsO5
         7omg==
X-Forwarded-Encrypted: i=1; AJvYcCXtZGzmvOYDtqJrL0pD9hmAEErxKHZZ8vXG8UPrXc9PdNqWV8kXt07drxC1wvC2gOgwOe7YugIFGYt3Z+2B6z8qhVHmNx/3VVHbVCjj
X-Gm-Message-State: AOJu0YwqFfJnktnQYFhlm8e/6QMqmZ9o0lDWNZ9LAUIr6xFqPZgPC0wh
	19M3mf3pi7R0DraeRK3JTjYGH1zddIVxMQxMHDrnPtMvDOBKmZ4t
X-Google-Smtp-Source: AGHT+IHVC0WpukfTqcr+TcavSo7Yya74MYSoeDV6FECFtCy2gBesmSCIQRMFMMSKtq3P688SlIUIPg==
X-Received: by 2002:a05:600c:2252:b0:414:a97:302d with SMTP id a18-20020a05600c225200b004140a97302dmr2821183wmm.33.1710868644870;
        Tue, 19 Mar 2024 10:17:24 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w13-20020a05600c474d00b00412a31d2e2asm18939329wmo.32.2024.03.19.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:17:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Kees Cook <keescook@chromium.org>,
	Mike Rapoport <rppt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/asm: Use "m" operand constraint in WRUSSQ asm template
Date: Tue, 19 Mar 2024 18:16:46 +0100
Message-ID: <20240319171714.76342-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRUSSQ instruction uses a memory operand, so use "m"
operand constraint instead of forcing usage of pointer
register using "r" constraint. The generated assembly
code improves from:

   6ece3:	48 8d 43 f8          	lea    -0x8(%rbx),%rax
   ...
   6eceb:	66 48 0f 38 f5 18    	wrussq %rbx,(%rax)

to:

   6ecea:	66 48 0f 38 f5 43 f8 	wrussq %rax,-0x8(%rbx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0ee2ba589492..aec6e2d3aa1d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -205,9 +205,9 @@ static inline void clwb(volatile void *__p)
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 static inline int write_user_shstk_64(u64 __user *addr, u64 val)
 {
-	asm goto("1: wrussq %[val], (%[addr])\n"
+	asm goto("1: wrussq %[val], %[addr]\n"
 			  _ASM_EXTABLE(1b, %l[fail])
-			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: [addr] "m" (*addr), [val] "r" (val)
 			  :: fail);
 	return 0;
 fail:
-- 
2.42.0


