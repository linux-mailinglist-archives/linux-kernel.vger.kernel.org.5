Return-Path: <linux-kernel+bounces-102664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1B87B57A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3D91C20FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3A5E098;
	Wed, 13 Mar 2024 23:55:40 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FF5D73A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374139; cv=none; b=Hk84plPrOsgrfrVCM/A9Q6zUTwsSJBJYyVaoUEECz/RkgjYMSM/POLpP/yvFrlihte8HR5icAmf/AS+518caM5AZC2BeR6zDOBzQPjAtr0yjc0PkMeCOsQoOXdQtClcK59W+hIXVzO8QvGdUcGhp1X8qLpD28Wo8AIm00j994Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374139; c=relaxed/simple;
	bh=nSF/R8gYLxY6alFA60B5rOXw4QyV2pEDvssncoOLngY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB9HoJKFrd2URpCT3lgUy/fiBQfdCiEwt+dVF/MxA9KqB1t/xYPwYjeNxHLkP7tXUsLqZEj62ipunDOwmZdG/7IwQgFtm0xL07NirDjMNxOSvNjuVMmMU1fLrP1KDuq5zO9rfNFZohU6wgT7zXg9fB4+1fFWrYqtegorMHTTEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 05ea9cf5-e195-11ee-b972-005056bdfda7;
	Thu, 14 Mar 2024 01:54:26 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/11] pinctrl: aw9523: Use correct error code for not supported functionality
Date: Thu, 14 Mar 2024 01:52:05 +0200
Message-ID: <20240313235422.180075-3-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
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


