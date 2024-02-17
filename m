Return-Path: <linux-kernel+bounces-70023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A332D8591E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446DFB21E74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3957E57A;
	Sat, 17 Feb 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="mWjyxl/s"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987461C282;
	Sat, 17 Feb 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195928; cv=none; b=hzc63i2XN98WbIK8s69lAije0OrrvVZ1zY8QUovSlE+q+6PBN1F9Fv+dcMmzu4QawNpE2xpHGe1ZcUHYJ1x23T1rMomf/h2DnqTHvzATBiCCaoGd5ojgyVio9JQG1wewDl5OUKXd0JNTLCraPp2/dfK63qSRt3WjhNX+7qPKays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195928; c=relaxed/simple;
	bh=HRBsXHjOejmZlim4WFTvQhmTd/GTxXJaVN/xTbbQgG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPnMoegw11tHlChtB9byjJp+ak2IGRFFeQbjY4Ot2AB6EeQkU3W5xlclUvxQIERchAJx/TEciXX5xCmko8yQZkbRj/XnUuDKy4ugycxlDsNP111aSINWD8IMnaPJDKr6ICRVizAaXVRjrVhpu+Zh5ip1SQxpfPPJyXBqOBbpyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=mWjyxl/s; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708195924; bh=HRBsXHjOejmZlim4WFTvQhmTd/GTxXJaVN/xTbbQgG8=;
	h=From:To:Cc:Subject:Date:From;
	b=mWjyxl/suWtNCVP3DS707u2Tlr9gLUP9/LtPcj2llvfo3lH+9+aeYKLqHZShBM5T5
	 957L5tTyBUBKzQxB4YD55mI5YEKXNuCcATMTQt9l+9JS4bWkBcMrEclljHWwZALfbh
	 BeGTYyNq14AIq/q7ysXwb2L7h3h+on5ps075co30=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-rockchip@lists.infradead.org (open list:ROCKCHIP ISP V1 DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support)
Subject: [PATCH] media: rkisp1: Allow higher input resolution
Date: Sat, 17 Feb 2024 19:51:58 +0100
Message-ID: <20240217185202.1754750-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

In BSP driver, it is allowed, and it works in practice. Tested on
Pinephone Pro/RK3399 with IMX258 at full res.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 4b6b28c05b89..74098ddbeeb3 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -33,8 +33,8 @@ struct dentry;
 #define RKISP1_ISP_SD_SINK			BIT(1)
 
 /* min and max values for the widths and heights of the entities */
-#define RKISP1_ISP_MAX_WIDTH			4032
-#define RKISP1_ISP_MAX_HEIGHT			3024
+#define RKISP1_ISP_MAX_WIDTH			4416
+#define RKISP1_ISP_MAX_HEIGHT			3312
 #define RKISP1_ISP_MIN_WIDTH			32
 #define RKISP1_ISP_MIN_HEIGHT			32
 
-- 
2.43.0


