Return-Path: <linux-kernel+bounces-115815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171A88981B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF99829CA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF33767CA;
	Mon, 25 Mar 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLlSugiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F53387;
	Sun, 24 Mar 2024 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322000; cv=none; b=dz/F2EtpNe9f0k6fvoep7QZp5uGoM0b9CCOTp5OHRcMfGj0dkvGMgDEI1Km3wO0WmXTjUHWbgTsOFmbqo54mlCbVVyrYk3r0teqekAyB5qVUsA1xYhOYmV/vRl+/Cv7sA93gEfGulmVRbTfx0F0tQCpdnddhBFUMXE8bE4LCH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322000; c=relaxed/simple;
	bh=m0x71HP1+3WNaL21MuUBueBIDkfZI+lwGDAXS1dSDuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmYAsXyaVKIVzr9xx2iMj/Mqo5HROMAyeNs0OwBaZPU0xV8+MTuNwrvm6hxktw8fXTs663MILbmDIioAVA9p7F5jrMFonUIYtRRBj81AGNjh4HhscYXJ+gkSL/HFh/GGcGKNY47ooJoz/tHg6q248L/bebXn1RD84kzREBGsqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLlSugiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D21C43394;
	Sun, 24 Mar 2024 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321998;
	bh=m0x71HP1+3WNaL21MuUBueBIDkfZI+lwGDAXS1dSDuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLlSugiPrGqOqi1FMQYTjdKrNhg2+NVt5KWNkKTNfNt0PtwEBFtw1Q1USugbMpec1
	 EMW4qb7P2spHL3vG0R9iBWpU9OnRWxJvfDcmJ7KyXypDHxoJt5hEMyMkXB9bpstJh1
	 KRimxdvjawNetWyqjb8ek1HOTHEQB3oeWE4HE6zmF/3QoCzHDUZm8M5afAJR/9lrCX
	 O2JK0J+NgHsWJw3sqlX84HZJBQ3oWJU+hCSLARxPJ/+puXE50WJt+TDkNea4VMKB4u
	 T0QPYauC6erPc7oTUketwYq8Oe6zNWLT+IMj/yHm/FDKQTaJJARX34zUsf1fpWYlBN
	 +sbh6OoLjsjFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/451] time: test: Fix incorrect format specifier
Date: Sun, 24 Mar 2024 19:05:46 -0400
Message-ID: <20240324231207.1351418-71-sashal@kernel.org>
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


