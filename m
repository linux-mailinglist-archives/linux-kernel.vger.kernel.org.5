Return-Path: <linux-kernel+bounces-136423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAFE89D3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9401C226B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE337E77B;
	Tue,  9 Apr 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TAT/PqQJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A47E11E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650466; cv=none; b=QRLlaZ3Y1Xt9jG3ZCgxIOu6j35xcL2GZ5H2WmAMo/dH4MclBXEftnQdj9+2WUhFtoyLooFdJxMxw9bNMTxcNSpD7m9cxgXLtap84S+ihQcqDN+kTJHdGJYSRrrI9AooeIeU4zZVQGeP9K7wXwuE/6aIlAC7WqW/yO4ZxxQBAQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650466; c=relaxed/simple;
	bh=z5AaZgRdCHKMFiwqPoJfl7Drtx40Uhi+HYFqiKBiDZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g79AKmnK0TJPBGU60H1yjRFnaQ28vHN/3L/Zqki4ljsKc9oyIwf6EDDkRl24Axq7ta3aPiLqvIf/KB9Ba3BUwY879cjqEiu09IWEgf/9yWnAxD8SlWTvid507/GmRffLnjh47nCgfa8+ILtkckj6MnBJn4GicaMWOf0tGDiG5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TAT/PqQJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712650462;
	bh=z5AaZgRdCHKMFiwqPoJfl7Drtx40Uhi+HYFqiKBiDZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAT/PqQJVMseLBdzIEdVoYbzVayfhEZ1XQ0s2DYOBN0z9ekIq1UEsHJ/hEyY9BWA/
	 BvfluflROD5gCqjZvtn7gOCI7ptVhmwadVg/YxsdvV6fB/v02AMQMTglXhRNMFTqTt
	 g1gt05UWsowgejj+Di3b8p/i96lJTNtqis+3Zz8lY/9E6UBb+VRVWVTFSL+cl9wjm/
	 Iz50LKFsoEDD7nNGKvLKKhYNHLvvBqts+hMrQ+nWeTsJZk7okiAWkL1LzFljYnUpCy
	 40fdeo0ZM734STDfndruUJbm9Sic3yRYat/g7NB/BQtNG4SLKhC0k7GhnmWhAskX1s
	 8gDkAZfsUgeGQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DA4D637820E2;
	Tue,  9 Apr 2024 08:14:18 +0000 (UTC)
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
Subject: [PATCH v6 1/8] drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
Date: Tue,  9 Apr 2024 13:43:22 +0530
Message-Id: <20240409081329.472463-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409081329.472463-1-vignesh.raman@collabora.com>
References: <20240409081329.472463-1-vignesh.raman@collabora.com>
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

v6:
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


