Return-Path: <linux-kernel+bounces-113305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF6888344
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C72284B10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE00191E94;
	Sun, 24 Mar 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLV912Jf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F26BFDD;
	Sun, 24 Mar 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320106; cv=none; b=SSRwb8/fCqcWZQyEbYLFpnS3jbs1i0XVG+Ckyok/TsZ6YTa7AQ3Sw9Bs3hT2xpaCnqMnm8UeaocF6Row9C0RMbZPOUXCO/MUL66YTRJedSR8mmoYKuV2d9M+8lskiVj3f35m/Jx06M0xui/3FryeX/CNQCMH85Fgsy+EPVDw0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320106; c=relaxed/simple;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEUyQmZAUG0793BDp7s+2M/A30PNUp7pobZAIxrSNo5rNxY1QH07ncsE2sKmoKGYV9aHSYtuxOBwHyiD2B0hAjlieolFFNJkyGWA+sKKb5XB3fu7HjLGGv4DPt/iaDNR8QBvEaOT+oAmxNLKPo0q+zA3Qk5I0XbVxdgP49ebqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLV912Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C8C433C7;
	Sun, 24 Mar 2024 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320106;
	bh=Ks6Rh39f4C3jBfEt62E8rPS/XnqfajC+vnztZG15Mmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLV912JffiSPOBaVfJA03ilsXPXcg5DuMUm1P2JQNrgWb1yvtj2u7LAW+IsK3qQ8G
	 phkftbn6KCJRNmzzyqbDoo4+f6cNb5jufFH+06B8GD/8voCY/WvC1wEPp0CNPCE2EH
	 651MCIRcygdgsE5nWxkUatoMCImcJcudUyX8lcAchrEuB0+29lfKEsZQ6buBleKIsV
	 0dkv1p6GbxErZnDV+YvHy6WZZnMg74GeNf0TQbPNVqNydZt/JAsh5o2iRC24Z4GjCx
	 GuFzDwCdERTa+wv0J8SKzquMgTLVtlj2JbDhqa3NbMcFncZR1sMayWBsgtK7Fnizg6
	 0HJ99nco3Z8vw==
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
Subject: [PATCH 6.8 414/715] perf srcline: Add missed addr2line closes
Date: Sun, 24 Mar 2024 18:29:53 -0400
Message-ID: <20240324223455.1342824-415-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


