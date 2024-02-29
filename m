Return-Path: <linux-kernel+bounces-87502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145C986D538
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5421F27C78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355316839F;
	Thu, 29 Feb 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5dX9m0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F816838A;
	Thu, 29 Feb 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239281; cv=none; b=uJEj6vv56UrZ4J2MQUoXgJfNngI3+hbFpe2xWeBqgVtqKT4CuWCHZRapVYmxmaMefuXtRZZlkxiMI36K/mjrhzK3wIT7ryhUU9wtUkZ3rz7dZTIoFZwmRpQwv7WMnA8hWUgcB7K6moOK7uqyGYwH2Hvju2GCE34Plb7y8MJlKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239281; c=relaxed/simple;
	bh=3VU3H4kuIe/rQdv1ZeQ5FiFnpIIR4BQFW/7JsgHKPno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcKJ0ZfuXEy3lI7Udb2fcOMteTKXuMDGIm+qSVEasmRIWMUvYSOjsXBpAr7fF6ojHFN9l5eFK9S2guGY/a5uxYNJHJ1PsqQ9m/TMIpFlMh+2Cwq80twYMQ+fQSZVmJ3FG/5BsmTB88WfgXinU1lAG1uPVOrI7UQs8CnmJ/xwx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5dX9m0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921A9C433F1;
	Thu, 29 Feb 2024 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239280;
	bh=3VU3H4kuIe/rQdv1ZeQ5FiFnpIIR4BQFW/7JsgHKPno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5dX9m0YnpZ8ryW90PL68UbS53r1GIz1nJ7IVnji7py4bdV4QItk4ocf7DQvTa2Al
	 sC/+Euf6tm1tGq8jDo7CeM1ASI4dFNaY/Yxz4fPdXuDVa+JB+yMoK9xOP8B4yNA7Wt
	 Gbc17O06ywmGAHAALfjniRHUtOUrpNRauHLGYz/u1jpvj9vkMc2IKqzHyRgNnLuUaP
	 24qVBj1s0qL1RpAWrPE6VA8ZtVC/Dg7TqcUmQEjS2YltW3Fz5NwTVhVQQf0bvabFd1
	 aFYWOVqrFx3NwovlozH4eeqL8wlKHg07Gn0CjSABKaVtkl+DrhAe2BOLf/cBqQzeOV
	 TGgSqYl5v4cRw==
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
Subject: [PATCH AUTOSEL 5.15 7/9] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:41:03 -0500
Message-ID: <20240229204107.2861780-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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
index 0a1e75af5382d..44d70fc30aae5 100644
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


