Return-Path: <linux-kernel+bounces-139529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26328A03FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874962880ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE433335DB;
	Wed, 10 Apr 2024 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfvkk3tt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88F39FEF;
	Wed, 10 Apr 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791481; cv=none; b=W9e9KDviiKJ1zXDR4FFVByBWGVhbFxsizPPnRxA7dcsSPGkIZ+NVwrouBSj62KW/OQ246LZZvbFUC4EfHGL3Jcf3DmqYIdcX2RjVkYDX1DYwITZx6cFOPb9fEC3n8jtnqVV0vi0BjVKCbHAeXj5cX/iCNQA2PUNj8crEdWcUuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791481; c=relaxed/simple;
	bh=VSMecFXyAePUCgsz3RR9EcSrH9KxBkZyQT9d7RkgPQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OXL6VO74CvnrCnNNHvGKac4cD7ZQ2GH1UnE/3QedjS4EX2tVWKWeuOX6Ffqgi8DX1jMc9K946haj8j/YDGLV3h4U1urXzC1vOi4dzFn18AqpfjPXxN9YmyYE0cJHEPlOh3jwJsSpKtVYQ9a2TZWjDLamrWJ3UgHuYBKfygNFhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfvkk3tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA8DC433F1;
	Wed, 10 Apr 2024 23:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712791480;
	bh=VSMecFXyAePUCgsz3RR9EcSrH9KxBkZyQT9d7RkgPQw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Yfvkk3ttkevWKhpWjnk5GUGu1t24eMxzcURqrCguTdfq5JV+aI3NxM3bmw2FNdLIQ
	 J8sp/IgJqS3yQ5vicxx7zMcLR56cBPPuvx591BPIP4ZreB9vs2YGp9JG5lXG1wyzD1
	 cldfHM3nM0FI/IQOfijlM0eWeT9BDhyDTeeEJM24SgdAN1ca7iI/Xy19Sw9Cla7YUx
	 QN0nV2A0DFAnN/7h7JHY16SnKHayp7MSqvIUHHA4mT02PEk0FoJjW6HnRUw69l9N5/
	 hOTxVA7NiTMZoi9DVlUdVAtR18nceI0r1mZtgZ/EqM6ugraah2ks3FCbi4Ca/407x0
	 bVoGYVpW1uedA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67DCD128A;
	Wed, 10 Apr 2024 23:24:40 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 11 Apr 2024 00:24:19 +0100
Subject: [PATCH] kbuild/x86: Use $(KBUILD_AFLAGS) in Kbuild's version of
 $(as-instr)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-as-instr-opt-wrussq-v1-1-99b1a1a99f93@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKIfF2YC/x3MwQ6CMAyA4VchPdtkjEWIr2I8lFGhBwa2Q00I7
 +7w+B3+fwdjFTa4VTsov8VkSQX1pYI4URoZZSgG73xwoXZIhpIsKy5rxo9uZi8MHcem5ebqXYB
 SrspP+f6v90dxT8bYK6U4na+ZLLPCcfwA/OQD3n4AAAA=
To: Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712791479; l=3696;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=+llTpAM1iXzBXWQE4E3YCDwpY226FU9sEdHRM+0QVpA=;
 b=8Y1dDthNatE9Xo7kK5BBVgBX5fExnKyrSVxyAhLa+w7TzV95A+BV7gNVUNoKRliO6m+acwj3rYt4
 kenCR8tzAX9gMGMTbmRDQllZ2+0SgDhz3Kcz3A1eOdUDCXljlqae
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

At Arista some products use compatible 32-bit userspace running on x86.
As a part of disto build for ia32 it also compiles the 64-bit kernel.
While the toolchain for the kernel build is yet the same, with 64-bit gcc:
> / @Bru-na-Boinne% file /usr/bin/gcc-11
> /usr/bin/gcc-11: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6571ad50d8f12eece053f1bac7a95a2c767f32c9, for GNU/Linux 3.2.0, stripped

It seems that gcc is being smart and detects that it's running in
a 32-bit container (personality flag? 32-bit mmap base? something else
inherited post-exec?  haven't yet figured it out) and by default tries
to build 32-bit binaries.

That results in a failing toolchain check:
> / @Bru-na-Boinne% printf "%b\n" "wrussq %rax, (%rbx)" | /usr/bin/gcc-11 -Wa,--fatal-warnings -c -x assembler-with-cpp -o /dev/null -
> <stdin>: Assembler messages:
> <stdin>:1: Error: `wrussq' is only supported in 64-bit mode

Which passes when -m64 is directly specify for the build check:
> / @Bru-na-Boinne% printf "%b\n" "wrussq %rax, (%rbx)" | /usr/bin/gcc-11 -m64 -Wa,--fatal-warnings -c -x assembler-with-cpp -o /dev/null -
> / @Bru-na-Boinne% echo $?
> 0

As a result, kbuild produces different value for CONFIG_AS_WRUSS
for native 64-bit containers and ia32 containers with 64-bit gcc,
which produces different kernels with enabled/disabled
CONFIG_X86_USER_SHADOW_STACK.

arch/x86/Makefile already properly defines KBUILD_AFLAGS += -m64,
which is luckly already available at the point of toolchain check
in arch/x86/Kconfig.assembler

By hacking around Kbuild variable the following way:
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -13,7 +13,8 @@ left_paren  := (
>
>  # $(if-success,<command>,<then>,<else>)
>  # Return <then> if <command> exits with 0, <else> otherwise.
> -if-success = $(shell,{ $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")
> +if-success = $(shell,echo '$(1)' 1>&2;{ $(1); } >/dev/null 2>&1 && echo "$(2)" || echo "$(3)")

I got the following output for the toolchain check, before:
> linux @Bru-na-Boinne% make ARCH=x86_64 oldconfig V=1 2>&1 | grep wrus
> printf "%b\n" "wrussq %rax,(%rbx)" | gcc  -c -x assembler-with-cpp -o /dev/null -

and after:
> linux @Bru-na-Boinne% make ARCH=x86_64 oldconfig V=1 2>&1 | grep wrus
> printf "%b\n" "wrussq %rax,(%rbx)" | gcc -D__ASSEMBLY__ -fno-PIE -m64 -c -x assembler-with-cpp -o /dev/null -

Which seems appropriate to me.
This also reflects the existing definition in scripts/Makefile.compiler
for $(as-instr) that already has $(KBUILD_AFLAGS).

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 scripts/Kconfig.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 3ee8ecfb8c04..d8574c1faf2d 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -33,7 +33,7 @@ ld-option = $(success,$(LD) -v $(1))
 
 # $(as-instr,<instr>)
 # Return y if the assembler supports <instr>, n otherwise
-as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) $(KBUILD_AFLAGS) -Wa$(comma)--fatal-warnings -c -x assembler-with-cpp -o /dev/null -)
 
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),C compiler '$(CC)' not found)

---
base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
change-id: 20240410-as-instr-opt-wrussq-48ec37e36204

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



