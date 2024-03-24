Return-Path: <linux-kernel+bounces-115685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BA8894DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E50B22164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C920C045;
	Mon, 25 Mar 2024 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7jPkEa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAE20C02E;
	Sun, 24 Mar 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321623; cv=none; b=K8UjYCSUINhZ1EhtGVrZDR4mTC0kf8iOYKstQdeoKfydIFlLKtsVk++9z1K0huLHCtX7PWntFPfwrmeDWLlngTDSbaM0fHlKQR/H9ezZNW1zNcfqsWWumHdLpYCH0VtA2uCjmaU/1lWuaVxkwdHsBvFDqupKe9x0AcGivSZjpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321623; c=relaxed/simple;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKIV+uDwGa0MzNBwX1vGREAIyGEkmrTCJMg3plcnEU8As8VYYY1f22ThgB4IknDaRNosywdGyPhz1R5wkZJRIItLV+SFiX9NzTMAHprJHHSUXhp3eUbHAguTEdVyJKRiD+wGhtYm1gNuxuS20btVKcgykoQgYFWdzTuvKiZ7KtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7jPkEa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F4FC433F1;
	Sun, 24 Mar 2024 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321621;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7jPkEa9qwpqtNtAkVgWkiNwT9bupJTwYd6XBWEiN/LxUXAgOPIg2zhqfOV09ysDx
	 V2xDTfMPHlBgtnImyf4Dj6b+r0p0A3iWP/iYBroZPxsR806vSCTJJg9dYNTJ38901Z
	 +KB73lcEzT6RoaZSGMDOnqUBaJ6YY+e3eJ8ICQzpdA6rcVH9djpkq8H1C3W/NirnAS
	 hrA1A9KMCTVTMyal5S+wmoqxpR84AYCuTVSeBWR4mUp7WCYFzdvFeJYFlqroaK/oZD
	 KPRUH7wtWIGczcaZNpcOlSlN7hU+HNpCYJuyP/mI/jmm3n62y6mA3pTbgw7quUGPph
	 83fj9rGAMUWNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 352/638] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 18:56:29 -0400
Message-ID: <20240324230116.1348576-353-sashal@kernel.org>
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

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit cf8837d7204481026335461629b84ac7f4538fa5 ]

Unit testing this in VKMS shows that passing 0 into
this function returns -1, which is highly counter-
intuitive. Fix it by checking whether the input is
>= 0 instead of > 0.

Fixes: 64566b5e767f ("drm: Add drm_fixp_from_fraction and drm_fixp2int_ceil")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231108163647.106853-2-harry.wentland@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_fixed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 6ea339d5de088..0c9f917a4d4be 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -95,7 +95,7 @@ static inline int drm_fixp2int_round(s64 a)
 
 static inline int drm_fixp2int_ceil(s64 a)
 {
-	if (a > 0)
+	if (a >= 0)
 		return drm_fixp2int(a + DRM_FIXED_ALMOST_ONE);
 	else
 		return drm_fixp2int(a - DRM_FIXED_ALMOST_ONE);
-- 
2.43.0


