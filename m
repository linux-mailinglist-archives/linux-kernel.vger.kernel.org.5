Return-Path: <linux-kernel+bounces-113365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17FA8883BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A785B1F256A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7419D1C8;
	Sun, 24 Mar 2024 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1ACDEKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959219D1B1;
	Sun, 24 Mar 2024 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320167; cv=none; b=DCDodia+bOF2Sn+ttHV9HL7TwIkegh9YVqQVDg1mcV+HBpla5Z4CpF0H7WX/m6wh8SW/EeBdGdQjUI/SLQ4XdrbMfLc/oLSG3MASCrrpxOvLOzs8/WKXwgi1l8JDkkHcV+9nT6GfWyZuO/gLoh/emHx8yj3TcjOj5b/M3Htoor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320167; c=relaxed/simple;
	bh=3Wzt/MY03JIIh8DBekuR6xPd27GDZod/Rv/dJ5fef9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJWSaWf8sBu9I0QL/9+800bkw1EUfB46gWdr2xSb4LEIRgc6SwWVrSmaEr5MfJ3aPP1I2zu78+3I2IxD4vQ5fvMZvMDr5t9XFOoLzLbIIC+QRcEowNSFuN3HuMOad201YSTAa53iFhxZowM7DTJl2zAXusFl5SJlFw2sOudoit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1ACDEKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EDBC433A6;
	Sun, 24 Mar 2024 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320166;
	bh=3Wzt/MY03JIIh8DBekuR6xPd27GDZod/Rv/dJ5fef9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1ACDEKyKfrnwsuc/9hZwuuLU8kbgtbd6uVtTafcm6VmlABJL+TgxdJlJ8xEAhyRg
	 fO5+96Ii3TLQXdxTfJEyL9aYa1aecQ50mdlnxaJugcPChVi3/gxUYLa1uAfQ9VmahY
	 4pgOZpgxdAkYRL4K+Gsq04GIw0LmDwvt6zXduJX2/V/8V32Bju/egcPeLRpPN7RKy4
	 YUw+iB3KRa/HenLOXGWyJar2pQIMlXfFVTT4/vATblTA6DU20X6RoBJGbdmA2caC8/
	 TQTW6On6onypu2rxGt/XPvCHyjUr4aifcL7Jijane2MEAh6P76h5MQzSV/khQzI1xu
	 YNSc6UDVk3fWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 474/715] drm/tidss: Fix initial plane zpos values
Date: Sun, 24 Mar 2024 18:30:53 -0400
Message-ID: <20240324223455.1342824-475-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 3ec948ccb2c4b99e8fbfdd950adbe92ea577b395 ]

When the driver sets up the zpos property it sets the default zpos value
to the HW id of the plane. That is fine as such, but as on many DSS
versions the driver arranges the DRM planes in a different order than
the HW planes (to keep the non-scalable planes first), this leads to odd
initial zpos values. An example is J721e, where the initial zpos values
for DRM planes are 1, 3, 0, 2.

In theory the userspace should configure the zpos values properly when
using multiple planes, and in that sense the initial zpos values
shouldn't matter, but there's really no reason not to fix this and help
the userspace apps which don't handle zpos perfectly. In particular,
some versions of Weston seem to have issues dealing with the planes
with the current default zpos values.

So let's change the zpos values for the DRM planes to 0, 1, 2, 3.

Another option would be to configure the planes marked as primary planes
to zpos 0. On a two display system this would give us plane zpos values
of 0, 0, 1, 2. The end result and behavior would be very similar in this
option, and I'm not aware that this would actually help us in any way.
So, to keep the code simple, I opted for the 0, 1, 2, 3 values.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index e1c0ef0c3894c..68fed531f6a7f 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -213,7 +213,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 
 	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
-	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
+	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
 
 	ret = drm_plane_create_color_properties(&tplane->plane,
-- 
2.43.0


