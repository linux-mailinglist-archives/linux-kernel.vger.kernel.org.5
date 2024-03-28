Return-Path: <linux-kernel+bounces-122641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E688FAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC98E1C2C9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217D5FB8E;
	Thu, 28 Mar 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="WvMTSt/U"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D528383;
	Thu, 28 Mar 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617116; cv=none; b=PzbB9UgnseYhoNwAbb5zmeWHiPKjttjM+5puwGGSqROSefZt+Yu9SPJhXAgv/TQGq+YdKGQ6EAUTQemT5Dd3eLaE8iOsJQBYMDNeouz0fJcfGhTRx0FwYHQc2yzea5dgktGXJu0SzYBw+E5FPOvbMeDMVur82iMTrBprJ4yBfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617116; c=relaxed/simple;
	bh=xLh6sA1cDo9lAwGZhSFLZxXSoW/5MgW2cFiEZVtezjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qiFKbYx/cMz3h+axA3Bc5kI6N7uHZnucOdgVlsTOsM2L8rtwS75ir7lLij6mvJHWnqKbbkP0wqZU3xmpXGogqSfFmSq6PMqg4qH6zzMV5sYZ3gWYUC3zxnsm4ljSuaMbSF2fhQPsN2G/DVH7rWbAxOZeHk1xxtlvKquxwmlX3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=WvMTSt/U; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id A47AE100003;
	Thu, 28 Mar 2024 12:11:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711617094; bh=2dA60c3u8NMsA53rnbkHUP4JLBJTm4YliDz9GB9JWBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WvMTSt/UHNE28Etstf5/h/lbVATM9C8t72dfsIPPgJm2rSxozA8jjrKL53POnYB7V
	 hKp2c15fvIoEZvyOZi6IbNpH+qw3PyHDKGjof+cWqaC5Ev6C4j6kHaya3/lssLb5Dd
	 wWvibFme26QC1oLOM5zXaDhh3fGmDNGuXxBgKVgsrj5PWzuFbPt2S5/MmeNj4/RPct
	 4xwpoG50cAAVAxWyZkqFxuUyYsf8MKhtz5IPYEKHtEIRl/htdU6rMyDXlNCwgHO/Jx
	 t6dJj87Rwtgwtwytlpe/AruE3e6KPbljESqzrGSeqGZ/Hr1IId4PnYehwE68WzTERm
	 LuyT9QIvFC10g==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 28 Mar 2024 12:10:49 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Mar
 2024 12:10:28 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Keerthy <j-keerthy@ti.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F.
 Davis" <afd@ti.com>, <linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] gpio: davinci: Fix potential buffer overflow
Date: Thu, 28 Mar 2024 12:10:21 +0300
Message-ID: <20240328091021.18027-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184460 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 13 0.3.13 9d58e50253d512f89cb08f71c87c671a2d0a1bca, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 07:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/28 06:03:00 #24486213
X-KSMG-AntiVirus-Status: Clean, skipped

In davinci_gpio_probe() accessing an element of array 'chips->regs' of size 5 and
array 'offset_array' of size 5 can lead to a buffer overflow, since the index
'bank' can have an out of range value 63.
Fix this bug by limiting top index value.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c809e37a3b5a ("gpio: davinci: Allocate the correct amount of memory for controller")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/gpio/gpio-davinci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index bb499e362912..b65df1f2b83f 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -257,6 +257,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	spin_lock_init(&chips->lock);
 
 	nbank = DIV_ROUND_UP(ngpio, 32);
+    if (nbank > MAX_REGS_BANKS || nbank > 5) {
+        nbank = MAX_REGS_BANKS < 5 ? MAX_REGS_BANKS : 5;
+	}
 	for (bank = 0; bank < nbank; bank++)
 		chips->regs[bank] = gpio_base + offset_array[bank];
 
-- 
2.30.2


