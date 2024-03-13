Return-Path: <linux-kernel+bounces-101982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048587AD50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4AA280C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7D1474C6;
	Wed, 13 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPCF5RZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41441474B5;
	Wed, 13 Mar 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348193; cv=none; b=rz+U95dVfoDrc9IiQat8RKBzzAwoTEnXqq2NWvwEUZ9avc/Qi+Gxjk06dOwqFu8hU8hkhBqWssOd/uzpMbt5CrbKfD4k7lnNWi7F+TI2it1QjstisuXqIAGRDsGBrabHbW232A/7pDKRe+/cBqsWUsAeXC5U/BBa6ENson/VbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348193; c=relaxed/simple;
	bh=LxXgNAae7E20TE67ywM3grU9vzZlJD5fGIwAgR5pvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKDq0NFzg2BEG5OfH1nkxXcCBKnr3tH5WyDRzuDc5Ocnj1OD4mlHjMmYp1LU+NnQzhBSrmB3nCg4ZKQrQS05QP+FmKm4LdZhqzHeQkE09qBXV71q8WSdXkvTGGvIQ0afhsb9evalNOnK9uQBUtIcsGtNvuZ3Xxxamq7qcyEJH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPCF5RZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF0DC433F1;
	Wed, 13 Mar 2024 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348192;
	bh=LxXgNAae7E20TE67ywM3grU9vzZlJD5fGIwAgR5pvE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPCF5RZW2Hxelib63FpQp2W+0kycu9K6rDklIRiz7D4FSU6WiQW5zHxeLAA4oHy7S
	 szDXFk+J6EBC4XI/2lVWtFBbWv2SLQOJ6bv37QrOCC2zBYnQmovUBQMntkKaiuUDrK
	 QdvLBcEv0o2J5V6qRUeDhmzrpImw59fOCaBz9ahybtQhn4KMJ2mCxwc9oURMVgEuK3
	 Vv/4LEsIg58IkwxeqIPN2WCY3U256VD1QBu/JZPcysl+ygjoOliT6m2jUnDPJDe7Hq
	 t7/BvMSPGz4MfvzVO3oCLwiHhkX1Kb+u/+FRlTZAxdCM/yXy7b72CvuWUONMvVqjHc
	 8cNLV7CwOQnAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 42/76] selftests/mm: switch to bash from sh
Date: Wed, 13 Mar 2024 12:41:49 -0400
Message-ID: <20240313164223.615640-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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


