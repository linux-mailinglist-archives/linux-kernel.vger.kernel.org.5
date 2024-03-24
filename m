Return-Path: <linux-kernel+bounces-112919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49CF887FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D431C1C2100A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136C6F079;
	Sun, 24 Mar 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYKYVW4f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9D6EB7C;
	Sun, 24 Mar 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319731; cv=none; b=c+D8h9gA6McMky/cZpEUEu4vJyXIUDDuAtCtdzeNujvyWyGY4hlojVwZvE+an6+HAGq8IxHiORArmbh9O9cWpsONrXOpKPp1amULrCEKBoakTi13MSouC73EC8IR+0XnquPPPrijGt7/ipKHpr8p4Woi0JthpMFEw7gErZVuXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319731; c=relaxed/simple;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYwOemICwudZwka9+GxQwPcdcdHSbDzXQdWU2GGgEueNZNalxY3GuhRgQ5pmFiKaqYNlwj2MuF6jDr+AHDdPSdKTfDLo88nqQwUbL2zXhRad9SqPRjX95brlljZGiAJbhJoWFhYSbG4cRaQSxtBs9SRYtSDosLcU6SRXbETm8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYKYVW4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333A5C433C7;
	Sun, 24 Mar 2024 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319731;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYKYVW4fCC/IvR/1m0eq7YQXMHe9aX5LT17KVEmtKzbzFjo2C3sG1C2tzwziADlyZ
	 tmns1ws9PY07jjcBZk2vX4jH1HwmoQrXL65N2TOUzwIXkjsc86Pa61ZYUut1llSEVq
	 kR9lfdR8y1ZRZH5MfJT1SpmWboV3nspfN+9gCNS+WHMXitFH0XckAOd7o4d7oEupPy
	 e6FBe8kl8LoJEfYYRM2OtRHdpdaQnaTzr4LDbZiw3wxkR0JSywP1zxR7jEMXKtCBn4
	 dh1BXDS8PysRPidyaBbfrtzxl824SG1VOfraP0ufu5I+RQqvrd8w6qMfpNjT4kBvCh
	 NRDL1LX5vMGjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 032/715] rtc: test: Fix invalid format specifier.
Date: Sun, 24 Mar 2024 18:23:31 -0400
Message-ID: <20240324223455.1342824-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 8a904a3caa88118744062e872ae90f37748a8fd8 ]

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 1d1bb12a8b18 ("rtc: Improve performance of rtc_time64_to_tm(). Add tests.")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/lib_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index d5caf36c56cdc..225c859d6da55 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -54,7 +54,7 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%d/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%d/%02d/%02d (%2d) : %lld", \
 			year, month, mday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-- 
2.43.0


