Return-Path: <linux-kernel+bounces-78718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C378617C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97271F23483
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9AD139561;
	Fri, 23 Feb 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqd0oMWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55F12E1FC;
	Fri, 23 Feb 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705313; cv=none; b=dUmSKX0qQOYQJdSDTk6lv2UVLlqKLRLqQBPPdHXhr1aol2vIoocHL4pvM9lEK6z0d/GZP5osnqzS9PdwMkdWUnIscREQWHrpNT++PoujOqZdWfF7dG+4vxgZVJ0TrVrKKsb8I3udWKHAG3WN4Mj5Xa/jI2uHj5ZU1KGllt7m4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705313; c=relaxed/simple;
	bh=WU89fYlzkV7iq1/qt/r+d2wUO9ZbalxxnTbNqYn/EhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GM4uiRDSdoj67MQ/eYjT6YelBOaHbpagTqjv49w66OKPomMsurVqXknLYJjYjFD1VJSBILOmk2asbb6GjCl+QiD/yPsKNqMZw4Hrf3kAb31t290uLluLzRAOazZ9/L4GyWPEbdH1Axs5KVNkS1nk+Ibm6+78kKda+DovnphS14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqd0oMWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1538EC43394;
	Fri, 23 Feb 2024 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705313;
	bh=WU89fYlzkV7iq1/qt/r+d2wUO9ZbalxxnTbNqYn/EhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqd0oMWqLS9+bUOV6/JV82J9rY81dxFPJAyjU99xQkWWqoXpQsErsWkJsFHY4d896
	 DXFzv4CVVIppsCbdCKmU0wXHlcL+E3NqNEcuX+UTrrcEuQ7pSIziUD8wjNn02Q4QHs
	 IQCg9jELJkmrATcWATFuHzeASjw+txxvuufNHcdvcwwUB72N7MVIzb9MfQGTagNZTu
	 MlEM6qIMiQI3N2bl9o2ocy7y29UIop+mf+6yfGTPkMdGoWyqIbWESHxAAJN3zNyywp
	 zFpMgq7+sKQADO5+rRHrqYWvEEyEHjssi0D8RsoJsmJwuJ2ytexvl926KND3gJ9DSC
	 ElUADPdKC/tHA==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v2 5/5] hwmon: (pmbus/ir38064) Use PMBUS_REGULATOR_ONE to declare regulator
Date: Fri, 23 Feb 2024 16:21:09 +0000
Message-ID: <20240223-harmless-covenant-9cd3d4f1cfd2@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=b9OMUzVMqRny91Z1AmDs/nQDPPMoHnmOADsngDqzbtU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jv44r/LpbqP0kaSVBQfDZ2lUVPkIT7BblRLP3nCuS eOgdLd2RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZyu5Dhf+Dxv3/v1lhWaBea 1AS6vrZ9eL3p76cnJ/It53at0JxZk87wT+GosxvnIu7w9yuW+p+akTCjYFEWx/1W6TWTNsze5Bx gzQQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

If a chip only provides a single regulator, it should be named 'vout'
and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
that happen.

Cc: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/hwmon/pmbus/ir38064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
index 04185be3fdb6..69e18cb468f6 100644
--- a/drivers/hwmon/pmbus/ir38064.c
+++ b/drivers/hwmon/pmbus/ir38064.c
@@ -22,7 +22,7 @@
 
 #if IS_ENABLED(CONFIG_SENSORS_IR38064_REGULATOR)
 static const struct regulator_desc ir38064_reg_desc[] = {
-	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR_ONE("vout"),
 };
 #endif /* CONFIG_SENSORS_IR38064_REGULATOR */
 
-- 
2.43.0


