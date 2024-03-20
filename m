Return-Path: <linux-kernel+bounces-109344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC18817E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19276285D57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52785651;
	Wed, 20 Mar 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fopIckmn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EE10FF;
	Wed, 20 Mar 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963081; cv=none; b=By55Yc0FM5gLCRGVDCIkSBbIL+eo8g5U9sd34+8qFS1otOhonsR2r5NO5528YpZLrhIf6slGJwHeR9VmAiPbc1B34oLDGPa96zqzweCjBhJlj8DyB1nOreGsKSKlouowkcLFxf0ab7nq5FfjHd3xbOB3rEX3HNYsVgbIGFdhlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963081; c=relaxed/simple;
	bh=uxhQ189kOj3hcNc/balsR6hLko7zNmVg0E06RlS6EKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNhKEpuhymnstG98cTs2dng7cfHjgkdnCEK1EF/7g8xEgJAcdxu/26w3jSP7UZWAUFNqOkeJZV7hPk3WQyKZQZmyu+aBvMM/dsx/0jmpesTFYEd0+D/6RSXs3HcmEaghhPR6BEhY1TcOEutxOLTtdhgPGApZgv+vx9azPRXh8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fopIckmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977B7C433F1;
	Wed, 20 Mar 2024 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963081;
	bh=uxhQ189kOj3hcNc/balsR6hLko7zNmVg0E06RlS6EKU=;
	h=From:To:Cc:Subject:Date:From;
	b=fopIckmnpxsoE3dk1mKUMUeNdEALb3WAxNH0HKcnZOkq3/VihAgh7Po/m0Lo4ontV
	 TD4s/fFVzXVvha3Op1CJ4NH+VZlUAujQ0t6J0w+2LvpyPuIIPmGaizcP9yYGn0buMJ
	 uXzVfEArS/HA5P1SK909gBY653pSA1+vSzXJzNLbeDZs43Zbnza8bmJ1esSvClog88
	 lPLy2/EgdOjDAx5KdKoRX4/FkXiBSeI+SRYGEF+aXF6N9QwZoBjR8KbSaMWELjdOTf
	 9l/vSzq6Xn96BpK3tMOAgZZbXQHEfpV/EOvalnh11/1uQmHzXoeaulZH4cFuslJz2e
	 5Sb+AjWfBLuOg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/5] More perf trace syscall pretty printing improvements
Date: Wed, 20 Mar 2024 16:31:10 -0300
Message-ID: <20240320193115.811899-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Here are some more improvements for 'perf trace', please review,

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf beauty: Introduce scrape script for various fs syscalls 'flags' arguments
  perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument
  perf beauty: Introduce faccessat2 flags scnprintf routine
  perf trace: Beautify the 'flags' arg of unlinkat
  perf trace: Fix 'newfstatat'/'fstatat' argument pretty printing

 tools/perf/Makefile.perf                      |  14 ++
 tools/perf/builtin-trace.c                    |  22 +-
 tools/perf/check-headers.sh                   |   2 +
 tools/perf/trace/beauty/Build                 |   1 +
 tools/perf/trace/beauty/beauty.h              |   7 +-
 tools/perf/trace/beauty/fs_at_flags.c         |  50 +++++
 tools/perf/trace/beauty/fs_at_flags.sh        |  21 ++
 .../trace/beauty/include/uapi/linux/fcntl.h   | 123 +++++++++++
 .../trace/beauty/include/uapi/linux/stat.h    | 195 ++++++++++++++++++
 tools/perf/trace/beauty/statx.c               |  77 +------
 tools/perf/trace/beauty/statx_mask.sh         |  23 +++
 11 files changed, 458 insertions(+), 77 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fs_at_flags.c
 create mode 100755 tools/perf/trace/beauty/fs_at_flags.sh
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/fcntl.h
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/stat.h
 create mode 100755 tools/perf/trace/beauty/statx_mask.sh

-- 
2.44.0


