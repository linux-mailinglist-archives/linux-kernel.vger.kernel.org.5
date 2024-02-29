Return-Path: <linux-kernel+bounces-87519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C286D56C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AA51F2494D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536116D5FE;
	Thu, 29 Feb 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvCSR7yt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC0152DF1;
	Thu, 29 Feb 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239319; cv=none; b=f1oiklDK+oImpHdNHgGQAZNUcQ5mTylUaeU62nkZZemujFayqasL1EYVQ+ssTKEa94IPvUqLqFNcAl/RQEjraOGzPGSvOM5XOx9e7okVW7A0cDhXvav30RmHGEVMpCn+v58WRm8fj3mRkKq3/K9/nyQ8DgdwyyQxlCUsQYAWCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239319; c=relaxed/simple;
	bh=w3wXilM/p6r1VZTb0UA83Y9zrU52YRn0KjPnNsyVecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8qpYR+jyHAzpXRxEqF1ESSP4igj0RgBTyVLWTjzFYW2lgliBSbMMXIj325nclAzSpZmkSKWlrV6G2cQrNssWcbNWvS4e4g3iIssp2lT8N1bb/Ldbqf/iM+s8aUO2PjK2E1uJaLEJRkvvyGQaCq4TSv4/+NXyieeivblpHPIaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvCSR7yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3EAC43601;
	Thu, 29 Feb 2024 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239319;
	bh=w3wXilM/p6r1VZTb0UA83Y9zrU52YRn0KjPnNsyVecQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvCSR7ytxw+9JeyM3uzbfUB8awBz3Y6HzLsuABOarKbldqbarUjx2fpVM0N0cDHff
	 U2XYkDQDVVWhgU1QE3FIF573XrxJBmKj2BpLkrkafS6amV4kH7yOESn9CBtOkXqB9i
	 Pugl400wDUc/dDYTeBlINVrNCDwjH4hpjhyosVh0o9fkvALixTOeRm42TZjqfexATY
	 WXcR09HpGxt8XXn7i4Jv5UGBGxYM7tGlhSgXTHiA4LCODvZHqDVbUiJtB0n7xOqRX9
	 vwzWo5ktp6pEFcaxqIycdSJc8JQvBkffHRAH2ln+3PD0CT1SkpcrYbHETzAttNv9DV
	 lsPf/aCZxgEqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	James.Bottomley@HansenPartnership.com,
	linux-trace-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/6] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:41:44 -0500
Message-ID: <20240229204150.2862196-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204150.2862196-1-sashal@kernel.org>
References: <20240229204150.2862196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 250f5402e636a5cec9e0e95df252c3d54307210f ]

Fixes a bug revealed by -Wmissing-prototypes when
CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:

 arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Werror=missing-prototypes]
    82 | int ftrace_enable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Werror=missing-prototypes]
    88 | int ftrace_disable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index b836fc61a24f4..f3a5c5e480cf0 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -80,7 +80,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return 0;
-- 
2.43.0


