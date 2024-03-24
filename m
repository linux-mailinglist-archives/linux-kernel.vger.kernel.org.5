Return-Path: <linux-kernel+bounces-112922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F64887FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC828138F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25670CBF;
	Sun, 24 Mar 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCCWDA2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C186FE2B;
	Sun, 24 Mar 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319734; cv=none; b=imf7UUiXdLv5hV8JimdHXKoY8WqRVCXe+9DGHszXUWGH8mHowIeKKJqXdwSVCkdSrDhs4Z+xefOhaPshKSRuZ83wxGpR++R+uO+WgduGP/UyJyu3oAa3Aq27wnzT52yQO2Gm22j6nSkPIbZAF7OzlRCd/f6cjOCcMppdvwA/kA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319734; c=relaxed/simple;
	bh=QaMkZjrTKAwC5rT+/146rHqBP0Wkx1m7aIt1TJjwpCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQUJ70NGGciBnowxwBjhOBtDznIQ7WA2m98xuqmQw6okwp0lr6m0dUp2fwewknBURZPqJxMUMKi374Iia4wtbKaPCCSok2682SxHPiz1NbWAoepR5yV2TVsePNPu9PoeYnZzuYTbUTv0opsN4myJZUSNChhfArUs4COSEzMUQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCCWDA2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998DAC433F1;
	Sun, 24 Mar 2024 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319734;
	bh=QaMkZjrTKAwC5rT+/146rHqBP0Wkx1m7aIt1TJjwpCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCCWDA2CD1Wh1gcRNE5oNVrXjmURHqdjMGzIAFWbBMm8b8uj1mk4KdDCz/EUhQHpq
	 CdasrL6gVE8AU0F86pyXEIgT2Bp2GLOwFKE/PPsfKgVfZuyw6SXjMWdCAA9EQ9TEId
	 e+ZkqGMZF9vLqDIXxJ04/rYuP8gSk8HlubqVEExhUpEk0Gz3Hn/rYL5qpLKV2LdIwp
	 ydWTGjb6TWwPfh09Nf/eYJP7o5Q+W49uPc2rZ+0QfZpmseUGErnI5kMVenodp2OaVJ
	 yGQOJo1NulSah4PtYl7N7sXxkiAX6lVnnOrfWohm+xnvOfMvHOABrcVC/V01f+1qKO
	 hQmooKF3BtA2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 035/715] drm: tests: Fix invalid printf format specifiers in KUnit tests
Date: Sun, 24 Mar 2024 18:23:34 -0400
Message-ID: <20240324223455.1342824-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit fc9a615200d48e076af58f4309f507e500ed900d ]

The drm_buddy_test's alloc_contiguous test used a u64 for the page size,
which was then updated to be an 'unsigned long' to avoid 64-bit
multiplication division helpers.

However, the variable is logged by some KUNIT_ASSERT_EQ_MSG() using the
'%d' or '%llu' format specifiers, the former of which is always wrong,
and the latter is no longer correct now that ps is no longer a u64. Fix
these to all use '%lu'.

Also, drm_mm_test calls KUNIT_FAIL() with an empty string as the
message. gcc and clang warns if a printf format string is empty, so
give these some more detailed error messages, which should be more
useful anyway.

Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
Fixes: fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targets")
Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
 drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 484360c7e1f65..e48863a445564 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -260,30 +260,30 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
 		KUNIT_ASSERT_FALSE_MSG(test,
 				       drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							      ps, ps, list, 0),
-				       "buddy_alloc hit an error size=%u\n",
+				       "buddy_alloc hit an error size=%lu\n",
 				       ps);
 	} while (++i < n_pages);
 
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
 
 	drm_buddy_free_list(&mm, &middle);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   2 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=%u\n", 2 * ps);
+			       "buddy_alloc didn't error size=%lu\n", 2 * ps);
 
 	drm_buddy_free_list(&mm, &right);
 	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							   3 * ps, ps, &allocated,
 							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc didn't error size=%u\n", 3 * ps);
+			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
 	/*
 	 * At this point we should have enough contiguous space for 2 blocks,
 	 * however they are never buddies (since we freed middle and right) so
@@ -292,13 +292,13 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							    2 * ps, ps, &allocated,
 							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc hit an error size=%u\n", 2 * ps);
+			       "buddy_alloc hit an error size=%lu\n", 2 * ps);
 
 	drm_buddy_free_list(&mm, &left);
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
 							    3 * ps, ps, &allocated,
 							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
-			       "buddy_alloc hit an error size=%u\n", 3 * ps);
+			       "buddy_alloc hit an error size=%lu\n", 3 * ps);
 
 	total = 0;
 	list_for_each_entry(block, &allocated, link)
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 1eb0c304f9607..f37c0d7658656 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -157,7 +157,7 @@ static void drm_test_mm_init(struct kunit *test)
 
 	/* After creation, it should all be one massive hole */
 	if (!assert_one_hole(test, &mm, 0, size)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm not one hole on creation");
 		goto out;
 	}
 
@@ -171,14 +171,14 @@ static void drm_test_mm_init(struct kunit *test)
 
 	/* After filling the range entirely, there should be no holes */
 	if (!assert_no_holes(test, &mm)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm has holes when filled");
 		goto out;
 	}
 
 	/* And then after emptying it again, the massive hole should be back */
 	drm_mm_remove_node(&tmp);
 	if (!assert_one_hole(test, &mm, 0, size)) {
-		KUNIT_FAIL(test, "");
+		KUNIT_FAIL(test, "mm does not have single hole after emptying");
 		goto out;
 	}
 
-- 
2.43.0


