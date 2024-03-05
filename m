Return-Path: <linux-kernel+bounces-92530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E28721B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E45F28525B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAAA126F0C;
	Tue,  5 Mar 2024 14:39:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AECA126F04;
	Tue,  5 Mar 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649555; cv=none; b=DOdthM2Br7zfWoQKB75HBXix+H4kkR0xjKGkI6YIyRGpKPr7aMF2lrGKoqGKE05ihsibGkAY0jfIL4WBGTmRQY9skqkzpwcR8w/5vyX4pbI0xTMo0VziqLYv8PH35uaM3LRpG5aYLgtVE5PU/cXbfScZsTsCPBhmI9urPuZjfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649555; c=relaxed/simple;
	bh=HHbVbOWDDOboNAEyisylzv0ctsMjCcsB4yqz0U8ueOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWu1Fmue2QoARDhTZ1vSLEDR/3yTOtfzJ750y3EhmkQFWfobE+A1LvzRAiUkmoEP00nsHbyk7fiq5XEwngoi8JCJ77IbWUXt39m8/O7aWDFl0mC4wQotCKL/egKNGs6gDvf3ngsugLDl8/ZPXuzvOE1B3h9tXK3W07fkylvlzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45E381FB;
	Tue,  5 Mar 2024 06:39:49 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C986F3F73F;
	Tue,  5 Mar 2024 06:39:11 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: pinmux: Suppress error message for -EPROBE_DEFER
Date: Tue,  5 Mar 2024 14:38:59 +0000
Message-Id: <20240305143859.2449147-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EPROBE_DEFER error returns are not really critical, since they cancel
the probe process, but the kernel will return later and retry.
However, depending on the probe order, this might issue quite some
verbatim and scary, though pointless messages:

[    2.388731] 300b000.pinctrl: pin-224 (5000000.serial) status -517
[    2.397321] 300b000.pinctrl: could not request pin 224 (PH0) from group PH0  on device 300b000.pinctrl

Replace dev_err() with dev_err_probe(), which not only drops the
priority of the message from error to debug, but also puts some text
into debugfs' devices_deferred file, for later reference.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/pinmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 23d2da0b99b92..a6d2fd1658128 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -188,8 +188,8 @@ static int pin_request(struct pinctrl_dev *pctldev,
 	}
 out:
 	if (status)
-		dev_err(pctldev->dev, "pin-%d (%s) status %d\n",
-			pin, owner, status);
+		dev_err_probe(pctldev->dev, status, "pin-%d (%s)\n",
+			      pin, owner);
 
 	return status;
 }
@@ -441,7 +441,7 @@ int pinmux_enable_setting(const struct pinctrl_setting *setting)
 			pname = desc ? desc->name : "non-existing";
 			gname = pctlops->get_group_name(pctldev,
 						setting->data.mux.group);
-			dev_err(pctldev->dev,
+			dev_err_probe(pctldev->dev, ret,
 				"could not request pin %d (%s) from group %s "
 				" on device %s\n",
 				pins[i], pname, gname,
-- 
2.25.1


