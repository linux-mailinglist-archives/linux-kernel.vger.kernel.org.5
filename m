Return-Path: <linux-kernel+bounces-114298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B1888F94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2931F2A2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9302613E6;
	Sun, 24 Mar 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Zp0ynQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60013A86C;
	Sun, 24 Mar 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321672; cv=none; b=Q14xzFjrm6CMMQBKr8ch0mpmnF0RetNZkTdgZWkrBslLz8SJYgtQw90WqQNxdBd2lzf4LoYLSjYhX4elzZbc9ue2pS99ddJbcJi8qFG0pVbzAZhjtvlnhfgsmk73iKnZIYa9kY9CUAionnL07KI0e1u4SHhIFmYysbm/JcTarqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321672; c=relaxed/simple;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIECAkq7XTU0WYV0oYZAd07TQRqyG/7u9uFQfj8EnAYcTmKkv34rLCgRdE0f0PlcBxgNtsYUZv4s/qgUIILVevgGqhKJt1zFuk29j1bJQdRiCihlX5khlaBmlk64sv5eci04dol9GH6AevNVGND2Yu6O4brBoTO6F4U1/3ofYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6Zp0ynQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C95BC433C7;
	Sun, 24 Mar 2024 23:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321670;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6Zp0ynQAH3r3vHi8QhgdbXM+BNOZLXdI/I/lILS1CPTww9SmYnpbbfhGH+lLJY4x
	 2yDyiCldyAesm3/mGUSMO9sE25xi16clzLd8Bl4A9GziQBN/gqA25HDtQo72vtHJ6l
	 oG036qf/lym5YrdwM7paSwRDemmXDcYOjB81VOQzoDhmZMMWlx1PCFGMOax/bsEer/
	 dYU72KWpzZMDtI/wHzShrc7nwlyKCoucHE+1WWlYujdDhbhDnB8KTT0yE8k5OFrrYm
	 hgnvM7VX8SD+xEBQdI4TVRvQRWaomIoCP4msbY8J6kWII2tHWSu5v6AQhf11Svv+PL
	 cWcWOzrLi1+5Q==
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
Subject: [PATCH 6.6 399/638] perf srcline: Add missed addr2line closes
Date: Sun, 24 Mar 2024 18:57:16 -0400
Message-ID: <20240324230116.1348576-400-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


