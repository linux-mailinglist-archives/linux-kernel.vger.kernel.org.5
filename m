Return-Path: <linux-kernel+bounces-138555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325B89F34C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4A1C24B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380A15B562;
	Wed, 10 Apr 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR0qcMun"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956415AAAE;
	Wed, 10 Apr 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754138; cv=none; b=i6nIgoVuVo6Igcmixi781sg4eBL8r78qrMr5ZMl+HOHt9TifmxmRU7dWgaZy7lhfHujxNwJSr/z1RYUWoFoIDO1GNcFgLCYpklLUXwq5npDoLOqn+8RJPPTxqdxpce93TQmbFDaNryDxtFa5Yu359i6WOM28y1/aB5S61dfixHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754138; c=relaxed/simple;
	bh=cCynkWA1egzt6idfM5NgSo+yPlJqqy2bQBgW20A3KJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pneMNC6caUhpEoKaX8rOYdw6LHoR/Bp3zQTO87eWicoUQFGmJuj5fUo1E90si5C9/mRwX1TwhJI5XDXP3I0MWIKLZ9fHqqO100cwjRe6BZOXiyO9naGHy8Qv1mbqV5iuI9AVy1xG0bcroYjKpF1J1pI90b1sqknFhWWFsHtsxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR0qcMun; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3ff14f249so24483855ad.1;
        Wed, 10 Apr 2024 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712754135; x=1713358935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfEkXHqcrSslp75yT8Es7LWtgthY82aZjWT+8xGzxlw=;
        b=OR0qcMunOhpxHttX5FqWnjaI2a29LdlvUEDXhRhZbOI3lL8UX9CeIawKcF2qmRL2XM
         xKNIaVpXwxLredZCE5H1PedzVAvVlhaxeJEOxp7gv9nSGSRdTrui3ZDDvwXO4FyIFs9K
         K/vIBiuiGGNbETuM6lFWHQoDlZTEaJ8TeG0jcHjyXtJaFH+Fuz2TssHhFW41EiHwYOBF
         Ce/peJYimi+YXvmHtRUN/J4mI6YUM7UMyku4uyE3nbfgOaEwzQH/fxK/5Nz3+dguUK2y
         iToz7tdnw8NFc7gebD95DkdEvdDD6I8NNkxrXbDOs9kCOBwpk5hmS+Hik1y57ebvzfsK
         ax4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754135; x=1713358935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfEkXHqcrSslp75yT8Es7LWtgthY82aZjWT+8xGzxlw=;
        b=tTWZC1FykeLcx4BCGVHC7Rn53S0aGT/zRi80x26/TetkiDzzLK063efYYqlXOx7xK3
         5gx9WAkcCfdanmOV9c/82lt2vkwYqHCs8y4e8dErbndje9mwggLRHVuV9ZK623Dja1r1
         k/7C7+yprG4NdqJq+/xw+2sVu3MOPRJBIY6YPZUWaOj9xLDvnrPO9eOn+X3Ji4X/M+MP
         csnKinlYcwFwZ7yEJgL4K5Orc+cFr9zJHF/teMoWWTD8ANcoFwNqSFdw8QBnO7IBPICm
         nn5GXTjtd61vo/9pZpA54Wv0y/66hsdObmGk5cAdgkbSvIm7oAA44m+s/mwKvw9EpE+w
         zwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKgRyU1GQKLOnKoF0ZGJ7yNs4hF71aqYRJWjh7mQrPR4N3x6Ha6A5HF/Da0BlByLjw8fc0wWWqKaqb8OOGlQ/oBWvrDs5u4y9bac8/
X-Gm-Message-State: AOJu0YyyZJ09YP5E2dXGeYUy8ftuQMbTdXbRSDqtWnRoJiIQE8CybHZU
	amGx/2PjmgpHzgyD7TP66shinpEubRCVkb4BekO8+B6qPQf0gHHM8AdUQrz2
X-Google-Smtp-Source: AGHT+IF/cJ6s5X7FwDxg61oaVso/YmK8UKpzLf5sIgkOvGvwW5GS5KcpnfKOsMZEpyBDBV1OVM9e3g==
X-Received: by 2002:a17:902:ee8d:b0:1e2:a5db:30d1 with SMTP id a13-20020a170902ee8d00b001e2a5db30d1mr3042367pld.13.1712754135238;
        Wed, 10 Apr 2024 06:02:15 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:d197:ecac:84d7:f484])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001e43a00ee07sm5445375plh.211.2024.04.10.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:02:14 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] spi: cadence-xspi: use for_each_available_child_of_node_scoped()
Date: Wed, 10 Apr 2024 18:31:16 +0530
Message-ID: <20240410130205.179069-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.548.g91ec36f2cc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code for "is the node's child available?" check by using the
corresponding macro instead, which reads more clearly.

While at it, use scope-based cleanup instead of manual of_node_put()
calls when getting platform data through cdns_xspi_of_get_plat_data().

This removes the unnecessary "node_child" declaration out of the loop's
scope and auto cleans up "node_child" when it goes out of scope, even
when we return early due to error.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 drivers/spi/spi-cadence-xspi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 8648b8eb080d..2209e9fc378f 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -486,20 +486,14 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 {
 	struct device_node *node_prop = pdev->dev.of_node;
-	struct device_node *node_child;
 	unsigned int cs;
 
-	for_each_child_of_node(node_prop, node_child) {
-		if (!of_device_is_available(node_child))
-			continue;
-
+	for_each_available_child_of_node_scoped(node_prop, node_child) {
 		if (of_property_read_u32(node_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
-			of_node_put(node_child);
 			return -ENXIO;
 		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
 			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
-			of_node_put(node_child);
 			return -ENXIO;
 		}
 	}
-- 
2.44.0.548.g91ec36f2cc


