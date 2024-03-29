Return-Path: <linux-kernel+bounces-124840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58407891D23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0952B2F8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAF1BAC2C;
	Fri, 29 Mar 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiIouIsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBED1BAC52;
	Fri, 29 Mar 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716268; cv=none; b=uFhEYC2E92eFxwdscRQqu/kMQSmS9aP1Zxqvce+XRE1jDUC3jveYicDQ7MLb+oj8XSShkOVsszoqJt6L+2vFHw43rmwuQdb2EPtJ9bczNaSp+7uyRzRNCjzJsRJcDa4FqNJTw3huHTn7k5bej39scSVNHApSzfgy3xf26pW/lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716268; c=relaxed/simple;
	bh=g4G966sqyGAo0Tea4bdG14ocnuCnsoCEQwCF6LPvnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftj/TyrtT0D0qq+Byu4Kh08qr+jQYRaRp50jZ0wtrvtrVMqAPnOuOt06UCv7N14vDmqurEqOvNefR5HpU4QvEDY4KAR1EEIVfRnMyMls4f76R2nm7r0NLIuxlBQPlIIYsaC+yJMySH+Y3ZKtaF+kU7SJhcmNOPApb2u25jRv73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiIouIsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F76CC433F1;
	Fri, 29 Mar 2024 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716268;
	bh=g4G966sqyGAo0Tea4bdG14ocnuCnsoCEQwCF6LPvnEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiIouIsmF80GjqhnK9F3ODwK9+42MUHlI3uOY3VhYx2C7E2TTXv8fy8rpq6eHQp/d
	 +80R/LMtFeYtq+YDNaMAozqyQ+XfI09ii0MyBj459TOproaKKqLr105xvulqGvrT2R
	 7s8Ulk6u6GU8qgUFOoryXpgta424vuH5MwxNS2g83eKM5dLfxwp6HTovvnFm4iEYR3
	 npmUGajMrGbJtlD4o1fvrXshiA9Y5Gj0RRAIMnArSf66cvf4kJwLgbWmcYWo7A0jtv
	 p8TI1Dm1LVxstHidTQvkdWGhTD65IAdOw5+Jq1ZZl1PoH0V+uoN7eN/IDLNjALdtaT
	 cVjn28TmGSS1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	nathan@kernel.org,
	linux-media@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 31/75] media: sta2x11: fix irq handler cast
Date: Fri, 29 Mar 2024 08:42:12 -0400
Message-ID: <20240329124330.3089520-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3de49ae81c3a0f83a554ecbce4c08e019f30168e ]

clang-16 warns about casting incompatible function pointers:

drivers/media/pci/sta2x11/sta2x11_vip.c:1057:6: error: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Change the prototype of the irq handler to the regular version with a
local variable to adjust the argument type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: update argument documentation]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/sta2x11/sta2x11_vip.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index e4cf9d63e926d..364ce9e570182 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -757,7 +757,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
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
2.43.0


