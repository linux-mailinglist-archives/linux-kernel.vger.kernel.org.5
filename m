Return-Path: <linux-kernel+bounces-102212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39F87AF77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06125287F39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B109150CFE;
	Wed, 13 Mar 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG4Wy8Ou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA931150CDC;
	Wed, 13 Mar 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349505; cv=none; b=XgYCMGFOP4t2WsuPOQ8SWHoi6byg5zlYQodTb/emKYS2wQByb5X9EvsSSbfEAxaB/Z6sV+A7nN9IRgPhOAWIpvE5P7LVHkPREOovrpODVd9QsqgpQHQQ7IWu5MAMWN79HUxLPj2dBtTVeLJL3MUfZzYyu+OY+1bcIbHCZBYlpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349505; c=relaxed/simple;
	bh=Ptq0cuJxKNvmwtHshe5chi0JrXuel14aDzjpEGVBeKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLGkwD81JUTFuC/7bG+2br7VroTNjt2W/MkpGjgTA6NtJkZuos1ilsWZa3WIGt0roT+CFoMS8xOonY/q2CRE0M/e5ZhtTW20I7lvMP3Bj227VKuLxLu80LzUnRqq1dj9o+vFSaLRNg4p5GzoHPGXb++upQrkLiUPmW0qV0d1i70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG4Wy8Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD08C43390;
	Wed, 13 Mar 2024 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349505;
	bh=Ptq0cuJxKNvmwtHshe5chi0JrXuel14aDzjpEGVBeKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MG4Wy8Ou3R5YuwqFllfNwx5Cd/hwZnRn5raZB4OwxK63aQ8n9zwERPos2KGW3JW6D
	 KCcFnVNTqkYVvsBWUUoexA7npm/8wbhnUMX698I+nfSUyfhCzwde3Mb5zrGqxqxWPl
	 AwjRU/7nOP0BSpsZ132IiqKEkHV/1Eou8yWrDtij3KzFAI/jKPkoww89oOarAlGnYR
	 0I4jtbTHWTOyrGsdR4lxeUUU5J1M7AE5IfbGRnnitFu9CK0G5bM/t1qRUA6BUyVXns
	 XsWyRkFMgFRZJUn35qLhYxOyWs+pI9L18uDMIRYc0KUTyP13RBG3/IMlMm6C0t4+Ea
	 ZojvxydgCKlSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/41] tools/selftest/vm: allow choosing mem size and page size in map_hugetlb
Date: Wed, 13 Mar 2024 13:04:19 -0400
Message-ID: <20240313170435.616724-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit fa7b9a805c797b729022029aaa3a2b7c35fff4c6 ]

map_hugetlb maps 256Mbytes of memory with default hugepage size.

This patch allows the user to pass the size and page shift as an
argument in order to use different size and page size.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: 91b80cc5b39f ("selftests: mm: fix map_hugetlb failure on 64K page size systems")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/map_hugetlb.c | 29 ++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 9b777fa95f090..5a2d7b8efc407 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -23,6 +23,14 @@
 #define MAP_HUGETLB 0x40000 /* arch specific */
 #endif
 
+#ifndef MAP_HUGE_SHIFT
+#define MAP_HUGE_SHIFT 26
+#endif
+
+#ifndef MAP_HUGE_MASK
+#define MAP_HUGE_MASK 0x3f
+#endif
+
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
@@ -58,12 +66,29 @@ static int read_bytes(char *addr)
 	return 0;
 }
 
-int main(void)
+int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t length = LENGTH;
+	int flags = FLAGS;
+	int shift = 0;
+
+	if (argc > 1)
+		length = atol(argv[1]) << 20;
+	if (argc > 2) {
+		shift = atoi(argv[2]);
+		if (shift)
+			flags |= (shift & MAP_HUGE_MASK) << MAP_HUGE_SHIFT;
+	}
+
+	if (shift)
+		printf("%u kB hugepages\n", 1 << shift);
+	else
+		printf("Default size hugepages\n");
+	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
 
-	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, -1, 0);
+	addr = mmap(ADDR, length, PROTECTION, flags, -1, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
 		exit(1);
-- 
2.43.0


