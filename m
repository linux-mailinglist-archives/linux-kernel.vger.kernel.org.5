Return-Path: <linux-kernel+bounces-113022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F78880D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7DB1F2606E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62171384A3;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPWYT/T5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03481138482;
	Sun, 24 Mar 2024 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319833; cv=none; b=VkZS6SlIot79yaYoQoz30UORg4+aDMYMugq3bMgxXBn7BsregqXAeg/QwQ5NQKpWwiLayOqT8XKaQ5S+nSnzPNI+OwQbz1m3bG66AagO7FpN1ZvBIDCS6QS0IuH9+hgct/4wwXZOaaK+rw3VEs+EglpoKSzfPA9ZcW/pc7YTRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319833; c=relaxed/simple;
	bh=Rk1Q+Aok+VkjPFU/uEYsGNr2WdeCIZyK5WHjnMJWslQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m//lNk8upquAZgu4y4k1/sbUdd+bW+xejNS7c4V48j/t1GegBIOnLrbBToglwfGDfPgX6XEY7LPQGSPhaH/oOBWXUcE0FKM5cxId0syPMP4BoLblwiS3Hcbm5fTA1EoY6yJFQJ/xpwI8c7R/2uMPHFpNSyhVuh1kfg2XrKDTh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPWYT/T5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A344C433C7;
	Sun, 24 Mar 2024 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319832;
	bh=Rk1Q+Aok+VkjPFU/uEYsGNr2WdeCIZyK5WHjnMJWslQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPWYT/T5zZv3eD6ar8Hho2C8lAglnvT6MH0l046bwFTwmG2ik5WMt7EGfBbQlIR21
	 Goas7mRVUPtCHXDJ3hrYRisUL3bipYLUJpvO/GCc+Mt4+PfX0XNfF52+lSechhGr1p
	 hvIscDhJ35pYAUSFU3AF/FK4IfNnfIGhyHE+6A3pD5L8XDjjX73FMMd5H2ik0KIR1+
	 rDdSGDNLl8uBNf9E1sbm9Pi7apvIv7TUsroimFks+C951U5RR69xWc/8KU8hAFMnFh
	 z7sXG5EpAVobvUl/FAH8ZalBAnFUW3E5pvEcn7YnVeugwGVTluDaUBfHSGaue2iKD7
	 CIuvQd8OBb7Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 135/715] selftests/bpf: trace_helpers.c: do not use poisoned type
Date: Sun, 24 Mar 2024 18:25:14 -0400
Message-ID: <20240324223455.1342824-136-sashal@kernel.org>
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


