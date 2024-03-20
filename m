Return-Path: <linux-kernel+bounces-109348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305068817E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96B91F22E16
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6A586128;
	Wed, 20 Mar 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9T2CD56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90985C69;
	Wed, 20 Mar 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963090; cv=none; b=CbxT7cMaSrkRsPPYe1x70FRhD0eXO6OD+UfTxTG0SXTDy70z6yexHBAlqJZ6ZF4zVWyc0Plc11OqBAwaOAHwayj0wZYjHXknl4LBSo2xcj+I0lfY2nMdq1u76z1ffzZ5dBtdXjyBUttkHVcbhPy5bYd3i1b0HxCQAfmK/qNm71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963090; c=relaxed/simple;
	bh=lKWJoxjKHcGWhs7EF/8Am3tfhFRbd6IhsPFZoIW5wnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tENpIJd9wZlkOR8D64xUws/sH0gXNMwZGKH+X4C0CbLx4VVOS05d7NSyXfVhoe+MUHIsQe7FT+jphhivGQID/0i9su36ZxQnvzsDEiQU1OFBOPNr8FGjAQQQuOMLtuUW7L4nZKF65n8BNadAtTKBF/YqW6S5S+DXIPPB3OollRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9T2CD56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF992C433F1;
	Wed, 20 Mar 2024 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963089;
	bh=lKWJoxjKHcGWhs7EF/8Am3tfhFRbd6IhsPFZoIW5wnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9T2CD56k0+dqbNjPy+2+Xz/0cWCd1W+4u0iNbNAO8lcAbbJhpxmVVxlFgpyzfvFZ
	 U56r4MIEkECYoBTcCELT+xn/SSEPm1LRu8UWgYA5ODqdYPlFySVq5LFaiHYJgAXnbn
	 52E45CoxyNtkzckzw3t8xBi8e1ao1I35wKlBXri8DecdnOXGSTvs6i19h4RqbBDkO2
	 6nPIqFfe0dC4c848i7RJTg6Vw8sA0NrXTwGgxujpU4xT0zAn3vwoktcLBcixYeb6N/
	 4XuEiA2XR1fYLzLz3NxjwOT4a5uYAsVFTiMREeakgpvAj/0VHe5wmZPoYxKWrztvrC
	 idZiTEyJY4hAA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/5] perf trace: Beautify the 'flags' arg of unlinkat
Date: Wed, 20 Mar 2024 16:31:14 -0300
Message-ID: <20240320193115.811899-5-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320193115.811899-1-acme@kernel.org>
References: <20240320193115.811899-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reusing the fs_at_flags array done for the 'stat' syscall.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58546e8af9fcf481..ef0dfffd99fdf3cc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1171,7 +1171,9 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* name */ }, }, },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
-	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* pathname */ },
+		   [2] = { .scnprintf = SCA_FS_AT_FLAGS,  /* flags */ }, }, },
 	{ .name	    = "utimensat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dirfd */ }, }, },
 	{ .name	    = "wait4",	    .errpid = true,
-- 
2.44.0


