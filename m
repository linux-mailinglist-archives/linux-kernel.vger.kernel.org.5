Return-Path: <linux-kernel+bounces-114080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E506888842
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E787B24122
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B123659A;
	Sun, 24 Mar 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azoMfycP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CB1FF5BC;
	Sun, 24 Mar 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321372; cv=none; b=jFKMar00oAAQZCISQBGx3k4WjEFV5ZmQZW6/gckq5xPB4LhyRZdMSQFH6epDzfeWiLgSw9r5cm8YiJaoVSsJ8eD5w3DXW8bIRCKa1ZD259rvtkqhCo1+VCw+cmi1jylmYUKDt9R7cvxhVoZdJPjlcUEtNEG6ZP7yBr2Iu4l3wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321372; c=relaxed/simple;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWNkXmKZP61RPXRVIr20F0LsivrJ2fFeZojEeYkmVUA9WPo9+wX9BE7Aauf4quIfSSGqfJGeyCNywzGXxy/2MaWH1+KWJHO9Q22V1FYsk45kC9dJYufJzqN0fEHrIJlflevHv/l86Yzzwd4THfLDn8AJmvwft3ZZ4+ILrBQQjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azoMfycP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB0EC43394;
	Sun, 24 Mar 2024 23:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321371;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azoMfycPXNz+Z37QfLDbfCLmCJ8PDI9aB/9s70LvmjqlKyez4Gixtp8+QMQYhp90G
	 r47Y3P/Rt+kiVO/qvnYuLbBSHf/vlbFGy3oKjvLuPV3jxeaD3LfdT0oekHts5GEtlf
	 hdOsRpggZWpFOhakLuZFtlBcrNWUmL+FgzOs9CEr+5fb43u9Hi3F46/oUI2NlRWV+0
	 B3nLBfOBaKhnweS5WTBd9bK3f9wRBDsQsCCa5xTt/EO0ob4MpCyn930lrSaHRC16hl
	 C6d4GMV+M+j3QxsJJ12oHLEZlVEDQbp+yxa1eQuccNX1JaAtpDX1o1l+sW7w61FUHI
	 y7I92lE+8mL8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Latypov <dlatypov@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 095/638] lib/cmdline: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 18:52:12 -0400
Message-ID: <20240324230116.1348576-96-sashal@kernel.org>
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

[ Upstream commit d2733a026fc7247ba42d7a8e1b737cf14bf1df21 ]

The correct format specifier for p - n (both p and n are pointers) is
%td, as the type should be ptrdiff_t.

This was discovered by annotating KUnit assertion macros with gcc's
printf specifier, but note that gcc incorrectly suggested a %d or %ld
specifier (depending on the pointer size of the architecture being
built).

Fixes: 0ea09083116d ("lib/cmdline: Allow get_options() to take 0 to validate the input")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cmdline_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
index d4572dbc91453..705b82736be08 100644
--- a/lib/cmdline_kunit.c
+++ b/lib/cmdline_kunit.c
@@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
 			    n, e[0], r[0]);
 
 	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
-	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %td out of bound", n, p - r);
 }
 
 static void cmdline_test_range(struct kunit *test)
-- 
2.43.0


