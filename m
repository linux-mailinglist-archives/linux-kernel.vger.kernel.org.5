Return-Path: <linux-kernel+bounces-123242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08E890508
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684C1298F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895021369B1;
	Thu, 28 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYYkUpqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE358132490;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=PWwqTILxV5bVZ6i7qYlvQyK9qozWUmjaHirphH+jfIW9w7JADOH607Kesb0yVO4TWLvqLsiX3JuYvKRfjSPXOx5EvQ/GGNdl54MkK8/y515sBgz6EZ3oehzBuAb8R07WDUguDuaF83p5iWvOFIWkSIPjRqYa8/+GuokgBovbxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=6tsedxfQG9tG36M17be5wbJpL1Spi7dRv5gmbuEJD+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVGzmE33OMef9etGZrxc2jgGbjmtdtMIsRLEI+Sz3N7SNaUfTSoggTetgkXq5grxLNivz4vHw4sJIRDOg+n9wyCI5gSawZeeylyTYLCG6MF0qHBqPa9187Y59wQTUjpar0f3Ugl0I6uAortFMUrtvQMNewILnRbg6BncnHmXsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYYkUpqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C2FC4160D;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=6tsedxfQG9tG36M17be5wbJpL1Spi7dRv5gmbuEJD+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OYYkUpqCH14EUBTx2+4tYiHwgygBIu7w2q0qiE9adEzVCoyN/jYa2+sO9DhxVtAfz
	 /Br3EJ4XHcW3sgCe89ETbauF6q070aoK9BtBk78Cg1AxNtkVkD3unOVhNV2/mnMxlT
	 g+DdI+kYq8+Ck2xvECm6Y0Ak+swqzLQY0lNlz8/uyVcnmldUuHyjlhagZ5z7Oa9o+K
	 +zAgwIDQzZm5yMzcGLnrlN0Pxnl0/BjRzWE5tpBI1YiuGC9iATYAolRo+u0oDp5GLq
	 Vn0r9n2tOIQDV5fmqlcG+E3bHtI02yCDv4E9Mx9wJvzQaL9ugqtvo8kVqUccY4s2yj
	 NW8fDGKWUfhMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36382CD1288;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:04 +0100
Subject: [PATCH v4 4/6] iio: temperature: ltc2983: support vdd regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-4-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vIAh0fbwcufBzWFPmQO/O8++O6EavSlE5C9AW8NDQh4=;
 b=fJtWRp8ioO/nf8wpJHWMQlpYTKwmEBGsC1Ob4PlDmd6sQbfq2yl/Aiw9upFN2CijYB9w5t0kt
 d6YW/P2DbUzDkwaZn15hxItqaE3EKqM9nYqAlo2t6COxS0qqm0axl2i
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add support for the power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b4a8ca36458a..ff7f0829b575 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
 #include <asm/byteorder.h>
@@ -1574,6 +1575,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	if (ret)
+		return ret;
+
 	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);

-- 
2.44.0



