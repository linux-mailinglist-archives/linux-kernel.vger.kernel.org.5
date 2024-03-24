Return-Path: <linux-kernel+bounces-113804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B118886AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2DB1F251F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B51FB6E3;
	Sun, 24 Mar 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3OHli2a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CA128811;
	Sun, 24 Mar 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320823; cv=none; b=B5JeAnjDVPYfCh2r8/Il1u2CaJU/KZrILl/X45WrBMbNK/8KZsOF54VybXPXb61f7stKI9Lo6tTvqpcOExPgbuZuIHYi9oVNYu81wu3nqWzPLNZdhSLBRCBNaGljhftKcVeeoh29K0aiFpOB7i5DImmE6qdVE9yb4is0plQj1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320823; c=relaxed/simple;
	bh=9+TxO1i+oU8d5+wka1VBLhZpB1nFKtle8lTbdAgfaW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruVu436rebXltp6gxVzb7cO0wd8zR5AetdL1rouX9jI9fmyRgGRmlyeLO00KKT43Vdc3K6r9W3KukjlLk6U664ksWUaBeQq85k0u+zFi/diKJTTRloolk5g0LyIh98aom5wEHNC8v2gHWYdBvQnTAY5Bx+RZajPQ/VO3JWWRWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3OHli2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799DC43390;
	Sun, 24 Mar 2024 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320821;
	bh=9+TxO1i+oU8d5+wka1VBLhZpB1nFKtle8lTbdAgfaW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3OHli2a4PajiBmq9k5ZERysKIYKVlpVUuWlDdMeguw+ym7JTjM+gvhXl+Xtk7IJy
	 LuHPpNnmzHJLQUXUW++bVQPoEdV1W1OES3BXhgGvtjJLY9Gg0100OkD5xi52RcyFiB
	 hyNpxgEaowfqwiZUb88SYxslN9DU3A0X2Iu9rvcpTEYOmLpRLTiQtor/5g2KI/SRTB
	 qJQkdM70me9MSEVypUCNjeHpMKHTlvxSxVj91P3UDU+qKHVtnqlBf9TZCVcJgC3r0G
	 a1XHQ51JWxTrVLpF3BljDoRn9RKDYvka2sJqaHtM2DRUOX6IhyZ8Rbnxs6a4+0NqC4
	 cScnxZvpcWIww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	"kernelci.org bot" <bot@kernelci.org>,
	kernel test robot <lkp@intel.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 386/713] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Sun, 24 Mar 2024 18:41:52 -0400
Message-ID: <20240324224720.1345309-387-sashal@kernel.org>
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
index fe254ae035fe4..27fd41777176c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -863,7 +863,12 @@ static LIST_HEAD(pack_list);
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


