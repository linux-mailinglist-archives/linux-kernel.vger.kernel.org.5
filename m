Return-Path: <linux-kernel+bounces-115679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0EB8898CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DE2B31205
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7CB15AAC7;
	Mon, 25 Mar 2024 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O79t4HXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC731152502;
	Sun, 24 Mar 2024 23:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321610; cv=none; b=oSnQlHFN2uz4H2sBDyc98o/4YlhrS5753NxzmbUZeb2WW+XYja0LbjGodBr/gG76PTt5pJMY62vqQ2VvuADBU9UzQ8HIUNlIVGl1YX+CSaooWs36gz0GCS4LxCZodEY/aZsnTaAER5lwSup3NyMg2/BzvpPrQNERI2354cKJfrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321610; c=relaxed/simple;
	bh=2JQCxS1z38ooUBpwC41Iatakm1a1oaQ5/Tw7+s0wzd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV2tp25/yqU7FbSsvXQgJAoWLVEMnH6y3LB4CBC6lnf1aapjS7atmqXr26OPm7F8Sn8neG1qWVnSZW+dINdzUtj8ehYPPOycrJCdMLAMALvlPJW9Q83tdWzZV2KIsBI3iFow+L5GmNB3s0pQRFLJv5T6HMEeGgEZATdPZKJ6PSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O79t4HXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23BCC43394;
	Sun, 24 Mar 2024 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321610;
	bh=2JQCxS1z38ooUBpwC41Iatakm1a1oaQ5/Tw7+s0wzd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O79t4HXggfg8CQiTT60YOuhsaCIGtjvx1V7D/3LWRsHixMgCEyB9Jsrh5ogEGKCk6
	 naoaJnh/7/xktSwkrYui0H8ecKTo6F9M7DCBsrSjUVT6bGSv8l+/4VvHRxtyLsNs5L
	 vWE8bdSqSC0OqGv8uqcfWZvdaFVbueuYKcfZYVl/SFDVNNqB3EL68cuvIAubKMx8e0
	 by31e3/Y7m/xfED+0rGmHllH3iw2GyDlhrl0OWuZTAK/ySZEKQubEUqxZa8OYv4j5+
	 LS+kFDh5771kz+FX816k4FUHlU+POpcbICuND0vABHLB84mCrWOoChLQwoW4fMzUsU
	 YMzbLqvClJx/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	"kernelci.org bot" <bot@kernelci.org>,
	kernel test robot <lkp@intel.com>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 340/638] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
Date: Sun, 24 Mar 2024 18:56:17 -0400
Message-ID: <20240324230116.1348576-341-sashal@kernel.org>
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
index 5d1efe5200ba3..1333273a71ded 100644
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


