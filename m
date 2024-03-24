Return-Path: <linux-kernel+bounces-114823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B51A889192
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51AC1F2D993
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE611B9DDC;
	Mon, 25 Mar 2024 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/mbvzzO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15992176FB0;
	Sun, 24 Mar 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323463; cv=none; b=RY/kpENVrrKueUE38Qi5G7PHvrCpsxzt1NeNSfKfgQDPDQVZlhDrMcbyBV3HQKDd/QjIEhUAYJP71DfFtf+y3SZd6qyxA8BCAMzV7Bg5gSIl9WE5RVwqMe0ecelNAovGs2XaMdGSOWqRHlD+8iZbG+V+WVeMNwV+0an7AIMKOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323463; c=relaxed/simple;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jcs45uDcSWUFQs5Tx+1Dip9YatQmKH5GXJAENkuR9u5HR0dcSXkSseNV+MuVgdASLBUqiAME4+6bdxE5w9Cz6d+HxL1U1I1ByjK7vM1zNp6FWryp0ZwdXtz23L8pUSd8U0pPG5ukCyPofwil6Mx9xKY4jZgLHUVJVSUT2SfYYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/mbvzzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F9C433B1;
	Sun, 24 Mar 2024 23:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323463;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/mbvzzO6kOSebJ/DCs8IegFo73/nheH6MEBf6AyOG66TFhuEs9fNVwhqRDVQz9S7
	 U6TFhmryoDF7SLJ/qJleMFEbH4YjqUIGhX4+bdPyy3v7quZUMxxjzTMGEomw4rYBED
	 Xyj4zZ41G6KI1Wb2H4VE/P7XsFiR8krpYRfIC858io1QxmLHDO3gO4X7vgsr28pHmc
	 4ZJrIm/HGnRspx7nbSHXXvD0H6ugB/jKYmXLs572rbl4X2zPcQguJRBqqHeAaNj8M4
	 YQNbSAhkUDL4fTGNVJh6qdn3zkzu8hZ0b2FM+YQlKqsGW4ghsOTX5VUz+aHcQbDUKB
	 azU03rqdIVbAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 167/317] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 19:32:27 -0400
Message-ID: <20240324233458.1352854-168-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


