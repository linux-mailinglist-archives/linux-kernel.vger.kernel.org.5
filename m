Return-Path: <linux-kernel+bounces-133156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF2899FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F150BB23561
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1A16F284;
	Fri,  5 Apr 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j09wuuDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472EC16F26F;
	Fri,  5 Apr 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327421; cv=none; b=sPE04pMSfmKFmHv3PUgAdPOwOXVndnzW1G+deCsx6EqJlOL5OuxsL4ceQE9lcdyesOM9EmBrk+1yZHMqvYT1isQUWwZoLlGy+zwm6GM5zVIijAjHFQnLPAxWgbf/UpigBPI6tks9hzFj5pEqGbNpBpDJ11FlHtKq7fgJzarUcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327421; c=relaxed/simple;
	bh=+hmouGUWtNRPVBEAQ5zRor/cUdIz1q9ZT+Aeo5mwccg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3BkPm4ZgArPInycI79fab3jDSc66O5YfpotASXQlyMdSMworU+CEZKeAY/R4C6EeUKNGH1uym2hhu9wdDilGuduccJt2015OPWgno8Eqkf6Vf503ehI/35T6AHG7pTgdvMRUNpi2yTqWfmF+BtKebYcUQ+HT20MD5nQXqMir6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j09wuuDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9D1C433C7;
	Fri,  5 Apr 2024 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712327420;
	bh=+hmouGUWtNRPVBEAQ5zRor/cUdIz1q9ZT+Aeo5mwccg=;
	h=From:To:Cc:Subject:Date:From;
	b=j09wuuDE9l5oYSv9w8XepGpi8h2sXOQdieK6zR23WRChleFDSnvbOVd+ExJnd/PXy
	 qdABiXoKu+9hxF4ZT9rFLZklYVCZIhjtZwfl+LMS9CuaD80N9b4J+ctJqvj8JZGfbS
	 k/EdxwZ7oJlIureGUJxau4aNZ17V7TZ+xviTLUS6nlAWdjuj1X9wzh2aEh6VIXaL5S
	 nrm8VdBr0/6Z0G4X4SwC9Hxc4dXRoAZ+f3bmpnHH7AlIujr+eM9sjFM+SjKkkGMzM+
	 KTn3DQsXZKnPBd4f1FNevs0uzygBXAJ2Oj0VwD1yRVm9XwiDHmHUf07eaB5vdvnX9i
	 2U2SM9ymcGdgQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: diskonchip: work around ubsan link failure
Date: Fri,  5 Apr 2024 16:30:04 +0200
Message-Id: <20240405143015.717429-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I ran into a randconfig build failure with UBSAN using gcc-13.2:

arm-linux-gnueabi-ld: error: unplaced orphan section `.bss..Lubsan_data31' from `drivers/mtd/nand/raw/diskonchip.o'

I'm not entirely sure what is going on here, but I suspect this has something
to do with the check for the end of the doc_locations[] array that contains
an (unsigned long)0xffffffff element, which is compared against the signed
(int)0xffffffff. If this is the case, we should get a runtime check for
undefined behavior, but we instead get an unexpected build-time error.

I would have expected this to work fine on 32-bit architectures despite the
signed integer overflow, though on 64-bit architectures this likely won't
ever work.

Changing the contition to instead check for the size of the array makes the
code safe everywhere and avoids the ubsan check that leads to the link
error. The loop code goes back to before 2.6.12.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/diskonchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 5243fab9face..8db7fc424571 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -53,7 +53,7 @@ static unsigned long doc_locations[] __initdata = {
 	0xe8000, 0xea000, 0xec000, 0xee000,
 #endif
 #endif
-	0xffffffff };
+};
 
 static struct mtd_info *doclist = NULL;
 
@@ -1554,7 +1554,7 @@ static int __init init_nanddoc(void)
 		if (ret < 0)
 			return ret;
 	} else {
-		for (i = 0; (doc_locations[i] != 0xffffffff); i++) {
+		for (i = 0; i < ARRAY_SIZE(doc_locations); i++) {
 			doc_probe(doc_locations[i]);
 		}
 	}
-- 
2.39.2


