Return-Path: <linux-kernel+bounces-104496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB787CEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E955286CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C643BB31;
	Fri, 15 Mar 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPOp7OJ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1714376FA;
	Fri, 15 Mar 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512719; cv=none; b=G0QJeFi18C80Hojw3n5yzWgKOO8tF6e7dX7mgAiu8jG6SIY5NG45trbPhmN9E18V8oFiRfeqmXg+xXoFHoit9DC5J1FYiPhJGT841JxcVNBGDK1gVIywyUrD96G1xZ3uhyD3i05h9JucfW5leariWvW7rcYJiFGKs497ZT6d4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512719; c=relaxed/simple;
	bh=9hw7RnvGG3Q7ZFI+nLxWE8ECutGHjIkAHNGB4cII4EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/3pAllhG8YOGQnc8al9M6LkhPsal29tWjK8lc8zZbJaVcd9GCFhOPQIj+l0Hoopai0a++ybDQT2xU9WI248SmK5aWQU7oSvfn44VhpBBH1gf6MVTqh9j5gye9NVep3oZopzEYIo8uk7i0hCkUCeixo/VxsOiHVSogdBQ20THTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPOp7OJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2A8C433F1;
	Fri, 15 Mar 2024 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512719;
	bh=9hw7RnvGG3Q7ZFI+nLxWE8ECutGHjIkAHNGB4cII4EE=;
	h=From:To:Cc:Subject:Date:From;
	b=RPOp7OJ8xHFNrdRUkvJDmY740IvM6wB6FmCDwrmmRUwZElRWgt4kbBdinA/SgjK4c
	 FI84FJCkfBHa8IsEfZwtMdIBDFzL1y6GLTChxteZh/MlUwFS2yrdcfy1natWqhOU4Z
	 77X1vObnzMqTXqYMBrV1shSqxaE4AfXqwlw+Fzrf7Sj0gp+ZlpmYUlkKgctOCckVQN
	 wg3vitZbXL95kwKdvmnwY7CdBSteOHQHD1nP/SJhd3kwwt15dC1fu/X3IxRFy+jKhU
	 VlRD3h36sVGgczG1bdbFXJWzsguxqFeIkqCiw9IKFulwpHVhKf/h+86zCTUDq1Hv/b
	 7LJvPxJwYOEEg==
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
Subject: [PATCH V2 0/3] tools/tracing: Use tools/build makefiles like perf
Date: Fri, 15 Mar 2024 15:24:58 +0100
Message-ID: <cover.1710512430.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/tracing and tools/verification/rv are using standalone Makefiles
and this approach has some drawbacks. For example, code duplication
and lack of proper dependency handling, making things harder for
users. 

Linus suggested using perf's build system, and it is indeed the best way to go.

This series replaces tools/tracing and tools/verification/rv makefiles
with makefiles inspired by perf and objtool that use tools/build/
infrastructure.

Thanks, Arnaldo, for the pointers via chat.

Link: https://lore.kernel.org/lkml/CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com/

Changes from V1:
  - Link: https://lore.kernel.org/lkml/cover.1709914259.git.bristot@kernel.org/
  - Proper handle O= and OUTPUT= flags fixing "make tools/tracing"
  - Cleanups

Daniel Bristot de Oliveira (3):
  tools/tracing: Use tools/build makefiles on latency-collector
  tools/rtla: Use tools/build makefiles to build rtla
  tools/verification: Use tools/build makefiles on rv

 tools/tracing/latency/.gitignore       |   5 +-
 tools/tracing/latency/Build            |   1 +
 tools/tracing/latency/Makefile         | 105 ++++++++++--
 tools/tracing/latency/Makefile.config  |  30 ++++
 tools/tracing/rtla/.gitignore          |   7 +-
 tools/tracing/rtla/Build               |   1 +
 tools/tracing/rtla/Makefile            | 217 +++++++++----------------
 tools/tracing/rtla/Makefile.config     |  47 ++++++
 tools/tracing/rtla/Makefile.rtla       |  80 +++++++++
 tools/tracing/rtla/Makefile.standalone |  26 +++
 tools/tracing/rtla/src/Build           |  11 ++
 tools/verification/rv/.gitignore       |   6 +
 tools/verification/rv/Build            |   1 +
 tools/verification/rv/Makefile         | 207 +++++++++--------------
 tools/verification/rv/Makefile.config  |  47 ++++++
 tools/verification/rv/Makefile.rv      |  51 ++++++
 tools/verification/rv/src/Build        |   4 +
 17 files changed, 549 insertions(+), 297 deletions(-)
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


