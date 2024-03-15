Return-Path: <linux-kernel+bounces-104977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50487D730
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D15EB216F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D25A4CF;
	Fri, 15 Mar 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAY2rBh7"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AC5A0E7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544170; cv=none; b=LGvJ+faRbSWV4fRaS+P2Eh0o5wUSIg4AODCmX3l6CF0HPgx6mIOHOn9NBHDW2QrPtldW3ghLOcKLg2rS4ahB6Xv4xw5gNz4paRhbSzxJ9lwMIsVQLseOEOElW4+vLHtuj36KXqfL2kwMmUjNhT6mvGT6xj4wQWspneldhXse2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544170; c=relaxed/simple;
	bh=Xz/0F5R/GLzLFGe5pxtwwRD+d9yZLove/zXLT4RqBL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdPLzxnVAqcjeGImEehbWRZTACBibkmUo7VfOYww07dPpEkbLpwM1g0ssqHrJR9uNl1wmk/ZYahNuUe5HA7P7fC9pq/6za23kjtyseMMkeTUZTDHv53o6xt5m9TWwuTiI04dB8B+a4I9PMoO+2sxBOoUAmEfCvXNxSG6yApTSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAY2rBh7; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710544166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAv6BgPrVkJLTM1YeEBSiN+uJDM8AJZB5ind4wcr5C4=;
	b=TAY2rBh7RljPyU0M6WV4VflZz7f7ZAEpV5Yg+zeSFWnHVouccYUGUQYx9qmSi7wNzo2tg9
	HMsDJCqDm+5eyPLlFeBhprxgJZ+mdbTbGGC8EvWYHseTs3ws3b3HKXc1g5GdbfMRo7Fff5
	RIlR2ffhFmFQZHFqR3jnpkTdkeQVG70=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/6] drm: zynqmp_dp: Downgrade log level for aux retries message
Date: Fri, 15 Mar 2024 19:09:11 -0400
Message-Id: <20240315230916.1759060-2-sean.anderson@linux.dev>
In-Reply-To: <20240315230916.1759060-1-sean.anderson@linux.dev>
References: <20240315230916.1759060-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Enable this message for verbose debugging only as it is otherwise
printed after every AUX message, quickly filling the log buffer.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index a0606fab0e22..98a32e6a0459 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1006,7 +1006,7 @@ zynqmp_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 					       msg->buffer, msg->size,
 					       &msg->reply);
 		if (!ret) {
-			dev_dbg(dp->dev, "aux %d retries\n", i);
+			dev_vdbg(dp->dev, "aux %d retries\n", i);
 			return msg->size;
 		}
 
-- 
2.35.1.1320.gc452695387.dirty


