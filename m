Return-Path: <linux-kernel+bounces-116008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED76889568
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641671C2F908
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D69179FB3;
	Mon, 25 Mar 2024 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjLpoGUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48572733D0;
	Sun, 24 Mar 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323319; cv=none; b=KdMJyuqE8S6pSEAaSw1YYOpUF+3PJGSYy+jckIBSFu4Anplr0k9gn3GV5wHdnt+FNauXDh7pe0SNv0LT/AvqXjWhMa4Cw++RH20z0tDhk6tjyHr4WvWq5aWVNZaolGTYbUspx/TTtdwOY28MntNB+eGatd545Y5/KcdyWXwxK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323319; c=relaxed/simple;
	bh=3VU3H4kuIe/rQdv1ZeQ5FiFnpIIR4BQFW/7JsgHKPno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvkVoe/8ppC71TPvLd03XZ8L/aVhaia2OdVR75kAt9/Q+pR4qqu2iGyANA143ATSj6II87xdUZsPm8+AXolaAYC4Go0c6ncbAr0Afu63JmNpJzChSpwaPahOqBRcGLoPgRR/ZsJwbZKRFH6b3naolO1hd+VN787+GM4yJg40yyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjLpoGUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C67C43399;
	Sun, 24 Mar 2024 23:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323318;
	bh=3VU3H4kuIe/rQdv1ZeQ5FiFnpIIR4BQFW/7JsgHKPno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjLpoGUQFduNqC/Nogp/vQhns1Tg9rBX+Wu+b4k1f0lC4MXRotmWiIkpl5O2xAhS7
	 fVDZISlttTs6ul3SMwDPEA8ynTRZZ2r9LdEthAVBmUgEUnoMhIYF++NPOfzliVqoMK
	 EOp+NeLFnHa3vPWBQhFuKBAQrUX7VvM7xvRsE/kHJKgKaETfD5g7VarD+y/sPnm+wN
	 T4LhO4qpzgwg93vkFhLv7T+6GRlrvxTVwJu2L9Mmkk3+1h7gWJoyPtj99XvLWqVaVP
	 AnskGh9FuZ1ag24aYe5V/mNNC9AW6Zc0CAuRlrkCAsdtiFFxU+/BE038wtsX9zZxP5
	 pK4IqPoTAM/tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/317] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 19:29:58 -0400
Message-ID: <20240324233458.1352854-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


