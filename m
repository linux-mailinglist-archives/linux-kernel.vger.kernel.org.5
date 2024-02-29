Return-Path: <linux-kernel+bounces-87511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17E86D555
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB631C2259D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3816A342;
	Thu, 29 Feb 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaoBVYq7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1930169E32;
	Thu, 29 Feb 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239301; cv=none; b=p2i6DyYZJTYm8Vaz2XI+or6TVHEJbaL1u1jGT3Q/9Fyph2WmXKE9hy+DEEFPSdV59XAL0XdIJpLtHGhIaMRgi8ssa6O++np9ZCKjm3+i1DdP25VHce49h1WZaf9tRqNXpQ70Jg5yrPIRzTfrIhuZKX7VjKUDx5Uc4QB1zpHXkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239301; c=relaxed/simple;
	bh=Fg21IVBdDngt1etfWcnPSEvzp7Y5DXNt8psD2PSobPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv82ZxSoLlXd6Vqh0b+Qpul/apeQwDooGi8MdewG7P2ks3PKbx5rom51yiiOdgIIX5WWwJE/Ql7Fb4lAodL3EFwGbeN3l5dZoh5sG/+ls/lEzdywjK4c8Pqz+VVFyF81vliBlgS/GTv2IHYvrTs44mJxjyu7qHx5y1HySwHoevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaoBVYq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B71C433F1;
	Thu, 29 Feb 2024 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239301;
	bh=Fg21IVBdDngt1etfWcnPSEvzp7Y5DXNt8psD2PSobPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaoBVYq7BeVGjzC6CScbrJNQpU8mTKf7/73tiPZMT7Lfdh8FQHUrBluTXyX+dweU6
	 jnlfFqQ9O+O4Dck9W5U/tVmf4/Ou48Zvc5yjpCKqUf4RqGvrAl8OkJGYk/HH8I7n+p
	 WAK80Ck6nknxmozvulq0zbdF0GrNc/akNeRiGrER4duX1lm8l8cB2Kr0H6h+WbXuYA
	 boBpbtFnNeusFdgSMB+lAiXUurj8PbxuxzxIGvoxIbMmBtFNq7Rbhr9pngrcYgijgS
	 bgkvTIbLn+QZ+JYDnj2aJs7rvb+vLD1ZgGMZu2i8DPSg+bGPz4KP3rdpmVZuOQIZP8
	 gAnHt3Wq9MDMQ==
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
Subject: [PATCH AUTOSEL 5.10 6/8] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:41:23 -0500
Message-ID: <20240229204127.2861980-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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
index 63e3ecb9da812..8538425cc43e0 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -81,7 +81,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return 0;
-- 
2.43.0


