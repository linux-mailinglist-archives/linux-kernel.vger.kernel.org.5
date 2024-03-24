Return-Path: <linux-kernel+bounces-114758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B177889104
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC001C2C963
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268A21954C;
	Mon, 25 Mar 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhAOVAFK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A1174EF0;
	Sun, 24 Mar 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323343; cv=none; b=G06Re2bJIR1QM6LOhq9mgW1e71gGF1WbUT0a9gnmbLZKj1/nDp44wMZjYeaea0NO+nl0wjYNpwY8kGgOhrpunu3Uqb+LBIuNpDMUZjdye2JDq1JJt+mbu/PDmF6w/y8TqOzYF3Tk2qsnd3q7EYCoZ19V58uNLoBGqM4pU9b0GfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323343; c=relaxed/simple;
	bh=n7Nw90Gp/WYZo0MmZIPnH/OngeW6HI544oQSyDnp0Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5mw7OsSgt4jV3kYCnItNel9dve1Bk6b4rFdcDGm+hQ0ynzmBS/c3pF6WNxhGj6QPVrsOvvfnwF7PdoBtsvpWBZEFG1+wqZy80DO0qJyHvbJVb7aiSm/M9nEip4C7x0uxWTassyp72IiUmxKb5BOHNxGAAzZDnOwj6lKQmBPrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhAOVAFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A9C433F1;
	Sun, 24 Mar 2024 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323342;
	bh=n7Nw90Gp/WYZo0MmZIPnH/OngeW6HI544oQSyDnp0Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhAOVAFKFT38GdF2lwEfvSNo3GFyZkPNPfzbF8H0pfGlDvvoxrufP/S7k+DB8Iw7R
	 E+Ntu++uPkc09zEJVy0HUkIRKXNCJfaoVHkbyfiUC5d1Q7FrHGtfNMdHLInpa7cbY7
	 7szUEm2/4M2ZgIYSQ7DgAgQ19Kj4bPM08VumCK+SK3MET2m/Itu21WXGOf44xduZDj
	 BtNYC4vidvX07EPmS2BBsZlhisKCuDnb/3HbuLMko9n8OETmSThKwBtnaUQQQhZgkQ
	 xfzwRc6e2vAkMPrDjt/qeKzgtSAprdjSzRO3YepvgiwgBFMX6mS6MhNrOYknubDlrK
	 jpvyge2nxhc/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Latypov <dlatypov@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 042/317] lib/cmdline: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 19:30:22 -0400
Message-ID: <20240324233458.1352854-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index a72a2c16066ef..de7fb7476cb9a 100644
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


