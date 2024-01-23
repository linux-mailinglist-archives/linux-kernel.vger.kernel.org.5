Return-Path: <linux-kernel+bounces-35698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D044883956B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B916B2C4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AB8121F;
	Tue, 23 Jan 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P32C4sWd"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B82811EF;
	Tue, 23 Jan 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028339; cv=none; b=poM5ZNnSRn8aJHJ+diMqDo0pZbidrryQ4fxnbv3uyuHrEr3C9GxGoYpuv83BzXYbH78bB8spTfVlswWx3zFejcpT+B+DCI2B8WzYCqYEe7IfevvPDYquoLzRt/XVHpm7ZU259MdvOd+a8nOWFd8Qi3jSIgOM9jHegQw6H5+gPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028339; c=relaxed/simple;
	bh=6DBAlHKtgTdDUg9RwXBHxBhu0U9svjp5OINIPB4+uQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzNS7wW1E3X85BaLZA7eNxXz+rg4Nv/V2ETlYRHi5JLMYNBCfRfZ+lPdj3UQ1cK6RE/jwhBw0S1YOlU+Y6QjEfAWJcFFQZAVFcLB7cSK/4scIOAATyOi4vRFLeowMim09o1Keya2ia0H+23kSqkT11DIhVoUdNxfP9r17DXBxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P32C4sWd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGikgJ078231;
	Tue, 23 Jan 2024 10:44:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706028286;
	bh=OWBMIAYGqql0wAgfbGIt4Wt5E8wAkJwz4O3xabNraz0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P32C4sWd5ISMqmsIw2A7ZleCJwNam9rf6cShR4bRElMrHQfghWuwC3/ybPjlCvhY0
	 3SM7OkUHwJejJHGom32T7hS8W5ECrSCI0pGuQs804DqdvZiknOyRJ/zA2Ux5eqpznw
	 TxdzgfJy3hf+IZ70As4HtYiocvQjrD5LkRaBC7ng=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGikBi008941
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:44:46 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:44:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:44:46 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGiiKG022038;
	Tue, 23 Jan 2024 10:44:45 -0600
From: Andrew Davis <afd@ti.com>
To: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala
	<kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel
 Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Mark Brown
	<broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Lee
 Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/4] kernel/reboot: Deprecate register_restart_handler()
Date: Tue, 23 Jan 2024 10:44:40 -0600
Message-ID: <20240123164443.394642-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123164443.394642-1-afd@ti.com>
References: <20240123164443.394642-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There are now two ways to add a handler to the restart_handler_list.
Two ways to do the same thing is bad design, so let's unify on using
the new method register_sys_off_handler() everywhere.

Reasons:
 * The other register_*_handler functions take a callback, this old
   API takes a notifier_block, which makes it confusing with the
   register_*_notifier class of functions.
 * register_sys_off_handler (new API) is a more unified API allowing for
   registering several system off types.
 * The new API has more helpers built around it now, including devm and
   platform helpers.
 * The new API manages the struct notifier_block for us, simplifying using
   code.

Mark register_restart_handler() as deprecated to try to warn off new users
while we finish converting the remaining existing users.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 include/linux/reboot.h | 8 ++++++--
 kernel/reboot.c        | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index abcdde4df6979..186291e9bf3bb 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -46,8 +46,12 @@ extern int unregister_reboot_notifier(struct notifier_block *);
 
 extern int devm_register_reboot_notifier(struct device *, struct notifier_block *);
 
-extern int register_restart_handler(struct notifier_block *);
-extern int unregister_restart_handler(struct notifier_block *);
+/*
+ * This function is deprecated, use register_sys_off_handler(SYS_OFF_MODE_RESTART)
+ * or devm_register_restart_handler() instead.
+ */
+extern int __deprecated register_restart_handler(struct notifier_block *);
+extern int __deprecated unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
 /*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 22c16e2564cca..38d6933fe892e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -197,6 +197,9 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  *
  *	Currently always returns zero, as atomic_notifier_chain_register()
  *	always returns zero.
+ *
+ *	This function is deprecated, use register_sys_off_handler(SYS_OFF_MODE_RESTART)
+ *	or devm_register_restart_handler() instead.
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-- 
2.39.2


