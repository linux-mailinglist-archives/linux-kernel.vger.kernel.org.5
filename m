Return-Path: <linux-kernel+bounces-157253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A38B0F23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD9D1F2331D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DD15FD04;
	Wed, 24 Apr 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfuR3PJT"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3113DBB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974016; cv=none; b=OCpYv3UVgFJ3sFwE8ZVu0chpd+X1Ai3oU65JR4M+emPxZqu0GV0VAwyhvVwDChU6G0/243JIkd1jorVYJ9VmQMWCwaqufth63vYa0cBJUIo+GLpjkAMwbZ0yKnmprcjyVwV5lo0CpWA8IVc3y0NfFyS8jL/2CuATvESKCx8EVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974016; c=relaxed/simple;
	bh=P7tOci3FIvCaUgN5ShYb22FrHmvvfi3TSK49QcbCOaA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OjgVk2XGndGYs2ya7ccLfwOBA0beVlPKOjHoj3VBtcn2mpUviE1b+QCfK+0JF2VzvjsJxshMAxCdGyE98/I8V+hcg/rsu/krM3/v72eI5+vgpCdMR5fAMJi4qVzOLu6Atn+L718yb9HTmA9926msxmBGkr4D7jiU+9/ma66rRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfuR3PJT; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-34b40e8482aso2426606f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974013; x=1714578813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhjj4lZ1BD8EjRsdlA75QEwqazDOqFi5p2t0e/m1hPo=;
        b=sfuR3PJTx2j3BI0M8lKez/iUgNqLalteVKayl7v1DMGAnTuKzngLGrs52ABJNVsjzk
         meKURXLBqTO7j7Av/SXdUQQUhmVEnKSTjBX7mhPAGZHXaWSLr3b0L2hg0cqOlZ0iauHE
         ZgStj0mwQCY5EowFfa4zWVHS0RQgcbThhg83Ja73iEf79meP/F/XWNOYWXtbp5EPZKPs
         IgCOvAFGTm9Mmn5JwhcADfY5seSW/zIwNzap4z0z4pr2qMcl5um8g3uihwcyKPRNyhbl
         0kANY9E0VbJ/Sg8Bqec9e5lF9YlubDMgxKRE89TtfBCRcLoXGZeN/X1bX9Esg0gx5xLs
         z5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974013; x=1714578813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhjj4lZ1BD8EjRsdlA75QEwqazDOqFi5p2t0e/m1hPo=;
        b=QHgVUD0DK7DlnItXtJYBNZccVMXsULtg0eOn1IJqAmIpwzJs3+LCWeR0GUio4sn91V
         hRG3h62OPRlMDiIMoPAIFoRHLZQlgweTB8jnpN+tf0SsSgJD04E1v6euwRw4cwKUkUH5
         901TP+l1tkQ2oLydVR0Heg6XG81spUT22uHVs6iyZ0d5t4ITOs75DWZebDHcAg4qlp2F
         AJaUOS8TvVz1AmGKNqyPsGxJMrLQ8wr0T6Ik+B9v0tSlM8aZDaES5TtS6M2G7LMLQHQp
         UVtzX//VL00yjnkjLsnAkjHzqaLaRm3+9rpN9KNoSZmidAPNqBvN9qt5SbQU+WxjA0Me
         p+pQ==
X-Gm-Message-State: AOJu0YyMrEjMh3mZIi7oKCUXjvm8a51fJUHIUKVHXJYkIcjX3Q+HM28Z
	5zF4rFxN/FevA5M7dAP/CSz9i176jmUgKsavzQw5iKtrntgwpA0XZbs/L//lzBn1Ii/d1eFIcYe
	ectPQtp+08f3xjZngzvSgHKh+E7HLOws67pN1oy6ceS0jytePfEsRPu/J12qAmuDzEhpdkC6vJt
	34tTm7te7NJR46nH0of0SRXmt80o9v6Q==
X-Google-Smtp-Source: AGHT+IHa58cnUIBreoWbfABwf39S/95YKEcQ+NiYVIhE+uBa5KCrBaMAwHWrFcCcQQ5CDkGU5MRf5zbb
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4689:0:b0:33e:d448:987d with SMTP id
 u9-20020a5d4689000000b0033ed448987dmr10048wrq.6.1713974012466; Wed, 24 Apr
 2024 08:53:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=ardb@kernel.org;
 h=from:subject; bh=idgDjYiAKHOsQh6BKM4ksIPor6eEyvMhl8OTBBlOdlM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T62nHZLEFLnn/7goFXZk7X0zg32aVqSkSCrp9mx0CW
 iq9Nq/sKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZ/JuR4aWxdVvw7dwFEfua
 V5SfUPZ+VSsleLNLaYHDFdfAyz+alzMy3G/ST9E741D48UDWgZrsN1vdT0290aCf+NZ+VqXi3u0 NnAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-11-ardb+git@google.com>
Subject: [RFC PATCH 0/9] kexec x86 purgatory cleanup
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The kexec purgatory is built like a kernel module, i.e., a partially
linked ELF object where each section is allocated and placed
individually, and all relocations need to be fixed up, even place
relative ones.

This makes sense for kernel modules, which share the address space with
the core kernel, and contain unresolved references that need to be wired
up to symbols in other modules or the kernel itself.

The purgatory, however, is a fully linked binary without any external
references, or any overlap with the kernel's virtual address space. So
it makes much more sense to create a fully linked ELF executable that
can just be loaded and run anywhere in memory.

The purgatory build on x86 has already switched over to position
independent codegen, which only leaves a handful of absolute references,
which can either be dropped (patch #3) or converted into a RIP-relative
one (patch #4). That leaves a purgatory executable that can run at any
offset in memory with applying any relocations whatsoever.

Some tweaks are needed to deal with the difference between partially
(ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
in place, a substantial amount of complicated ELF allocation, placement
and patching/relocation code can simply be dropped.

The last patch in the series removes this code from the generic kexec
implementation, but this can only be done once other architectures apply
the same changes proposed here for x86 (powerpc, s390 and riscv all
implement the purgatory using the shared logic)

Link: https://lore.kernel.org/all/CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com/
Link: https://lore.kernel.org/all/20240418201705.3673200-2-ardb+git@google.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>

Ard Biesheuvel (9):
  x86/purgatory: Drop function entry padding from purgatory
  x86/purgatory: Simplify stack handling
  x86/purgatory: Drop pointless GDT switch
  x86/purgatory: Avoid absolute reference to GDT
  x86/purgatory: Simplify GDT and drop data segment
  kexec: Add support for fully linked purgatory executables
  x86/purgatory: Use fully linked PIE ELF executable
  x86/purgatory: Simplify references to regs array
  kexec: Drop support for partially linked purgatory executables

 arch/x86/include/asm/kexec.h       |   8 -
 arch/x86/kernel/kexec-bzimage64.c  |   8 -
 arch/x86/kernel/machine_kexec_64.c | 127 ----------
 arch/x86/purgatory/Makefile        |  17 +-
 arch/x86/purgatory/entry64.S       |  96 ++++----
 arch/x86/purgatory/setup-x86_64.S  |  31 +--
 arch/x86/purgatory/stack.S         |  18 --
 include/asm-generic/purgatory.lds  |  34 +++
 kernel/kexec_file.c                | 255 +++-----------------
 9 files changed, 125 insertions(+), 469 deletions(-)
 delete mode 100644 arch/x86/purgatory/stack.S
 create mode 100644 include/asm-generic/purgatory.lds

-- 
2.44.0.769.g3c40516874-goog


