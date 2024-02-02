Return-Path: <linux-kernel+bounces-50362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FF84780A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AA28A916
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72774151CD0;
	Fri,  2 Feb 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmwWr8lS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896768592A;
	Fri,  2 Feb 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899193; cv=none; b=XB6wjaTrzQ4smnCKo6folRtB74A69zsfxNjUlpw8QZtSNU9qg3aC224vXkXQkDE9AeQw0/DInDOdmctoY7GIUaR/EoQP0yzq2/vKu3szuVScaCi/pr6UoS1Qcz9N6z5xvPhEc0eHvK2ryhRobS19dmvBXshVsMQdJOIZu7brfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899193; c=relaxed/simple;
	bh=MAtB2ChwFF1exhEfUKrF79D5jxW1fp8BGXZSzKt5ZVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvkCkRXL+akje/PSwdORurUGfylySpCusnw2583qH7PAVfYVdgDrWdimfJRWsU0yhzo7f54Bv1hHDqDo9EhC7eky3uJBYUbbihiEdAOgctZtR/ViQBY0OC30zkTpAXWbnjM3IyJhcKURpUSGEDlSAwetMI7gRfCI6w0LuYI3Zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmwWr8lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A4C433C7;
	Fri,  2 Feb 2024 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899192;
	bh=MAtB2ChwFF1exhEfUKrF79D5jxW1fp8BGXZSzKt5ZVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmwWr8lS5qXnv/HIncGxsoRRi0lNkX5NvSRT07ylB1KllAe6T3wiyR7QQWSuzxpxH
	 kCT1tWEb449EpNr9KGBavyvS3A2/jWLevMGbtcmEjc+RYNhTNC/K0NyNL2Y5I4pCD1
	 hNAnJ2LzVzo5YIAHl0W+Sghw+lbZFHBAU+tgt1ojekQJ8bIflVzR0kJPcIJpuazGnj
	 MtNYJz6+wuzitC6KEfFeq9Tho0n2TGqN8d2/euYLr5Ryom0L56hPWIGvyBNJnmPJA0
	 98V9RJnkDqwmYWGXQfLI6YqHbuJWWbTCI1XwTvS5UCVU6/r0kMd2B6fRKfDTV9a1Ps
	 WbLexpMJxMlAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 17/23] spi: cs42l43: Handle error from devm_pm_runtime_enable
Date: Fri,  2 Feb 2024 13:39:13 -0500
Message-ID: <20240202183926.540467-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit f9f4b0c6425eb9ffd9bf62b8b8143e786b6ba695 ]

As it devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://msgid.link/r/20240124174101.2270249-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d239fc5a49cc..c1556b652909 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -244,7 +244,10 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	priv->ctlr->use_gpio_descriptors = true;
 	priv->ctlr->auto_runtime_pm = true;
 
-	devm_pm_runtime_enable(priv->dev);
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_idle(priv->dev);
 
 	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
-- 
2.43.0


