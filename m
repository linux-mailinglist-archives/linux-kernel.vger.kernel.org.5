Return-Path: <linux-kernel+bounces-155032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1F8AE492
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A01F218C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6213BC34;
	Tue, 23 Apr 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5hWrNue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172F13BAEC;
	Tue, 23 Apr 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872442; cv=none; b=T/QdUUgn87XiM+ovSM8zrjXVKUqGCon7JgPazrUu0VSYLUJYlRCj+J5Vdo3zuN1mme/Ek4HUewpZ5H0ZrDs1K6K0/gpcuPBO6lMps5XGmgomf29PdqLUgPzY/ju+M5mGR+64sQdSOAPMCu/xE7cyn+rYbK4VOW15GOa53MK2nmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872442; c=relaxed/simple;
	bh=5RAUvk4sjc/qsa/C6BSAWC/Hw5N4z6bB5pl4q+E9wyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P177ig7ORwaLx+hkHLRShEVdnVNOUQT40tYIM9UpCgwAlJchzFAdbfIBo0jx3HSOghhm9aiJhs+KazNzqLPXn+YeOhP7jUwQXqwJfjkxHzDYnAANtt/fO8aFOCHoeYj/y1l4NApKg5L9pVVVzUUonKeR+OfDEo9jzquUU0llPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5hWrNue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1FAC116B1;
	Tue, 23 Apr 2024 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872441;
	bh=5RAUvk4sjc/qsa/C6BSAWC/Hw5N4z6bB5pl4q+E9wyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5hWrNue8bl18x1fRymfDXknRQDqYc/aqOwGQbTxCqUpdM+CLw32aWLESiuezKN5g
	 SDzgVmF1Pnvlt/ryk9w69+RvAZKihu8mg+mXhaSMF6Oug2L6Baxpo3S1+TTG7BhROx
	 oz02zhdoHCcr6YOHx/c459HG11h3/6tQe7rpOjo5JptskargCAHSZyweVvUdnI9su+
	 hneQmgtDm/1E4OlnrxFnO9+VENTnhViEIh+E+3v2qckfA8kQ7dCyqaw2GRm0g5RAaj
	 4jVAakP1Ec846FsR2PaZE3Vns1TP7JVtHBIVynIIy4j0q5WOSTW750EvWxVFpjgY86
	 KbKVT2QXmbpcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/16] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:01:39 -0400
Message-ID: <20240423110151.1658546-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0c3b532ad3fbf82884a2e7e83e37c7dcdd4d1d99 ]

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index c18b6b47384f1..94ca9d03c0949 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
-- 
2.43.0


