Return-Path: <linux-kernel+bounces-101223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631D87A433
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63BA28320B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F301A286;
	Wed, 13 Mar 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy4eA+ZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB881AD5C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319633; cv=none; b=SyAeoGiUkYzOMZFWdhwdop9nuJV+6B8ropHa4I/E/Cu9cEgL5cLk8y+09NxnHgKCi9fyxfcS8K1WFWgUBJHnG65D4/KcqnL/hqIBfqdg9BmUYnnpX6HuTqPml9RAhTvNsnO/oHtGrORJu0hR67wXZgk710iHsmv0gum/oy/OhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319633; c=relaxed/simple;
	bh=yakn8DcYyX6FHUb9D/6Aegg8RoUb6WoaYCsMozwxIKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lVIDcKQMtcIQycVY9xymrrjKQoJYuJybGvbOzvB/raK4dcHAWCOKGJeh/xr+NCf1z2mF4ZM2pMALaeZGDSxx/cF4M0iuLwWtuvi0Qvg5vHNrkfrM6d9+7lPSPHygWmjdAFRETweWEyFMY2k/jhmNeFY4gqsxbTtEjkxVwNVuN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy4eA+ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3BEC433C7;
	Wed, 13 Mar 2024 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710319633;
	bh=yakn8DcYyX6FHUb9D/6Aegg8RoUb6WoaYCsMozwxIKw=;
	h=From:To:Cc:Subject:Date:From;
	b=Zy4eA+ZOxcbi0qOUZY7hjDjyCYobz5eb5R0q4k/kV9pzxxDR6bhSb0CHxMMB4bbY8
	 Abm7lYB8ciTbbMqd0TxHS5cTej35LSdDsvBGTRtIG7gK97XiWxE4Ic6DKv+yxvLHed
	 0gkV/OJr/KOQld5dmGNwO40uY1e6BrCRCkq7FugPr2T58SK7hNH7k5cm63BsfC9UqE
	 EaoQHWs4dHszp+yioksWs3p3TjUkLG5XNxj2sRCC+59QO2eRK0PyrbP0SZPEGzxbCl
	 hRqnsXCctrInJvM3UxF8cmnL354M+9H9UQfJHcl7wNgvJTxMMk5aiKKrpEuNw8IW9C
	 Wdo4RA9WPWQfQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
Date: Wed, 13 Mar 2024 09:46:52 +0100
Message-Id: <20240313084707.3292300-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The use of do_div() in ubi_nvmem_reg_read() makes calling it on
32-bit machines rather expensive. Since the 'from' variable is
known to be a 32-bit quantity, it is clearly never needed and
can be optimized into a regular division operation.

Fixes: b8a77b9a5f9c ("mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems")
Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/ubi/nvmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index 8aeb9c428e51..a94a1a9aaec1 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -6,7 +6,6 @@
 /* UBI NVMEM provider */
 #include "ubi.h"
 #include <linux/nvmem-provider.h>
-#include <asm/div64.h>
 
 /* List of all NVMEM devices */
 static LIST_HEAD(nvmem_devices);
@@ -27,14 +26,15 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 	struct ubi_nvmem *unv = priv;
 	struct ubi_volume_desc *desc;
 	uint32_t offs;
-	uint64_t lnum = from;
+	uint32_t lnum;
 	int err = 0;
 
 	desc = ubi_open_volume(unv->ubi_num, unv->vol_id, UBI_READONLY);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-	offs = do_div(lnum, unv->usable_leb_size);
+	offs = from % unv->usable_leb_size;
+	lnum = from / unv->usable_leb_size;
 	while (bytes_left) {
 		to_read = unv->usable_leb_size - offs;
 
-- 
2.39.2


