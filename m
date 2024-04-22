Return-Path: <linux-kernel+bounces-153865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85328AD449
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6358D2857DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD4156C48;
	Mon, 22 Apr 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uM/UcWLK"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF856156962
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811580; cv=none; b=eb5hBZrGNoWqaJC2mTSNSzfwVMVdeCt0dTWb1IbQzG1EZ9avaxKm0R8Om3BhCSLrBhKVWKGfEUlgghsRG+x8CdtB5sR8TyN770hZrTl8TxUcuXCwiJKN3+zI4usx7yOHVs17uDx5OJlNcKJVfu/O+dmm9mPYB7e9MxWM+gjMSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811580; c=relaxed/simple;
	bh=Hzw5ZGP57CdMyUjqqbNpq8ChoCI4EWej6zxj4mtjxYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em4GyVIKE2nD5fgtjXgGpSsKeFexPeNI30zGvdRJ3NoqHtV7pcD/mMFMSl9W7DQfTniSGA7drmGu1O9mmNMrAsDiI8RA8lEVPqlKhgQGRbfCvGTv4xpA/eJK3NYsL2cLwR4rBvmEBjpx2Kjrc2YhSu08z5L9q00LuR3FWMxuYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uM/UcWLK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1nR5YnTg+vd9vnQmjFSkw7hgekdgnmkJ3Q9sUvBYxo=;
	b=uM/UcWLKSLwOJoeKCSubhVPlhhUklqGCpWeJcOHV1Eyxq9lKo2NN2ucuERtrOoWXL2Uqar
	+jiCZA4WNuIJuq5g1sOWlnb3H63ithT3nE2VCe58h8+ReJ7Par74d9GWPXW1hUj8lOVaXT
	4n2wNywLg1rcdRQcTO7l5t0zOxIWAjw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 09/13] drm: zynqmp_dp: Convert to a hard IRQ
Date: Mon, 22 Apr 2024 14:45:49 -0400
Message-Id: <20240422184553.3573009-10-sean.anderson@linux.dev>
In-Reply-To: <20240422184553.3573009-1-sean.anderson@linux.dev>
References: <20240422184553.3573009-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that all of the sleeping work is done outside of the IRQ, we can
convert it to a hard IRQ.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 8ad8db01f136..3ecfebf35a72 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1774,9 +1774,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	 * Now that the hardware is initialized and won't generate spurious
 	 * interrupts, request the IRQ.
 	 */
-	ret = devm_request_threaded_irq(dp->dev, dp->irq, NULL,
-					zynqmp_dp_irq_handler, IRQF_ONESHOT,
-					dev_name(dp->dev), dp);
+	ret = devm_request_irq(dp->dev, dp->irq, zynqmp_dp_irq_handler,
+			       IRQF_SHARED, dev_name(dp->dev), dp);
 	if (ret < 0)
 		goto err_phy_exit;
 
-- 
2.35.1.1320.gc452695387.dirty


