Return-Path: <linux-kernel+bounces-115351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAA8893B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CA41F2F32F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EAF1EBD22;
	Mon, 25 Mar 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQQp1tCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9D1422D1;
	Sun, 24 Mar 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320546; cv=none; b=HRpCAxNXnGB+CrDzyuYy8yOsJUux8rjW+8wAVfGBJ+dgLOZQR6okZoCwfjJsACJxyqdYIHwf7458fqi5zCYAJdpXYAYi/MAPMRh0G2bXTO51q1bfi3WIOPsTl6H+Y4HeovMOdC+e9hCKS6B0AaZTktUcmvRIlD4Us/cZqIbUcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320546; c=relaxed/simple;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9TuaaKC7gmDMdyp9+BrfFWJz7ue/fnC38Szjbb/bS6yrs0KNTobk9rq9YRwh+DV2+HOIuCsYk0SafZvTcZ4JyLS3BJewvFBZcDd5+59108uCR2kLrW5guymV7W9fbY+QhNZSBoPK3hUQegLi8toD7ini9eWJEcfqLYHLuX+qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQQp1tCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4BBC433A6;
	Sun, 24 Mar 2024 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320545;
	bh=kcjCwDbEJD49FCkn7bWPsxt2uts52PTkJf8FWlS/DAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQQp1tCeM63NF0Z8xT1hXJoa1vFyz5wwOHdwS5Bj8uSCIt0vPdIxjMviWFcrzt/6c
	 RvthkeIk7EikXNAunpGip20HxZ9KYEoezNAT2rm3WLhKy6ylMUb8SFWlsNjx0hDW/x
	 Hc5O77lF10dkFS8Pr2V72SjaJUkvBnzsjjK0T3zcXq1P+JR1rUMF23Fa5TO9X2lO2g
	 pR/j3STgJUdNVDox0KRW66palwvplM4SAs0PdTiQHdSan3W8nszYyFRunlaKIZIial
	 V/iQrmS1Ko4YF3hbz/hT8Skz5zUh3OWh/Rk7qHF6qi43mPJa7c56h9gH8KmeV7uAQJ
	 GabzOA/+HOK4w==
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
Subject: [PATCH 6.7 106/713] kunit: test: Log the correct filter string in executor_test
Date: Sun, 24 Mar 2024 18:37:12 -0400
Message-ID: <20240324224720.1345309-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


