Return-Path: <linux-kernel+bounces-116190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DAF889A21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D2A2C3191
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D53B9CA7;
	Mon, 25 Mar 2024 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhNm+kvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECC284543;
	Sun, 24 Mar 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323790; cv=none; b=Mc0rkj9aK++/QDwS4NS75xrRPxD7d9tvweK0v/umdIJ2A+2XBUiI4g7JZybrPt3zejGnGZBSZYUUIoH5wmdKw8W2zrGpAz4g7iJZm0kesoD+DCnCeJ6X2kRKPG4/UM7h5kuiO8j5ZyjeaWfTLfbhMWK0jhbqspUMrob+pdSaYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323790; c=relaxed/simple;
	bh=+v+Bo3Zpez8dY5cSC1s1jooMHNg7M0a4EuKuqRako8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMl0Cpj9WzISAjQNoGkHzBo6O3NhQs91WP54VXo8F7K2STwZhTiSkyWj3IxONVVXzHe0X7LoUsGBWE/4fzeZQaMa3N/9OcRaJ1UgA5JcXavMKYNv8VjzGUUKm4WC9WOBIvugYMWjCEDW+8QFvJ6pUBEaYsHkyItJqdNmxJ2OOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhNm+kvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF0C43390;
	Sun, 24 Mar 2024 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323789;
	bh=+v+Bo3Zpez8dY5cSC1s1jooMHNg7M0a4EuKuqRako8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhNm+kvApIoymwcmvVsQwKjVpI4kCRa1cXFgmfQFioLIz1Z5jpEFkYkeuVN1OQnk2
	 Rt9xKHTOjmcra93QlN+y5BRzKBvBTpRQFgMjm2nrSGl/N9NtGjbw3wyCAIAmpsbzVk
	 IgPPJ8PZualqIih6vieMe1mD0d4+uOlDdq0mrD6k7f5jQWMuiFXYd4Cp1VlvvLTeuo
	 Gv7kkSiYBQ0o1Q4ZU03O5h4+hgsZlfn2tcPgDnSM9jjvfQjR8Qi7nd1AtZRJlPVm1p
	 BOYN9GhwzPBP9WjVj0ikJBhgpKR1rYbeeWH833B/P8xrky4r9uMvnYUnO66lBLNDO/
	 VvP6BxVXNK1gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 166/238] drm/tidss: Fix initial plane zpos values
Date: Sun, 24 Mar 2024 19:39:14 -0400
Message-ID: <20240324234027.1354210-167-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 43e72d0b2d84d..e2ebd5fdc1138 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -202,7 +202,7 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
 
 	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
 
-	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
+	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
 				       num_planes - 1);
 
 	ret = drm_plane_create_color_properties(&tplane->plane,
-- 
2.43.0


