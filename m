Return-Path: <linux-kernel+bounces-107775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC788017D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92238283F67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75E82D8E;
	Tue, 19 Mar 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3tSh9A5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AD823C4;
	Tue, 19 Mar 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864482; cv=none; b=rK6IeZf4jOV6XOP9ohLQ5Dl5e5yxaublewFRrKQwitCPYOTTC6SPXpOIDWpyqFKsu3nvRZl5u22CV8SDde/SdZBjCrfgmKNiozESU5yaIyJkSghHdWJUgZ+Zmv+eYyrCcDQwVtcQOYI6uxydstQ7f3rUVhDSDPrL4NJZkB9ITcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864482; c=relaxed/simple;
	bh=w2V5d2UCp17oxIbLB5SOI4dH0DOO083lsUavf7oC++4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dv9oimm/QW88JIv6Dgh01FPSdimIsAsh9j4dqV9qlwKvPRndxVVOeI8muMlVd0Ktvz5TfQPAqh4XkyDOjh7cAe1zgd9RXe/NlUAZLGjvQs2xa/0yLXJi0AW50a9G6HJDW63IPG2HTr3s5FCxgvV2uanwni1gskVfXKGw+a1sEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3tSh9A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60280C433B1;
	Tue, 19 Mar 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710864482;
	bh=w2V5d2UCp17oxIbLB5SOI4dH0DOO083lsUavf7oC++4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E3tSh9A5+XGqk4VZBDEd/MVbLWUCyGytI3xgprjfOtf3E8EYVjB1bHoWdT/UIzekT
	 w9+Wy5Mqg+yQWRhsWudBzsdacxXg7NXQVH+ZPgnbfcH0kVnlbMx7tfajWSM9eUjXsn
	 oNxqN7ugN2W7/M6wvZ7IAMe2Tt8vcgFWpdAZvkh6CScEW11jPU4fQh2MC1xH2VSIDW
	 DRdyxUGsSg+44m1MW95V4f9vlQbkJ3rLIRCUo5HP6NGtGb5HQiF/gYDHmm8ibwdXNd
	 H+dXSZpDJ0kzFF6MfdQ0otiGA+j1Ge96FyypYy84O7Phjw0MiS11zburvPfriokXNx
	 XFHffYkUyaaGw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 19 Mar 2024 09:07:53 -0700
Subject: [PATCH 2/2] tracing: Ignore -Wstring-compare with diagnostic
 macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Linux Kernel Functional Testing <lkft@linaro.org>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2414; i=nathan@kernel.org;
 h=from:subject:message-id; bh=w2V5d2UCp17oxIbLB5SOI4dH0DOO083lsUavf7oC++4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKk/d8R7Hs/lnXK5btVJPat/s5lNFeuF1v3onvZ1S8aea
 oUfdw8e6ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQAT+bub4b+7dNrTHXVsa/9O
 +Mgoad3hwerOPyVwy6P95yY8ailrKGZhZLh0+HSu9apfVhN9DJ4ekH7tyWYXeH3G/jOTpzdIhK9
 hEGYGAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON()
check") addressed a clang warning, -Wstring-compare, with the use of
__builtin_constant_p() to dispatch to strcmp() if the source string is a
string literal and a direct comparison if not. Unfortunately, even with
this change, the warning is still present because __builtin_constant_p()
is not evaluated at this stage of the pipeline, so clang still thinks
the else branch could occur for this situation:

  include/trace/events/sunrpc.h:705:4: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
  ...
  include/trace/stages/stage6_event_callback.h:40:15: note: expanded from macro '__assign_str'
     40 |                              (src) != __data_offsets.dst##_ptr_);       \
        |                                    ^
  ...

Use the compiler diagnostic macros to disable this warning around the
WARN_ON_ONCE() expression since a string comparison function, strcmp(),
will always be used for the comparison of string literals.

Fixes: b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON() check")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYs=OTKAZS6g1P1Ewadfr0qoe6LgOVSohqkXmFXotEODdg@mail.gmail.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/trace/stages/stage6_event_callback.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 83da83a0c14f..56a4eea5a48e 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,9 +35,14 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		__diag_push();						\
+		__diag_ignore(clang, 11, "-Wstring-compare",		\
+			      "__builtin_constant_p() ensures strcmp()"	\
+			      "will be used for string literals");	\
 		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
 			     strcmp((src), __data_offsets.dst##_ptr_) :	\
 			     (src) != __data_offsets.dst##_ptr_);	\
+		__diag_pop();						\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\

-- 
2.44.0


