Return-Path: <linux-kernel+bounces-37183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1490C83ACCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B8BB22BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF9136648;
	Wed, 24 Jan 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXMUN5cl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935D135A76;
	Wed, 24 Jan 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106720; cv=none; b=bvO8TuwFpzBxF16PwUN13dcwiOMvXCCdHvn6StuOquAO7FKMmqJqvOVtor/zA27Da1/ZMXqnbjfhhCpmKQ9jRIBUju5ImcTWfT5HLrLR58bbY4QwBHikJZ02XOQf5DQYv7uvGTWwLxNmTykGE4U2ZAIkN8tIm36/JvlOQv+aVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106720; c=relaxed/simple;
	bh=RqHq28KrRsG1sb1EQg9DKXv8hvRBmr+M1tnj8o4C0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDOwrx7rewq6addgPzkIzsD+W/DNz5s6znr7Ecey064qT5duH5oTcdgOg40mFzr5IdF6Ig+SOLEUQs0DnrU2nPUs4tSco0s8lV1JWdLc5MAef/mNYGSAJ2iOGu7ktZov0R2HpVzcGEkZGnbCKIjKiYxdijiHtq7LDCUHBwW6ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXMUN5cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A6C433F1;
	Wed, 24 Jan 2024 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106720;
	bh=RqHq28KrRsG1sb1EQg9DKXv8hvRBmr+M1tnj8o4C0r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXMUN5cly+xxrEFw3U0pI0Gl+IN5fc92UPB0oynjIIW5uPUGyar7abaqtNIkQwql2
	 AKCjXHSDuuYYDn9LQg5I4i5Yz99kWcaWG7kl7UV3l+AV7UBl2TKJttZrOSS9gRhXWk
	 ftkcRrnCjgu8nCrq38b+xK44gX82Q3nX6W8qwpB6Zt9yMSWWBWYU+f6gZ0gBVpkYrR
	 E++u+Q4wmlafc5iI9xdtIN+lO7j+NJC+Y/4sMoIjq4M/U6GzHrEvr2ze5kOMDWkr4P
	 s18GvygltVWAtrsR4n6F40+yV8XtQp8YFfENmM+iU1AIoVOkSH2atNq0xDC3STzhPM
	 M+/OJ0W5CdRIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 3/5] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:31:38 -0500
Message-ID: <20240124143149.1284622-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143149.1284622-1-sashal@kernel.org>
References: <20240124143149.1284622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin@sipsolutions.net>

[ Upstream commit 236f9fe39b02c15fa5530b53e9cca48354394389 ]

The threads allocated inside the kernel have only a single page of
stack. Unfortunately, the vfprintf function in standard glibc may use
too much stack-space, overflowing it.

To make os_info safe to be used by helper threads, use the kernel
vscnprintf function into a smallish buffer and write out the information
to stderr.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/util.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 8cc8b2617a67..0436cc9537e0 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -166,23 +166,38 @@ __uml_setup("quiet", quiet_cmd_param,
 "quiet\n"
 "    Turns off information messages during boot.\n\n");
 
+/*
+ * The os_info/os_warn functions will be called by helper threads. These
+ * have a very limited stack size and using the libc formatting functions
+ * may overflow the stack.
+ * So pull in the kernel vscnprintf and use that instead with a fixed
+ * on-stack buffer.
+ */
+int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+
 void os_info(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	if (quiet_info)
 		return;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
 
 void os_warn(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
-- 
2.43.0


