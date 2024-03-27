Return-Path: <linux-kernel+bounces-121753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD088ED42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534DF2A308C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4D81553A0;
	Wed, 27 Mar 2024 17:48:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144514F114;
	Wed, 27 Mar 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561712; cv=none; b=RJuuvN0GBfNDR2R51IApVKNLh+t0A9PnsUcSltrDf2UIzHH8AqIeGtZtSIQZxP6RVDYJsXe9DKWb9xLaOXx4WCWKzUcUnTuo7i5/H7k58uu+sDYbVZS1xP/hf1K1s7FsjB4OvEAghGkGpNAsVeV6tXhJlQaBAjX+GzGXUVo1uS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561712; c=relaxed/simple;
	bh=GlXTJYgV3U0VaavTKzUi652h6ZbWONW0X+LAIesw5uY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVYaDVWLWCedAsRuXZGf0pxZ1JK3ciKhcBm8GUsIKxJ3U3Ywb3Y8lAp5ZPa1zMo9Clbg6qDTehB0aFl30gCEaYGCzo2PcqPYgBWg14g9wBs5XeX88HlUcSYYoPNgE64WKPX4rmpe+dGQXl/UTwdc/4m8eaCJduv0vBTPW8vHoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A55EC433F1;
	Wed, 27 Mar 2024 17:48:27 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] nfc: st95hf: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:10 +0100
Message-Id: <20240327174810.519676-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
References: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/st95hf/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index ed704bb77226..ddefe470f4e9 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1242,7 +1242,6 @@ static void st95hf_remove(struct spi_device *nfc_spi_dev)
 static struct spi_driver st95hf_driver = {
 	.driver = {
 		.name = "st95hf",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(st95hf_spi_of_match),
 	},
 	.id_table = st95hf_id,
-- 
2.34.1


