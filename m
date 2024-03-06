Return-Path: <linux-kernel+bounces-94174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF652873AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11F51C2160B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636F51353FF;
	Wed,  6 Mar 2024 15:38:59 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3C1353F2;
	Wed,  6 Mar 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739538; cv=none; b=nMQHxV+TpVcP+6Y5B+OXp/tBaanEasbxAg/XFAuUXYDF9uc7J46qXxZMbAnXEr4rS0NqR/ALot13OOvvSsJGbTfA7DKn/cZ+sh78poj+cWIe2pb1ckzE7prgU+l1Y6PlsgOcHYWmXBLx3NzcLtlZTSCoEVqAq+FE5R2YQWaq3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739538; c=relaxed/simple;
	bh=mIrYgWybZIzzTmLvKcdEwm229Qxy6TkUJtHepPTkmW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF9X1R/1FbwykANr7kxC2r4pK/qDAzRg78+vZ3m9M6r7ogEw3We/ODwgd+vCsfGlZ3jMdA61fXg04yrxCsjT76IATO2n6l9e5eS8EO95h0qnrn4T4/LHZHG1UnwvAHnPOZh3nc8DG3V5DgsUjgTAler3CQzD2CHLbgAdjMxwKSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Vadim Pasternak <vadimp@nvidia.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Mark Gross <mgross@linux.intel.com>,
	Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] platform/mellanox: mlxreg-hotplug: Remove redundant NULL-check
Date: Wed, 6 Mar 2024 18:38:04 +0300
Message-ID: <20240306153804.6509-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <BN9PR12MB53815F52C9033DC526085827AF232@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <BN9PR12MB53815F52C9033DC526085827AF232@BN9PR12MB5381.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Pointer item is checked fo NULL at mlxreg_hotplug_work_helper() and then
it is dereferenced to produce dev_err().
This pointer is also dereferenced before calling this function and should
never be NULL except some piece of hardware is broken as it is said in
the comment before the check. So, this check can be safely removed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c6acad68eb2d ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 5c022b258f91..0ce9fff1f7d4 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -348,20 +348,6 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
 	u32 regval, bit;
 	int ret;
 
-	/*
-	 * Validate if item related to received signal type is valid.
-	 * It should never happen, excepted the situation when some
-	 * piece of hardware is broken. In such situation just produce
-	 * error message and return. Caller must continue to handle the
-	 * signals from other devices if any.
-	 */
-	if (unlikely(!item)) {
-		dev_err(priv->dev, "False signal: at offset:mask 0x%02x:0x%02x.\n",
-			item->reg, item->mask);
-
-		return;
-	}
-
 	/* Mask event. */
 	ret = regmap_write(priv->regmap, item->reg + MLXREG_HOTPLUG_MASK_OFF,
 			   0);
-- 
2.25.1


