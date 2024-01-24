Return-Path: <linux-kernel+bounces-37168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ECC83AC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224161C230BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E613172C;
	Wed, 24 Jan 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azZ1dkw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E2132C15;
	Wed, 24 Jan 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106668; cv=none; b=ctSzCc6jwRedXmDMkF69acRxNgQZYA5D8MjxVv68+BgaaDq8UGEYAOVbOeHN4+2S6cRrpjYUw9S64sH7KVy2P+99++M/mW6llDhRXEH2lLB1WGytOqFgtEa0Hq184sBHaYXqRC9Zb6Frvb3A7DZUnkY2lu87zrp4/zkR/BrnF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106668; c=relaxed/simple;
	bh=/98Awh1CB37Jj8VC10X0uE1E820OU/1QxbbiYEcjqBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNBf6JPOEDLkwHxehoRgJnUBREInDjxscrz8RD9zg4rPkagr/XLUxy4yBMapwMrkm1mnNNrrH597BqJQyrBEXGuP5j0rs6GLZNB73MyaD4N4chA5B0Z8qPWZ6MVS/C3Z6iaQhW+KyHjHif+kUtfaVjLJmEcrqu/DetlEajrL/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azZ1dkw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A057C433F1;
	Wed, 24 Jan 2024 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106667;
	bh=/98Awh1CB37Jj8VC10X0uE1E820OU/1QxbbiYEcjqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azZ1dkw5CsaQqrKymBGPILUKjzPdMKCD30u7C3lJUgNH+6F00FoKiaPKmu2n8ah/4
	 3RS56RPGXTG0qFMk+38NSge8XOqe7tAyxK73Fd8jGPS8zdxkDhwSwHQg51AW3ubyXO
	 DXr0HaL5KbM+0R/+uqZH06cD8J592EmK1TS4rgDkSidsGPhyeOEy8vgNDygYuolNKk
	 F2bHCWiSK3d0TUVtILztH/OtAsuFVOCqBLS2c7dVCBqVhLQBQh0n/GiqvPKTigBISf
	 wcuIGObhD0o9Uf/PGTv90+67qB/cyokzkWvAXaLjA3v/827nnxsctywzRdfRZ0hl8l
	 2BEYUp2InH6iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 3/7] um: Don't use vfprintf() for os_info()
Date: Wed, 24 Jan 2024 09:30:44 -0500
Message-ID: <20240124143057.1284274-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143057.1284274-1-sashal@kernel.org>
References: <20240124143057.1284274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 07327425d06e..56d9589e1cd1 100644
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


