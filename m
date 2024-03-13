Return-Path: <linux-kernel+bounces-102056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DDA87AE08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B9228109A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1E156963;
	Wed, 13 Mar 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR8eiH02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7A155A37;
	Wed, 13 Mar 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348435; cv=none; b=braYCVwPMYLn1qJdbaZKiCPGIpG7HqXzci07fKX3xWBWWxXONl3UVAR143RwMFl+6CQPI3dusueDnl9Mc2mmWT1J/61YUWqc1sd/htYx6KvKWiEbRh6UYVxEd6MwhadvQ3Lx3E4aSaUZ8vlbpea87dLymRjWXCCPIZzzKiZcVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348435; c=relaxed/simple;
	bh=Fk4VBjoxky/x4vOZ0nYWTRX8O5NSYCQ4esJ/tMM9+K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTjtHaqVdx5HU9GItC/II1sFl0fGoo4mLnWGvDEfI2/LZa2IOL1F8HLFi/t7wESE7CSq2eb0KUK6WGUDwIvWV2XyymDjmbqmoy4BWf+HKYpt43P9LRF3ZRAi+5WOj5qIt0sa+EKjGnh65cBo0SnhNAzElcOYvW4HdGwZtdW1GGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR8eiH02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE33C43394;
	Wed, 13 Mar 2024 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348435;
	bh=Fk4VBjoxky/x4vOZ0nYWTRX8O5NSYCQ4esJ/tMM9+K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR8eiH02rOG4Ri21iqLwApkP6A1SeC9GGKkcQPxNFe0rVNb35ML3s80mOMsdDlmc1
	 ddu6gBxI9nbqXyiha7ldzDVNypcWmvmd4k9fJfMN+GX5xKC9JFkb1qhuHGVjYq38sy
	 9dNjAFsPFghcnLNyh8jsKV//NJT/Tv4dFod25Nc2Jg2IrpNToO8Fk3xkK5Hs79dLwv
	 qqcr0X/u7+ON+ivpjXYFbrVqbu2xNliKFnFYcjbsF8/wKIwBDC9KMrNRNfI+rXNsAB
	 CuGHOQN+4TwZtiB+nkN3TyIAaTxxYepQIwaxJdI0WZ8AVCGDZOAA2nWA1ePSCabkA/
	 obO1UPpmieZSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 30/73] selftests/mm: switch to bash from sh
Date: Wed, 13 Mar 2024 12:45:57 -0400
Message-ID: <20240313164640.616049-31-sashal@kernel.org>
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
index 7536ff2f890a1..d0107f8ae6213 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
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


