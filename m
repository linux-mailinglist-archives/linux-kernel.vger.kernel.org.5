Return-Path: <linux-kernel+bounces-114075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E24888838
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8101F229C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A19234D9A;
	Sun, 24 Mar 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmR48/hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0A1FF5D7;
	Sun, 24 Mar 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321375; cv=none; b=Q4luDohRkrKwqrgASi3oezfvX3eGyy0rR69lSg1aGm0HeSvBG2yccN7yv4YXF1TnKqWw5LsuAhtsw+4hSvR4QQqs+HaYxd++evFim6JPJzK6/wvexJgjYQ/3bLiLHRXlT7bNInAOWHl6s7KgKaXue4pZSQGKnrX1Z6Uf43f9UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321375; c=relaxed/simple;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqLjy8DH4uPUCFGePpbUB07dC25sVJFvpwoM2NyeTknbR1iYucYzgbNmkZUzb6+fH5EijDyY32jFT2tVuClbbB4drK1uqWEndBBkQdiakRZMFi3ESlLBI9Z06A+uVKHmJL3d2WFu9gD7yX3dPcWYrBEjVsolVsE+Lb00h8+/iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmR48/hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946CC433F1;
	Sun, 24 Mar 2024 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321374;
	bh=5C+htp1cj21cUDOBsDFxDwPW3yx1GRI9GjuFvV4teBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmR48/hyUebQR3tds3kNVqqQruJ5xjEjtPneg2K6euUZJ8diRf8g29PDvAaIZ4dWn
	 WDF3McGGRXHKcKyBZmNSfRsorN2Ge+rIfh5YVgbXW70+OXcRREweQguYGQYIroS9rj
	 djXJp35vvGf4WpxsIAqZAo4rGXBvugs3MPchy9Eq2DzCLzKUVfAcjoYZXMpGrpSE8v
	 XHO0J5foj7W7OzDbZbt77XJEynE1ISpTnKKtruUr3okqSiMRouRljmAH2eAB/qRQlq
	 J2hf4XMvNmzwavgKUnC9phEkODYxX4Em+UO8pJ0Otd/b4OZmZOdkakFDcFwmindI6b
	 leuIy+iUoh8QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 098/638] rtc: test: Fix invalid format specifier.
Date: Sun, 24 Mar 2024 18:52:15 -0400
Message-ID: <20240324230116.1348576-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


