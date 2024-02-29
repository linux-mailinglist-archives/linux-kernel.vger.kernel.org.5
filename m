Return-Path: <linux-kernel+bounces-87469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B986D4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2F2B254A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DC15E020;
	Thu, 29 Feb 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UimlbWU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181015D5DA;
	Thu, 29 Feb 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239196; cv=none; b=sekgs7hXdFhVy7rZKqRKrNkszFraJ2MniHhgx8MOerqwf3rbAddh8fc3tYTUpmLYuTQ0GxlmJ+tUUCUqlIYdJ3aam6htD9hdMzoAfg23Ye6Op5q0n8jp7iGDJOPMLZne/tdRnKr5pEtlUbVsIhsvaa4PIdBukUv8A+i3JtzgVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239196; c=relaxed/simple;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SywK39PIsmFKnv24WkQ2I3Adey6b3Tp1tlC42cib4kmeL2P+Oe21Ie73/rQEriJaTVVfUJIIMIAzVL/0/3FK1Tzcc1DEHzOe5XWWuy5MIg+KSl/34BkiAFBFCkX0F401ozsFWptkrir+I59sxzt9B+Hz/C/Qi3MU7hWmm75zRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UimlbWU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD2AC43394;
	Thu, 29 Feb 2024 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239196;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UimlbWU8izNk868PWw++xraMBsrUpOzxSAAy4ebL/c+6p6NTtdvH++9vwf57IXV1O
	 WY6+AfV+3WfZhKgQr2VPIyARddhGoJYWvh84QKnD/Z+oV6qn7diFIkQabC1BgG8hBE
	 vSEQkKKMyjGaYxVuzbnG2jibuBy8IsLzZyexJkAWhy7ammdeWo94stuUX24ANptOg6
	 +H+0d+Ye9/X9vARxRHOGmJPXk53vjPk1y/w2v02JwfmVSIAoftimo3aXUcG7B9MLvH
	 UE4gQ7fOMdVhlRsp9+k0l9pici+XsNAUhzkN1KPIbHF7l6vddSaMsFnedvLGXrGr5M
	 yTsVeMiqzQhvQ==
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
Subject: [PATCH AUTOSEL 6.6 10/22] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:39:03 -0500
Message-ID: <20240229203933.2861006-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index d1defb9ede70c..621a4b386ae4f 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


