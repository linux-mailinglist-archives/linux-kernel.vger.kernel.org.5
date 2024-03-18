Return-Path: <linux-kernel+bounces-106473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFC87EF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E671C21F37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798E5579C;
	Mon, 18 Mar 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8mCslIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458B3B18D;
	Mon, 18 Mar 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783687; cv=none; b=WmY8K0vqNiDTm1I0m+CllueLt3VTBCV4VT++4m9VqzqGg4F7Zqj+klbDo2R+O2RUboq+zwwTSHZHaQlhWNAz6XMIrWhR+vJqO0oqTdtutpSemqP/vGcauVTRejlINFFn5evdGpmLqQBMo/+2zwo2Tu8MDJbXIQzGYZwWGG7oXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783687; c=relaxed/simple;
	bh=AeD+xtd/SWdYD0ybNwABImyLxfcVppzYgjid8FtIZMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UM/R6iNU5JE85ltxWuIHad2L7hFmQhXFC/P0gZlB1ZNV6W0jaS1UDdo4ct6AqOG+y5QrcoiLdR+NwvJ6VRcHiwHRkEyeauKiQaMIovHjME82bthEX0DAkcWWkikGT142umnGHx+xBF582XyJ7yZ9wIkvp6ENlrT90I7CTh4N9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8mCslIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64606C43390;
	Mon, 18 Mar 2024 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783687;
	bh=AeD+xtd/SWdYD0ybNwABImyLxfcVppzYgjid8FtIZMM=;
	h=From:To:Cc:Subject:Date:From;
	b=X8mCslIJIo1YZdYA2qtn6bHDe/Z6vt63FyeHlUC1LTEksaNYluGTpDK36t3ARGjRK
	 PO7VNeiHWTW3oRswcZEaMqwfkMtglb1ZGo4SRPuEORJoyVlugPmgVzZLgTWALaL/2j
	 WSn3oU3anH1itPzPuS9RS/WJj8LmpFVK/YCfYE6TlaYV+YPtmYnmOEzEiLmg6MF3Os
	 Bj5WQYDGPB2bReNlXnYd4nFeEuOm1rYn1USDlASwpRF/U0+vLB5RqonzpY4h3Qs2LA
	 0HZTttew4XXeR3mY6SV8EK46ra+txecW8WTswu2V1LgA976K5JXd29OG4f61JqpeQI
	 tUstXPO9z4r7w==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] tracing/tools: Updates for 6.9
Date: Mon, 18 Mar 2024 18:41:13 +0100
Message-ID: <20240318174116.420584-1-bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

Tracing tooling updates for 6.9

Tracing:
        - Update makefiles for latency-collector and RTLA,
          using tools/build/ makefiles like perf does, inheriting
          its benefits. For example, having a proper way to
          handle dependencies.

        - The timerlat tracer has an interface for any tool to use.
          rtla timerlat tool uses this interface dispatching its
          own threads as workload. But, rtla timerlat could also be
          used for any other process. So, add 'rtla timerlat -U'
          option, allowing the timerlat tool to measure the latency of
          any task using the timerlat tracer interface.

Verification:
        - Update makefiles for verification/rv, using tools/build/
          makefiles like perf does, inheriting its benefits.
          For example, having a proper way to handle dependencies.


Please pull the latest trace-tools-v6.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
trace-tools-v6.9

Tag SHA1: 2eb09a97c56af3c27bd9dcebccb495f70d56d5c0
Head SHA1: 9c63d9f58a42b979a42bcaed534d9246996ac0d9


Daniel Bristot de Oliveira (4):
      tools/tracing: Use tools/build makefiles on latency-collector
      tools/rtla: Use tools/build makefiles to build rtla
      tools/verification: Use tools/build makefiles on rv
      tools/rtla: Add -U/--user-load option to timerlat

----
 .../tools/rtla/common_timerlat_options.rst         |   6 +
 tools/tracing/latency/.gitignore                   |   5 +-
 tools/tracing/latency/Build                        |   1 +
 tools/tracing/latency/Makefile                     | 105 ++++++++--
 tools/tracing/latency/Makefile.config              |  30 +++
 tools/tracing/rtla/.gitignore                      |   7 +-
 tools/tracing/rtla/Build                           |   1 +
 tools/tracing/rtla/Makefile                        | 217 +++++++--------------
 tools/tracing/rtla/Makefile.config                 |  47 +++++
 tools/tracing/rtla/Makefile.rtla                   |  80 ++++++++
 tools/tracing/rtla/Makefile.standalone             |  26 +++
 tools/tracing/rtla/sample/timerlat_load.py         |  74 +++++++
 tools/tracing/rtla/src/Build                       |  11 ++
 tools/tracing/rtla/src/timerlat_hist.c             |  16 +-
 tools/tracing/rtla/src/timerlat_top.c              |  14 +-
 tools/verification/rv/.gitignore                   |   6 +
 tools/verification/rv/Build                        |   1 +
 tools/verification/rv/Makefile                     | 207 +++++++-------------
 tools/verification/rv/Makefile.config              |  47 +++++
 tools/verification/rv/Makefile.rv                  |  51 +++++
 tools/verification/rv/src/Build                    |   4 +
 21 files changed, 650 insertions(+), 306 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config
 create mode 100644 tools/tracing/rtla/Build
 create mode 100644 tools/tracing/rtla/Makefile.config
 create mode 100644 tools/tracing/rtla/Makefile.rtla
 create mode 100644 tools/tracing/rtla/Makefile.standalone
 create mode 100644 tools/tracing/rtla/sample/timerlat_load.py
 create mode 100644 tools/tracing/rtla/src/Build
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build
---------------------------

