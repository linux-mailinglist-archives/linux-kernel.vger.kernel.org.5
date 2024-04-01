Return-Path: <linux-kernel+bounces-126782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7E893CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B6B1C20E66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3A4F8BC;
	Mon,  1 Apr 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi+2EWfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABA4779C;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=o0xWMFrrC90G+YGQ7UvKcwsMRr/ZwbtZ9rEQCmojI8wSh1jsj0BySY1sYWpKpy2JkTzMe3bMPV5/AZccIMJK4yJertV/sCVVQOkJ2VZG1v+036t9MYhFs7OQe9Wu7fhUmJVLS+VrPRyM+UZ//shKe7AtVVcDCfaOp75+IxrqQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=rMNIm6FF+KZ2ZTd24xaZhI8c5F+8wLFZxJzWUcCFoE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWhoRTMMGm4Hpnpa8GlvF+6MSh0T+cIYRmt/M4BnKEeS3hrNxnNklB1uh6xQ1z4elWoV5SJ46guHuzQUqRJlcZhlwvlXGPYGdoOcQMIVe9o40EVtZqe7q5U9w/SKj1DHVKDtKT1XNuUGgc9FisX5hgdYUgF6M7qejly/dbWkRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi+2EWfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42A6AC43142;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=rMNIm6FF+KZ2ZTd24xaZhI8c5F+8wLFZxJzWUcCFoE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yi+2EWfO+KGVpi7JDBs5lIvKSv+UTUhk2N3pUx7aBUI7L3F7npNPeW7U2c/gtJcBt
	 yuffCjtV2eFE8LQufDwLWcynUvO9yUP9F1sfqv/Nth7mfI+a56+i6YGkH3G9fmtN4Z
	 kFcDCHxqhTbJni5odIg/rGYUJ+v2DRbRJRbMVZs33HnZueYP8IwOnqowR6zWHH7qnX
	 vigRtRTTNZVa0j281w5raiyNlX+IBYp39iQAisICf7oFZedfdns84NkRoPI8Z1YWso
	 2AttD8CWIMH/ZqUvokiXQ9jpz4wKNvwx+a8dlVDwM/VlHekFeGIo2/LYzwDDRAp2Jd
	 ReTv5wHgLj7kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B35ECD128D;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 01 Apr 2024 18:32:23 +0300
Subject: [PATCH 5/6] iio: adc: ad7173: Remove index from temp channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-ad4111-v1-5-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=697;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=BEq6V85bjOhRpMOZUvZXO8DDCT8wIyhHIFI5fumHsUQ=;
 b=uRtEs9PSWhwA2agYFbdIGhRPxleMz2YI6DJQGcqKWjiKcckx5OaBkgBeVypd7Pkc4k2o8EF4Z
 Oe/2pVoVCLyDEuuNazmWNj21SPV6BuCXgX9le+FvPpRM4d/974PE+6r
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Temperature channel is unique per device, index is not needed.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index bf5a5b384fe2..9526585e6929 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -797,7 +797,6 @@ static const struct iio_info ad7173_info = {
 
 static const struct iio_chan_spec ad7173_channel_template = {
 	.type = IIO_VOLTAGE,
-	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE),
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0



