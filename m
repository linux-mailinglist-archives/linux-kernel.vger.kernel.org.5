Return-Path: <linux-kernel+bounces-97417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A1876A36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8FE1F2391B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1C4C627;
	Fri,  8 Mar 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY13+6zW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D783FB9E;
	Fri,  8 Mar 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920258; cv=none; b=s1H4IhI9574eEknLrbEYRxAlcVJNMYJG0gJZCJ5MSq0MgS4wnfrQV7Gam5G3h/Qx82NgKHYflehVuc03QbsZ2SIygouSrow18TO/UR00rh5UheIuIOfyTSi1cH39x62ZT0FQwe0g5IhqdJBidxLlAw/Gp9Lei3viyT6IM43xn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920258; c=relaxed/simple;
	bh=5xlHmpYcqX2VUgXngSc898YF3hx2VkRxiuAQwacZBvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=artOMHw1J+knYC8yGAOP1NKEnGWq6m51v5+bLHW9mtI0fkYuZi9idTaqS1KlBBaoFlbcyNOw93ypZOTkUt2LerxDdgBt2r2ON5lVtOYb5NOqum13VshuHo421L5f8GRUfyAR0FkBFlQsSSJBwQRhjqkWHeaHGJpC7rwIr69gqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY13+6zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D64C433C7;
	Fri,  8 Mar 2024 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709920258;
	bh=5xlHmpYcqX2VUgXngSc898YF3hx2VkRxiuAQwacZBvY=;
	h=From:To:Cc:Subject:Date:From;
	b=aY13+6zW6S/SJhSKtscJ8SAlZD9kmmmL1bE/UpTi/J8R2Up0ewZMv997Zku8Ua/Sp
	 XqCkOiWfYDolLNMnFMFs9D3+RR49W8gk7akIbuqzdD+NGZPSI0Cx2fihdNBffJmL/d
	 eaTl3HhoL2JZFvLrJjMzP858Yvbt1HW63It3+5+4nvfBx4F+gl8xViyJMX3qEpSEST
	 U48vvdJ/ssYIz+QezYTR13c9oF60RCppAWdXFSXdliQLqf0GNOzv3ix3ai9nq1FbWX
	 UdRKji47GcObTSuoqC9z9GW50AieebFDzgMuMI2hUWP1XdLvzoBwsM+X1Pkb1/F+b/
	 pnrHPnR1iGQuw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tools/tracing: Use tools/build makefiles like perf
Date: Fri,  8 Mar 2024 18:50:42 +0100
Message-ID: <cover.1709914259.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/tracing and tools/verification/rv are using standalone Makefiles.
However, This approach has some drawbacks. For example, code
duplication and lack of proper dependency handling, making things
harder for users. 

Linus suggested using perf's build system, and it is indeed the best way to go.

This series replaces tools/tracing and tools/verification/rv makefiles
with makefiles inspired by perf and objtool that use tools/build/
infrastructure.

Thanks, Arnaldo, for the pointers via chat.

Link: https://lore.kernel.org/lkml/CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com/

Daniel Bristot de Oliveira (3):
  tools/tracing: Use tools/build makefiles on latency-collector
  tools/verification: Use tools/build makefiles on rv
  tools/rtla: Use tools/build makefiles to build rtla

 tools/tracing/latency/.gitignore       |   1 +
 tools/tracing/latency/Build            |   1 +
 tools/tracing/latency/Makefile         |  48 ++++---
 tools/tracing/latency/Makefile.config  |  28 ++++
 tools/tracing/rtla/.gitignore          |   4 +-
 tools/tracing/rtla/Build               |   1 +
 tools/tracing/rtla/Makefile            | 177 +++++--------------------
 tools/tracing/rtla/Makefile.config     |  44 ++++++
 tools/tracing/rtla/Makefile.rtla       |  77 +++++++++++
 tools/tracing/rtla/Makefile.standalone |  24 ++++
 tools/tracing/rtla/src/Build           |  11 ++
 tools/verification/rv/.gitignore       |   2 +
 tools/verification/rv/Build            |   1 +
 tools/verification/rv/Makefile         | 166 +++++------------------
 tools/verification/rv/Makefile.config  |  44 ++++++
 tools/verification/rv/Makefile.rv      |  49 +++++++
 tools/verification/rv/src/Build        |   4 +
 17 files changed, 387 insertions(+), 295 deletions(-)
 create mode 100644 tools/tracing/latency/Build
 create mode 100644 tools/tracing/latency/Makefile.config
 create mode 100644 tools/tracing/rtla/Build
 create mode 100644 tools/tracing/rtla/Makefile.config
 create mode 100644 tools/tracing/rtla/Makefile.rtla
 create mode 100644 tools/tracing/rtla/Makefile.standalone
 create mode 100644 tools/tracing/rtla/src/Build
 create mode 100644 tools/verification/rv/.gitignore
 create mode 100644 tools/verification/rv/Build
 create mode 100644 tools/verification/rv/Makefile.config
 create mode 100644 tools/verification/rv/Makefile.rv
 create mode 100644 tools/verification/rv/src/Build

-- 
2.44.0


