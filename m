Return-Path: <linux-kernel+bounces-116271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1908889DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230D72C3E06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC901327EE;
	Mon, 25 Mar 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHVU64IN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40767181811;
	Sun, 24 Mar 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324092; cv=none; b=tlB2CEtOhKbTzDbwJEbgozt1VZW4fiumPRKl6dmT+lAAscAf/TPSeE4qioZvzUwhGZfueArPlneBBkh8SVLTF8gtoKCc8YiPkLNXpcP8PJCqHroBPdJvDlvz1hzQG7LsKjhIJe9jRVoqVG8SrDBGabsFYsGAUK6eCT4cov28pSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324092; c=relaxed/simple;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt4e7WDyak0Le/LgmDS3dnG/3Vp/Z+tksAwqM+6loK9tWj75/r5RkqCx4sXSA5SsLvgb7SVfr/XXtNamQlwdttCvYRbtgLbIwZce1NSna+GU57goEmuP8gV+/cYWnvWPpGhCwPNz4P9pHcThkaofyiN0JiiZ1FoIAVoNBgeNgq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHVU64IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BFEC43394;
	Sun, 24 Mar 2024 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324092;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHVU64INu98LyPY9KAzFasqUatZEqQ70e4kY6XnDLDbIGkp85V6ziraUbTbfLLOdE
	 VZIFFZMskGpPMQJsdn5v/ifYNE6hA8TmIgFRjINezP3X83L6UO2WhWbjFQUHhQlxry
	 C4Ydm7dDAfhv2eSioM2rKOV0ifJxsL1u7nKZXha+gQHoQFsbx9ntcq47THXLBHwnuK
	 U1myQGRJfmiPhPL2dAHtAn2nboqNrWPsTmTuhcjpz/dBFTvZ9Z7HtNifbkWnNh2Dzo
	 0CJOGX02V5fUh/xq9a5gpVdGSiWe+A2kx4lW1jsGUlWSOqiHFBSlaoTnI+Hn70mBmv
	 gEJQBS28zd2sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/183] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 19:45:05 -0400
Message-ID: <20240324234638.1355609-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 553210c02ee0f..627efa56e59fb 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -88,7 +88,7 @@ static inline int drm_fixp2int(s64 a)
 
 static inline int drm_fixp2int_ceil(s64 a)
 {
-	if (a > 0)
+	if (a >= 0)
 		return drm_fixp2int(a + DRM_FIXED_ALMOST_ONE);
 	else
 		return drm_fixp2int(a - DRM_FIXED_ALMOST_ONE);
-- 
2.43.0


