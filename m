Return-Path: <linux-kernel+bounces-114529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE0888AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4361F27071
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2F22B6A7;
	Sun, 24 Mar 2024 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyO+ZK2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B822ABA8;
	Sun, 24 Mar 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322155; cv=none; b=Q3CD/dJ8IMcdSzsQYpntFpvFTGpNhd7dVsZN67Zsdxn+X/KC4J77kvXQszADioJA59pCglQ3cKEgd4pI+ZMxmHL1+vr4GB+JHwH20mQfq4w+9CxR8Li8MUMTS8OSZxJf2r+qDcAq/oLaJVCyRhlh9MLN/6afjpGus2WkyTQJEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322155; c=relaxed/simple;
	bh=vHSIdueeSDo7C/bjgb9QuLxCxrm26+NVsjz4z8tTlkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnQbd3cpWbq91aUZ15owXwrb6llOELzGhYxD3J79uWnjtavefsvmQRtuFVEpzXqxj5ZhdogBKCdUcWCAdrNkhadQ6aWcUCL5LTBEnjnzh3flUiDnTz11cWViD9qaXBU9BCiHYr2saN+87EQsPWg5W6VJeiEap1wIfbCLVE258y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyO+ZK2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B85C433C7;
	Sun, 24 Mar 2024 23:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322154;
	bh=vHSIdueeSDo7C/bjgb9QuLxCxrm26+NVsjz4z8tTlkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyO+ZK2S4YmXG/Bx/Rr/NWJnEjYu6INQGCk5Qza6SgbujpdGjUk1XRY55Oq5a68lc
	 gxBlA2k96o7x88EE7pQEbVL8iXmeV8XzJy9qmISj0vyuGZ6yoWEBgcCEAn3YKiLMGb
	 HrGp/pn9utDbxBBvSA9wJpnT+0wFgCRpxxRTChLAV5EXrCPBe+9gzXfILkE7jljLYB
	 tzwplbtDMWpBBNnH934BrNqnuwMTBFrJjNg+u9qDR0e6oQduDazpykMZBze+oSRDO4
	 7nX+FmZ1bb8U9fQV9P2KP3JtetJN/Roeam0zWpJDpCRlRu77hAE1d3WJPXArHJ8yOJ
	 ojxlMymDHgMsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	"kernelci.org bot" <bot@kernelci.org>,
	kernel test robot <lkp@intel.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 231/451] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Sun, 24 Mar 2024 19:08:27 -0400
Message-ID: <20240324231207.1351418-232-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay12@gmail.com>

[ Upstream commit d6170e4aaf86424c24ce06e355b4573daa891b17 ]

On some architectures like ARM64, PMD_SIZE can be really large in some
configurations. Like with CONFIG_ARM64_64K_PAGES=y the PMD_SIZE is
512MB.

Use 2MB * num_possible_nodes() as the size for allocations done through
the prog pack allocator. On most architectures, PMD_SIZE will be equal
to 2MB in case of 4KB pages and will be greater than 2MB for bigger page
sizes.

Fixes: ea2babac63d4 ("bpf: Simplify bpf_prog_pack_[size|mask]")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://lore.kernel.org/all/7e216c88-77ee-47b8-becc-a0f780868d3c@sirena.org.uk/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403092219.dhgcuz2G-lkp@intel.com/
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Message-ID: <20240311122722.86232-1-puranjay12@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 76bf1de261152..44abf88e1bb0d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -857,7 +857,12 @@ static LIST_HEAD(pack_list);
  * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
  */
 #ifdef PMD_SIZE
-#define BPF_PROG_PACK_SIZE (PMD_SIZE * num_possible_nodes())
+/* PMD_SIZE is really big for some archs. It doesn't make sense to
+ * reserve too much memory in one allocation. Hardcode BPF_PROG_PACK_SIZE to
+ * 2MiB * num_possible_nodes(). On most architectures PMD_SIZE will be
+ * greater than or equal to 2MB.
+ */
+#define BPF_PROG_PACK_SIZE (SZ_2M * num_possible_nodes())
 #else
 #define BPF_PROG_PACK_SIZE PAGE_SIZE
 #endif
-- 
2.43.0


