Return-Path: <linux-kernel+bounces-114829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088EE889197
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B192A1F2DAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78947279215;
	Mon, 25 Mar 2024 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUm94Oix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5B2789B3;
	Sun, 24 Mar 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323454; cv=none; b=B5zjVuJZ0h7VeaWddbQb8KNTEfwIP6sd6XcAEDXoqNIjpL2GwVZ/WzmGCC04WF3F9XmzIut2g9UHuQOmrTxDU82s1tT+oLIH78ifAWnowYlAjN2yyiuhUHWi0ezGIfMigr2gKuVD3Qa83lPCTvDrtRNvzoLxSjt2WoJAXdycRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323454; c=relaxed/simple;
	bh=CuNdbve/aDMAJHCA8RKTF4o+ELZsUr2WdCEhBLl+Gc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkcegUPu44K55I0prHkc9X+jjd74vQOOt3m8zrLahDkzCCvXPcoIgH5JBQ0B4ITMhJp7mA+s6bZ8Rfs7U4nk5jze0Q366VeV4g0n6UoWY90clOdLHI58JSC3A5LHnRrdOQ0yQzC/haIk60B8NQDADpLigTB2f6tcS1ACWrqFL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUm94Oix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432AC433C7;
	Sun, 24 Mar 2024 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323453;
	bh=CuNdbve/aDMAJHCA8RKTF4o+ELZsUr2WdCEhBLl+Gc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUm94Oixin9qBVfZGabrYHOdB4xealLM0KhfCBa+ezb62qITFXtAvC3M3zUEf8BZt
	 msrxzeIvZNmmWcB3hRtPcONmbCl9NPW6EQT0j4Ov5/Irr/k0GSAfcuECOEzTXzRjCT
	 zYERq0HtO/gfWs/T0rGTUSI7/TiZOsNkwRASbW7t0ybYpT0sW4pGvKrOdFWaHTnMvC
	 TIAn9YooMco9hjetq/e6K1mTcXPtBPegRVyKbYfNlDWWxcj1bZMKJsbx4SP2eiqIYt
	 /5OViBOq1AnGp+QMr+Dc3dNbfsxNnw4mb8Sse/6g1IRe3tAsk6NlJeKfuNjnk3I9Oe
	 ZA76pvTtaspIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 157/317] drm/tegra: dpaux: Populate AUX bus
Date: Sun, 24 Mar 2024 19:32:17 -0400
Message-ID: <20240324233458.1352854-158-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 8913e1aea4b32a866343b14e565c62cec54f3f78 ]

The DPAUX hardware block exposes an DP AUX interface that provides
access to an AUX bus and the devices on that bus. Use the DP AUX bus
infrastructure that was recently introduced to probe devices on this
bus from DT.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Stable-dep-of: 0800880f4eb7 ("drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/Kconfig | 1 +
 drivers/gpu/drm/tegra/dpaux.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 1650a448eabd6..b09a500934f73 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -5,6 +5,7 @@ config DRM_TEGRA
 	depends on COMMON_CLK
 	depends on DRM
 	depends on OF
+	select DRM_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index c96c07c6458c3..12a92d09ac909 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_dp_aux_bus.h>
 #include <drm/drm_panel.h>
 
 #include "dp.h"
@@ -570,6 +571,12 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	list_add_tail(&dpaux->list, &dpaux_list);
 	mutex_unlock(&dpaux_lock);
 
+	err = devm_of_dp_aux_populate_ep_devices(&dpaux->aux);
+	if (err < 0) {
+		dev_err(dpaux->dev, "failed to populate AUX bus: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


