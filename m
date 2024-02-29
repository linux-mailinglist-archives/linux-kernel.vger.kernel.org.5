Return-Path: <linux-kernel+bounces-87491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C786D513
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647171C225EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E3315CABD;
	Thu, 29 Feb 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZHkSyxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C015CAAA;
	Thu, 29 Feb 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239254; cv=none; b=WqQsGWsuE/Uz+CqX7BwyklrV8b5SbHxjr9zWXQ7tKN+58ngDRY4S28jOtej61oBe91zc/IM3vVat+prLzrDOKiTeAQsdQpc2pE7n6v0oURfdZxeP6xqtYIk0cZzKPYfjLHq+HHQrfTBbsqcnex5NqgVkf/J7TEHnCTY+/xmtOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239254; c=relaxed/simple;
	bh=PbeCPPqUTj8zu2JIOMJODjSU9380VXX4VQ800iYqnmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqONR4BT1bvbdNA2CgXwGw1V3Q7eai732XsFeS3dSlVuoEq0GlysRHeno6SuHqDI69PxKvK9VIr/Leu6tSJFTmBKm0kFpxTbjFcSkXo60dyo9Y46wad0lUYv3Gu/jiHkwPGs6XRnKv1eSbT/ipQREMtht88OrHx96rXnixm0vSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZHkSyxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A56C43399;
	Thu, 29 Feb 2024 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239254;
	bh=PbeCPPqUTj8zu2JIOMJODjSU9380VXX4VQ800iYqnmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZHkSyxL+RePfVJnOil25XyXjvPSLOC9CHHkdT9mFCMOrPPqtBo1LqAawJsDNsE57
	 syW2SCFKJ0UHJQy8bpDPstSGdrLv2QtErF0tijYX49DBwVXQvSlALxAck9oDPjGlRp
	 fNaL0nNypsozCGP5IUaHsA9DtUqULAfPvKQgjIAhSIF84G3M/jgOQt0huvpBbRhTQ4
	 arbk9T0NtaIr/LH1W0bs30ba6aheboZ+ZqAxQMjwpyDJxGJnCNAhYBGikP6wFDkZXW
	 yWksUmeHz1DdxrFWmhu38l4JJAcUPyv4gygDmzpv0s1oez+k5pOfa5snAYqtbMQzdq
	 PlefNM+NCpH0Q==
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
Subject: [PATCH AUTOSEL 6.1 08/12] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:40:30 -0500
Message-ID: <20240229204039.2861519-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index 4d392e4ed3584..ac7253891d5ed 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


