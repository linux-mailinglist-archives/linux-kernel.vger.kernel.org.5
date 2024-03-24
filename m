Return-Path: <linux-kernel+bounces-113677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620238885F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C55828CB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B51272CF;
	Sun, 24 Mar 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4/ZxaO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292051D8BA0;
	Sun, 24 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320637; cv=none; b=TfBu2OGIWASp2Pnamfy5n2bb3iXJmkLIQHnDxomceSKpqepmFe6QX8zBW8kVJGe7Yt2lshGQ7etV4Q+LfTDOvW1vpF0JZ09nOUvGgn0FMJkNJc/D6TJ1hT6Q4RglONygg7ByZVMyFHzb6+cYBfFAjxjUM3yT5e9JwGa604CWKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320637; c=relaxed/simple;
	bh=Rk1Q+Aok+VkjPFU/uEYsGNr2WdeCIZyK5WHjnMJWslQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFjAxv1lVQX5f69g3sNM7KR0GwkLWQ52vT9Wi/K9zGs/ELF9314Xg25XxrGZyXVUrTGinweafa3/SfJADk7x0WPdoxyEswnh64YsaJxvnEXokoSAGysnxRnaRFktvk8EJ8adCWAJyu9bnTOg6dvNtNnf3DWuwVASmIuluHMaWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4/ZxaO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48984C433F1;
	Sun, 24 Mar 2024 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320637;
	bh=Rk1Q+Aok+VkjPFU/uEYsGNr2WdeCIZyK5WHjnMJWslQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4/ZxaO8PMqliNl+7KLodkuLq1XbIWvKzXQZfRh8Ow67nbbY4EQj6dtoUhC0zh5tg
	 c9cPNoHxdOADPutAcKqIJk/zs3RmF7xADoTTRW/LUQ7GS9Jvb+bu+4ID8NpgQtXHRJ
	 yL+9eLCAhLP2vBghXO8jcWrlDe4NJAatriUUI6/S8Bar12orYV0FgTNUDc41FQO4j5
	 LIjDPyn5DFZeUZVk5YDNFfSXSB+hFCuOsRj1fTzuCbJsV5Dgn9pk8r482C+SKLZIvE
	 7xNU+z5tZulkiavoAsJW6Fki0RvzBLcqI+1RRkwUjIa4yP0YsO5kTQQWZhQB/LlQsF
	 iDCbaufmFv8kQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 198/713] selftests/bpf: trace_helpers.c: do not use poisoned type
Date: Sun, 24 Mar 2024 18:38:44 -0400
Message-ID: <20240324224720.1345309-199-sashal@kernel.org>
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

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[ Upstream commit a68b50f47bec8bd6a33b07b7e1562db2553981a7 ]

After commit c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize
kallsyms cache") trace_helpers.c now includes libbpf_internal.h, and
thus can no longer use the u32 type (among others) since they are poison
in libbpf_internal.h. Replace u32 with __u32 to fix the following error
when building trace_helpers.c on powerpc:

  error: attempt to use poisoned "u32"

Fixes: c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize kallsyms cache")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240202095559.12900-1-shung-hsi.yu@suse.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 4faa898ff7fc4..27fd7ed3e4b0c 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -271,7 +271,7 @@ ssize_t get_uprobe_offset(const void *addr)
 	 * addi  r2,r2,XXXX
 	 */
 	{
-		const u32 *insn = (const u32 *)(uintptr_t)addr;
+		const __u32 *insn = (const __u32 *)(uintptr_t)addr;
 
 		if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
 		     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
-- 
2.43.0


