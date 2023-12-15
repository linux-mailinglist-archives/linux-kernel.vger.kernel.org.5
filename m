Return-Path: <linux-kernel+bounces-1248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC523814C68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1728AB231AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFDB3A8D9;
	Fri, 15 Dec 2023 16:03:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from harvie.cz (harvie.cz [77.87.242.242])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF39FE4;
	Fri, 15 Dec 2023 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by harvie.cz (Postfix) with ESMTPSA id 13566180370;
	Fri, 15 Dec 2023 16:56:51 +0100 (CET)
From: Tomas Mudrunka <tomas.mudrunka@gmail.com>
To: jeff@labundy.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomas.mudrunka@gmail.com
Subject: [PATCH v7] Fix freeze in lm8333 i2c keyboard driver
Date: Fri, 15 Dec 2023 16:56:43 +0100
Message-ID: <20231215155643.705116-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXpnbifDOQ/eF5jb@nixie71>
References: <ZXpnbifDOQ/eF5jb@nixie71>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LM8333 uses gpio interrupt line which is active-low.
When interrupt is set to FALLING edge and button is pressed
before driver loads, driver will miss the edge and never respond.
To fix this we should handle ONESHOT LOW interrupt rather than edge.

Rather than hardcoding this, we simply remove the override from
driver by calling request_threaded_irq() without specifying trigger.
This will keep interrupt trigger configuration as per devicetree. eg.:

	lm8333@51 {
		compatible = "ti,lm8333";
		interrupt-parent = <&gpio1>;
		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
		...
	}

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
Reviewed-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/input/keyboard/lm8333.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 7457c3220..c5770ebb2 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
 	}
 
 	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   IRQF_ONESHOT,
 				   "lm8333", lm8333);
 	if (err)
 		goto free_mem;
-- 
2.40.0

