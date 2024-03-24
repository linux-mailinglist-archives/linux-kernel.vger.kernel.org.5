Return-Path: <linux-kernel+bounces-115823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E1889694
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37D61C304BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFE3782AC;
	Mon, 25 Mar 2024 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqRRpLnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24990145B0C;
	Sun, 24 Mar 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322001; cv=none; b=AYsne6ZWSShl2ig/nsU2LEn7I0ALcIYFabAmwfSymYdOZriZ+oExaQgvv49LyUlwVNupti5DOvNEsCRz2RI0SMmJksN3aBfp5RZ+SO/AuCbBX8NEHYhHs2OVYTqFchQm28Hc3L8cwhy2U5SR1Gj4hEl5RjqPU6Ki4maZWlLFhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322001; c=relaxed/simple;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA5/Yv8BHtgtmsRaLC/GCjPMLs7FpIoOFo3Sy09RXfsaYDE36Xc91+cGoVXTpE4bNTNNcArM+/DVN1AgSUoEQwoPu8qjPhUIZ1kOep5r5hHx8R9Yc/EKN16UktZiCYIXv1MoGjLvWgFTq0JK7jK94mEQ7AOLly/9tNFZ5mpQ9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqRRpLnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F390C43390;
	Sun, 24 Mar 2024 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322000;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqRRpLnX4bqfm9wMr3Vq1KvbdhRaQ2ciJfRLXANHGh1D0atXPmQ3wUjh3cxzFS2l7
	 /onkeWXrHU4MCsSSbsniN18HN9YH948FoGZacZ10ijEXUxxUGdUlak8Ysv9NMy8aRk
	 j+iw9HevSqPa2u0FlXhckmxE6TAdXjJrwBHpfJoFrVU9Gj7veNLVyGkqaHamR4Eyxy
	 hWic9mgF61ZVaTzTN5JUFRNTN9idZywEWP7hBgoMbitdI7aP0MUV9f5ThGt+yH41Ek
	 usAiCmP1d5kBC6pa8xenzbNsZAaQOpd7SyOuMF/YGZeoaTmRMPCQYCqwodqMKddtoZ
	 UJNu2Z2aDzjoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/451] rtc: test: Fix invalid format specifier.
Date: Sun, 24 Mar 2024 19:05:47 -0400
Message-ID: <20240324231207.1351418-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


