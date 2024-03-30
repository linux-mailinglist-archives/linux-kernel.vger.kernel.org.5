Return-Path: <linux-kernel+bounces-125660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8B892A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E510E281FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96240866;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWqa0DJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0D241EC;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=WnQaqdT6gJ6xPMb6iXHfshgNsgC4QNR3rTb41p8ZRBWzWIWSTq5BXGB0IGoFs3czvwrQLBOk+GtduuIGHkh0zHu4BYYXj1e25eonQAzi6KcRX7eQ41Fv62lojktFrqsaPXnr8ljZh52PujiLgZRlSemASdFSvIFhnEygfArr+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=2x1IekDisWrxO1QZCgeGBonkq2kpGwPfzqPpLTwCkTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stcMCBPs5GSqLIjz8gk+bE6zGBMIRhI9GUcZ99PQ6Sb1VEFLwrQq2CR5a80DasE+7rULWTIdnzFV+ehZXrGfPkOT/vdd7kJYcVPggvnQOl46ZV+21yFOvI8H/M7bVos5+fCUycVBnS0CupRZoEsYKMYVzGPdxYHe1xXMZvWy1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWqa0DJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31874C43330;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=2x1IekDisWrxO1QZCgeGBonkq2kpGwPfzqPpLTwCkTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LWqa0DJAIsItDuvPm2rnGmxWDwcB8YCM0NFLG6hA1HsHVE5v0mkCqwQGhUX8wGa6K
	 kpeVYt3WJOP+J9BEL2nGQSgY2788DWykWZXI82ZqgTSYQDzzk4j8rOUv95SeS6mEUe
	 oCSpesB1M62aQCnOisnw5yM5KOHQwfFDV9hJZsFd7mB8ynJuXJwAC1U1KoxAgrWOgm
	 azWienMxItEXyGQ8u7iH7KXkMGs9FmwgjbZn3wNf0yh3mwlo+lhdpZTGtut3taQ1g4
	 2X4c4171aqYPEY2HTTUWO51jm+3kLWE80W3Ozc26x0vasj4pQ8sGR7ribuEsX0Qg3a
	 ssYxPanNCpVog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2975FCD1288;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:44 +0100
Subject: [PATCH 08/10] sparc64: Fix prototype warning for sched_clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-8-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=793;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=LqRShLF2pPHi8lE2rdN92NEyqocrs1j4uVYYbMfSLj4=;
 b=PMlAy600lZhsdddNHFih9ANgCUb2ySEAKULe4KxaXQj8cNuE9rH8bUgekUv0O74HWlQK3QFI8FQT
 6K32pHisBTZybIa4zA2VFCw4AylacJr627XuYudCqRPoXxaNfq7O
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype for ‘sched_clock’

Add the missing include to pick up the prototype.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/time_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 89fb05f90609..60f1c8cc5363 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -33,6 +33,7 @@
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/platform_device.h>
+#include <linux/sched/clock.h>
 #include <linux/ftrace.h>
 
 #include <asm/oplib.h>

-- 
2.34.1



