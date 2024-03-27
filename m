Return-Path: <linux-kernel+bounces-121742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BCF88ED2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF781F32905
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAD154431;
	Wed, 27 Mar 2024 17:47:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF8153BCB;
	Wed, 27 Mar 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561622; cv=none; b=ZnWQGIiuYNhEB+nanOD0BBaLstd/S/kumkWg240Eow/xDs2v1XgF7vaS/IBHXMlk173rJNDZqddUgyxAP2Eh03TiMdLDjuN4h9clrzG+6W6DtLLx4wgKhog4c7ds2QI9M1dAHHSPv9ZEnP46ZU1LcCC2ELm2cnO0dyGzq0pNHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561622; c=relaxed/simple;
	bh=c1Yr8cxUu6FlQv/VNuwEY7Asv2sj0ZG5bn+tuaa7ilk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/2in0FvSVi98oUxgtYHz6L9brlQ7BETfPbMdjDN4oHj6G9RnCW/OiA9UM4iJPm3NU8VePpBfJ4HjDqWT9dCNOwTonw90Hev65X76kGkJFiJcLTBP5OsjioqVdJ0bMNM1cWptzGxi5ZyvKFqpan2XkJcbHHwYPOVJKEJ2WwNguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F4BC43399;
	Wed, 27 Mar 2024 17:46:59 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Input: stmpe - drop driver owner assignment
Date: Wed, 27 Mar 2024 18:46:55 +0100
Message-Id: <20240327174655.519503-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/input/keyboard/stmpe-keypad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index 2013c0afd0c3..ef2f44027894 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -413,7 +413,6 @@ static void stmpe_keypad_remove(struct platform_device *pdev)
 
 static struct platform_driver stmpe_keypad_driver = {
 	.driver.name	= "stmpe-keypad",
-	.driver.owner	= THIS_MODULE,
 	.probe		= stmpe_keypad_probe,
 	.remove_new	= stmpe_keypad_remove,
 };
-- 
2.34.1


