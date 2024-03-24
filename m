Return-Path: <linux-kernel+bounces-114937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614F888C15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB911C29E99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADB1BE80A;
	Mon, 25 Mar 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toZ1DJzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B530179FB0;
	Sun, 24 Mar 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323647; cv=none; b=dX+hjyWBbFnLs1W6G5xYWH8Y46zxG2Y5ad8DSCsbH6WBFMBndiNwsHJOyI91VhilWFdj2m9euDMRTaR8UTuKj6ASnD/WEg/YWwlAjYKIjTcMlATU8VmYGHolOn8z/UUdm3NreROSmwMIweoZznCyQh8w1Sgzn0/JiaHvs5sseq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323647; c=relaxed/simple;
	bh=Fg21IVBdDngt1etfWcnPSEvzp7Y5DXNt8psD2PSobPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMo+9XLUQaVug4SVtbIa3XVk9bFvwtqtFw7tZk5Z59DcFNiPLA1bnHjQetmQm3cBl+HlLPl/+vc+1ygDWTlx85M8hptL6rq/Zb19fyLDBc14hN4dULxBxZ8OpJ35iki35/JrpSrBTw9uk2dOqv8BYUJ5E8dse7uEnvo4rlaN6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toZ1DJzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51235C433C7;
	Sun, 24 Mar 2024 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323646;
	bh=Fg21IVBdDngt1etfWcnPSEvzp7Y5DXNt8psD2PSobPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toZ1DJzr/oAPjR7bv+gznv8iFYQTtX+5vpnQ33zAWbWclWK8avxJeP7L30ynIDxCp
	 mGgC3qK5bjVBLF2nLi4HG+gjHvqA/EuqaDJBAYYQ7O/XXP3zpC+4RMzJ1nPL/HLZUA
	 xQy8p42ZdG2THxnNOss1uS/AEOyaLg6bGkC77ktb+OZ32ulGjFLsDXpNIfITWlN1Ul
	 kDFutl4fHHVt4DBJ5m90hG9ETo/r7pSTUqgcLU4Ocx6BaD/fIkTlsWVJmKmhXWf/Zy
	 mzbdG8azNG+jm/Gr+Uxvm6DnO8tbCHhszS3eu4lweO0a+FZ7HqUiBMm47tYYYZIUJG
	 ur+bYfi1ayTdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 017/238] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 19:36:45 -0400
Message-ID: <20240324234027.1354210-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


