Return-Path: <linux-kernel+bounces-56843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4A84D01F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C68B28E54A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90968288E;
	Wed,  7 Feb 2024 17:42:54 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6B823D9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327774; cv=none; b=Kyjg4YueVANeGgQfCp5TRKhJp/C73NywpxVFkbRxbUXAgq8fJo3jUCxEzJZOYCDb0AnLHo1/jchjGq79rznFpg/G2ZgE/L0zu8zCpfjrQWUjBDLOKjvddNQG7T3Zn2cBX8MI6nwojoSfC18YADmy+x9rC8+mm9yp+ptRcVMXLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327774; c=relaxed/simple;
	bh=sbQ0q2InasHxX418o7X4ZW5il0O1Qo5AEyD+/brS8+c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jOtJAFXX37tNS6A4nFWg4XmHjzvIOAAIkoRETn3JDd4A1BruD9sQVwOrLkBcYsviFWcuBhDGlMKqIjciunMUKS3nGTEBnB3DH1S6lJo+Yzpp8xp50aKkLMQOwImBvHLnvyD/YUx0ElGQiCIu5nk0dfxvJeGnO3RkThOygAHrxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rXlwe-00041Z-08;
	Wed, 07 Feb 2024 17:42:48 +0000
Date: Wed, 7 Feb 2024 17:42:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	William-tw Lin <william-tw.lin@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
Message-ID: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The mtk-socinfo driver uses symbols 'soc_device_register' and
'soc_device_unregister' which are part of the bus driver for
System-on-Chip devices.

Select SOC_BUS to make sure that driver is built and the symbols are
available.

Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 50c664b65f4d4..1b7afb19ccd63 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -72,6 +72,7 @@ config MTK_SOCINFO
 	tristate "MediaTek SoC Information"
 	default y
 	depends on NVMEM_MTK_EFUSE
+	select SOC_BUS
 	help
 	  The MediaTek SoC Information (mtk-socinfo) driver provides
 	  information about the SoC to the userspace including the
-- 
2.43.0


