Return-Path: <linux-kernel+bounces-108927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D4881217
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316711C22670
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517742057;
	Wed, 20 Mar 2024 13:13:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915341C7C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940383; cv=none; b=A4xzdes3ZjvQNPzNw/SwamzfleQtue//1XVDM5ldeY0Eta4xyJaYLCvNM+vLBsHDRvtymUeoqwP/w3FCeQrQpwK99P8lY4DV2nuhRGhkM5W+BxBHrnsm7hq2PYwS5Ld7b76P6PcJJeFWtXitunl08admz1RGK+q6gJIgNuq/z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940383; c=relaxed/simple;
	bh=IYVjmc30ghVm+nkDLV+ho87nLXCDj0SQAYQHBoksiuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFXPBjSEvg+q1VqKly+KXD40+vvSyz/c6qsoFzckwpNu3xwQkC0kzd7Q/IXMyywqEXMSHgIoT7ERY+PjseBbsLVwWfun5bdjDP6PpAToh+7LjszLOjZ8/LRF1WQCQs4fy19ljw6XpQ3LScQhOS9fRaSgjKIlyDARx3u5llpRlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rmvkC-0001W6-Am; Wed, 20 Mar 2024 14:12:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	quentin.schulz@theobroma-systems.com,
	klaus.goger@theobroma-systems.com,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] drm/panel: ltk050h3146w: drop duplicate commands from LTK050H3148W init
Date: Wed, 20 Mar 2024 14:12:32 +0100
Message-Id: <20240320131232.327196-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320131232.327196-1-heiko@sntech.de>
References: <20240320131232.327196-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The init sequence specifies the 0x11 and 0x29 dsi commands, which are
the exit-sleep and display-on commands.

In the actual prepare step the driver already uses the appropriate
function calls for those, so drop the duplicates.

Fixes: e5f9d543419c ("drm/panel: ltk050h3146w: add support for Leadtek LTK050H3148W-CTA6 variant")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index a50f5330a661..8e0f5c3e3b98 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -295,8 +295,6 @@ static int ltk050h3148w_init_sequence(struct ltk050h3146w *ctx)
 	mipi_dsi_dcs_write_seq(dsi, 0xbd, 0x00);
 	mipi_dsi_dcs_write_seq(dsi, 0xc6, 0xef);
 	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, 0x11);
-	mipi_dsi_dcs_write_seq(dsi, 0x29);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, 1);
 	if (ret < 0) {
-- 
2.39.2


