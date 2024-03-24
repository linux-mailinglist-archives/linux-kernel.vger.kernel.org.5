Return-Path: <linux-kernel+bounces-114975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D482C888C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741121F29093
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C22E0128;
	Mon, 25 Mar 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCT9kuaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425B15689D;
	Sun, 24 Mar 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323745; cv=none; b=YGXBZ8cOwtuJgnvjaFfVHZzYmhnW/i+p8rV+R2BXs3JaPF+FSCT30qjcmIfeNk2q9Ren3QWJcrf6rhRsDpip6df/NEXqc2+jaq3F3z5nHI9zFtquYIm2hNUv/+YX1ftSL1jtAlNE6wdqAdJ8AYEBmyMdicVEERG92lA2ZRGpAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323745; c=relaxed/simple;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPpdbLQou+WsfpCq1juX4ZPmteGPEGmBuz25emy7QWBm1J02YuZxn7ivMOUgvqKPxA1m/97f+nhIiqlBDa5ZHfdhkzEdvh8W+EkeNTcAPX3HlnPCFCAEZQ454yYVX+ChEuCVYmN/nWeWGUdCQ1L28YSjoLxzsohyB5VxqW/lfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCT9kuaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40E6C43390;
	Sun, 24 Mar 2024 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323744;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCT9kuaH0zaxfnhYMDw4HEBk1ilFHGUEL4UzQD2NglkcttBRnOz+JThqYNNY6jhX8
	 OgpKa/z1gb2fmZokyJeVCEwbB1sCNfMOOw+vx5cNMZ2wwYVd+4b5HaOs7Jn//l6c2R
	 ysL+nBo7bTBb7ZzkNeEGtoGCVZAvwQOViQixxKqOK6hdp6WUtSy5hD1lQBf8gL4rSD
	 7ekyHa3O1LL9s2UKIY6pjb0vOBouIRQZTH3CzVJ7VmtSJl02B5hNrwt9Zf4dqZYut6
	 8dbE6lXPO2aIgco2tgbTHIoM6sS5ZsPoxZ9UyPOUJkKzxobhRCeg6drErPrhijwcfg
	 G2B39iBFFI9Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 119/238] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 19:38:27 -0400
Message-ID: <20240324234027.1354210-120-sashal@kernel.org>
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


