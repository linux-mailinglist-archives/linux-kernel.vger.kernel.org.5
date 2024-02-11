Return-Path: <linux-kernel+bounces-60638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA68507DB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0631C21831
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5F16427;
	Sun, 11 Feb 2024 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bT35LFlh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D179;
	Sun, 11 Feb 2024 05:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707629289; cv=none; b=VsVCr4mZzS5gY6YdYE1ncVJ1j/1yfArd+04mpVzw+O7AhFQoy8pO8+FzUDDoozqhL60/DH35wZKT+d8K/KjrROIbjBMQPtJmj3GdB1C/SAgg636YresZPMNwBSGEl0r95NUPT+V8JAtUd475ZkVeIzqq31omkgN7a+ZPPyShiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707629289; c=relaxed/simple;
	bh=i0Nhzbsc3qnry4feuPLAhZuqnBIdJRfPzmCcqKOp+K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcoqFovlEYY6SRx2FZNDiNZfYs96xXgXDN7XryExEoMSiD7hODOq5o433ERroy2z1jddej9dnvRXQmv+NvxWcWrpuCBbmJzhAMpW7iQtAI3z3T39RhkFXybd1jKg26ZHl2wrC8/qu88nXtFha4RCU7WaKyhKxWSjCkhb6OafeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bT35LFlh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=P+G/gr3dpwkYnrJHOwZ1xhtBo+38a0UA9vbSN3e/DkQ=; b=bT35LFlhKw4oOkmhZqKE1Yyaz3
	rk4C7RY2dPjW6o0LN3MjTGVcreO3WHsGhmQ1mLuFiNCogrOUW6EzKWaSLH+QJbnf4DNpa3XTGpGVf
	GkKfIL1XQgvPAolcfInud0leHUedJLVp6ukAxHbMnsDLJwmLLztfcxMqrQchBOhM0aGDf7zzOTWNL
	3/ol72nJnoyDJL/CPyTRDfdW267zi7BT+iX4zqhy98zE+AXVpsOSx7q+tO8uyQaMfx7H7FaDDRdi1
	IA7z8QFA+b4hbNSj50R/DhNwJ0cnXVj3/cJxCo2gKKxlDBtkQ4ngSBeMcKFTBTVCpljTJFn9J4RCD
	cpopOUog==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ2Nn-00000002Mxq-2f5q;
	Sun, 11 Feb 2024 05:28:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Igor Zhbanov <izh1979@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v5] sparc64: NMI watchdog: fix return value of __setup handler
Date: Sat, 10 Feb 2024 21:28:02 -0800
Message-ID: <20240211052802.22612-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from setup_nmi_watchdog().

Fixes: e5553a6d0442 ("sparc64: Implement NMI watchdog on capable cpus.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <izh1979@gmail.com>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>
---
v2: change From: Igor to Reported-by:
    add more Cc's
v3: use Igor's current email address
v4: add Arnd to Cc: list
v5: add Andreas to Cc: list

 arch/sparc/kernel/nmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -279,7 +279,7 @@ static int __init setup_nmi_watchdog(cha
 	if (!strncmp(str, "panic", 5))
 		panic_on_timeout = 1;
 
-	return 0;
+	return 1;
 }
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 

