Return-Path: <linux-kernel+bounces-115353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F718893B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F34E290555
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795381EC4C8;
	Mon, 25 Mar 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9a9A5ma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540381ADB;
	Sun, 24 Mar 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320547; cv=none; b=m0Mh75qo+dfBfArmqBzj+tTh1X2/IMnya0Z40e9ZcqzCB5K28KfX8j27dJPyw76DkfyPFVLE5mInrfT66Vis5zSC1HkMp6KzNjFc0NaloHNjwAfPdvTO8vxrh2CG5Ujd3ndNQYG+iARh7toe68356UcBYITpFHhfskbor8GGlRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320547; c=relaxed/simple;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emstW3FzHajmogWkkKkMNepupDzSobch1Tj63G93vMXubPF2oS0AeDytLrNQ2QntUNAtEu+4oUsl0zmTp+v31DdwKbOfjIEI/Y2iWu8CKefO18ASSBe/sBdE6lRrXD+q+D79Fd2JtJhTaqIvpUtyJQMHdMlNgnMYSYdMKSthzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9a9A5ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B4C43390;
	Sun, 24 Mar 2024 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320546;
	bh=UtPbFHo8lwti70qwLux/kF9zRmuI2UztEodfyyPfoCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9a9A5maXPKU8On3HszyYBE0lPB2y8tvJqEXF9x9NwgzJ53u7mWXYT8mY7K4L6a/7
	 tcSvQx804G5zhDua5FHFDd+zmgYWJ1pZ5YNAlobm+ZlAMMvlSl2maCr/MyQBqVRiOO
	 WJbrQWqUkro0aIMeS7CEFafE3qRyBJMICtALqR9Chac5yIRhjHC/4UKg9hhcM6ZxNu
	 yqIQG/ARdNvSvnSrAtVYc/MsIN1wog4k2II129P+b0bFr5dFOUdVMC0//7a3rjo/CB
	 QIjgnxo36hoDFhMnEMrvn8A05wG/yyymOTky+iZzHUaMEOst37efsRKhOZ8RuMgCfY
	 w4jDqkfjEAKpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Latypov <dlatypov@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 107/713] lib/cmdline: Fix an invalid format specifier in an assertion msg
Date: Sun, 24 Mar 2024 18:37:13 -0400
Message-ID: <20240324224720.1345309-108-sashal@kernel.org>
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


