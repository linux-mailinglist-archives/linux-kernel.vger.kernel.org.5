Return-Path: <linux-kernel+bounces-115347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C04889B06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2282A1AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0621E8919;
	Mon, 25 Mar 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkrANMUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541513FD6A;
	Sun, 24 Mar 2024 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320549; cv=none; b=gFnQw0UZgNGEN4mwQf28unA65EwXowaLEcOwgIyv9vdbGAsKQk/fH6D7jCU11W3HaFoldoyoOaCNs6unlET/mX0NrIBQ1cqlQ1SYnbWX3GTDRw2Zf8dVG1z7dks0ysDaWTDLl0VJDsssEJEad05qV0A5x7wFc1ZvwjsBMT5USDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320549; c=relaxed/simple;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs94Ux+2ZS+TlH4hmQXuWBRU2md9bCnk1FKruNqWYRcjGgbaclkjyHLbw4TtlVKR8BPagKur+rHhlVnjWzAjXEFRxkwW0waoqshZcr+NawTfjakaknKz6HMwQBziVUa+06g9VIeLHsa0HF+7woukNAQkVcBGs+mokAFvGavwHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkrANMUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8513C43601;
	Sun, 24 Mar 2024 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320548;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkrANMUes0T9mzgx7G8b/V4xX1pBp5bAdJ6wYegbuiSIXiZfeS52ne5yJlAKH+gno
	 GM6VUun7zITALJ/2OM4ETpEFfGpqILlbvj6sn0/0YnImSQFDAa3Ek6uXmK459sLuxS
	 C7x+o5M9uLUbBrDj6V7snoxxPsSsbWElrdmvAKReeQ6pJZttSmB9C72F00L5+gi9Nn
	 9Cpx+hYbfcP7FdsdYAKTHVrfOBguzVjI+XwYvyHwSOwqaJGjxnAslYd4ejpZiCQ2vj
	 eyG6reit35mOEkXmrgsi4HFxahNSw/oKddcY3qxp8fT6aikmh29P61HclDgJHdLiR7
	 Q7ejIOgQtiipg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 109/713] time: test: Fix incorrect format specifier
Date: Sun, 24 Mar 2024 18:37:15 -0400
Message-ID: <20240324224720.1345309-110-sashal@kernel.org>
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


