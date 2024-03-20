Return-Path: <linux-kernel+bounces-109458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1688197F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11C61C2126E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB078381AA;
	Wed, 20 Mar 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ER8oSDVy"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34585C58
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974172; cv=none; b=r6P34ycL74pcYpK+/m0xb+3f3xEqj7fgV2ow219VIDRhoYZerNuA8hGOoC32i8MFNB8THx7l56y2klqik49UsdCimUKvbmkXykTmdOuEJjMSpwLfAtVYlRwG226zYGk8hUNMdt44IJvhZrvwv5XwqMt34yh12Nlj7qtCsxvs5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974172; c=relaxed/simple;
	bh=FrDJYOWwf0Ic6PWmCehY4eGVyxmoLrR6fV2hXhRI9/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hvq0SbpbA/Me3MYc1jnn0UXSnBRrUREgxDjHirapVYDHiHyzm8kMfJel/sa5nmVn8ZMazEOaI/U/5ot3qHMllxDHyQQbZSMcsd5F6WyBHC1bPRZiP+Q7pPf2c4Cxo0lYMVwADwnoJdaaWC8rM5bWlIEWIcgpRk0KgzM7PHggxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ER8oSDVy; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2C1A3C0000F1;
	Wed, 20 Mar 2024 15:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2C1A3C0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1710973631;
	bh=FrDJYOWwf0Ic6PWmCehY4eGVyxmoLrR6fV2hXhRI9/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ER8oSDVyI4SJemYdbsgNDwpfuVSQeWV7O2fsjUkexdgoUpfAYVJF0CsaG8zXRVHWv
	 yCJ9ZAjuaYfFtblXku6S7QQS0lDWMKy7VFlC7wGmYO/ldblsPv0kekiCYfXob+yNZG
	 qAAgxKj9kMvY0ep7wc4FbfKjEOwcJQ/l3QM3wXQc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6420918041CAC4;
	Wed, 20 Mar 2024 15:27:09 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>
Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	joel.peshkin@broadcom.com,
	f.fainelli@gmail.com,
	miquel.raynal@bootlin.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	kursad.oney@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	David Regan <dregan@broadcom.com>
Subject: [PATCH] mtd: rawnand: brcmnand: Fix data access violation for STB chip
Date: Wed, 20 Mar 2024 15:26:22 -0700
Message-Id: <20240320222623.35604-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Florian reported the following kernel NULL pointer dereference issue on
a BCM7250 board:
[    2.829744] Unable to handle kernel NULL pointer dereference at virtual address 0000000c when read
[    2.838740] [0000000c] *pgd=80000000004003, *pmd=00000000
[    2.844178] Internal error: Oops: 206 [#1] SMP ARM
[    2.848990] Modules linked in:
[    2.852061] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-next-20240305-gd95fcdf4961d #66
[    2.860436] Hardware name: Broadcom STB (Flattened Device Tree)
[    2.866371] PC is at brcmnand_read_by_pio+0x180/0x278
[    2.871449] LR is at __wait_for_common+0x9c/0x1b0
[    2.876178] pc : [<c094b6cc>]    lr : [<c0e66310>]    psr: 60000053
[    2.882460] sp : f0811a80  ip : 00000012  fp : 00000000
[    2.887699] r10: 00000000  r9 : 00000000  r8 : c3790000
[    2.892936] r7 : 00000000  r6 : 00000000  r5 : c35db440  r4 : ffe00000
[    2.899479] r3 : f15cb814  r2 : 00000000  r1 : 00000000  r0 : 00000000

The issue only happens when dma mode is disabled or not supported on STB
chip. The pio mode transfer calls brcmnand_read_data_bus function which
dereferences ctrl->soc->read_data_bus. But the soc member in STB chip is
NULL hence triggers the access violation. The function needs to check
the soc pointer first.

Fixes: 546e42599120 ("mtd: rawnand: brcmnand: Add BCMBCA read data bus interface")

Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index a8d12c71f987..1b2ec0fec60c 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -857,7 +857,7 @@ static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
 	struct brcmnand_soc *soc = ctrl->soc;
 	int i;
 
-	if (soc->read_data_bus) {
+	if (soc && soc->read_data_bus) {
 		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
 	} else {
 		for (i = 0; i < fc_words; i++)
-- 
2.37.3


