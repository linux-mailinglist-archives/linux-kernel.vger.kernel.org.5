Return-Path: <linux-kernel+bounces-112916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53515887FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BFA1F21725
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B236E615;
	Sun, 24 Mar 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksGCOPnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E56DCF5;
	Sun, 24 Mar 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319728; cv=none; b=lX1sFkJSWcJBco9cN73kH+vOScZJzqWlZJsFdx3McgoeRl6Voh7MZ3LP0dM/9wG72x2KU4VYpxX0O/s6odLst/8kJJOepo8KZvpsbfYjLe3X1iecF2rc98i6b1gUAqgpDUfq1aIAFA3AkMdQ9EJWy8EZtDgM5tTJociO7rrrYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319728; c=relaxed/simple;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1IxLBpD6CcIfEOlrV2pzqIkbbZAik6xSevIpP3MsLx8ZPyepcwZZuyv81r1vy5skp/9FjF9mSXeC2aT6kal0OYExMk7Yj5q2r7nqaLDPR8xgUE9oUqjXN+aQQTXN8Qysk93RLskaqgv3lDLXTHDPjLtuGNGOGYPUlAVhbOyjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksGCOPnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D1CC433C7;
	Sun, 24 Mar 2024 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319727;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksGCOPnnbpSerW8vz6zFtqvEmug78gJKX0Uu4O/yUZDVNQXuTFd1sdN7aJ0GzQshI
	 GkQW1G1zsW/bQa+Of6NjvWO+Ul0bmamNrpNM4Yw57GgJDDMYzT1l7eI6i5b4oT3HVq
	 COrBFDtgH1a5PfKJ9yHtniUPcLldSxEdiC3s3DgPzxsrY1CezKOyVUJuVhdqXr4lfx
	 D1y4SbJYj354eR+bEry9IhqnOwpTFSxCfceJUcYpcdtN1GOYG/qr9dRPwh6kmMQZv3
	 7BxrhmQ4C34YGcyLPbunKmPvtG1UaE70RncX8ij4Po7ycsS529eFoLqokW+5AxdcjM
	 g2VxMTs2c8qnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Latypov <dlatypov@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 029/715] lib/cmdline: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 18:23:28 -0400
Message-ID: <20240324223455.1342824-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


