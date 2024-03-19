Return-Path: <linux-kernel+bounces-107774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9588017C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF36E1C22B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A833823C3;
	Tue, 19 Mar 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVz/p9rB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1681AAA;
	Tue, 19 Mar 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864481; cv=none; b=OeI3vMNdg6yjVMmtiq0tKq56xPDg4kqfKI9CQbCUsOrsV5dXBgPB50WamC4kSQLeA++3O+w1JZRfQ7qf92QkvYQgFxZu14dIiM5G85UpvbQqJqUokqle/6YfyIbM+BF6Ue/V0soGStqYFUX4OZbo3yXIwi7yj0BxNls0jOXUVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864481; c=relaxed/simple;
	bh=2oPRCy2jisk83BK9tWeY8QIf69NClUJuFjLh49eN6r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ln38dstdQImXd5xm7mIcahK3WihL3Wm/Y1hlmfzWgoLJ91EY14GOCP6vn2FBwv9nOy2Wf52ja+z7Rc9P7My1TxsFTI3+48/6vpydgolNBmEATvJUkMucfO+3DmpV8WmCR2VNdDxNURNwRpdfVAxUXHGch7UvT+xdILfR1BAwtgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVz/p9rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99459C433C7;
	Tue, 19 Mar 2024 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710864481;
	bh=2oPRCy2jisk83BK9tWeY8QIf69NClUJuFjLh49eN6r0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HVz/p9rBxhLOlLri5i/0BzV9oAyPFuWl446RsG5glK2Fb9QuyrYeK7iDpNGAceUDs
	 JpybmA6kMskp7XblzeigLRxUDb+lmOCHKYF1apEwS37IalkjmeqTWYxJrLMwsS5vTW
	 9z2czcLT7o7SgrGFr1Q4nC2TyQTJ9a4VsD434q4LjXDbI9Um8yF8Qw92uyHbLTX/ix
	 PM5QjPXgSNHDt6ejmQJXKjavZcGLrwdeIr2H4JdVpNa79lZ6z3W+qpaAPqvKmMrwxC
	 PWPxgkgeLTncmtrBmZAEfAdeJ9NgCqTaAALcq5T5FD+kCUBrGletNb2NLWxWUJtDH+
	 FQUlwBq30YgzQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 19 Mar 2024 09:07:52 -0700
Subject: [PATCH 1/2] compiler_types: Ensure __diag_clang() is always
 available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-tracing-fully-silence-wstring-compare-v1-1-81adb44403f5@kernel.org>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=nathan@kernel.org;
 h=from:subject:message-id; bh=2oPRCy2jisk83BK9tWeY8QIf69NClUJuFjLh49eN6r0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKk/d8QHGN6Jk5eUfuqdlPjaq3AGg+KDv2ttSu+cev9MU
 I214s2jjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARhWhGhpZp8t/DEvb8m8t9
 vnPloyumYmcbDZ+3eOrzbnGwljmRGMDwz1Jnh+aRY8KHrITq/WL6vGxK7/EVVFR6XVqRqu4a7zW
 RCQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Attempting to use __diag_clang() and build with GCC results in a build
error:

  include/linux/compiler_types.h:468:38: error: 'ignore' undeclared (first use in this function); did you mean 'inode'?
    468 |         __diag_ ## compiler(version, ignore, option)
        |                                      ^~~~~~

This error occurs because __diag_clang() is only defined in
compiler-clang.h, which is only included when using clang as the
compiler. This error has not been seen before because __diag_clang() has
only been used in __diag_ignore_all(), which is defined in both
compiler-clang.h and compiler-gcc.h.

Add an empty stub for __diag_clang() in compiler_types.h, so that it is
always defined and just becomes a no-op when using GCC.

Fixes: f014a00bbeb0 ("compiler-clang.h: Add __diag infrastructure for clang")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3e64ec0f7ac8..fb0c3ff5497d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -461,6 +461,10 @@ struct ftrace_likely_data {
 #define __diag_GCC(version, severity, string)
 #endif
 
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
 #define __diag_push()	__diag(push)
 #define __diag_pop()	__diag(pop)
 

-- 
2.44.0


