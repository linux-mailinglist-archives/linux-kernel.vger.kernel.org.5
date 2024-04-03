Return-Path: <linux-kernel+bounces-129393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE8896A04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F98284D83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055DE6F506;
	Wed,  3 Apr 2024 09:07:59 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535EF6CDDB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135278; cv=none; b=kELzssal+Q0GN/O/m7vHF9Jm+CT4D8PdmeedDRdhMKq3vOrnZskjur6rR2LMcFj0tfgQ+nclS3LaHfdbyZzCouWKPcAdrBqNi1jifhvEnGgJNPpffm0VnT0LhK+hQV///6918Qn3cxuDqoWf8buRit4KRuQCZ5q1y0yz3QhpMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135278; c=relaxed/simple;
	bh=36gxGJifEXD/hnaYX25hmL9Tijx1egA+ts829G4M6To=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTQ2O2aTaOdmOF3+6wtb00uhLSyAp4rNPdestkNC64B3WDj2PgBO++SCExpXvClaPjwmXD+EH/3SerHtKmSoTNvJZ5qcShu4MKLquiOnc0CTIxydRnSHZeBx7n1D6zWlOuUDso5MJA0PZFa5RgwB8VZ7irfXAfvEsNmoGWIi9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 17:02:46 +0800
Received: from twmbx01.aspeed.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 3 Apr 2024 17:02:46 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <tzimmermann@suse.de>, <jfalempe@redhat.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<airlied@redhat.com>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/ast: Fix soft lockup
Date: Wed, 3 Apr 2024 17:02:46 +0800
Message-ID: <20240403090246.1495487-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There is a while-loop in ast_dp_set_on_off() that could lead to
infinite-loop. This is because the register, VGACRI-Dx, checked in
this API is a scratch register actually controlled by a MCU, named
DPMCU, in BMC.

These scratch registers are protected by scu-lock. If suc-lock is not
off, DPMCU can not update these registers and then host will have soft
lockup due to never updated status.

DPMCU is used to control DP and relative registers to handshake with
host's VGA driver. Even the most time-consuming task, DP's link
training, is less than 100ms. 200ms should be enough.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_dp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index ebb6d8ebd44e..1e9259416980 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -180,6 +180,7 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 {
 	struct ast_device *ast = to_ast_device(dev);
 	u8 video_on_off = on;
+	u32 i = 0;
 
 	// Video On/Off
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xE3, (u8) ~AST_DP_VIDEO_ENABLE, on);
@@ -192,6 +193,8 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 						ASTDP_MIRROR_VIDEO_ENABLE) != video_on_off) {
 			// wait 1 ms
 			mdelay(1);
+			if (++i > 200)
+				break;
 		}
 	}
 }

base-commit: b0546776ad3f332e215cebc0b063ba4351971cca
-- 
2.25.1


