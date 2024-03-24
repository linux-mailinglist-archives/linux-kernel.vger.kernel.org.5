Return-Path: <linux-kernel+bounces-114064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEE888F34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC81B1C2B72C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501A15E212;
	Sun, 24 Mar 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FftRTn2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC61FF5CD;
	Sun, 24 Mar 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321374; cv=none; b=aG6NOFn+qM6OcwhWk3W2Kb7gFb10HL+uJltmrfPMardZ0EQw3fTXGdGVFFVIpKayZkxQutvwBexdFwUn2Z8Cufu/kYKuWBNEYmHJbRcizA+E17V3+oP4EZJbjevWB6jJQxhws02B0YKCjFXsIWet/ZXdxAdsymYE0IcXZi+I6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321374; c=relaxed/simple;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayY+f844/WpYTEN7i1W/PMsXh9BHmFGF6UafWzJ0QXqGwU2PfkztNDTtRhV0HZuLuWGgqYfEHj6r4ssby7bdDe4XfeDpLwF5KIaGkhlMdehzkjyeVZYsJIGtwAjqCAx4/cmvuT9JeEM6vrr5YDXRbLWj6GM1kz2hbU8ToFLqBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FftRTn2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B87C433C7;
	Sun, 24 Mar 2024 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321373;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FftRTn2SFAynQm8RAagsUmEcCsjJQyKZBt9XVzsNVE7d2Lra9CRjSXveFc+64kyWN
	 tAVKFfFgpRN5nOxyaTty9qdo3dNAgjAXJo015s3zCpAmen701sEFX+4wGmEprDJZyq
	 z59B/CjLsgJemjK7cpDEjAJDjcAA9C53OUV/ykdBwP06P0ZJLKwzPdviU+cPbZxAFM
	 13dyMd1OL+2nOLvNfWqDzv9V2bHRYx6VV54RuI3pQ6eFz5BdfDTDFnJIr8aWTPncwN
	 XuWVrpM3c2xpMQZ3wsMSFF/oRsl6z7KP0WyOubxbhvUpbfEPDAjtnFmm2zPKbgGAMI
	 I0ZgZ8dGMEAVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 097/638] time: test: Fix incorrect format specifier
Date: Sun, 24 Mar 2024 18:52:14 -0400
Message-ID: <20240324230116.1348576-98-sashal@kernel.org>
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
index ca058c8af6baf..3e5d422dd15cb 100644
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


