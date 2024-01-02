Return-Path: <linux-kernel+bounces-14140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11312821849
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7F8B20ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C64C94;
	Tue,  2 Jan 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMTcUzvu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2D46AB;
	Tue,  2 Jan 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DD151BF20B;
	Tue,  2 Jan 2024 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704183586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F7JhpyUgH4Jq+rXwdSiSSX32DA0GZkdALp7liQzCyVM=;
	b=DMTcUzvuzO5wWZxzkxtkgpGfk4NtH/WHDgEF4W8hiKTuQ8I0j7k5PPvxXZ13G8VjZLPz0o
	Ti7lAEzLQHF9EC7A0fuU/8vIooDBwkmz8Ji1AAghDNuB0V0v/FxkVqjHc4ceIidkDFuhKu
	JSXbhy0n8VmhyZZhU0mWjJ/b2wZuaBXssd0i0NNjcNDMm1ChiA8l5MZoeQHOtZxel3E8p9
	Q1V/pBtMbsOm7lo+xbY4VB7ZBhI0YpheVioufVRvMiHaY/2nj4eVOhVIUYIKzQUoef6GZn
	IZsDZ8fY2KKd/xWVqHKtiePtsJvmThdBDhIpdfHSAIPKbbS9Hde5h6nG3/7Utw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2] dt-bindings: input: touchscreen: goodix: clarify irq-gpios misleading text
Date: Tue,  2 Jan 2024 09:19:34 +0100
Message-Id: <20240102081934.11293-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com

The irq-gpios description misleading, apparently saying that driving the
IRQ GPIO resets the device, which is even more puzzling as there is a reset
GPIO as well.

In reality the IRQ pin can be driven during the reset sequence to configure
the client address, as it becomes clear after checking both the datasheet
and the driver code. Improve the text to clarify that.

Also rephrase to remove reference to the driver, which is not appropriate
in the bindings.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
---

Changed in v2 resend:
 - added ack/review tags

Changed in v2:
 - reworded to clarify even further
---
 .../devicetree/bindings/input/touchscreen/goodix.yaml        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index 3d016b87c8df..2a2d86cfd104 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -37,8 +37,9 @@ properties:
     maxItems: 1
 
   irq-gpios:
-    description: GPIO pin used for IRQ. The driver uses the interrupt gpio pin
-      as output to reset the device.
+    description: GPIO pin used for IRQ input. Additionally, this line is
+      sampled by the device on reset deassertion to select the I2C client
+      address, thus it can be driven by the host during the reset sequence.
     maxItems: 1
 
   reset-gpios:
-- 
2.34.1


