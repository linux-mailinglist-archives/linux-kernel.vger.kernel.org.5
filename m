Return-Path: <linux-kernel+bounces-126449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AA289383C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97351C20BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031DBE65;
	Mon,  1 Apr 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a7/Q6TFF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D929468
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952023; cv=none; b=Y9Zgcca1qzKrlm2ZbZYghReWpKyl1yG/SSIhl5AH0MrJ9DLladI33AoET0b3xrsngAm3bGtxhp2e98b3BjgmIgupQUVPC3CI2ia3tWzwT/qg+4k0IccxEr/FoufDD1wG89NXLffifUz2TvL9QJfAu1n5MkA0Zq5Zm/u6R4Tz0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952023; c=relaxed/simple;
	bh=MAvIq3nC95x+6aB1wCFQkntVt7j3whrUWvyISXnybso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7YFd/5rFnnFOC3i2V/uqfi1KGvOBFauD3bKXF7wVeWHB1G+suQ+B9haIxSCuS3331tZQcSP4E1HhhxxdpgOZDP43HSNFWruzOQGqvIK9XftVbWj9jnkojMIqYfg6u2SsEGBME4SpdHxYGiMEL14XMKJi2+PO9qRpNVL0F5LI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a7/Q6TFF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711952014;
	bh=MAvIq3nC95x+6aB1wCFQkntVt7j3whrUWvyISXnybso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7/Q6TFFobsflBAgBrH2YxsBhKvBeO1hZiziKWGL5ouG3+hqBixhaW4Tjl8ZIwzhZ
	 EPz2Na/GcAFkn4q0ksbHW2wD8VV1S7uoxkcQdqTgPwzl8D0n4V8d2xQQe+mCjvjxjK
	 jfiFI8l+3EYJ7Hizp/jcA6MCyhY00zPLN34dNC3z2WDu4twL8Xq5mtDaGW/54qtxVr
	 Ec6qeXr+bAeysl9CcTweel6tDGadG3g7ItCTyda9A4lCRcdbiSAtjmYWjeiTAAjC+9
	 OSHYxukoKNRBjs8tNBvZoGSevqWvQ2oqXYPlRe+mR/hyK+n+cZIw2qiDHRrdMYgamg
	 OrUo/Jf50rqOw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 174AB37813B6;
	Mon,  1 Apr 2024 06:13:29 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	emma@anholt.net,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	mairacanal@riseup.net,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/10] drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
Date: Mon,  1 Apr 2024 11:42:26 +0530
Message-Id: <20240401061235.192713-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240401061235.192713-1-vignesh.raman@collabora.com>
References: <20240401061235.192713-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CONFIG_DRM_ANALOGIX_ANX7625 in the arm64 defconfig to get
display driver probed on the mt8183-kukui-jacuzzi-juniper machine.

arch/arm64/configs/defconfig has CONFIG_DRM_ANALOGIX_ANX7625=m,
but drm-ci don't have initrd with modules, so add
CONFIG_DRM_ANALOGIX_ANX7625=y in CI arm64 config.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - No changes

v4:
  - No changes

v5:
  - No changes

---
 drivers/gpu/drm/ci/arm64.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 8dbce9919a57..37d23fd7a367 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -187,6 +187,7 @@ CONFIG_MTK_DEVAPC=y
 CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
 CONFIG_REGULATOR_DA9211=y
+CONFIG_DRM_ANALOGIX_ANX7625=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.40.1


