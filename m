Return-Path: <linux-kernel+bounces-60234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D168501B6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE7A288FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B11A29F;
	Sat, 10 Feb 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZEkE3+Eo"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4928371;
	Sat, 10 Feb 2024 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528301; cv=none; b=dPE21uU6EguussxQZT8WcyATSslQ5N1J4vJKsPb3GR4zGh4V+I3ZvKFZexzf4SQK5lvKQiBzkH4kY7Kp7uuCDqe/wluKW9o32XlTtMB392A8FompX59xDtdWBc9HUrJvJususGomNgRwxrl9Aa0pqt8L/2buIHI3MZoAEk+n/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528301; c=relaxed/simple;
	bh=xxXAvFJcsZzZwiPknF3QF04PRu/JojlyXTHWeEtALdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DM+Qb5Z2RGPbdiAKqCQVMtm0naIfI4xgNrfvx5BQboivsaf4nW0Lw5bkTtU2SXIs93no0xpC7tyfuZ5SaadPvbZeoU0NH2dEWO3YhSTk0bxVcvD2kLn5a3Vg7sKWA00tdkD40sK+9yrU20ytTho74/D41E5bFMi9whb3rzRN9Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZEkE3+Eo; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E3480C0000E8;
	Fri,  9 Feb 2024 17:24:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E3480C0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1707528293;
	bh=xxXAvFJcsZzZwiPknF3QF04PRu/JojlyXTHWeEtALdU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZEkE3+EoCdjX3b21BnhGHFsVlZ4nRVj4bXX0scg0IQDki3QtARbi9uIE+mb+te4mY
	 VthG9C4Qn84KV+bCTTvOg3FdoT0TQiH/5cRTkVcIJ4IJpnyNewUlZQJSa1EoI95VaT
	 EfbpYaPeeZttX+41nC7TlWr5dDCNChw1QvfZi3zM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2C94C18041CAC4;
	Fri,  9 Feb 2024 17:24:51 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Brian Norris <computersforpeace@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH v2] irqchip/irq-brcmstb-l2: add write memory barrier before exit
Date: Fri,  9 Feb 2024 17:24:49 -0800
Message-Id: <20240210012449.3009125-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opendmb@gmail.com>

It was observed on Broadcom devices that use GIC v3 architecture
L1 interrupt controllers as the parent of brcmstb-l2 interrupt
controllers that the deactivation of the parent irq could happen
before the brcmstb-l2 deasserted its output. This would lead the
GIC to reactivate the irq only to find that no L2 interrupt was
pending. The result was a spurious interrupt invoking the
handle_bad_irq() with its associated messaging. While this did
not create a functional problem it is a waste of cycles.

The hazard exists because the memory mapped bus writes to the
brcmstb-l2 registers are buffered and the GIC v3 architecture
uses a very efficient system register write to deactivate the
interrupt. This commit adds a write memory barrier prior to
invoking chained_irq_exit() to introduce a dsb(st) on those
systems to ensure the system register write cannot be executed
until the memory mapped writes are visible to the system.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box  Level-2 interrupt controller")
[florian: Added Fixes tag]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- add Fixes tag
- bump copyright

 drivers/irqchip/irq-brcmstb-l2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 5559c943f03f..63aed60dd3f1 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -2,7 +2,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
@@ -112,6 +112,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_domain_irq(b->domain, irq);
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.34.1


