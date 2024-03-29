Return-Path: <linux-kernel+bounces-124419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0D891743
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB4B24FED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194416A346;
	Fri, 29 Mar 2024 10:57:51 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153869E0F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709870; cv=none; b=AjNnknpte/zR0SSuQBJGfCaYTNA8zGvH5lXYYaP+EhuVVor+zp18JiM5qMOuzw+pIWMtmLxaTQjgE9GPkusqEcIbydF5fDO5kOvKgVa4mz8LfPBBd3jiu452JL/60OgMQH0upErZllHL7wcWyF5nYC+XbeIo5DLMGLTVw0aP2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709870; c=relaxed/simple;
	bh=nSF/R8gYLxY6alFA60B5rOXw4QyV2pEDvssncoOLngY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmMspT7KmfHPezgIKSXvcRfoE5ynAez8J0QcBZTrth1JcXgGJeIiPLAPiTmJ1qZys3SVhK/6plilOVivT2LoZHqL19P0Xl8ULL2nyUUc9nT+6MKG5qKZyHUOP7fiT25XfvQhDmD6BBu/kukASP+rOurSXG6Nr7c9SM9q9+HQxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 04a93f69-edbb-11ee-b3cf-005056bd6ce9;
	Fri, 29 Mar 2024 12:56:38 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] pinctrl: aw9523: Use correct error code for not supported functionality
Date: Fri, 29 Mar 2024 12:55:16 +0200
Message-ID: <20240329105634.712457-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pin control subsystem internally uses ENOTSUPP for the not supported
functionality. The checkpatch is false positive about this error code.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 66629af0b88b4..65d523697b731 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/errno.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
@@ -239,7 +240,7 @@ static int aw9523_pcfg_param_to_reg(enum pin_config_param pcp, int pin, u8 *r)
 		reg = AW9523_REG_OUT_STATE(pin);
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 	}
 	*r = reg;
 
@@ -290,7 +291,7 @@ static int aw9523_pconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			val = FIELD_GET(AW9523_GCR_GPOMD_MASK, val);
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 	}
 	if (val < 1)
 		return -EINVAL;
@@ -344,7 +345,7 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 			/* Open-Drain is supported only on port 0 */
 			if (pin >= AW9523_PINS_PER_PORT) {
-				rc = -EOPNOTSUPP;
+				rc = -ENOTSUPP;
 				goto end;
 			}
 			mask = AW9523_GCR_GPOMD_MASK;
@@ -361,7 +362,7 @@ static int aw9523_pconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			val = AW9523_GCR_GPOMD_MASK;
 			break;
 		default:
-			rc = -EOPNOTSUPP;
+			rc = -ENOTSUPP;
 			goto end;
 		}
 
-- 
2.44.0


