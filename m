Return-Path: <linux-kernel+bounces-114453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D49889127
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18F4B290DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A012811A1;
	Sun, 24 Mar 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igZi3Vbv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76721FA0C;
	Sun, 24 Mar 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321878; cv=none; b=mRJVzjIGdk/nrV/WzlHmNIyx67O77AKoOMGHhHX5CE3MhTIQkby3dcv+G+e6afh60c6OMfQ2joAlghVzGmtbCoKnEUpFNHbTO7bg1ETD8xDjlmWSgLEwxHozE1Q/OrQl7s+Bkn6QU0/1tSuNep/xh7f/2+WV/dpW3C5q7QvMWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321878; c=relaxed/simple;
	bh=oPWSx8SdfdjsEVzy+Z5jo84gY+npncO8mSnmQcUnbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0Cmy8r1cp893H/kzon0bimsMLit47so9AnzFHTopwPM+z2rMGe/UM55omH9ZDVoIMFcFkwE9XI3FGhv7TsKFTeofPhuxI+qEwMeZ0i5gwI+CmJzP0+ngcz99bHYBZXmntG4Mog026vzHtAQ71rSsq23x13npWcKsRynM8bR3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igZi3Vbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF9BC43399;
	Sun, 24 Mar 2024 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321877;
	bh=oPWSx8SdfdjsEVzy+Z5jo84gY+npncO8mSnmQcUnbCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igZi3VbvPFvVyryv02QuESkVIJHDEB82jWs+jrrTcNa9Fiqtk0XGiZmI5kfoDm7rb
	 bcvESnAX8kOjh/CRat9Mlrjsh7XoGRZbn+zyfLJ8o404/XhxHGcYirc3UvfSRsqwJ/
	 Sm44YEUIQTrj7d5BTKG5v8xD2VZA4eKOTD5tBxNdY++GB1i9yivOO8+drUDHfTlW2A
	 I+YQLRxpwxNyKNWRNgGIVwd6ja6uc+L2Fmh1dzWj4yvLx/jymTaX43zZ3fXCaTCa8V
	 o51zDXLSUqfUnEBbLWhqNPl5BMZv3M0+EMrk1oR9pFUSYvftLXCybp7kNEpcM0dlbG
	 Otg04tSkrXPtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arthur Grillo <arthurgrillo@riseup.net>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 605/638] drm: Fix drm_fixp2int_round() making it add 0.5
Date: Sun, 24 Mar 2024 19:00:42 -0400
Message-ID: <20240324230116.1348576-606-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arthur Grillo <arthurgrillo@riseup.net>

[ Upstream commit 807f96abdf14c80f534c78f2d854c2590963345c ]

As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
To round a number, you need to add 0.5 to the number and floor that,
drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.

[1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/

Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_fixed.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 0c9f917a4d4be..81572d32db0c2 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -71,7 +71,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
 }
 
 #define DRM_FIXED_POINT		32
-#define DRM_FIXED_POINT_HALF	16
 #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
 #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
 #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
@@ -90,7 +89,7 @@ static inline int drm_fixp2int(s64 a)
 
 static inline int drm_fixp2int_round(s64 a)
 {
-	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
+	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
 }
 
 static inline int drm_fixp2int_ceil(s64 a)
-- 
2.43.0


