Return-Path: <linux-kernel+bounces-124768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3E891C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E321285DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E76181BB5;
	Fri, 29 Mar 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxbOmAwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8B181B9B;
	Fri, 29 Mar 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716107; cv=none; b=k/nXdxFXsWBrt5HFKsILxrc0I4L6X5vSIHF7iN+VjSodcJv2OM9UGrHOyJUVZyqBZ0jSkphogBHhm4ChGuPXXB2yy7nWK9TzPQszMo+dLbUCGDbi8omeMnWPjOqWC0N79u1HM6GNarqI3rYYcC4ks1nMpoVrEArEvFtgDSWvvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716107; c=relaxed/simple;
	bh=CMbxUBDwWb3gao2egFpqs7ok8qzPCP3w+opAmXspYFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGkl809NZr6MG1JWnNDIY8wCWuBgvVnt5QEhHj+IVg4mOrSs0xj8ZH1EgtfDJtEybsLpGalLMmfMwhfGMqF6g/+U0STthLKnh7Og2uUHGxRikoYUSdTrq3xsSQM9Ru+z0BuxPHM2oQ2eSjYxhPfAJ5xgVcCafUH/XEg39hvr/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxbOmAwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B61FC433C7;
	Fri, 29 Mar 2024 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716107;
	bh=CMbxUBDwWb3gao2egFpqs7ok8qzPCP3w+opAmXspYFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxbOmAwj2XOVQw84Wc0bS2jNHz7a92bRCoHPJLOjYsFk9ouYja9rJ7weZznEHrIU6
	 wj5Q9OqJVMo1NNr1DhmwjlgcMsS6NDzcX72sfXG0orainLgZI1Y69v/GfDtIp8Aevr
	 5uvhiieNZBW76Sj38nTiV8V8kE2MbP70uyyRnkm96X5u0jm/Wa6Iyb8BvzjPR9bPMq
	 JuGNEW8ezzJTUCeKWsgIWA1dFm5zSLad/PoseFNgokh/xDA8kS1nYJfRWyGu2FwYva
	 TzvECEKyEJflQogtwtnUsMjV/5kShOHaEbdS0da1BHQymLTxUjMSP5qgh2V07qnlEl
	 JaDNutcRLfc0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 58/98] mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Date: Fri, 29 Mar 2024 08:37:29 -0400
Message-ID: <20240329123919.3087149-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

[ Upstream commit 1d8c51ed2ddcc4161e6496cf14fcd83921c50ec8 ]

Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
misconfigured clock divider, which should've been 1:1. This introduces
quirk which conditionally re-configures the clock divider to 1:1.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231221185142.9224-3-alex.vinarskis@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 5 +++++
 drivers/mfd/intel-lpss.c     | 7 +++++++
 drivers/mfd/intel-lpss.h     | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 07713a2f694f3..8c00e0c695c5b 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -34,6 +34,11 @@ static const struct pci_device_id quirk_ids[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS,
 	},
+	{
+		/* Dell XPS 9530 (2023) */
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x51fb, 0x1028, 0x0beb),
+		.driver_data = QUIRK_CLOCK_DIVIDER_UNITY,
+	},
 	{ }
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index aafa0da5f8dbf..2a9018112dfc8 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -300,6 +300,7 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 {
 	char name[32];
 	struct clk *tmp = *clk;
+	int ret;
 
 	snprintf(name, sizeof(name), "%s-enable", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
@@ -316,6 +317,12 @@ static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
 		return PTR_ERR(tmp);
 	*clk = tmp;
 
+	if (lpss->info->quirks & QUIRK_CLOCK_DIVIDER_UNITY) {
+		ret = clk_set_rate(tmp, lpss->info->clk_rate);
+		if (ret)
+			return ret;
+	}
+
 	snprintf(name, sizeof(name), "%s-update", devname);
 	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
 				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 2fa9ef9162580..6f8f668f4c6f0 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,11 @@
  * Set to ignore resource conflicts with ACPI declared SystemMemory regions.
  */
 #define QUIRK_IGNORE_RESOURCE_CONFLICTS BIT(0)
+/*
+ * Some devices have misconfigured clock divider due to a firmware bug.
+ * Set this to force the clock divider to 1:1 ratio.
+ */
+#define QUIRK_CLOCK_DIVIDER_UNITY		BIT(1)
 
 struct device;
 struct resource;
-- 
2.43.0


