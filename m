Return-Path: <linux-kernel+bounces-138011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7389EB12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB881F251BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEB22071;
	Wed, 10 Apr 2024 06:42:09 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FD17BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731328; cv=none; b=By21aepY1Pspoapf7U5P97IsiPE5c2wTp+mc8JVqW5JSL+vVs+/UwzqgDhXiSOGDVRpiiGzef96fIscyvx9AzE0K/Zdb95Qx/j5Yl79BsbD1ttnIqAt0rlFQB/vGZ33hY3g/k6/VYsptM0nn5f6Zh0btu4oI6C2Amd3VY0/LraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731328; c=relaxed/simple;
	bh=xxEOl0qZbmAWfxl2RnlJnJ/GRhE5ZxBQtOVBcv//8kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XeqVoAFmnv1zxsw2nFQM1erNhTfsLJX/65aGRvG482qZX/tOMBQCwc4WSjujV2u9aujN236eEvjOHNVlqe1WamYh6+2T8P0Pl0vJBBcAi89jihrKoxmh2+w3t+fIUfYQ3+OvWXRGOUqXaFIRnsTFtxV+VBiNk91a6ZOeuyBvIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 6d769ccf-f705-11ee-b972-005056bdfda7;
	Wed, 10 Apr 2024 09:41:58 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] gpio: pcie-idio-24: Use -ENOTSUPP consistently
Date: Wed, 10 Apr 2024 09:41:56 +0300
Message-ID: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO library expects the drivers to return -ENOTSUPP in some cases
and not using analogue POSIX code. Make the driver to follow this.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-pcie-idio-24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 2efd1b1a0805f..7f7f95ad4343d 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -267,7 +267,7 @@ static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned
 	case IDIO_24_CONTROL_REG:
 		/* We can only set direction for TTL/CMOS lines */
 		if (offset < 48)
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 
 		*reg = IDIO_24_CONTROL_REG;
 		*mask = CONTROL_REG_OUT_MODE;
-- 
2.44.0


