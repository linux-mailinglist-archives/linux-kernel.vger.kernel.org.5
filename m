Return-Path: <linux-kernel+bounces-24286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478A582BA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1BE282C21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242181B29E;
	Fri, 12 Jan 2024 04:24:17 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B523B1B28E;
	Fri, 12 Jan 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 02C0C604F04A2;
	Fri, 12 Jan 2024 12:24:07 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] gpio: mlxbf3: add an error code check in mlxbf3_gpio_probe
Date: Fri, 12 Jan 2024 12:24:04 +0800
Message-Id: <20240112042403.3940316-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker warning: Value stored to 'ret' is never read.
bgpio_init() returns error code if failed, it's better to add this
check.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpio/gpio-mlxbf3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index 7a3e1760fc5b..d5906d419b0a 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -215,6 +215,8 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 			gs->gpio_clr_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
 			gs->gpio_set_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET,
 			gs->gpio_clr_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "%s: bgpio_init() failed", __func__);
 
 	gc->request = gpiochip_generic_request;
 	gc->free = gpiochip_generic_free;
-- 
2.30.2


