Return-Path: <linux-kernel+bounces-49855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC884708B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52971C26E14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8A46436;
	Fri,  2 Feb 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr4npCf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1F45BF3;
	Fri,  2 Feb 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877825; cv=none; b=E9eBcgmyegkE6C0CqMzTTVgerHsasxRA5RHyQPDwt5FBm9ZUstIp+Lvl9295u+Z9SQP4fAYW7g+lwhXN/fPS+JKp18E2XIy08g0BXKJG1TClNBqy+oapzNLb1g+6gauX1+8m/jDmJ9qGAHH1ZHF3Gpa/qVQhANqlMntI/FkZIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877825; c=relaxed/simple;
	bh=7w9jYsNrgzos+uYg26MrZfbM/Ib33qRnR69U9JTdFys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jogWZ2GZivXDp4AIYCGb4q7A3tLjBjv8di5SJ+9NRkW5Wsu21wBcwneURW92yiHhhmOvNpyWqBFbwqkEWj8S4rd05JxykaROzLT0AlGBUpCydCKBAA9LePFkU5wtCT7mSwN9H9mDjMAKG3hVKBZasOOcgzcxDs2zOYdsYqvuibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr4npCf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5781C433C7;
	Fri,  2 Feb 2024 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877825;
	bh=7w9jYsNrgzos+uYg26MrZfbM/Ib33qRnR69U9JTdFys=;
	h=From:To:Cc:Subject:Date:From;
	b=jr4npCf1yXqSmIqj7xe9gCzNMeVfBYQkr1mG5F4OiRKnJ0q/RXT19NhwuTafC8V06
	 TIzjMVLfly2Z2XsKL38dwsimVb41gavpiZ2ay3lasXYq+GDzhAkXpzhSklJs1PuU0n
	 v5JANdsDULyayLchy7vWfTRDq12h9FWKHdA+6s8Nvr2CzOBOepDtghhuawgwjrzmpZ
	 vDJoSAgpQ2gcZ5xlruILoo5vjgwHwnrz095Ex7b2f1x2/mHEqLNgVF6tT44s9fyPLb
	 7lY/wCGAgfauK7hEa0HJCHnCmVWGB3eOhlbYrCYAkTW7iX0hhf8RQIovbAoo/lTp51
	 60g8FuueDWFYw==
From: Arnd Bergmann <arnd@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/dbgfs: fix bogus string length
Date: Fri,  2 Feb 2024 13:43:26 +0100
Message-Id: <20240202124339.892862-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc correctly points out that using strnlen() on a fixed size array
is nonsense with an overlong limit:

mm/damon/dbgfs.c: In function 'damon_dbgfs_deprecated_read':
mm/damon/dbgfs.c:814:19: error: 'strnlen' specified bound 1024 exceeds source size 512 [-Werror=stringop-overread]
  814 |         int len = strnlen(kbuf, 1024);
      |                   ^~~~~~~~~~~~~~~~~~~
mm/damon/dbgfs.c:813:14: note: source object allocated here
  813 |         char kbuf[512] = DAMON_DBGFS_DEPRECATION_NOTICE;
      |              ^~~~

In fact, neither of the arbitrary limits are needed here: The first
one can just be a static const string and avoid wasting any more
space then necessary, and the strnlen() can be either strlen() or
sizeof(kbuf)-1, both of which the compiler turns into the same
constant here.

Fixes: adf9047adfff ("mm/damon/dbgfs: implement deprecation notice file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/damon/dbgfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index f7abbc0633aa..4a189eb65d14 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -810,10 +810,9 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
 static ssize_t damon_dbgfs_deprecated_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
-	char kbuf[512] = DAMON_DBGFS_DEPRECATION_NOTICE;
-	int len = strnlen(kbuf, 1024);
+	static const char kbuf[] = DAMON_DBGFS_DEPRECATION_NOTICE;
 
-	return simple_read_from_buffer(buf, count, ppos, kbuf, len);
+	return simple_read_from_buffer(buf, count, ppos, kbuf, strlen(kbuf));
 }
 
 /*
-- 
2.39.2


