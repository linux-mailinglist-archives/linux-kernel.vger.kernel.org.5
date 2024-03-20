Return-Path: <linux-kernel+bounces-108928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00698881219
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3010F1C22443
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB8446AE;
	Wed, 20 Mar 2024 13:13:05 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602ED41C93
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940385; cv=none; b=Eh1sOawW2C2N7L5uuuPC8jlNKebfH6EZTzKtlWejCxl1yIfEf55qQkIXLzpIlRNqPveg07N1QlHHSToyomZovP5c4YyfQDVM1xXcMG2GIqlnQoNcSB25lVioHmo3nU/svBAQ6AATM30iI319GrWGxW8Eg7pGPsfgaRZ4qyfk6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940385; c=relaxed/simple;
	bh=wL+k2OP7ETsdiy+7aOWTaXP+awLCKPX6VEzfPjiZ/2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+SyxVMkk5JAkdTmCWC/uCuN3Q8BxnxLqUhNTWqRUI65PWwzhbPYiugXM2xGODON5ZWT6v76v7ZemsK+qVpd6Z2007f4BuUKPxL/y5jmctbChTAci2S9Wr7k3OIg3r+FyX+FT1SvGpdlpfDMJtbWuyCbGvI2RBkFLvGAAcp1wfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rmvkA-0001W6-Ny; Wed, 20 Mar 2024 14:12:34 +0100
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
Subject: [PATCH 1/2] drm/panel: ltk050h3146w: add MIPI_DSI_MODE_VIDEO to LTK050H3148W flags
Date: Wed, 20 Mar 2024 14:12:31 +0100
Message-Id: <20240320131232.327196-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Similar to other variants, the LTK050H3148W wants to run in video mode
when displaying data. So far only the Synopsis DSI driver was using this
panel and it is always switching to video mode, independent of this flag
being set.

Other DSI drivers might handle this differently, so add the flag.

Fixes: e5f9d543419c ("drm/panel: ltk050h3146w: add support for Leadtek LTK050H3148W-CTA6 variant")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 30919c872ac8..a50f5330a661 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -326,7 +326,8 @@ static const struct drm_display_mode ltk050h3148w_mode = {
 static const struct ltk050h3146w_desc ltk050h3148w_data = {
 	.mode = &ltk050h3148w_mode,
 	.init = ltk050h3148w_init_sequence,
-	.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO_BURST,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_VIDEO_BURST,
 };
 
 static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
-- 
2.39.2


