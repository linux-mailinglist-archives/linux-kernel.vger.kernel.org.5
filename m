Return-Path: <linux-kernel+bounces-114079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB088884A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35A11C2755B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F525236586;
	Sun, 24 Mar 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVy6i3dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D81FF5B3;
	Sun, 24 Mar 2024 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321371; cv=none; b=XGI4uKylNKwG6f3fKCe1XBWvSI6ManNQkE6La33O1ysltCmhq4ldiRpnpmIbCIOjDgje73sX9vOTfNQYF+bdaK5RXKxj0TWtNH0HkriJzfeX7iAQsJQWlLUX0EHERe0igoJ5loPAW5hUfqDf8QSJyScA95uCesOurq/5DPK3XcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321371; c=relaxed/simple;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m93+Z/v0z7fuvC4C1hK3+/6ugcTY3j5RWhHLPTpmLQ6Y5cXhlZlQ6E0Kje5ulxCbXIpqfg7mDez4b/x1/WKJuyhpEc1pWp6D6YjT7JhOOSD+FbnDNq1ZWswjq8Rev935/argV5W8fyhsTGgh0jSSKHD+J763mCcIlFiEOsYCKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVy6i3dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F125C433C7;
	Sun, 24 Mar 2024 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321370;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVy6i3dqkFrQmQPJ9eji195d9W6D7eFv+2LT+jaCUGztjsrqm7e16/RtRpxVBUhrV
	 yOFu5OAfqLHtqCwmZhnnCDAHaLrRLI/YVRIcNkyBORxPVzrOciGD4LqhQ7qZ8HjP18
	 07D0xKUYs/e11Gt43QHyIh7dqEvcrkV051+79MBsEXa/UfVAuqjPYjPaZl1YU+9W9v
	 /aCw24G2KpjihA2A+81wa8uuxLh3RvgsXteuf9Q7nBJCRWLLRcv6Jcz4FdAZIQfBRs
	 VZSF9Th3hCKgtXZuX/41aB8tpEMUtN5cRpmEFSP0MrA90uWCne9O5ZlSNtNsNOTP0N
	 jmD0qyLgY06pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 094/638] kunit: test: Log the correct filter string in executor_test
Date: Sun, 24 Mar 2024 18:52:11 -0400
Message-ID: <20240324230116.1348576-95-sashal@kernel.org>
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

[ Upstream commit 6f2f793fba78eb4a0d5a34a71bc781118ed923d3 ]

KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
but passed a random character from the filter, rather than the whole
string.

This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
the format string.

Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/executor_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 22d4ee86dbedd..3f7f967e3688e 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test)
 			GFP_KERNEL);
 	for (j = 0; j < filter_count; j++) {
 		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
-		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
+		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
 	}
 
 	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
-- 
2.43.0


