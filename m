Return-Path: <linux-kernel+bounces-102057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E587AE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67621F2D0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32C15698C;
	Wed, 13 Mar 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGi+CYOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3415697B;
	Wed, 13 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348437; cv=none; b=R9hpWR2ZTIh5HV+3O86aBFnK5AWLYP2JoQ2EcATkA8cIVMfWDnOZ6saQKuvWHNYuBx6VAAW0DISUV7WVwY6WPkwkvo07R+JzLrj2my2wnht6OhBc3O0qPFwL+fHSkjxGjW65kjE42s+j1fFgJoqxuXMe25s37dByygzGfSV9T0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348437; c=relaxed/simple;
	bh=LyeZc5QveyggAQYPY/hrck83W9yX91L3yriLGxrzjlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJGGHeOFtW6/H+P3lHwDqOiLFV26f4OYgU4nRj0maf69YCOojK4DeUVoHJcY+DzFmCzEm826M1e3hOVNB9RSGook32hCCrBBKgqv2E/XJLw45o2qrlO9AJTgy27UHp620NeYB4HGjV4WqLmGfcNJzFuQtE/WdaarXdOJHgeAZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGi+CYOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9289EC43399;
	Wed, 13 Mar 2024 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348436;
	bh=LyeZc5QveyggAQYPY/hrck83W9yX91L3yriLGxrzjlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGi+CYOM6bmhJO3Nt1Yi1aZ2MiFiToiqpLpcl6mFdf9AFGjwh+WDxep0+xNqIV1Ti
	 6uTzEKxbodeC5pF7OqrmteTSG8L20dnN5nLI4HU9o7fsHrUhcAT7t7tdTPlXBkVhWU
	 0FwyF7v212ejYq1Xl64C7j6FNivdKUzZ17wSkxCtSzHKt0KGKYgoFTEDsZCOhF9kJH
	 Y5XzxPl/Le5RrmixbCALe33db+aFuushywUEfhb0+mZYyDUNiuIKxu6T2kSXS5gQUg
	 2D+rLrSDGILgdFKEGjmOjuwGse/LN2k6fTvnj36q4SFEWTiwl0K6qAXbjIm16RLMJU
	 TBFnqakPCcawQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nico Pache <npache@redhat.com>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 31/73] selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Wed, 13 Mar 2024 12:45:58 -0400
Message-ID: <20240313164640.616049-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nico Pache <npache@redhat.com>

[ Upstream commit 91b80cc5b39f00399e8e2d17527cad2c7fa535e2 ]

On systems with 64k page size and 512M huge page sizes, the allocation and
test succeeds but errors out at the munmap.  As the comment states, munmap
will failure if its not HUGEPAGE aligned.  This is due to the length of
the mapping being 1/2 the size of the hugepage causing the munmap to not
be hugepage aligned.  Fix this by making the mapping length the full
hugepage if the hugepage is larger than the length of the mapping.

Link: https://lkml.kernel.org/r/20240119131429.172448-1-npache@redhat.com
Signed-off-by: Nico Pache <npache@redhat.com>
Cc: Donet Tom <donettom@linux.vnet.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/map_hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 312889edb84ab..c65c55b7a789f 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -70,10 +71,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	hugepage_size = default_huge_page_size();
+	/* munmap with fail if the length is not page aligned */
+	if (hugepage_size > length)
+		length = hugepage_size;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
-- 
2.43.0


