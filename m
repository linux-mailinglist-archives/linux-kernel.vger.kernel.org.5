Return-Path: <linux-kernel+bounces-115454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB2889BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94DD1C32CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5E2197B6;
	Mon, 25 Mar 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orqM0RQ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68A1E587C;
	Sun, 24 Mar 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320834; cv=none; b=oq1qP7kHNvNrmxuyc2aoHF2GrBvdEXwQ4YK6dlME3Ep05blqMkx2KYmhHlFHlfCTUN1EUHdJ5fH3ZvVyNe7jun0bC6wxY0+KkCMKQitomLdrziSBShnE9VwDBxV84UV9UbsWkANCf0WR4B6GjsO3aWmcEvMeuw1+H91bgSbbdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320834; c=relaxed/simple;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpYP/qxKw4ZSPxKcnXNUc0zOA6H1GPVxj+3GBYluqplEuU315Fq4QUiCsrFOdfYdRnZ3nU2PBoEOiLHZRN5lV5VH0XZA5vCAVInw9ifPAZeRkmoGqf+wzKsoCIdey3LacIdzAlFx7pyBaklxMjPUCeYPyOcHxVr+jQKKmfoOrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orqM0RQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386C4C433A6;
	Sun, 24 Mar 2024 22:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320833;
	bh=qgWoNH854Qu3UszLlD0IS5mUljLWw9/aZEUoPzuQfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orqM0RQ0MIbu+9hWp/PTOIlq2C0aWr0tecQ+I/I6st74AszDtA4Nipz96d/C4NdEq
	 pqaCTbzttctLrzy6orEoPFqhiWTmxK+QGgrQjAhv5s2pws23H2dWKYuMaPYJkLesuN
	 ueUOo9A43aR6QUwaXAgMXhCNtHUJjuXaOEMiGVRZ4Gi79z++4kiVGuqcHwn6E2rezE
	 WQQCt/670yNmTuo6z9lPY0GcxjThdKB8L9fDHJWjl2ymfu7brCMq83tjy5GNuApPLo
	 YnIrapHeCVZ9pI4OlWRkhg0G4sx0PqhTYUDPKO/5jhB3OR+VGzs5ptTPdjPtMtZA8X
	 LvA4d5UpzBUZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 398/713] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 18:42:04 -0400
Message-ID: <20240324224720.1345309-399-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


