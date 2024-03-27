Return-Path: <linux-kernel+bounces-121756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BD88ED94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365C8B295C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71EE152520;
	Wed, 27 Mar 2024 17:48:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD914F11D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561738; cv=none; b=DgP5IXbsZNN5xfWYZhVWfXdIDuP9PltYWzREyR/6zEGyQ5+RYpBDHSyPlDyJsoVr/o47Zvx8clGL7z3FYnwLbIDUMHOUvb6X5slR0Wn3GqgKF5GCqfw9YNhSomYSfjhwAK5pNioW0+eSe3JptAA0N0rLRxAcHjoXzuWxf1FQt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561738; c=relaxed/simple;
	bh=YFf/7Rpc+zlgpxoEylYlvLliSnn9dPWEDvyROt541AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSc7lBtBCs6UohIBiccHxKf1vgNKN0VlaAr5IiAP+WeJ4XnHzymsoe6r4qSuPobvVcqYG+fx+v0cQpplAZOV1TtIoKWcIW/VKVY3QrXWePvC2FCbxykCuFA66KOd1GoXa8iaMkR7esuJqBgynX0B8V/GhHlxBCc/Z42lT06+9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12431C43394;
	Wed, 27 Mar 2024 17:48:54 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: David Lechner <david@lechnology.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] drm/tiny: panel-mipi-dbi: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:41 +0100
Message-Id: <20240327174842.519758-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
References: <20240327174842.519758-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index f80a141fcf36..a3cc09c578c5 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -384,7 +384,6 @@ MODULE_DEVICE_TABLE(spi, panel_mipi_dbi_spi_id);
 static struct spi_driver panel_mipi_dbi_spi_driver = {
 	.driver = {
 		.name = "panel-mipi-dbi-spi",
-		.owner = THIS_MODULE,
 		.of_match_table = panel_mipi_dbi_spi_of_match,
 		.pm = &panel_mipi_dbi_pm_ops,
 	},
-- 
2.34.1


