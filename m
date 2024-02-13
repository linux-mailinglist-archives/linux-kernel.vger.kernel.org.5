Return-Path: <linux-kernel+bounces-63275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE62852D21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D67F1C2643E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79788224E6;
	Tue, 13 Feb 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjfvP/Nh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83212BB03;
	Tue, 13 Feb 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818097; cv=none; b=bQmxIkjLG2dW88EYKZSbnVRoNMNfpo4XTJzMCn1RD0br8rV89EnsEhU72hXMdKcSMOzNxNccu495JXbE8OGRtvn8DmDNEiHMfNq+HqfzoCa3TiKcRZb9/t4qhbpi55Qp1uePJr0ZcYOj1dhfFzFrz082pNS7AQZUu3Yz+0Xj/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818097; c=relaxed/simple;
	bh=4De3RyTU7r+pUzJUl0tRw/D7nVV5tAv3p6T8Js04G/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M7ZP1qENUFqRSCZY2SD+QrecC7P9D9vNiQvnHnsCah46ti4LofGH8RM46MrmTFUN+HdOPV5Nklx3imFEEx1rOWrTn344ZtThE6YFS5tHj6XHB47CnOaPcYcFH4UTljR/xDeirTrrrn35SnugVJSRtIrIRyePHN14FtgiQB9ypqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjfvP/Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5ECC433F1;
	Tue, 13 Feb 2024 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818097;
	bh=4De3RyTU7r+pUzJUl0tRw/D7nVV5tAv3p6T8Js04G/c=;
	h=From:To:Cc:Subject:Date:From;
	b=KjfvP/NhWaO4TPXRscwaIdNAvjfmjfNzJMINOI7zjyj3rzCsHcNLiJAjs9E1aQlki
	 rg5MogLLMywQQ6U8N5g5KnHPpdcPsaG5aSK9fCZj9ailMSDaA0CfYz6O+mcuYx6llh
	 NRqe7zADwWnvYKUKveVnKLnbsRcKeKNWS8MO7YTAkM23IgzIslBoEQAWbCJFUH0gKy
	 EgUXlpYiCl3r07CXddQfD6IE72/vLJYB7QtQ9/4bNCTl0ySYNy9OtRS2DRlefwxGDz
	 xe4N/R7iLBxVzUHT+P8vescQb4PKfT4Mu2wKba29P4ghiPRgQadUSP9dKojAAVUbmg
	 Srkt73YXHuY0g==
From: Arnd Bergmann <arnd@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] media: sta2x11: fix irq handler cast
Date: Tue, 13 Feb 2024 10:54:47 +0100
Message-Id: <20240213095451.454142-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about casting incompatible function pointers:

drivers/media/pci/sta2x11/sta2x11_vip.c:1057:6: error: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Change the prototype of the irq handler to the regular version with a
local variable to adjust the argument type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/sta2x11/sta2x11_vip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index e4cf9d63e926..9def7d08c809 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -767,8 +767,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);
@@ -1053,9 +1054,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 
 	spin_lock_init(&vip->slock);
 
-	ret = request_irq(pdev->irq,
-			  (irq_handler_t) vip_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, vip);
+	ret = request_irq(pdev->irq, vip_irq, IRQF_SHARED, KBUILD_MODNAME, vip);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		ret = -ENODEV;
-- 
2.39.2


