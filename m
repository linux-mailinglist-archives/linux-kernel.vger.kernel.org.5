Return-Path: <linux-kernel+bounces-129295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F0F89684D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC69283C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C42126F1D;
	Wed,  3 Apr 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aduusoJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC353E48E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131818; cv=none; b=CaFlmEljzYHqDMKp8SanOArXHMRTMXx5Re2YNRjEPFmwr6Bg6vxY1+5d+eVGnpgOuoG9Rcypdc3vQho4XrSNOUI3j/Y7KDIppZ+uBkUIZHcrMeJTEgIFq4MJCj7oGNxBOsviSH3Rk0kC1MGnJaBfTIksLED7nebOLLayRsbqCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131818; c=relaxed/simple;
	bh=uzjOp0xr2MZStRulQupRQ+qP+V7YCJngXfY+4GCdPKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpzZXvCjHbke76Jq4QfHDsG40n9x8+wmU+vYXwunmJ9znILJjXruTWW/x0qGZv6YVX6IUyRrgq15mvlDZmsMBLM/UJCLxkZpYyGrzQw/rWweeo/g2tXNAdRFp5dOuM0F6GPhDA302mqouD0huBro0IQPk+csj3d3a9FteTFsb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aduusoJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E9FC433F1;
	Wed,  3 Apr 2024 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131818;
	bh=uzjOp0xr2MZStRulQupRQ+qP+V7YCJngXfY+4GCdPKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aduusoJpFvmeo2xsPOKjpWaqWGcBrHBvvddO8Le6Ar23DmTL7t5YQDWDgzTZseKxm
	 swaPV5HbHXgZtMbAVjuKdbGsmjnDLXubGoUAewJeZU7WKpCdDELcOW5bfs8VW0Sdhs
	 eFs15OsS/B7w7v3M5oe7vDJfnmzqZ5VipT1QYdREN9dWfKY4CF42sAueDZFp/eLbRM
	 3AQ3BAqGiDs/1m1wJydFD6qSa/5xnF5UH/GLfKmg2DLh2WOyk+/ahRFxK33pugDrSU
	 aUvumLZKGMWy0PI/g9gR3cEC73dvtMDbnI2O6fOEE3rtcA9azcrlWf0QXdX+Fj7Ike
	 zglWpD+swPxRw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 18/34] lib: checksum: hide unused expected_csum_ipv6_magic[]
Date: Wed,  3 Apr 2024 10:06:36 +0200
Message-Id: <20240403080702.3509288-19-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_NET is disabled, an extra warning shows up for this
unused variable:

lib/checksum_kunit.c:218:18: error: 'expected_csum_ipv6_magic' defined but not used [-Werror=unused-const-variable=]

Hide it under the same #ifdef as the reference to it.

Fixes: f24a70106dc1 ("lib: checksum: Fix build with CONFIG_NET=n")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/checksum_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index bf70850035c7..80dd1e1b71ba 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -215,6 +215,7 @@ static const u32 init_sums_no_overflow[] = {
 	0xffff0000, 0xfffffffb,
 };
 
+#ifdef CONFIG_NET
 static const u16 expected_csum_ipv6_magic[] = {
 	0x18d4, 0x3085, 0x2e4b, 0xd9f4, 0xbdc8, 0x78f,	0x1034, 0x8422, 0x6fc0,
 	0xd2f6, 0xbeb5, 0x9d3,	0x7e2a, 0x312e, 0x778e, 0xc1bb, 0x7cf2, 0x9d1e,
@@ -240,6 +241,7 @@ static const u16 expected_csum_ipv6_magic[] = {
 	0x99aa, 0xb06b, 0xee19, 0xcc2c, 0xf34c, 0x7c49, 0xdac3, 0xa71e, 0xc988,
 	0x3845, 0x1014
 };
+#endif
 
 static const u16 expected_fast_csum[] = {
 	0xda83, 0x45da, 0x4f46, 0x4e4f, 0x34e,	0xe902, 0xa5e9, 0x87a5, 0x7187,
-- 
2.39.2


