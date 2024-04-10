Return-Path: <linux-kernel+bounces-139029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00E89FDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160AD2818ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A217BB00;
	Wed, 10 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMWIUT+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC017BB04;
	Wed, 10 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768591; cv=none; b=sC4flb2XgYodTt0k0I3dGt8Z13qbTnvzYp+oPn8oWK1AwMXIDUAv+jT9cJeitx1iFhrd/w1HFwx3QpylzU4NSr/yPgIE1Kz8k2CZYP5Jk4CzOr9t2C6gYHRbP6M0AB51fCzRc04rkESgO+neeRg6xNMEIZQPL+XTh7p2eOfA8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768591; c=relaxed/simple;
	bh=xehGgLUQjh8/yjMno5bm1Yrj+8g5Zw6i7tTbr0V6/Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKjZG3twLoOueGdfAAghobZVx/mmwRqdLYMIAX+MS7/TK0O6AX/VIBsuqClyVYg01NRnnKx+PlcHExFXVAqcAOrIcOhC8e9ZfOAQriY+3TshalrYtXyfvY37zetTZzIWzEHAmKhZesHYLbzukUOSZam4z7HbLIo8U9n7m4VAIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMWIUT+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97517C433C7;
	Wed, 10 Apr 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768590;
	bh=xehGgLUQjh8/yjMno5bm1Yrj+8g5Zw6i7tTbr0V6/Rs=;
	h=From:To:Cc:Subject:Date:From;
	b=eMWIUT+UXcRUDE7PHz4Gz2Snr9yDR/7AFj/ApMgha1qTlaqcRIDqr3sl+W6z+bP8O
	 5mqv9QHqE0mHr6f06CVsfF6QsTd7pWFTOZVyy5k2qvMeEk0a0zc8aqK3ND81tIHX1r
	 yCFHeAYTvEZelpf71cn6wmfdz5UFIcyh9OitrLYodqYCItkvjZick2Ehvb2vYPnDuu
	 ugH6ocIAXwAXwHJgTIF6CqSX8BQfbqBLZgkKmNIG70gPHr5rkFeoI2o8LRTp5OphhL
	 QszNn5802IGpnEhyRWSeAFuPEF/LQTqbc+eYBq+rnwJnIbye4lQ7aOO6ph1UXYqTJY
	 3lSaMZ2xHXetA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] gpio: lpc32xx: fix module autoloading
Date: Wed, 10 Apr 2024 19:03:05 +0200
Message-Id: <20240410170305.248683-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpio/gpio-lpc32xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 5ef8af824980..c097e310c9e8 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -529,6 +529,7 @@ static const struct of_device_id lpc32xx_gpio_of_match[] = {
 	{ .compatible = "nxp,lpc3220-gpio", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, lpc32xx_gpio_of_match);
 
 static struct platform_driver lpc32xx_gpio_driver = {
 	.driver		= {
-- 
2.34.1


