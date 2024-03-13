Return-Path: <linux-kernel+bounces-101906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A771087AC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479AA1F2EED4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B181AD6;
	Wed, 13 Mar 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKvDjHnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E6823B7;
	Wed, 13 Mar 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348045; cv=none; b=SE5t9wy7OZfoDRRBFJYPNUXqjDT4nxMfvRfoQUJ4evkIZL9z6bY02TVo2oApb+LET1hW10psPFKadvc5jA0NHp4+oERLqvPo/SdudAvoiiipyeLrHv3+ftDtwqfmnRstyOre1BEJGBYpUBmAdNh6Is1SUkgqUh5fI8lJDRDFMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348045; c=relaxed/simple;
	bh=LxXgNAae7E20TE67ywM3grU9vzZlJD5fGIwAgR5pvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTFSmMsIDEb25ds7k60GCASByLo+fKaDUUNf5Y8pRKslc3bwX/7Tjgu8+l/huLCwlXZje54YeN2A6rzeuWauQhTXsXOIuEO31FW3kTEJ4kWFzih/gguGJX6vSYvPU8di3FJEaV0Hme2DCOvlvm5Il27/SIj7lrfviSRxBIgNWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKvDjHnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FA3C433C7;
	Wed, 13 Mar 2024 16:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348044;
	bh=LxXgNAae7E20TE67ywM3grU9vzZlJD5fGIwAgR5pvE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKvDjHnvMBznNrjuk6SfRgjxGWVzBrIJO8++HJUv+GzEM54Kj+Ifpn0E9CHS4u61z
	 RqxDEqMBH2+pIxIbx7+sgnAMnO49dSgV7dknJmcd5WmnsYPcCK0hQwR6CoEt1GgVOP
	 q+6ry5h8pZQvWuWdrT9RpDODUNYNXOECDcMWFKSaUy5bUFfpL4Fp+fOjRndh/xugDS
	 MNAfe4x+cEOr3OONM0XniIr4GbZFmULQBWHZEU1H6bKgSTzyjzDGhkx4ka9MuQsRsW
	 BcnRYZm558No1/10mz/m6QSVKJfrSOfLqpQr6iwZ6sZGFy0cq7OfXf9cWmcv2ujtiC
	 48LCgyNnYYNfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 38/71] selftests/mm: switch to bash from sh
Date: Wed, 13 Mar 2024 12:39:24 -0400
Message-ID: <20240313163957.615276-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit bc29036e1da1cf66e5f8312649aeec2d51ea3d86 ]

Running charge_reserved_hugetlb.sh generates errors if sh is set to
dash:

/charge_reserved_hugetlb.sh: 9: [[: not found
/charge_reserved_hugetlb.sh: 19: [[: not found
/charge_reserved_hugetlb.sh: 27: [[: not found
/charge_reserved_hugetlb.sh: 37: [[: not found
/charge_reserved_hugetlb.sh: 45: Syntax error: "(" unexpected

Switch to using /bin/bash instead of /bin/sh.  Make the switch for
write_hugetlb_memory.sh as well which is called from
charge_reserved_hugetlb.sh.

Link: https://lkml.kernel.org/r/20240116090455.3407378-1-usama.anjum@collabora.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh | 2 +-
 tools/testing/selftests/vm/write_hugetlb_memory.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 0899019a7fcb4..e14bdd4455f2d 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Kselftest framework requirement - SKIP code is 4.
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
index 70a02301f4c27..3d2d2eb9d6fff 100644
--- a/tools/testing/selftests/vm/write_hugetlb_memory.sh
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.43.0


