Return-Path: <linux-kernel+bounces-104639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0587D15A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237181C20F44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CD44361;
	Fri, 15 Mar 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ9GQ/ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A74CB37;
	Fri, 15 Mar 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521065; cv=none; b=DJmPo8STzP7OgBvXnuAaujanRVaRXQB3hY2ebjAFD125X16XjfHiw8frPeRSVnFOo4Ghdhp803Xl2kJZHdCVOmjCgMEwD0cXHE228As+JQGcv0jW0zBfj5kuhg2xDaN9qEA0m1CbIxbnhl58I0lEeM4ahnejgAsCilcs6XJNCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521065; c=relaxed/simple;
	bh=m2M0bzDQP7LBLbY5WGghf90fghZZ5GohwCMNQ8FH0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFG6YVlqAtYKmCKsb0yhbooFQL7bC7tkGUGXx4V5aZB5unfT3/mUg2M9j8LSVswyV5HqVvOZM2k5PgsHfRWFEsgXlDVHurwdOKkxtYXF/xjDCrsAiF76CbfbKgp0bQKQ8VP5iJq/aflVrS4eRU7br4oQsJFS1PNwNmTuVuhkTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ9GQ/ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FBCC433C7;
	Fri, 15 Mar 2024 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521064;
	bh=m2M0bzDQP7LBLbY5WGghf90fghZZ5GohwCMNQ8FH0GI=;
	h=From:To:Cc:Subject:Date:From;
	b=OZ9GQ/owYNz3xacaCyoTFY1itYJNNt8A3ZvpILKQ27jGrDKifPoTBdcwupc9kGhCi
	 h6aldyYUh6EhncYWk6sPyNlZ99YOS/3JPBrBFnX/sxEQYKeCoz4N/PfJa+ECAkhOAh
	 7whwIKgP1fkvy5dF+TVB+qT3qEAntkKhL8p0Tcqmg6cM7piyz3k2cwsGd5kx0dyWPr
	 M77IqlxgzlWaH7Cm3jdA0zvckxBigivAbdnXKXqnhHj0l44+TUjyfFtwKYY1ID25mB
	 5gepTzYFrqg8DYJSp5APF122ucYUELf4sfc5S0dhBaBYA9xe0Ee2TC9/YeLtWQp//3
	 gTXUugGkVDUxg==
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
Subject: [PATCH V3 0/3] tools/tracing: Use tools/build makefiles like perf
Date: Fri, 15 Mar 2024 17:44:02 +0100
Message-ID: <cover.1710519524.git.bristot@kernel.org>
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

Changes from V2:
  - Link: https://lore.kernel.org/lkml/cover.1710512430.git.bristot@kernel.org/
  - Fix the log of the first patch, removing the '----- %< ----' because
    some scripts interpret them as the '---' patch separator, truncating
    the log.

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


