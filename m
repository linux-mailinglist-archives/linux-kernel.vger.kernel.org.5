Return-Path: <linux-kernel+bounces-125658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459CD892A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4C11F224BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C44084D;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4rtyxn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683020DCD;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=S0ASKBQ6DPznGdOlq6yF6UWylOaksFo0G9k0ib2ScR/qL7mH+unN2UIeEfyHvxsy2byZCFZoqIyD4sT4JK7WuEbR2ReoP1A6Q0uyK3carlHuCZ1EBc+W7/54NI0c/ruJuHuXSHKc8BiZ0g5RE0VRxXhPqV+hWr9q8lTYhb02kVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=znSQZ+RM/9bvAWoDcrE1grU/bOJFvpoINbFAcHKmzU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTNZBLcShEEPv4qa4Y9F1HW6W0CNR1vTT/hcgCMzC38LfVV3KQXi1lrHzkshGfsAPOiTsPY5qYrPgPjpGnRJ5/Ckf4R3MK6XJJmMzBmX8pdeM7RNvMFL0uGSbKbNTeHBIfzWWRUrYGnyCzPZSz4IK0iJFQvGyj2lIrcVvuyI0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4rtyxn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0811DC43390;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=znSQZ+RM/9bvAWoDcrE1grU/bOJFvpoINbFAcHKmzU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z4rtyxn3af+SZLBb07MVwPSdN4NPsJHwcKuBTvcxsBh0kkjCr1+RktJCsKdRnMZos
	 lzGoiHnMrgd46S9aOPoWruUUJHEx1wrQLcnDSxfvxDUnmEFJEhdpM+gsMv9+SNynvj
	 uBTZn5BMgvCAHfXPFsWxn8rIZJx9Dl0Xefl44mzEnQE2ZQaGBnCCvV/zYqnBTiJVz9
	 +8xlet4HhNv7Ybtysq3+P6WoWtpvkkNT7TTNkeXvyLY8OaWUUh/xBit0t2VmUF5Ol/
	 zfrTC0XT3KWPce0lZYo5+SFU0LI8OWJgH6V+CglwYEUI8Wc7JBDdHwEFSVBUK9lPLp
	 Yz5FwDEa7lvmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AFCCD128E;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:40 +0100
Subject: [PATCH 04/10] sparc64: Fix prototype warning for
 alloc_irqstack_bootmem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-4-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=877;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=hR1E8vg8CGDYDik5XN2GQOk33c8EjJhA30OsWe34a5M=;
 b=5y52pp+9cWGwXXEVdYXKKaopN1VKfX8WuRlPMgDaXdoQ0CqhfOyr9569kP/JZSl9fR9ZcPdeOem5
 5YiL5Ib2DKwFLPLfipiRNfAvXMwNmevHWCfz6YrVABfnmoBVIau8
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototype for ‘alloc_irqstack_bootmem’

The function alloc_irqstack_bootmem had no users outside setup_64.c so
declare it static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6a4797dec34b..1d519f18d2b2 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -599,7 +599,7 @@ static void __init init_sparc64_elf_hwcap(void)
 		pause_patch();
 }
 
-void __init alloc_irqstack_bootmem(void)
+static void __init alloc_irqstack_bootmem(void)
 {
 	unsigned int i, node;
 

-- 
2.34.1



