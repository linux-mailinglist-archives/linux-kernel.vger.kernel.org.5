Return-Path: <linux-kernel+bounces-150739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ED28AA3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9251F22A25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E7F1836FD;
	Thu, 18 Apr 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGso32qo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D76A00E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471442; cv=none; b=Al7Dr7ZHkhI7EsPkY3GYEpZQ3xDRR921XiD7AcZ3kFK4lZwRtMCmOZbN0SDrU8BTWnCuROq4q/8XdEHYcuVBOdtCAXWVfF9tKZxhjk+4EBUi/Zh7squZInLs16s5L5Va+yEmNJy8R7+6FXB/XQwsLSXttw7Tv/ctWyYLfxROU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471442; c=relaxed/simple;
	bh=PNpJ102IODnY+tP+EPd4hBpdwzR2uPBBpsCceK5xb1Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sSVHGwpYbtPwa5Bvi8Eaq2/VPd67YuzusEivINFosX7fgBMyTD6J0FY+dWhSW9pmqeXzzVBAf/uMtSI0ry54fFmIxB3jkgVm3JfDbLJBR1pNSJvEjugLNBIEQvzxgzxAS68+MAY6D5ZW5X3CQm+sJUtSVJHmdCLOZZgtNWrP5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGso32qo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so2287927276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713471440; x=1714076240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nPRPig/UBV/GYmfvV/J67GripPGXMGIUkVLpwA56bFk=;
        b=uGso32qoUzfsGxoN4A39Y+kdwdEOTuFPfrP8xZmz32jJLkTeEj/igkFBwl6A3TsEWr
         nl17E4B2TO+FhORhr32dTLIwO5blXRYb6w9W+WnlfgyovKKP7nnMgrCoPT/GQsHJONwn
         sh5+TySjxkjfySV7OIFwcBDYsaN8DkrQ682kCI1diDAPzpzneIaLztK15pcyF/MplRX+
         5VgGKIX6p1NWTTLOu7FnA7SWnNzk4d0TEFkGGW+CzWCOVNE1AelbkKTUX8oSJVdfpoRw
         s/pOzsziJhhzvtb3BrYxJtOP/QFdXkNPB/rZ7twNPAWT4ARgeF3zcXDRrC85GY4T9mPe
         LfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471440; x=1714076240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPRPig/UBV/GYmfvV/J67GripPGXMGIUkVLpwA56bFk=;
        b=l29dk9/o7jyI82v6opHNmckt/QmHDXMxlM7la1m76vdWLtTKhxoyVLNZLLEHorEws6
         5IengdY93p2ymNaSfFQvX62VMWdd9J/xne41NhYYlvlaOFAtuogf82SzgSAb63o2y2PM
         HyaSN1aMa1St1YU1ocrZoJEFvE6XkrGSG0vL2syjotevkwbnUZFNGFbGAIDhb2etWp32
         PK0vDR4yzAYK6wpo0EItFpYDAFAssh5Ph4bHtxzQrBbO0t07lxj+9w/TaK5Bok2BfPv+
         lm57ZEle2ipI1tYQmaIW4/AjODvGCN5FCWxihyuZfXpSZ2+gB1E/tCt0XAl2ryaHc0gA
         UJfg==
X-Gm-Message-State: AOJu0YyVzL6HfpI2BVJ7kZbTQXNMVio+Xs+TcR7yEQW8WDnHncSHScIb
	oDfxK+MQ2I7Ue0iHP16Q3aAnh2HpJkWGJuyA7RQ5jwlpD4kdpPFjJPwe8rJ12VAMg+gn4aQrPbt
	8Oazpl0+tysmSF+0EmZPVY1gbPSgzLMgV5ywqrCcJqk4jJU511ODZG5BgkQ6bLN4GI3BDJhpyaJ
	OfnbNnekzryIHmXAlHVQF3C6PiSZxKxw==
X-Google-Smtp-Source: AGHT+IHhR2ajpJ5AbKkKViK2PWF29qowrptoZgf1Y1XIFZIDe3IMYHifRXgRh70WSViJcAY5E97OOgPd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1005:b0:dcb:fb69:eadc with SMTP id
 w5-20020a056902100500b00dcbfb69eadcmr444642ybt.6.1713471439850; Thu, 18 Apr
 2024 13:17:19 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=ardb@kernel.org;
 h=from:subject; bh=MPuylR2BAeKlyMS0C+bD7PXG3vqlOIfrzNI/uvzYVJY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU2x/uD9iAdF0/M+8kzr+XBP6uE0h2d7lIM7mozWPwopF
 itS+zSzo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyEqZmRYdW+5VmfT519Zx91
 8J3XiVKVRP15NxqKTB11Atp+ep7tPsrIsGx1mOv/jsh9bB3rjr03+e279umMLq9diwV3BqhYMRe vZgUA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418201705.3673200-2-ardb+git@google.com>
Subject: [PATCH] x86/purgatory: Switch to the position-independent small code model
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>, 
	Ricardo Ribalda <ribalda@kernel.org>, Fangrui Song <maskray@google.com>, 
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On x86, the ordinary, position dependent 'small' and 'kernel' code models only
support placement of the executable in 32-bit addressable memory, due to
the use of 32-bit signed immediates to generate references to global
variables. For the kernel, this implies that all global variables must
reside in the top 2 GiB of the kernel virtual address space, where the
implicit address bits 63:32 are equal to sign bit 31.

This means the kernel code model is not suitable for other bare metal
executables such as the kexec purgatory, which can be placed arbitrarily
in the physical address space, where its address may no longer be
representable as a sign extended 32-bit quantity. For this reason,
commit

  e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")

switched to the 'large' code model, which uses 64-bit immediates for all
symbol references, including function calls, in order to avoid relying
on any assumptions regarding proximity of symbols in the final
executable.

The large code model is rarely used, clunky and the least likely to
operate in a similar fashion when comparing GCC and Clang, so it is best
avoided. This is especially true now that Clang 18 has started to emit
executable code in two separate sections (.text and .ltext), which
triggers an issue in the kexec loading code at runtime.

Instead, use the position independent small code model, which makes no
assumptions about placement but only about proximity, where all
referenced symbols must be within -/+ 2 GiB, i.e., in range for a
RIP-relative reference. Use hidden visibility to suppress the use of a
GOT, which carries absolute addresses that are not covered by static ELF
relocations, and is therefore incompatible with the kexec loader's
relocation logic.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Ricardo Ribalda <ribalda@kernel.org>
Cc: Fangrui Song <maskray@google.com>
Cc: Arthur Eubanks <aeubanks@google.com>
Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org/
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index bc31863c5ee6..a18591f6e6d9 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
-- 
2.44.0.769.g3c40516874-goog


