Return-Path: <linux-kernel+bounces-120080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AA88D14F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC01B23656
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DD13E6AB;
	Tue, 26 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5j6UdWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B713DDAA;
	Tue, 26 Mar 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492838; cv=none; b=h00sRcB+x1aOEqwFhPyEqnKnjZG8Ygs6JFGUkyrSs5JiQlb65KyXQWZ/e8jiGmZHLl+rBw1xMpkZBGqM9d8nm434ZMcseA1aWKtDrg4qHFAfbMnDtBt3e3vsWBjZjRKLWfc6m0J64c5XGzcS6bKG4RyYNh15FCYJYOo9S6tFbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492838; c=relaxed/simple;
	bh=DvdOaxXySSb88hE1tdZLq/K7+rtZJ/+uDHjNaQDuU0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jvr5W81AGEkxwkYEVdxJOP8MbhmPr2qJLTcrDNn9BXwKlrPGEcxQEuDtTw73c1Z+6eEtQMng1kU7Dn55gyhN2PAX/XQQMTP8pRofRr3jl5/z6tWtYCa4o1mH5EVuGcGKTuk+BqcfTATlsKhRkMMdLu15JwI0mitO2vxEZJNLbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5j6UdWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F56C433C7;
	Tue, 26 Mar 2024 22:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492837;
	bh=DvdOaxXySSb88hE1tdZLq/K7+rtZJ/+uDHjNaQDuU0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5j6UdWxGLPCw8MD1MG7G52pz4jf9eUDs/fFAPZ0nSxoBq4yXx+Or5Lgn1xXUeElp
	 +cj8i69kiAsbFcByaE6X3MwtRtceTT9Edu4WzpCWxVfQyKIQliXEXJ9jaPuhdPt1EO
	 hPTTraFVvOo4PuszlnUsVbUVQUggXvzt/b36cPf3IquLaD83kojbUDODfNp+wT8Qnk
	 rI2SfYkMFrUIaTNggJBf3zCEFOjGEO3szpfqF7F/VaaNyAUHWaDczx4OxbnERjzweR
	 DJEEn+vReYcCj0bTRNiF21fVJnOstGn5xp5kbalE8IMqei4+oKEuSso3nQa0xJ0jNL
	 NVn1p1MByEg6w==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] surface3_power: avoid format string truncation warning
Date: Tue, 26 Mar 2024 23:38:04 +0100
Message-Id: <20240326223825.4084412-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns about printing a pair of escaped strings into a buffer that is
too short:

drivers/platform/surface/surface3_power.c:248:3: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation-non-kprintf]
  248 |                 snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%6pE", buf + 7, buf);
      |                 ^

Change the format string two print two less bytes so it always fits. The string
is still truncated, so there is no change in behavior, but the compiler no
longer warns about it.

Fixes: 85f7582cd484 ("platform/surface: Move Surface 3 Power OpRegion driver to platform/surface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not entirely sure about this one, as I've never used escaped strings, and
don't know if gcc is correct to warn here, or if the kernel defines it
differently from the standard.
---
 drivers/platform/surface/surface3_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
index 4c0f92562a79..72f904761fde 100644
--- a/drivers/platform/surface/surface3_power.c
+++ b/drivers/platform/surface/surface3_power.c
@@ -245,7 +245,7 @@ static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
 		dev_err(&client->dev, "Error reading serial no: %d\n", ret);
 		return ret;
 	} else {
-		snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%6pE", buf + 7, buf);
+		snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%4pE", buf + 7, buf);
 	}
 
 	/* get cycle count */
-- 
2.39.2


