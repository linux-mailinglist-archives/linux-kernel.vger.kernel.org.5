Return-Path: <linux-kernel+bounces-93266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49792872D49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AEA28CC03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE281134B2;
	Wed,  6 Mar 2024 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1qXVWDIF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20B15AC4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694481; cv=none; b=lfA7s58l8sz050HplKvR9Pw7nsLY6SEQshYdSH+88qNpuW+VjiL56YdLJw5wsRlpygeKdGt0Tm+FZQjFQOwWePAwYaNVkG2Tbrwk/PuN8WnvsOnRPkfSKts4qUYpERZyp+QxJoq8EiIG2u+kFpCY/+WhlN0uPDU54jSmRXKK91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694481; c=relaxed/simple;
	bh=z7xJjE61GnyWSNcNF8ZFUk0qdTWAw1hMjcJXN6mVxsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTDqK0kQ/+n6p0yeH79pH0hiKzXCKKnPiBn9Y0gOBEQNnI+UnxEZbuWb4OU+CqCW4indLe6Tf7IUeh0p2V1gYqAq2P0LuNeQn0wR22SSB0/dSoRRJqKnUI9MJ/P1MSkPcqIUbz1QnX53ZOKUF5ZakY3JfSd14MW3D3biXUhGMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1qXVWDIF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709694477;
	bh=z7xJjE61GnyWSNcNF8ZFUk0qdTWAw1hMjcJXN6mVxsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1qXVWDIFRXArMYA5uaa0HzLEQSJOhpAC77xz8dvu6oxyhBgKQzdWPKJ36C9rrzck/
	 NMezOalMH9hTTLQ0rw9x80xKPeqtiLmXQ0uQ2JKRd0w0nlUToz3mXuqi7pIB7JGyT8
	 SLkt6mw0azWlp9j3+pM/IvqykI6oVp6Lg79JL9Wn0pplFoAoUMr/rMWkq0r1C++miA
	 wW5WpeHxmApNkflZPtMEr5TyfH6G5zzfij/QWEu+3592ygukGKozjgtFoIYfpUnZJ/
	 xcQxf72qrJ7ZzEjk/4JZjphkGfNwz0iPE2BXpUV8CoqbVPehDJQPkWEwRrBV9MJpDd
	 n21VAx2it+5pg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D39CD37820BB;
	Wed,  6 Mar 2024 03:07:53 +0000 (UTC)
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
Subject: [PATCH v4 01/11] drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
Date: Wed,  6 Mar 2024 08:36:39 +0530
Message-Id: <20240306030649.60269-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240306030649.60269-1-vignesh.raman@collabora.com>
References: <20240306030649.60269-1-vignesh.raman@collabora.com>
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


