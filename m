Return-Path: <linux-kernel+bounces-90379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7AC86FE74
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8427DB207EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB518224FD;
	Mon,  4 Mar 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V1g4ZJXg"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95A224E0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547058; cv=none; b=heFfD9arj9lBzC+Lv/BhUd25+VuqI9QT2VvNNGHGaMRaboa7arBA5bBUIaJbGVmTYWuUcPweNQVNO/F9AmIS/HBXDtwpO+SjzHaW+Szbe09uZeH6iTwiqMK4jHWTW1tBwJOCY6BW5EnszESU8TZQv8gXFKUqMpbmRw5KUUU9e7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547058; c=relaxed/simple;
	bh=Qd+RI16juGVjN7zrBNOH3Q/KIOhwUI6VbC2DgVyOadg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MO/YeUGvWRtlHJUSd14upQFdmyGBcLtZyBPs8I5ck2AkBFZUG+xheTaMH0bBAAe2FT5hgxqyOjFYlaUHOUPWETiypSchlNpIlu6iO6iahRKaMo3JzC0q6QQUzGiz8NXE/BT/BPbDckShu/JABiIGO8EVJ7t2KdQpZL4wFDC+o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V1g4ZJXg; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rWWze
	ynqvpKTE8wM5BvJ7WhI4cRh2jw6a0Kbi0ZwsdA=; b=V1g4ZJXgnDduvAq01bKml
	dVxaDiyDzC5H4z8/n32ZfrcKQKaIKR84bNNjoy39SlkZ4ACN02OkX7LyOHn3rPMt
	3o5L/JA0VGQGxfl9d6OGJoZ6RYmMk3p9veoiCHDvQ2k/XdiEmDlo1ZL8lSo48HFe
	dM9SAFp1cugZROOeyXS7fM=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3n_jzneVlOacmAQ--.60415S2;
	Mon, 04 Mar 2024 18:10:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	s.hauer@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: vop2: Remove AR30 and AB30 format support
Date: Mon,  4 Mar 2024 18:09:52 +0800
Message-Id: <20240304100952.3592984-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n_jzneVlOacmAQ--.60415S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47XrWkGr4DZw17ur45KFg_yoWfuwcEk3
	47X3Wfur4xCrn8Jw12y3y7WrZFy3WI9Fs2ga9Yyan5AF1vvw1rXFy0vry7Gas8JF42kFs7
	GF1jqry3CFn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1YL95UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEB6XXmVOCknmwAAAsJ

From: Andy Yan <andy.yan@rock-chips.com>

The Alpha blending for 30 bit RGB/BGR are not
functioning properly for rk3568/rk3588, so remove
it from the format list.

Fixes: bfd8a5c228fa ("drm/rockchip: vop2: Add more supported 10bit formats")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 48170694ac6b..18efb3fe1c00 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -17,9 +17,7 @@
 
 static const uint32_t formats_cluster[] = {
 	DRM_FORMAT_XRGB2101010,
-	DRM_FORMAT_ARGB2101010,
 	DRM_FORMAT_XBGR2101010,
-	DRM_FORMAT_ABGR2101010,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XBGR8888,
-- 
2.34.1


