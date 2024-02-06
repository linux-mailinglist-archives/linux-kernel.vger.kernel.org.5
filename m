Return-Path: <linux-kernel+bounces-54737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF684B30E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36B11C23285
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9E12F395;
	Tue,  6 Feb 2024 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1YMZore"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849612EBF1;
	Tue,  6 Feb 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217546; cv=none; b=ivkgRbgbmub5rKiVtyd4N5r5e6/C0zvKJTAygBFpAN28KFdrtEj6vRWCAL/1dK2j6BZRG9PIMQhBjzEr1aSd0qs8gcCJRsRSfPnCTyUNCcHA+CBX/MVUW0sW5YkcTiD4d+Q154Jgo/bSSXpdRB359kLTZxmOPcX/lPKugl7et48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217546; c=relaxed/simple;
	bh=H+Nq8LvP8FkxrlJRAmYgk8e/3dEvC0tbNoCGSHxyVo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioeBjY4eqEQcizuGJeyGsx4BCyHAWX0gHm8JmXfKAhaNwB+0Hh+Qz4qjtPDnAaRKlDW8/8t5Vn49DrXSQttF/Pce0P7GkyThfetclItYWMSC5GK2IQJpH9Tm/z3zGyBtTWM6khaac4s2W3KBfV9Qec7Uo/OjDFQHAMzqKDyUWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1YMZore; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E4EC43390;
	Tue,  6 Feb 2024 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217545;
	bh=H+Nq8LvP8FkxrlJRAmYgk8e/3dEvC0tbNoCGSHxyVo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1YMZore3LK+hCmmjIJLFzaMEHTPS9Qer8HNeXEdoITlXgsKwybVTMlk7mMKDGKYL
	 5Lxx2Wcd39OParl2MLKcQlUctSN1L7TYfrEpzMGRxxDnLkyi3RRNvDUdsRudp0NqLo
	 QUqF93n5ZJqy/MDPF6N6FUsR6f+taP3kDkJY1EmYfyHTfIsEFnVCePQSihf5/K2AqP
	 8d6ZuSA2UCudZedqbbxHF2K1EsMxyDiP7N1aT+vDWRgr27TV8/37pIX7c/9hojch1y
	 pWeOAEQuegm7z7CXj2SDZEdxh7aTj7lE4QW1m/TSaWluNkgizRgdaqyuW5JbIZ68oy
	 wB+HVVlTBS9Yg==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donald Zickus <dzickus@redhat.com>,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/6] tools/rtla: Fix Makefile compiler options for clang
Date: Tue,  6 Feb 2024 12:05:29 +0100
Message-ID: <567ac1b94effc228ce9a0225b9df7232a9b35b55.1707217097.git.bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707217097.git.bristot@kernel.org>
References: <cover.1707217097.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following errors are showing up when compiling rtla with clang:

 $ make HOSTCC=clang CC=clang LLVM_IAS=1
 [...]

  clang -O -g -DVERSION=\"6.8.0-rc1\" -flto=auto -ffat-lto-objects
	-fexceptions -fstack-protector-strong
	-fasynchronous-unwind-tables -fstack-clash-protection  -Wall
	-Werror=format-security -Wp,-D_FORTIFY_SOURCE=2
	-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
	$(pkg-config --cflags libtracefs)    -c -o src/utils.o src/utils.c

  clang: warning: optimization flag '-ffat-lto-objects' is not supported [-Wignored-optimization-argument]
  warning: unknown warning option '-Wno-maybe-uninitialized'; did you mean '-Wno-uninitialized'? [-Wunknown-warning-option]
  1 warning generated.

  clang -o rtla -ggdb  src/osnoise.o src/osnoise_hist.o src/osnoise_top.o
  src/rtla.o src/timerlat_aa.o src/timerlat.o src/timerlat_hist.o
  src/timerlat_top.o src/timerlat_u.o src/trace.o src/utils.o $(pkg-config --libs libtracefs)

  src/osnoise.o: file not recognized: file format not recognized
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  make: *** [Makefile:110: rtla] Error 1

Solve these issues by:
  - removing -ffat-lto-objects and -Wno-maybe-uninitialized if using clang
  - informing the linker about -flto=auto

Cc: stable@vger.kernel.org
Fixes: 1a7b22ab15eb ("tools/rtla: Build with EXTRA_{C,LD}FLAGS")
Suggested-by: Donald Zickus <dzickus@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 2456a399eb9a..afd18c678ff5 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -28,10 +28,15 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
 
+ifeq ($(CC),clang)
+  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
+  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
 CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
-LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
-- 
2.43.0


