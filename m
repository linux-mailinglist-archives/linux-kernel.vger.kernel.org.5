Return-Path: <linux-kernel+bounces-102228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F487AF98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF9EB251ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9C151139;
	Wed, 13 Mar 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhiMiup8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2689151126;
	Wed, 13 Mar 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349525; cv=none; b=RSqofSm/z/ZuTUKogO7UDydHmBuiujDv/2XaD0+L74J+pNhCIdNCAmQxlG4EQO7Y4r1j7rFdb0ND9ITDvN6pvoAfsjfctjUchZWTHYsXOlq77B3oBhKJy7r9Bc6Hf1XoApuYp+yFGN83Zk2/FEX8Sn3vNURldnjDmGsKPaSHLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349525; c=relaxed/simple;
	bh=C0l9zfBD03qqUENYkRjOgyyKCuXIjG2HyK6nNyqrk+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3kvhaMuY0TCsJ+6kclGbMz7CtQvyOxzUXkKajT3Y1ZZ1NURyxWaAWMU65saU+YjixgrB75xbUxfl83YAjRi6e5DFWA1tNESHfFAO6XapyKw5NX9mnKoJjTUTtk6dj7E8rO/V6Bv+3LIFveqvqjnikyimAHVaIvCL6eksoik7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhiMiup8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C457C43394;
	Wed, 13 Mar 2024 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349523;
	bh=C0l9zfBD03qqUENYkRjOgyyKCuXIjG2HyK6nNyqrk+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhiMiup8Gp0lS0/qWP4DaP8GTdjLpfULgsp89gABClOVMpjOmbSNx4Ika169xX6q1
	 jbuELS1ckdH9mkVlYrxT/HY4+mDFC3pqfD6YR8qvUlvov+pnL8ux/CF+jc0+3chiWO
	 gKxheJnpBS+jqQjtw3UG+EV9rstF2Q5KCRlPfLh2kjG7S01qeH2Rod+PYa6fWjLrVQ
	 vY21UWQpRpYZv/iWeYUl55nRfd0g0TOem/eMVgJybmWNfxjj1LMuyBm9S46i3i5gbn
	 I/aAHkvf3Y0NQvXOsZRWBxRFxdNs3FdyRT0jUvTFKXh8CEVsWoMr2asPblK9/F2ezf
	 NMBQcURzNEfMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leonardo Bras <leonardo@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 40/41] selftests/vm: fix map_hugetlb length used for testing read and write
Date: Wed, 13 Mar 2024 13:04:34 -0400
Message-ID: <20240313170435.616724-41-sashal@kernel.org>
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

[ Upstream commit cabc30da10e677c67ab9a136b1478175734715c5 ]

Commit fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page
size in map_hugetlb") added the possibility to change the size of memory
mapped for the test, but left the read and write test using the default
value.  This is unnoticed when mapping a length greater than the default
one, but segfaults otherwise.

Fix read_bytes() and write_bytes() by giving them the real length.

Also fix the call to munmap().

Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/map_hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 7b41cc6ecb0bf..c65c55b7a789f 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -46,20 +46,20 @@ static void check_bytes(char *addr)
 	printf("First hex is %x\n", *((unsigned int *)addr));
 }
 
-static void write_bytes(char *addr)
+static void write_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		*(addr + i) = (char)i;
 }
 
-static int read_bytes(char *addr)
+static int read_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
 	check_bytes(addr);
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		if (*(addr + i) != (char)i) {
 			printf("Mismatch at %lu\n", i);
 			return 1;
@@ -103,11 +103,11 @@ int main(int argc, char **argv)
 
 	printf("Returned address is %p\n", addr);
 	check_bytes(addr);
-	write_bytes(addr);
-	ret = read_bytes(addr);
+	write_bytes(addr, length);
+	ret = read_bytes(addr, length);
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, LENGTH)) {
+	if (munmap(addr, length)) {
 		perror("munmap");
 		exit(1);
 	}
-- 
2.43.0


