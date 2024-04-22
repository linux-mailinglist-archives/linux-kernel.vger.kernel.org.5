Return-Path: <linux-kernel+bounces-153906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AB8AD4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCAEB23B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A32155382;
	Mon, 22 Apr 2024 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uoxEaumF"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C03155395
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813574; cv=none; b=r/QJMN3rzka9NPvSFAtbN9Xw8HYA4RUyoybYbBSStG7UxOfMHKDR0mda581yF38jhtgOMXRUWj0AAt/5mA/4BUzrG4RYi1XWqzN/NhK1Wl2IZ2raMpltVaAnakRV57lFDuOu/OvCabT3puxqzjgTocVJDnfL/687vbBH7oHkzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813574; c=relaxed/simple;
	bh=yzB8risQ/c2CdJHlV9ORRQanzsD3FP1orhVnEsX23KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osOWBULMmDivHIhZoyPPmGqZbmGrhZ7hGRDZqYC9fPp9iLw2xHMeo0gHi+VWP8HDSAhXbIbK/R76NIFn+1BTm0zNgFOk5b0EhOTZFwywSmJ8EdPDKteXnB8YeXlh6ggYPD6SwlA34D4eYBhIk92ycERLP83glQkRABw9SjGuYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uoxEaumF; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVIjTXds8eAkXzXoUlZ7BHHYR9mhqmmL/UDbaTDw7XI=;
	b=uoxEaumF/2nv/SOlGcXl4HGPyt5m0zJ7fAzEyUdXrcnr3k+soWy5zu/95/2dmr8Dm/6anR
	KDkV9SReY+dBQQI6B8YN96/1Jm1/WKbDg5vvdtEQYmjshBYB3/NMy8iagwACPrg9m0wL0X
	1LXBQDKD5DebOp5nGttO/oPiQUV6Guk=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Phong LE <ple@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v4 3/9] drm/bridge: simple-bridge: Add platform module alias
Date: Tue, 23 Apr 2024 03:18:57 +0800
Message-Id: <20240422191903.255642-4-sui.jingfeng@linux.dev>
In-Reply-To: <20240422191903.255642-1-sui.jingfeng@linux.dev>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Otherwise when compiled as module, this driver will not be probed on
non-DT environment. This is a fundamential step to make this driver
truely OF-independent.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3b09bdd5ad4d..6be271d1394b 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -308,3 +308,4 @@ module_platform_driver(simple_bridge_driver);
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Simple DRM bridge driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:simple-bridge");
-- 
2.34.1


