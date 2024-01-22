Return-Path: <linux-kernel+bounces-33701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB92A836D77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEE21C26DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E17745D9;
	Mon, 22 Jan 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GiDxdmtZ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B71745C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941163; cv=none; b=LpZWHu6kBI3xf+lCvT2giNNYqhWMXYiKSsKeJkLHHLBx6zNgRdrKOH+sxSePqEKqMqRTxGY5wBXzA3vMwrH19EBmEjUu4dybABPz6C77nlkEICGWUcJgQoOSRw5cvJWdU7557AQTzyMjm3FkzsZ9qxWlAK1w1+fRZdY9zEJlckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941163; c=relaxed/simple;
	bh=EhA7OK9iZuqJaQHTfYEIMHbkg7XW9r6FQHon4CJYBn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQV31NrfwPDSPm9gWEg8Amie78fbWHTvf3DcwI8rByvwvaHfX82Co9HB+yP5lWgPKZWAw+Umihu3In+3SqmGKAbEoeGXc4r2H3hxZ8+p6ZM96hPKw33Naq0oOU5U+lX7681Y7M72E2guhwGFqXTm88LQikvHLoWpG68obodL5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GiDxdmtZ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705941160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odkYqjzTWVuL5bWOI6DRA1l4DPeGSEAeS9hiMNWXJJ8=;
	b=GiDxdmtZc1x5dCXVgT4BFw0UWGv7oQkINHwu127uWmaaETnWhpHHIo/Eptolf70gx4Q5RO
	LKYUO4oHXqhhIEyDvp5Ob2qSK31ThTj/vkp/36T1hretTg9MPqV44tjB4m+J3+kuQnO90l
	/rbZEF7Yv5M4j9YPHUN4tOY5tj0RrlY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 4/5] drm/bridge: display-connector: Extend match support for non-DT based systems
Date: Tue, 23 Jan 2024 00:32:19 +0800
Message-Id: <20240122163220.110788-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240122163220.110788-1-sui.jingfeng@linux.dev>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On which case the driver is not probed by OF, Instead, a fwnode is
associated to the platform device before this driver is probed. The newly
added code is intended to be used on non-DT environment. It is assumed
that there is a string fwnode property associated with the platform device,
the name of the string property is compatible, the value of the string
property is used to get platform match data.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/display-connector.c | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 08bd5695ddae..eb7e194e7735 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -202,6 +202,24 @@ static int display_connector_get_supply(struct platform_device *pdev,
 	return PTR_ERR_OR_ZERO(conn->supply);
 }
 
+static const void *display_connector_get_match_data(const struct device *dev)
+{
+	const struct of_device_id *matches = dev->driver->of_match_table;
+
+	/* Try to get the match data by software node */
+	while (matches) {
+		if (!matches->compatible[0])
+			break;
+
+		if (device_is_compatible(dev, matches->compatible))
+			return matches->data;
+
+		matches++;
+	}
+
+	return NULL;
+}
+
 static int display_connector_probe(struct platform_device *pdev)
 {
 	struct display_connector *conn;
@@ -215,7 +233,10 @@ static int display_connector_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, conn);
 
-	type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (pdev->dev.of_node)
+		type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	else
+		type = (uintptr_t)display_connector_get_match_data(&pdev->dev);
 
 	/* Get the exact connector type. */
 	switch (type) {
@@ -434,3 +455,4 @@ module_platform_driver(display_connector_driver);
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_DESCRIPTION("Display connector driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:display-connector");
-- 
2.25.1


