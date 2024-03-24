Return-Path: <linux-kernel+bounces-113840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF68886E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E391C260A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76245134401;
	Sun, 24 Mar 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQVfH6FP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A11E85CB;
	Sun, 24 Mar 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320884; cv=none; b=sjgImEEObSJIeat7o3aACHBmzSQpLS/lWr+Z41w44T1cEw1fgYtuSJS6R2pENyoqIMfuvJXIpaLX33MLqDeF7m8wcNvd+MbibM2KEdCkFXvMOuuo6umDoVgBKVk3FUUWQGjWi2Hg+Jla/YSFduFVQrMoyiZNI42EWpVAyaHKE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320884; c=relaxed/simple;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKDTfkgxV5qRdQhv2GdGPlp1oT06NwUEsZ6NdnhReiF1V7dkKsMn+B+ubIcvJFv5Lv576BO5YxqCZdr624cQheyQYbXPGlnty2Z8Wc7+/cKMWabIb+CdahenIgcT/UmsraYqUTyDGqAGIpGoKrEQ7RQvFh1knUaDqhlHwnabBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQVfH6FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B076C433B2;
	Sun, 24 Mar 2024 22:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320882;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQVfH6FPH4EtYn/ciLExQZiJX9KixBGr9/a+Qf3mwVzBYQ3FF+To2C8G+2migTHuF
	 t0RMbhboq0iyAVFLrW01pHR5zfZUMTnrm8B2zAUbnQcjEH49Gj2PKczNTaESz8gaAa
	 zuVZloWP2leEpxq6zEqYX/N4cSV5KMHIz/U/pj9NRkhlDU0ggd9ZP7LrUdiIpuihzN
	 7/ChllUJoPqlQGPlnvZMKVFb+rn26+irm4s8qryyJxOt+zKgQBLkIgB2WQokowAkYr
	 qlBcp3NZFos9BqbIAi3a+X4LHknq8hQbKhqMyTi4Iyo0+1ZDpvb5FY54fjPM9okX9Y
	 HbCgYUwnsX/Tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	James Clark <james.clark@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Tom Rix <trix@redhat.com>,
	llvm@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 446/713] perf srcline: Add missed addr2line closes
Date: Sun, 24 Mar 2024 18:42:52 -0400
Message-ID: <20240324224720.1345309-447-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit c7ba9d18ae47924a6ea6a47ca139779f58eb83c0 ]

The child_process for addr2line sets in and out to -1 so that pipes
get created. It is the caller's responsibility to close the pipes,
finish_command doesn't do it. Add the missed closes.

Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240201001504.1348511-8-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 034b496df2978..7addc34afcf5d 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct child_process *a2l)
 		kill(a2l->pid, SIGKILL);
 		finish_command(a2l); /* ignore result, we don't care */
 		a2l->pid = -1;
+		close(a2l->in);
+		close(a2l->out);
 	}
 
 	free(a2l);
-- 
2.43.0


