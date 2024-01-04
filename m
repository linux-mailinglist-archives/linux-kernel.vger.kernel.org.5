Return-Path: <linux-kernel+bounces-16206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D6823ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EBFB24909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F35226;
	Thu,  4 Jan 2024 02:43:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8522103
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4042h8JW001784;
	Thu, 4 Jan 2024 10:43:08 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T59h7758Yz2Qby50;
	Thu,  4 Jan 2024 10:36:23 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 4 Jan 2024
 10:43:06 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko
	<andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>
Subject: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
Date: Thu, 4 Jan 2024 10:42:41 +0800
Message-ID: <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240104024244.12163-1-Wenhua.Lin@unisoc.com>
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4042h8JW001784

The eic debounce does not have a clock of rtc_1k in the sleep state,
but the eic debounce will be used to wake up the system, therefore the
clock of rtc_1k needs to be kept open.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index be7f2fa5aa7b..bdcb3510a208 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -24,6 +24,7 @@
 #define SPRD_EIC_DBNC_IC		0x24
 #define SPRD_EIC_DBNC_TRIG		0x28
 #define SPRD_EIC_DBNC_CTRL0		0x40
+#define SPRD_EIC_DBNC_FORCE_CLK		0x8000
 
 #define SPRD_EIC_LATCH_INTEN		0x0
 #define SPRD_EIC_LATCH_INTRAW		0x4
@@ -223,6 +224,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
 	u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
 
 	value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
+	value |= SPRD_EIC_DBNC_FORCE_CLK;
 	writel_relaxed(value, base + reg);
 
 	return 0;
-- 
2.17.1


