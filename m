Return-Path: <linux-kernel+bounces-87260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4286D1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4131C2153B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9D13C9FB;
	Thu, 29 Feb 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgwLOh3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39779DC5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230448; cv=none; b=i6IZikntEePydTw0zZ5aDNNNYzjG4MqzOa8fd9KwrCwBuo36If47kxe3dSVGYyBW4opGTNsCkNs5u+4BbsMg5KeHjt6Yqt+xrhu2rQWNr+/z3KXJb7BMRxl5DyWP1Mjbx5Ft/BYyILZYc8F4dMUtBUojCZusIyIHv/CpwevPJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230448; c=relaxed/simple;
	bh=puQJBrcPK5Z3RCYzqNZihfMO0Tg5uf4iB/iw30xgVpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JXh5w3uJDUOKVWGsbTpC0i4uOb3Ur1I5OZVsJJxh8aGXl/0uH1YpLAbGDB/XGAcEAZqRXuPJCVh/yFCT6sJQFcZw/f480dOYJAhPgyD8YdLYMLTRmwjgexo3eoS7hnTCn0z4OoCvp94gdc9thzfGHf5VxN/HVtMreBRHRwL55w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgwLOh3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F53C433F1;
	Thu, 29 Feb 2024 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230447;
	bh=puQJBrcPK5Z3RCYzqNZihfMO0Tg5uf4iB/iw30xgVpg=;
	h=From:To:Cc:Subject:Date:From;
	b=IgwLOh3/lmwXC0mbjV854Af52B9itc20DwBDBtiL+ZCpBmeB/rhY7uPTW9t45066c
	 u760pkPWHfLKADi2HRS1Lm2VzYNXbbYQ5n2FK2cfgJpJMWgU4blPaYQWINfPCncMsg
	 RtOAAGd5AaIT8CAw7W9z8AEon1NtdPyptUww6kaibhwSpX2SPWIUC+etomWPM0q3bV
	 jyrdVowQI3n6qBOJAHnRM+HqyKMQ6vz9vBMOAlwFOseItcTwtMvcNgGksBvhOC4Azm
	 tdOJlS+CdFLB9eWTe1xRX41UPYh8oRiYFuwU6dd/LqTng83HNykivVnnEvdR2Ld27e
	 RaWr2REeoswMA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] drm/fsl-dcu: remove unnecessary NULL checks
Date: Thu, 29 Feb 2024 12:14:04 -0600
Message-Id: <20240229181404.352531-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The power management callbacks are never called unless .probe() has already
returned success, which means it has set drvdata to a non-NULL pointer, so
"dev" can never be NULL in the other callbacks.

Remove the unnecessary checks.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index ab6c0c6cd0e2..ca23a2ca16bb 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -170,9 +170,6 @@ static int fsl_dcu_drm_pm_suspend(struct device *dev)
 	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
 	int ret;
 
-	if (!fsl_dev)
-		return 0;
-
 	disable_irq(fsl_dev->irq);
 
 	ret = drm_mode_config_helper_suspend(fsl_dev->drm);
@@ -191,9 +188,6 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
 	int ret;
 
-	if (!fsl_dev)
-		return 0;
-
 	ret = clk_prepare_enable(fsl_dev->clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable dcu clk\n");
-- 
2.34.1


