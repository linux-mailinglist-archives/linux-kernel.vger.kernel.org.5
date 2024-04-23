Return-Path: <linux-kernel+bounces-155658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B58AF548
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B73C1C222A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064A1422B8;
	Tue, 23 Apr 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gy/9e8cd"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420C14198A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892771; cv=none; b=eENYB8qBvbBiHpbezInWfKE6Rtd0VfywGe0gkK7rOzLtKXoYfS2sLBi7cri9ROtQy25wZangF8TGx0mCDvkYnMAtpNM72KrWdtXpt8YLACdZsYTardBk1XbtHdmAmoxgUnCkMM0A5PIz8pbSQCbYCaUWdFK35QwfT65a7redxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892771; c=relaxed/simple;
	bh=5oREvWUddGV660IzRNgHWrO9LZBQ6w1msMTk3Sx82u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZGzaV+JVAeiYhotK6dff3nv4c+Coyt0UgLvvFoXMofiwrfiNKXA1n3jla25dVjbvjeKp3O2WEbMxOtpjKZpMQpmQ0exbujznuhr8w3CzpXccY63HsgXFNENfinEsqWLT48JfinjOWYwPh5QYMJFgGwyvbznFGlV8IBk1eolBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gy/9e8cd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713892768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzn5Umez7NxCZ2bkVnMudoYDwe+Vkq0l/h8/KHMEmjY=;
	b=Gy/9e8cdfldTj98r6jA6kfvtkV+lRw6bUrO+vzaBMJ2MbBGUDtgvr5yP4pacZL7QB8BtJ3
	kj5mgyziaFkRiDoEzUArn9MQ49uQweJu3nxRyxu5h/vKmF8OhqDbFdln6aboqxkq7hXggz
	3WCFmaH5Z25GNivn141cINVzGn5i8uQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 09/13] drm: zynqmp_dp: Convert to a hard IRQ
Date: Tue, 23 Apr 2024 13:18:55 -0400
Message-Id: <20240423171859.3953024-10-sean.anderson@linux.dev>
In-Reply-To: <20240423171859.3953024-1-sean.anderson@linux.dev>
References: <20240423171859.3953024-1-sean.anderson@linux.dev>
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

(no changes since v3)

Changes in v3:
- New

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 26034672964a..9d61b6b8f2d4 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1786,9 +1786,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
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


