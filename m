Return-Path: <linux-kernel+bounces-83893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A1869FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EBC2893B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645D14AD22;
	Tue, 27 Feb 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OVFmRDrY"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29765103E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060606; cv=none; b=sxei3HbUN9i1o6KFNtcMxZUk17z5MdmsXDpSJwlsQQAHwkZakfctkOFWWTgcQou6ES1fmv0fTGqsIvJtgfJDDHxwZpIP2utj+kxnmakgaXEd7V+Y58krZ4OQcuXBA2ZTc4mR556U8fE4y+5Vhl25i/ZK4ZISquglaCP8Mtgxr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060606; c=relaxed/simple;
	bh=BoWABUn1BHPA1kyndGRUMStiFm/fHNE3QtKwM9H3nBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMa7A8/YNVkmtyNp2D6bDBdTs3kMysIqmf7XutGCr8t4uo5M17swnWeP3SOoJ7S+aqQC3cayiX5csNslimL3YE2IqDiHKOKBK6HAJmOUp8Z/3kdhNC037Zm3z+XFgXC/NjMJp+0f9kWnToV99YkhbAEjLO/ynAADP4ZrJX/fmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OVFmRDrY; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 38C09C002447;
	Tue, 27 Feb 2024 11:03:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 38C09C002447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1709060598;
	bh=BoWABUn1BHPA1kyndGRUMStiFm/fHNE3QtKwM9H3nBM=;
	h=From:To:Cc:Subject:Date:From;
	b=OVFmRDrYgzqLGPly1HT6HYrshnsYYT48BvU8jVn9UBewjWVkzpDazgtEEbk4qMIVc
	 jgT0+K0xciQkv++/5yukLJWftEr14alsLbKIh9UOWrICPqIBE+IHh5QuuBe4JLf79H
	 cCLrw4v5+scKOo4maI5BkHnpVe1iPl0UYpJJxxNQ=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B9BB418041CAC4;
	Tue, 27 Feb 2024 11:03:16 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
To: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	miquel.raynal@bootlin.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	William Zhang <william.zhang@broadcom.com>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Regan <dregan@broadcom.com>
Subject: [PATCH] mtd: rawnand: brcmnand: fix sparse warnings
Date: Tue, 27 Feb 2024 11:02:57 -0800
Message-Id: <20240227190258.200929-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following sparse warnings:
sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:79:41: sparse: sparse:
cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
cast removes address space '__iomem' of expression

Fixes: c52c16d1bee5 ("mtd: rawnand: brcmnand: Add BCMBCA read data bus interface")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402270940.gmVLVRg0-lkp@intel.com/
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
index 7ad3e7a98f97..ea534850b97a 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
@@ -76,8 +76,8 @@ static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
 	 * and dest address, which is incompatible with nand cache. Fallback
 	 * to the memcpy_fromio in such case
 	 */
-	if (bcmbca_nand_is_buf_aligned((void *)flash_cache, buffer))
-		memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
+	if (bcmbca_nand_is_buf_aligned((void __force *)flash_cache, buffer))
+		memcpy((void *)buffer, (void __force *)flash_cache, fc_words * 4);
 	else
 		memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
 }
-- 
2.37.3


