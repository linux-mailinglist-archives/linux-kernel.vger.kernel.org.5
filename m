Return-Path: <linux-kernel+bounces-114761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A4889241
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4CB295F42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22EA1B04D9;
	Mon, 25 Mar 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj/UwNUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B861EFFEA;
	Sun, 24 Mar 2024 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323345; cv=none; b=MI6JIH3YdJeAwvDp6+SFFBPQcUQ1mrtdezFGQ3MHq7SVdOKaT/E/YyNUvPTBhhv5eka5Qif5PJ8RHc8v9bCYPmTwN6+F5AmaNON7Rehzqo+mrDyJ2oDS/loWm5bjZTE1g/4Lt1VOk/A12G92+uQhAluo1DXdH7xlxEjeiF1EiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323345; c=relaxed/simple;
	bh=m0x71HP1+3WNaL21MuUBueBIDkfZI+lwGDAXS1dSDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJN1A14VDd4+heo31pCCLBpUniGG+SbA3AUbQWDSgl/IvfgQOCmtPQRyvEX+uKEngQXpg7vdl7QmVk65VuPbzJC69DajJoJq1Mrdt+wVU8oxRZAmgrYSL/4w6EML4hnSA3ZX5M3WFRzV/HaCea8PVLGUjjo1r8vgpj6ZKzg3rdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj/UwNUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F6C43394;
	Sun, 24 Mar 2024 23:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323343;
	bh=m0x71HP1+3WNaL21MuUBueBIDkfZI+lwGDAXS1dSDuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xj/UwNUGqX6n94OjCDdl7lsHXvkw4AyPKjPDoAf5d/KdU3zNI2GWoIIQEs3zXRqKn
	 Coa4dirrH8/Xbb3095l5B7pXNryKinxOU29dxgecRmsb50593OVuzAK/Y0vau7U2WG
	 gGn3r5eYl2I8C+dQkzvIMXLo/49yG1RkdHNnF9pDFwkqC1RAljmfBuQzxzT+N2staD
	 u6laoHi8IZKm5CMBkplUV+VtK1XrJ/miaAbSXKhVkaxTi6ALVQPKVmulThzg2I+svr
	 HBFlKjWxkaqK100leDnicVuxUvECOGA7QPw0UN8ST1eK+Ql3QM9lSmOBk5qHYwD6IZ
	 skxERhMoY6v7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 043/317] time: test: Fix incorrect format specifier
Date: Sun, 24 Mar 2024 19:30:23 -0400
Message-ID: <20240324233458.1352854-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit 133e267ef4a26d19c93996a874714e9f3f8c70aa ]

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 831e8e779acef..f7c3de01197c9 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-- 
2.43.0


