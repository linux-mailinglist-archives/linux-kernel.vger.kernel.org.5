Return-Path: <linux-kernel+bounces-129316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C9489687D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E9C1C214C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE5134CC8;
	Wed,  3 Apr 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSSdA1OQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C4134CC6;
	Wed,  3 Apr 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132128; cv=none; b=aEhwbigHNZzh/ucKRjvSjNbFZFkMFsVySZpZhBS32BMKOHpxZYB2Lod9kGh+BqqHaislFRsrCdlcz2Xw5wPGKLVuEmpZwfWRVP67WzcRPvVeFIJYtg/BhRh0gAEtmGmpYC4e8z0ci6fDrV349lYvh3Ja3i1Lcv+u6gEUhVVM9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132128; c=relaxed/simple;
	bh=JOPsom47Sc136qgfvRV59X06uzcHOevejbHhq+F/jfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkudiykhLEZyoEkxbln8tPH5U80V/RAUPjvgfAx7MPDLuQ8b2iDmb02pWbgn/tfi9Jzwz0gT89xXjUN+WkWDEIx/30ZOLQeRGd9zmAeb4svDinL71AUQZ/lBxhpJh79QVGKRsurQo8Ywp76EvlQaBb/xbY5dxzCLq2Ru8gQlSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSSdA1OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1494AC433F1;
	Wed,  3 Apr 2024 08:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712132127;
	bh=JOPsom47Sc136qgfvRV59X06uzcHOevejbHhq+F/jfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSSdA1OQaL+eEA0Z0TUh0zRo4zDqXBC37Yr9QTJIMtim6w0ykg4OHiXGl/dCToq4D
	 p4vPulBWpALmObpWNkckM9RlQnLF/d6UiwsIhemLeA6wTN91gzBnpYNtIbWsYe9i9+
	 /IunC4Bf6a974R7AyCRxTz+8fngyK0QuoMJyjAT0oPTjy9RHpyDYW2o///6RBRFCfj
	 FXmwk/MeXGNSZ3sdgtsUMOr2YyWshEg43YNk7W4+PZ9Hvv4IPwNQwf/3NjqeSv6vF8
	 wkBqQ1ieK2IrYV7/lTlSOhNlugFs10d/7liI6zi1t2OKexThTT5BxiWro5VPV5HIRi
	 rk/2tG9fULdnA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 34/34] kbuild: always enable -Wunused-const-variable
Date: Wed,  3 Apr 2024 10:06:52 +0200
Message-Id: <20240403080702.3509288-35-arnd@kernel.org>
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

The last such warnings are fixed now, so the option can be enabled by default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 24d29e477644..a534aba0b97a 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -96,7 +96,6 @@ else
 # Some diagnostics enabled by default are noisy.
 # Suppress them by using -Wno... except for W=1.
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 ifdef CONFIG_CC_IS_GCC
-- 
2.39.2


