Return-Path: <linux-kernel+bounces-153908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01F8AD4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBCF1F23011
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94D1553B2;
	Mon, 22 Apr 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USB05btD"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606D155725
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813584; cv=none; b=pZskyYq2epKkrGC5VnbzrLwom/E6cgXsY4jP4BMdvbSBUHKpjFxC/OEyKt3wuQWvc/RuMT5uPQPFFCfCwZ1edK4yLSoYhDw0aiUgvclUGF3/+/uybp7ps9IpiiPf1VjFVez/OXFuLEOPNGrR9uznqhp3Md8ZehJLj/RE6DKYDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813584; c=relaxed/simple;
	bh=yaLTN1bI0geP0UCxwHgulhuB6FKX9px1dQExhoKkdro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qsf3H7SoY5mSb1VDiHwam11xKeokGsnc26g2YmQlKeaWwXgiQqToOObosW7ikIbBmPIRQoRujmd4H9jvDcUOqwxwxTX7JO8p+Y6PHlSmQgolXQWKqO2zZFbfnJ/sM5I7jLXRPulgaV4fHDS7K7HupdGNJTfRTJ6HdfilxqVrZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USB05btD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713813580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHcHgLztm1MbyZtiaxxPtZqiLu7TluHYcwMGaSWtFjQ=;
	b=USB05btDDzI8uOyGmlMplJpq7Qmq3rVj99yphIeUU4pwVOum6BMSyvHrPInoXDYhlLXHJz
	9OZRRJHKSnaxeBjiPsIV66BvlpCc4STHECvUy+3tMtflXPtrIPHHpOsDHkpTRWKb5ZT6h+
	uwyFbmzadGv5inQLcdNPsZrd3yIeJvw=
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
Subject: [PATCH v4 5/9] drm/bridge: display-connector: Add platform module alias
Date: Tue, 23 Apr 2024 03:18:59 +0800
Message-Id: <20240422191903.255642-6-sui.jingfeng@linux.dev>
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
 drivers/gpu/drm/bridge/display-connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index d80cb7bc59e6..7d9b4edf4025 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -434,3 +434,4 @@ module_platform_driver(display_connector_driver);
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_DESCRIPTION("Display connector driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:display-connector");
-- 
2.34.1


