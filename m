Return-Path: <linux-kernel+bounces-54738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD284B310
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A761C2279E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F212FB06;
	Tue,  6 Feb 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcwBOYz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C512F592;
	Tue,  6 Feb 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217548; cv=none; b=fFHd3qwfhaoapvWWQ72aegCbAI9Cw5zRhJ3nmagWpsdPBfhYSaT4dp93ea04Nh4JHcqZXsNdyJR/YKVu5UKZ1kS6thtcjyslTWFU+9S6q8/1lDGGi4pouL1TjwzdfvwRcnQxw4lCYr6p8YbctuSY1RUWngGJHsD7F/tUEMIuMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217548; c=relaxed/simple;
	bh=hJBcq6G53sR+Sok4UfO9asd3HIeiHC7fn0zZDIFhFKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goiCOaVPIJfKQlEwb9Hty2TfDYqq/nmN3n2PVfWZoftZQtSkMRJhiAWeNPoP+vMFG6DfIGmDLCSFGO7cyffn04nfl+UuWuJtuTK647nTXV+u54EU1omxVX+3N/cN2THk3c6GqwOJMBlQo/gLN4LUQ5zNs7thvPBdu97bH64vFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcwBOYz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0A1C433F1;
	Tue,  6 Feb 2024 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217548;
	bh=hJBcq6G53sR+Sok4UfO9asd3HIeiHC7fn0zZDIFhFKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcwBOYz1BMGlcZEu4c59TB4CPKUsT2QK1ewkFW+0mBdhO4CM8hRvndL7AHm4wI+Q4
	 g9WJvsh4FAsHgR3mUJFsLDAkrD7p4n+kzbdf+5wbUMjZarqCPtjb1TlgedNm7bjVvS
	 9/hjcRzqqIi9TdAsjXOu+0PvqlpTS5FIvuY71mRr0AYi0xIk9nZZg/bzZtWDqzbf+M
	 p4Ed8JBdvVlr1/kONzexSsLh0xcXtXCkLN3jQnpJbiJhAq0enuqhLU/FXyTZN2S+eX
	 JEdu0w1MgxQbzzpkkh99Ie291zgXpSTB2WB6m5nhauJKf+IXr5Dqj8OxYEisPgwId6
	 AUr3L3KgjEUtg==
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
Subject: [PATCH 2/6] tools/rtla: Fix uninitialized bucket/data->bucket_size warning
Date: Tue,  6 Feb 2024 12:05:30 +0100
Message-ID: <6e1b1665cd99042ae705b3e0fc410858c4c42346.1707217097.git.bristot@kernel.org>
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

When compiling rtla with clang, I am getting the following warnings:

$ make HOSTCC=clang CC=clang LLVM_IAS=1

[..]
clang -O -g -DVERSION=\"6.8.0-rc3\" -flto=auto -fexceptions
	-fstack-protector-strong -fasynchronous-unwind-tables
	-fstack-clash-protection  -Wall -Werror=format-security
	-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
	$(pkg-config --cflags libtracefs)
	-c -o src/osnoise_hist.o src/osnoise_hist.c
src/osnoise_hist.c:138:6: warning: variable 'bucket' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  138 |         if (data->bucket_size)
      |             ^~~~~~~~~~~~~~~~~
src/osnoise_hist.c:149:6: note: uninitialized use occurs here
  149 |         if (bucket < entries)
      |             ^~~~~~
src/osnoise_hist.c:138:2: note: remove the 'if' if its condition is always true
  138 |         if (data->bucket_size)
      |         ^~~~~~~~~~~~~~~~~~~~~~
  139 |                 bucket = duration / data->bucket_size;
src/osnoise_hist.c:132:12: note: initialize the variable 'bucket' to silence this warning
  132 |         int bucket;
      |                   ^
      |                    = 0
1 warning generated.

[...]

clang -O -g -DVERSION=\"6.8.0-rc3\" -flto=auto -fexceptions
	-fstack-protector-strong -fasynchronous-unwind-tables
	-fstack-clash-protection  -Wall -Werror=format-security
	-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS
	$(pkg-config --cflags libtracefs)
	-c -o src/timerlat_hist.o src/timerlat_hist.c
src/timerlat_hist.c:181:6: warning: variable 'bucket' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
  181 |         if (data->bucket_size)
      |             ^~~~~~~~~~~~~~~~~
src/timerlat_hist.c:204:6: note: uninitialized use occurs here
  204 |         if (bucket < entries)
      |             ^~~~~~
src/timerlat_hist.c:181:2: note: remove the 'if' if its condition is always true
  181 |         if (data->bucket_size)
      |         ^~~~~~~~~~~~~~~~~~~~~~
  182 |                 bucket = latency / data->bucket_size;
src/timerlat_hist.c:175:12: note: initialize the variable 'bucket' to silence this warning
  175 |         int bucket;
      |                   ^
      |                    = 0
1 warning generated.

This is a legit warning, but data->bucket_size is always > 0 (see
timerlat_hist_parse_args()), so the if is not necessary.

Remove the unneeded if (data->bucket_size) to avoid the warning.

Cc: stable@vger.kernel.org
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 +--
 tools/tracing/rtla/src/timerlat_hist.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8f81fa007364..67128171c29d 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -135,8 +135,7 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 	if (params->output_divisor)
 		duration = duration / params->output_divisor;
 
-	if (data->bucket_size)
-		bucket = duration / data->bucket_size;
+	bucket = duration / data->bucket_size;
 
 	total_duration = duration * count;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 47d3d8b53cb2..3a5b8c409e7d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -178,8 +178,7 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 	if (params->output_divisor)
 		latency = latency / params->output_divisor;
 
-	if (data->bucket_size)
-		bucket = latency / data->bucket_size;
+	bucket = latency / data->bucket_size;
 
 	if (!context) {
 		hist = data->hist[cpu].irq;
-- 
2.43.0


