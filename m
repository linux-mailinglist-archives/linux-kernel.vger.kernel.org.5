Return-Path: <linux-kernel+bounces-115212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBC889358
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367331F2F83C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34B1CBDE2;
	Mon, 25 Mar 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJfrUx2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1E1327E4;
	Sun, 24 Mar 2024 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324299; cv=none; b=CXsET9mSlDNvGrqkFAtLcLqAGaX7KoDSSCJUxJQlU0EjD9xQupDNoFmdx05ZoF0qV3xJq/KWCveSg6nH9gXD0l0XSlEFs80oQCwCGWHvHEQ+sotwM5qXwQADPdJsNVuk2A6D2plMjW8Et9JBbGNa/NtXP/pQlSAK5NKQA/X6IVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324299; c=relaxed/simple;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHAbUBpm9P9Ui00eolt4XS6RtLh5sKDN1Pnl3zpMkibCEc6zi3HQb/WRSpZduqvUyWc70IgHZcLRUoRAUiuZzpIZdUM6TYWmPv2LgYb/jvG6yM61fZz2hGDkQx/6v3PS7TZscL0IAXXmFbgkyj2GzjoRvwO7Gjj6QbuD1LsFlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJfrUx2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971DAC43394;
	Sun, 24 Mar 2024 23:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324298;
	bh=gbU2EowSPlHE2x6WXeXSsOfbfUQE1IU/R3YYLu6N2co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJfrUx2OXY0uZ6N15hprJsheyIFX+cBtrhw1RlQsfHPqPWL37uNuYJPWWzQYMTk0c
	 Sc9bzffMlLH00EDngAaFSbGtDQ4sD2EkyfthDWl/UciLAw5XZZwWnJwVMBGsQ6lH4R
	 1Ed3Ef6MhBypfdOA29a18klLsC+/2MgrPllW+zjJbTPUmN+y3K1cphM92Q5iMZqLu+
	 oxzejZ0LFJQG2Al4e0cwyk6ssv6ICDBMZhrzopRg1rTbo/MtdFpr3HD1g2YJS509Kj
	 jk+AI/uOwUr+aLlrYRpNKusaLXWnUeLVOk/wz/hjBxVU83XcmQaZ9ggFJ3C7DqA2v+
	 FdIRxxkGqpwuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/148] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 19:48:56 -0400
Message-ID: <20240324235012.1356413-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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


