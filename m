Return-Path: <linux-kernel+bounces-157086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56778B0CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613661F260C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390215E817;
	Wed, 24 Apr 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwWXgIMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575015E5D2;
	Wed, 24 Apr 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969425; cv=none; b=BdkD0Ki4Sy/7+1DY4Jcus6GMl9c+soIqcITg82zdL8HREA6WquC3Jzx+3q3yu8zeHgVzgBEQeGduqAKzcMbZNzcrks5I9BUF4+KPPMFEq2/asrRBrGhigbUCrdqLkp6JsDiXp5T0iqN7aXPloovqkuxjjGv8T+9Ti5ENGkLSaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969425; c=relaxed/simple;
	bh=h3kni25RcZfL1isJbSQY1P90CKhCozvYjFrPz4S27pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u73O51AXd81HphhfftGrnFziBZamF4rXoG0kk6TuhJh2pUR3qBuY20yW47kvEfiqAUK4qAea8Z57CKsxWoNfMx1RqbUBrOrsSjUiKijJAsuAeljUo7QWMS/o3bzHqtQpulq5KbPAYFYY4Gednz05SAswD95jFo3rsyZSxkRE5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwWXgIMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30779C113CD;
	Wed, 24 Apr 2024 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969424;
	bh=h3kni25RcZfL1isJbSQY1P90CKhCozvYjFrPz4S27pc=;
	h=From:To:Cc:Subject:Date:From;
	b=mwWXgIMp7onRxIzQMA/o2hJjg+kLerJWdGA8NmXQBkjR3qi2vj/bQcmimTz0maYi8
	 z5gMU5Octleth+6gAmoNuyUcD87z8qUeRbudH/zLFzlrnFWKT+4Zn4V3QxR5YagCAU
	 sQn/rwmF/242nsRJulm6n+rabudxSrtlEkpv+p0INusFS5xIwV5YVCxTxZluFWwR8h
	 QFdRxUeHDOWyNPlVW+G1pTmms/xmdJBZxRtx4CxNXCe1PPRomABni77Hm7BByEKEBK
	 hJnZ/FSW076buS4A+GTcc+mjOgB15eg6FUJDRPr0pkANky9aTF5MAkauz8FCAAuMVh
	 57tz6HVsJ0Bqg==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] rtla usage improvements
Date: Wed, 24 Apr 2024 16:36:49 +0200
Message-ID: <cover.1713968967.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

These are some changes I have accumulated in the last
weeks. Mostly improving the tool's user experience.

 - On timerlat top, remove an extra \n that was breaking
   the output.

 - Replace \t with '       ' on the auto analysis, fixing some
   copy & paste.

 - On timerlat top, do not print TTY formatting characters when
   the output is not sent to a terminal, because they break the
   output.

 - on timerlat top and hist, add a summary with the overall results.
   For instance, the minimum value for all CPUs, the overall average
   and the maximum value from all CPUs.

 - Add a --warm-up <seconds> option, allowing the workload to run for
   <seconds> before starting to collect results.

 - Add a --trace-buffer-size option, allowing the user to set the
   tracing buffer size. This is mainly useful for reducing the trace
   file.

 - Make the user-space threads the default choice, also adding the
   a -k option, allowing the user to switch to kerne-threads.

Daniel Bristot de Oliveira (8):
  rtla/timerlat: Simplify "no value" printing on top
  rtla/auto-analysis: Replace \t with spaces
  rtla/timerlat: Use pretty formatting only on interactive tty
  rtla/timerlat: Add a summary for top mode
  rtla/timerlat: Add a summary for hist mode
  rtla: Add the --warm-up option
  rtla/timerlat: Make user-space threads the default
  rtla: Add --trace-buffer-size option

 Documentation/tools/rtla/common_options.rst   |   7 +
 .../tools/rtla/common_timerlat_options.rst    |   6 +-
 tools/tracing/rtla/src/osnoise_hist.c         |  41 ++-
 tools/tracing/rtla/src/osnoise_top.c          |  41 ++-
 tools/tracing/rtla/src/timerlat_aa.c          | 109 ++++----
 tools/tracing/rtla/src/timerlat_hist.c        | 220 ++++++++++++++--
 tools/tracing/rtla/src/timerlat_top.c         | 236 +++++++++++++++---
 tools/tracing/rtla/src/trace.c                |  15 ++
 tools/tracing/rtla/src/trace.h                |   1 +
 9 files changed, 566 insertions(+), 110 deletions(-)

-- 
2.44.0


