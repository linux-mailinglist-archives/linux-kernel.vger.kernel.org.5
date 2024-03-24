Return-Path: <linux-kernel+bounces-113237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5F88828B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E1928A7C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D961327F9;
	Sun, 24 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4sQJZML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DB5D74C;
	Sun, 24 Mar 2024 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320038; cv=none; b=keWVa1IUzLB02PnQ8fK68mkiwM/lhUhatDxUxkDxg9hL7waoAS0MGV2Dj9laEE5Mmh8rwjBtLRFw55L8uT8jJXX0miztWfkf/mQK2RuIyOxp5Dr4ddF6RhK831Ohfm8fsJsgL8shbX8mvr5KguINqXXRxELNQtUQ8TNK0TyNQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320038; c=relaxed/simple;
	bh=Hf/0iSxlOyzs7Gvuy/xTK00B0B5wdp+9ZWqBR3qUq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg0Wqdqn4FVOWiWlh1qhtQVDFghU2szVVK57LNsdkix6I65KtmMu4884rKrxvO57m4xjR3xVeJGYA7lBOM43tr0HYNWt9J4lxrJS2jiGDBO5Rw8I/ZQcaf5LYE47ei70QLCu7idYZw5sRf8hUE0sld5hfPgSctNGCFb5q5I69P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4sQJZML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C6EC433C7;
	Sun, 24 Mar 2024 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320038;
	bh=Hf/0iSxlOyzs7Gvuy/xTK00B0B5wdp+9ZWqBR3qUq8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4sQJZMLhGgM4vowtTq7J3L217VGbc3cj1HslyNTh+Bzrc5Z0imcAKVCMGZnM2LW9
	 MkFXAF9OfzBdz+RxUNhoDdgUDHfWw11iRnZwRA5WJFqfIZ48D+Z++UzUrBrDFRgj3C
	 N1mTICu2HCLLdZYG8tz7Tr1ftIwM2WIRC1d3H8iSgG2JWgaOobOs0uVy+D3wqUzLhO
	 8YRCWhF2wGvALRD5yy//5D7mdJHyvMjTJKi1knsqQNx8VJzhfnw7wVm4rfC+FGiH0M
	 LleuC1dmFwTingPH+GMNCEwwsAIGGmtW+G+3khNMAoj4kNtbeB+Nv9hwYYCf7ep+Jv
	 to+zKl/3PDX/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	"kernelci.org bot" <bot@kernelci.org>,
	kernel test robot <lkp@intel.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 346/715] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Sun, 24 Mar 2024 18:28:45 -0400
Message-ID: <20240324223455.1342824-347-sashal@kernel.org>
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
index ea6843be2616c..026627226ec48 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -888,7 +888,12 @@ static LIST_HEAD(pack_list);
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


