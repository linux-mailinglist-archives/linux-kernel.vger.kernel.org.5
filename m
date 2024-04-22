Return-Path: <linux-kernel+bounces-153162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E049C8ACA73
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC051C208F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002513E8A7;
	Mon, 22 Apr 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gk8bVHbC"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308213E3ED
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781219; cv=none; b=pathn4EkpnIfCnN5aVn/ZLqoIB/NeXQyscjIjb1GMs4mrsX6p0pksm/gqVaHpE59AhGZtDNz06HR54497CL+C5IYHTfzMt7mPDYqaaGah82ZRJaqZJWVldW32b7k+JUO1GMct/P4R4jazk4egJvAOFDi1Pc7jYtw/pCbZewX0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781219; c=relaxed/simple;
	bh=+QTRi9bFBrSot9mmYoUkrXbxSIhor3OXIS8dqNGz/c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVwZbn80398g4SMJTKW0rlT0ZhfrE1YkNfsnt6r3RHkAUkLAJInhDAyLfiszk86wxjq7REOU/T+uNJ9NEQPoV7ZGRpPc5OdexyZI7Wp5i+zMjmxTfxDiZCjiWpy/FJqgWAnC1geJ9Ty+DBcm8uDlfV9P5cXAdQglhG1ON5QQeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gk8bVHbC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p2ORg
	ZDzSKVifuuO/4694cN5BzMQozrvf4hgWYIQay0=; b=gk8bVHbCll4il7G5c+K8e
	fPSYPWXboelLycremu9396QGozJZywTHOj/3HbM+w4Aozz1KqdgHL1BB0elDGegP
	NlUmgQ19uM1Tu6KK+VUsBKoW1N9fxb+gnoCoBmruvhVIp9zNWIZpf3MRZJolpJGD
	lp22RovFMEWP5UwpcclMW8=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wB3fymbOSZmRwO9Bw--.23790S3;
	Mon, 22 Apr 2024 18:19:10 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	hjc@rock-chips.com,
	s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/1] drm/rockchip: vop2: Fix the port mux of VP2
Date: Mon, 22 Apr 2024 18:19:05 +0800
Message-Id: <20240422101905.32703-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422101905.32703-1-andyshrk@163.com>
References: <20240422101905.32703-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3fymbOSZmRwO9Bw--.23790S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw13Gw1fWF4fZF4rXFW8JFb_yoWDCFc_Ga
	y7XrnxWa1kuwnxAw1UCw4fGrW2y3ZFkF4vya10vF9IvanxJ3Wvqa4Sv3y7XF1UAF13Wr1D
	Was0gr1xZFnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeb6pDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAPIXmVODidz9QAAsB

From: Andy Yan <andy.yan@rock-chips.com>

The port mux of VP2 should be RK3568_OVL_PORT_SET__PORT2_MUX.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 97b0ab4b6db8..1f4250de570f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2377,7 +2377,7 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX,
 			(vp2->nlayers + vp1->nlayers + vp0->nlayers - 1));
 	else
-		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT1_MUX, 8);
+		port_sel |= FIELD_PREP(RK3568_OVL_PORT_SET__PORT2_MUX, 8);
 
 	layer_sel = vop2_readl(vop2, RK3568_OVL_LAYER_SEL);
 
-- 
2.34.1


