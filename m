Return-Path: <linux-kernel+bounces-54741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB484B316
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677F2B26CC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9541130AFF;
	Tue,  6 Feb 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfNv2wNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7850130AF2;
	Tue,  6 Feb 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217558; cv=none; b=hF+ek1yDNxbQryoDfwkH5coFcG2GxlrrGRCA1aVOfWbR2z54oUpbGxY8vVdL0AQ+QLHtwyIBnNZRLtboC79+LFOtSiTvc6afPYAMlf1vb65Spg0vciEZfLBlqqj/3OKq58iGtDljvNWQhzGB+xIL+lSza6oPfFGej+wdqzbWECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217558; c=relaxed/simple;
	bh=oBgtkf5GsR7oInvTgvXmuuezLk03GfOH/+6u6oZvCho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSabcQ/qDLBbaDuc42kcGdTo4SK7BFblGdz7Wvr4zxYiiOmyGiDEjUd+5QRrbUAWEJ9I7shaIxEHCJhYJ7vS8udnVAbcpYicVPIIQmi6b8wfmaR1ot+nx5GQ2+udwHkuocboekKCaiWm5X54oP4I5lembpuF4JkMhfSXttPFloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfNv2wNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE566C433F1;
	Tue,  6 Feb 2024 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217557;
	bh=oBgtkf5GsR7oInvTgvXmuuezLk03GfOH/+6u6oZvCho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfNv2wNLBieC8aH78hNfv/GOF8mA9hhZmEPpD6sAgcVmpsetChkXkZxAQjZA8W/qB
	 vq3e7vtbYLs9eWyE75mfegnu/BIje/RaSfhfkG3Z1lop7paRAhULue7h6ecnY7Ixj0
	 4B4MIuqKYCqSdKbDx17zLMT+Q29oXRv6HpBrMnOMoeS+EipoolxR4oVoskghah3u3z
	 zLPCI2iJO+c47fgM+nRJ2KETK5hbRdcunESQpSxzAgExHiEnoWLbj5WYUDYzhLxVf1
	 hG0SEV0+v1h4yPYRixQHCHsap/5qDGLSe9LdB8BBsvW3LydH85CwtgNTJHgKhF8D+t
	 ly5UkWT4NfseA==
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
Subject: [PATCH 5/6] tools/rv: Fix Makefile compiler options for clang
Date: Tue,  6 Feb 2024 12:05:33 +0100
Message-ID: <ed94a8ddc2ca8c8ef663cfb7ae9dd196c4a66b33.1707217097.git.bristot@kernel.org>
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

The following errors are showing up when compiling rv with clang:

 $ make HOSTCC=clang CC=clang LLVM_IAS=1
 [...]
  clang -O -g -DVERSION=\"6.8.0-rc1\" -flto=auto -ffat-lto-objects
  -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables
  -fstack-clash-protection  -Wall -Werror=format-security
  -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
  -Wno-maybe-uninitialized $(pkg-config --cflags libtracefs)
  -I include   -c -o src/utils.o src/utils.c
  clang: warning: optimization flag '-ffat-lto-objects' is not supported [-Wignored-optimization-argument]
  warning: unknown warning option '-Wno-maybe-uninitialized'; did you mean '-Wno-uninitialized'? [-Wunknown-warning-option]
  1 warning generated.

  clang -o rv -ggdb  src/in_kernel.o src/rv.o src/trace.o src/utils.o $(pkg-config --libs libtracefs)
  src/in_kernel.o: file not recognized: file format not recognized
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  make: *** [Makefile:110: rv] Error 1

Solve these issues by:
  - removing -ffat-lto-objects and -Wno-maybe-uninitialized if using clang
  - informing the linker about -flto=auto

Cc: stable@vger.kernel.org
Fixes: 4bc4b131d44c ("rv: Add rv tool")
Suggested-by: Donald Zickus <dzickus@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/rv/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 3d0f3888a58c..485f8aeddbe0 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -28,10 +28,15 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
 
+ifeq ($(CC),clang)
+  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
+  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
+endif
+
 TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
 
 CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS) -I include
-LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
 LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
 
 SRC	:=	$(wildcard src/*.c)
-- 
2.43.0


