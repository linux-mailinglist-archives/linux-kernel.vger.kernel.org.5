Return-Path: <linux-kernel+bounces-102213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FB87AF79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946BA288A39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F161A0A2B;
	Wed, 13 Mar 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5k/dVVE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854D1A0A12;
	Wed, 13 Mar 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349507; cv=none; b=byYPqKLrP8Q/Hbl/tVlUwpOz0hLfBw5G0TLiu6wq3dGrN+eK+l8bj7eHyFhOoH+7coyHucRJWtUED6URjw/9jezYDoGF9z3MM2tEzbN8DFeF801JMTiZbfD70157SsyO5pDH0eSOOLwrHpslxDxEse2599WFmEO+HYgi4qIQgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349507; c=relaxed/simple;
	bh=8pkugNJXCAGQDIXWP8dF/TDqhdMUENJaJJI8RkjeAeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uj4FzWcTsGmShT7eGxivjQr/crEGSX/9D5r102VQ8KOAhNbOlNPMt5r5mcq2txviw3mFI2XorZWVB4uiK5E8c1G1G5rWxixoE5sUpwD1bAHA8C/EVAHVUn1bPcbDXXzDQSl7vHLE0H1JTs0OllrP6FAEjC+I6vqj7VRuNRjZjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5k/dVVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD1FC43399;
	Wed, 13 Mar 2024 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349507;
	bh=8pkugNJXCAGQDIXWP8dF/TDqhdMUENJaJJI8RkjeAeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5k/dVVE2QTUYOvLjD+aFYttX9L5YuqWSt2GPCtT+vtwknRgfRDE08OXYFRtNIlqi
	 Ys1cUywb/fTi6jr1uHO3KqXCw5rUMX+L7W8v5rXoJdCI61MEH1s3AsKu6SOVUF71Gt
	 iyAaRO9/8OQ4T8+HxPRgkLCuSNUBRylzOxy90EuY3aB4Rmr/S5Ul6oH4LyjRd4Jr2g
	 yvt+4jPTm1WrYDqEt/1o22lpwl/QZGn+F87J3iPHdNwC/qDthuzdqNi3kTlnfp/P6k
	 xOViUokphK+loLgA8BNl/yJ/8olFakLuR/dMIGoLK0hljZzTPX4p9KdKmqPrYJxLBY
	 ZHbaeycszrtzQ==
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
Subject: [PATCH 4.19 26/41] selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Wed, 13 Mar 2024 13:04:20 -0400
Message-ID: <20240313170435.616724-27-sashal@kernel.org>
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
index 5a2d7b8efc407..ab349c6db00d4 100644
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


