Return-Path: <linux-kernel+bounces-37177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4583AC51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092831F20588
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEC1350EC;
	Wed, 24 Jan 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUsB3vPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD561350D2;
	Wed, 24 Jan 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106695; cv=none; b=CG4W2ar3676rdsDo45PrmvOMwVg+s/cjXsZlKaNrHZa76AeYD4Jpn1u6xwQ3fD2TLagk+84Pj2oVaMZKAije337K9mRHvpFRT4qxGS0ovbl9z1sE9rbexMXXu1WhGVIX0AuqOGXkVeKMq+j24J6we8mlYsSs4oWOBJQ701+2OuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106695; c=relaxed/simple;
	bh=mHvd9apj8BXG3CS5HPvF6zxU8m5QNDA90dsY+iDv3zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keK3qsj4NupKRQwiaZXCqG4H3iVe9xhpQCBkm+z0eyhc1ABMSfEY2cT0NrR5M96Nqk4AXUhUTnKxx1fBXP6egyM0ZmhfaATbI/PZdPkyjDYFahWEmzfhv3jOFl090VA/NChJdEtSRvxSUgq1Ig8V8fKvChnqJUjcNAGcfI53zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUsB3vPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5024C433C7;
	Wed, 24 Jan 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106694;
	bh=mHvd9apj8BXG3CS5HPvF6zxU8m5QNDA90dsY+iDv3zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUsB3vPQ+K4OeuLIeE/zO/FpDe8K23/9M/krX34+3iDzSG+Qt4HEgmMC6Yo/UfhxU
	 fXhtir6ovFp03QnXHQgRl3jqhOo2hwxgc1qWJo3uOqQLTQNBmYO4Cn2lIZh9qghA0Q
	 fB1Wb/D+F4gNq9Ub/qZgVc4Xc7/ICczb6s/GYLI+xWhmDuleCf5qsjWYwUFtU3hhv+
	 CCcKrLvj6SX9M42qtNt2lcrkm25qgfVqhLCle3vBmQa7OqsGzLTMzp1tVwvZdt4ZG1
	 goq2QUmHZNQuyux2XPWGIr38FfBJFBR3jW6ibj2Z6cQ5TbNYE8aYSoVY+7GP2bkgcY
	 4zdbl0jFW0rrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 3/6] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:31:12 -0500
Message-ID: <20240124143124.1284462-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143124.1284462-1-sashal@kernel.org>
References: <20240124143124.1284462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index ecf2f390fad2..b76ac4df5da5 100644
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


