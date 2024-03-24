Return-Path: <linux-kernel+bounces-115963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3088898E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAAF1F33295
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD5393B5A;
	Mon, 25 Mar 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPrAZrZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067A14C581;
	Sun, 24 Mar 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322234; cv=none; b=L1aYEKx70Dd6I8h3H/LhHDN58+uxZlOan8fm3Oz5zGDiwWdQyZ2dSVZrpwOCEy3EJoMnitvE+HWrlu9j3VdnBggaqWZGWAafh2f3m14EBVeLwCqwlLu9FaxIiAIcegyzZTGDK4IYBLdN01yYwi4HWwoIWZNF2kgfvj+xyAFuZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322234; c=relaxed/simple;
	bh=iZgMns2rA9Thds77z35AZf+v1OfqQkQbsN5QHiFZhtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDd5C2s4WzsJ0plgo4mHtg+0y6g5/1G3ldsAyfnLKVoKN+SsBUfY0NXd7232rn1E/IZluREwYS2OYZZ6n4EzVWmUItjVU2GwaRNdjFfVXWOleQj4OBlefKN7tG7kfI/5X32fSWW63wNBoIUhc1uKAEeYTeuSYcXkfmDIJc554zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPrAZrZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF871C433C7;
	Sun, 24 Mar 2024 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322234;
	bh=iZgMns2rA9Thds77z35AZf+v1OfqQkQbsN5QHiFZhtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPrAZrZfuoXTwkW1yUbx3eplNg/U5bcbBNsKz/63BfX5p2SZcS9u2pelsZVkSyWoT
	 dtGzpvTqxpOYxNav4kF8jCVCBU8isZHmBFuxVu1seZEtZCRhcohO9hOQIfNI6sAMSv
	 N4juDidR8Kf/rUuFO5ZaPZ3Cjx69GF1ZKkNMHZQ7CcfzI7N/a+T3ygZ3Rmie2JGpfK
	 F1gip9ffQXro+k8c3oHvm5qfrJCBeMIwpjPhy7POoy9BvGDq4QPqotaG+dGk7Pa5Ui
	 4ICj2bJ5r28IffCbBabEDnJmDSFOirvL09cNTmWGzImvPo08J4v2ne6BTtVjfbm35O
	 2Yx50C9q1H/UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 315/451] drm/tidss: Fix initial plane zpos values
Date: Sun, 24 Mar 2024 19:09:51 -0400
Message-ID: <20240324231207.1351418-316-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 42d50ec5526d7..435b3b66ae632 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -211,7 +211,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 
 	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
-	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
+	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
 
 	ret = drm_plane_create_color_properties(&tplane->plane,
-- 
2.43.0


