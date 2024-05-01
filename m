Return-Path: <linux-kernel+bounces-164937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EB8B853E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A19328437F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6D433D4;
	Wed,  1 May 2024 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4LlReB3"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C91D68F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714540420; cv=none; b=fpl0I2pwiscKU4JQoJs0YO8DI3bE3IMq7TS2xzMol6QD30U1RGsQQqZJTglkTJqV1aSPbIqN+iaUVPLwq9K3hQBJIZqEPRjW67D3UYj+rBJhX8b1L+g6LLhfU67rDLPBgiCIZR8DpJhS49DGQsbOyxY4X0eW9dqIZw1TvG4Pc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714540420; c=relaxed/simple;
	bh=IyHptUUohnW3r093RcnjlP6XPm56w94Pwp2frUOijAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c23mKpyCiyxzyzl+w+5zmJdkcMH40vuMMSjjwv4khUsDY71D2XL0DLwhdjSLyzBacmiBDxNksjANSeDEoPcKXY82PGgQXYUVE9bYGdndOL7jkZIbEcHCKFjx9zQNI1ahy74ugGRz/m5+DZLkicLRCVNrkHjmc/DwVq5e4DXyFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4LlReB3; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714540415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=05WNzqmqLv1QKE4Y/P8AHkj3HrmEQHj1mc/aw/CiANo=;
	b=P4LlReB3hNgroqsQTv26mFyfidd8iGuH/1AmYn2a2a+9/AAjaNSHIv/1eduVEhv/qT0Mu1
	CmWzSBBOMzrQUlXyqtVDQ5eRxj2xmPevcqmh4supYL87m1NFulRvWkIt6O04idgr4BDPuV
	o+itTgVj/XYKtPLs0TlKOIi3TnzUFOU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Doug Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] drm/debugfs: Drop conditionals around of_node pointers
Date: Wed,  1 May 2024 13:13:23 +0800
Message-Id: <20240501051323.805076-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Having conditional around the of_node pointer of the drm_bridge structure
is not necessary anymore, since drm_bridge structure always has the of_node
member since the commit d8dfccde2709 ("drm/bridge: Drop conditionals around
of_node pointers").

So drop the conditional, please also note that this patch is following the
convention used by driver core, see commit c9e358dfc4a8 ("driver-core:
remove conditionals around devicetree pointers").

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
v2: Update commit message
---
 drivers/gpu/drm/drm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 08fcefd804bc..28a471fe4bc8 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -597,10 +597,10 @@ static int bridges_show(struct seq_file *m, void *data)
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
-#ifdef CONFIG_OF
+
 		if (bridge->of_node)
 			drm_printf(&p, "\tOF: %pOFfc\n", bridge->of_node);
-#endif
+
 		drm_printf(&p, "\tops: [0x%x]", bridge->ops);
 		if (bridge->ops & DRM_BRIDGE_OP_DETECT)
 			drm_puts(&p, " detect");
-- 
2.34.1


