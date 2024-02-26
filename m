Return-Path: <linux-kernel+bounces-81746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6638679A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9DF29D835
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1A12CDA4;
	Mon, 26 Feb 2024 14:55:35 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FF135419;
	Mon, 26 Feb 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959333; cv=none; b=QbPZ9XYkbxWsQhVed7Z9qCcBJp9lPBvmDUA8asnxibuS9BUq8DMXQ5z60nyxoMqMkJcOUUkca/0SgKYb6fBMNtuBD2IhydJWKeo++ECFWbb9/4+ehvtJJwLi8G5B5TPYLDLFDZNx9f2b26X4m8ijIepkG2XfJ+DJM17WKH1zQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959333; c=relaxed/simple;
	bh=Ra5nRQiwmBuhhUWhWiSbDuLHQ11UKnwbPZndQYrHsgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j2bWaEw7iv/5Ie1q8NlJszmmLnYcsp9RvG0gFgD6z8qWi6w7BXGgAFcqixhywaqhWklxuUWZCC0yKAGRLruFT78EhQh6t9YyD+EHcqySBopdmeHVIPufjte8BwMR4dJrZ0Exn0XQP3ZvGBGb27gY5NBgqLnZ2KFsCHNXE8fSGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Hans de Goede <hdegoede@redhat.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Mark Gross <mgross@linux.intel.com>,
	Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
	Vadim Pasternak <vadimp@nvidia.com>, <platform-driver-x86@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] platform/mellanox: mlxreg-hotplug: Check pointer for NULL before dereferencing it
Date: Mon, 26 Feb 2024 17:54:42 +0300
Message-ID: <20240226145442.3468-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

mlxreg_hotplug_work_helper() implies that item can be NULL. There is a
sanity check that checks item for NULL and then dereferences it.

Even though, the comment before sanity check says that it can only happen
if some piece of hardware is broken, but in this case it will lead to
NULL-pointer dereference before the function is even called,
so let's check it before dereferencing.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c6acad68eb2d ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 5c022b258f91..524121b9f070 100644
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
@@ -556,7 +542,7 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
 
 	/* Handle topology and health configuration changes. */
 	for (i = 0; i < pdata->counter; i++, item++) {
-		if (aggr_asserted & item->aggr_mask) {
+		if (item && (aggr_asserted & item->aggr_mask)) {
 			if (item->health)
 				mlxreg_hotplug_health_work_helper(priv, item);
 			else
-- 
2.25.1


