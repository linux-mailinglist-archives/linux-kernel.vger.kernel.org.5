Return-Path: <linux-kernel+bounces-113250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD38882A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3387286606
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CEF1870A0;
	Sun, 24 Mar 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZQUWZLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A31869EA;
	Sun, 24 Mar 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320050; cv=none; b=U9hy9hl4e13IQB3gxG4c7OE8OmnrXK+Civ76Ovq1Zp6V6lCZfrLe5/P7MjI85MyFVE1m8wBWwqRsaw2h5aysfTfz6lZYMUrrP6phWreVHFhuwfqDzzcB8iU67p4iZoLL1/iDxoyoKXsWc5GF4GK9yCr+IULAwtf0eIMYowz6Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320050; c=relaxed/simple;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIFxVyx3xL1nTvYeBlQaCQSqO3c7NxGlNtVJNyzYYQPBegj43AHKSI+k6zh934dokfSI5GUtY0x/Ul+L3wiQOy4Ujz8fjvfg89gJxEIA6elnvcS2DMobdO+XzE72ThguRvnFRqaEZsmR3OQUau/ptiiDyN7uKo7uuirId/Kaiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZQUWZLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56518C43394;
	Sun, 24 Mar 2024 22:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320050;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZQUWZLl+MCtemuDY6dpidcM1VV4YWKWqLMDYDdck2/36OGY+Y2ZgZHP35PaMc8Wn
	 AheqCxGyDS0mLV/hys35fDSZGfcTRVRIyj/czzw+dy/Hqh3LlCU5MaWOQwr1gETqa9
	 3GjlQTFhSUCKxjftCiduIAF1wedsp8R2Yz3k9AGnY6xgZQnQ2BFk9NmdlyYvLbWH7K
	 U1pSvzKm3+1BP7HEaAmjO/KVCNkku8BJlWbYA0L8BMH1U+MgYUzFkBWlm2fSlkocZm
	 GSRGGSlAqGXXFyaesXyRoCU8e/H0idkQpBzjviTa6gkui6fNkh3B4d/KWQ10iN5g9I
	 kC3jwuqNhq/dQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 359/715] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 18:28:58 -0400
Message-ID: <20240324223455.1342824-360-sashal@kernel.org>
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


