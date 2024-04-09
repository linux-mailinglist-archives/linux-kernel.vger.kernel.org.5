Return-Path: <linux-kernel+bounces-136723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034589D794
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C301F24FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD88592A;
	Tue,  9 Apr 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZK93D7+G"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23114811E9;
	Tue,  9 Apr 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660654; cv=none; b=VZE5YGr5vdGKTfTqW+en3o0pn7OUWziZN33RLd+9YMgbHzAIzFGw/l0Pkcd0j3vdTw1l+IVIgLSi2iKC6gRRnH4slM8THyWRTosfvBAI04sGk6XY+34ctFG8z38E/Npi/RNPtxv6WqTyiO5OlVvVC0Xtxrdl9/W2tCDaEaGySUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660654; c=relaxed/simple;
	bh=rfBIQ16lw3YLziXerzIzYPI5vDnBIoD+c9BYXTQHuR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lh7VzTwdeUXONgS8yRsd/NXRz8e8LGoIGsnuserVCSM0BpTTp6UTGrVIhGTWk8tA6sfqUrjIWkDXDfhryHELcO09GkBGUCQzE+lfMsLUnSaHzf3DLiMDP82S+i53Aor4N7es+QaIj2CbpkzC0U/Q6G++0wKRDeZjRPXXmwTYXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZK93D7+G; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TSsEO
	mMeFjpa4wdVSYXOGdmsaMpEPa60zsgqosWqJow=; b=ZK93D7+GzJuOQcApaNkcC
	xAKy96ciTg4nKffwK8Qe7dIzr10itFNlG0vcuTnCCTEm/+B8urwBoOZgg1rF0X7H
	aNz08JIbB10S+Vh8LARJ0eXtui1SyPoVwMy9qPuCPh5ipEs1NEDV+N9egBuHPsWg
	m/yLaxeNP9YjTIqgYNizpk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDnl5dgIBVmhGZSAg--.8304S4;
	Tue, 09 Apr 2024 19:03:13 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	linus.walleij@linaro.org
Cc: asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] pinctrl: apple-gpio: Fix null pointer dereference in apple_gpio_pinctrl_probe()
Date: Tue,  9 Apr 2024 19:02:54 +0800
Message-Id: <20240409110254.2201457-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl5dgIBVmhGZSAg--.8304S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1kCFWxCw4UWF48Gr47XFb_yoWfXrc_Ca
	ykCr97J348C3WrW3srtw13Zry0ka15XF9YqrnagasxCry3Xw1UJrWkuFs8G3yxW34kGFyq
	k3y8X34rXr1UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNv31JUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiPQG7C2VOCYQteQAAs+

devm_kasprintf() returns a pointer to dynamically allocated memory which
can be NULL upon failure. We add a check to ensure that failure does not
occur.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/pinctrl/pinctrl-apple-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
index 3751c7de37aa..af2f90d1950f 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -474,6 +474,8 @@ static int apple_gpio_pinctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < npins; i++) {
 		pins[i].number = i;
 		pins[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "PIN%u", i);
+		if (!pins[i].name)
+			return -ENOMEM;
 		pins[i].drv_data = pctl;
 		pin_names[i] = pins[i].name;
 		pin_nums[i] = i;
-- 
2.37.2


