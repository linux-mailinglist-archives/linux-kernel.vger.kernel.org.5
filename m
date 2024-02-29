Return-Path: <linux-kernel+bounces-86979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C89386CDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C24B265CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C778284;
	Thu, 29 Feb 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5OpD6tw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB178269;
	Thu, 29 Feb 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221794; cv=none; b=ST7iduCEyKxvaZPxZN+iSWONcexKDOpO4RcMCfJ9gWaOv1AiMwkQBbL+yR78RxoleHUHRXj15kCYeH1/ymPDSkv0rL+f9ZtJ1RNOKuAxqiiPSv24aVvtIR1JScLITXDhoi4Al4rra3EWtRY+E96tbncbcx+PiSqgEnzDztYIfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221794; c=relaxed/simple;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrwAH/6APNrJ7PklnEOW8cFGQ1R1dCaB1giRK8p/Y3P67kCd4ojhkEEjvc960UfLtnVAuBAGlkL+TXrsyhF64ilrpGZB9AVoiKtY8NtUk+kSPYXuG8RobVTfGQARL0rnn224tQaIB3kCY0ZM1+pWajMI9vX7D8NRr6GvepuuINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5OpD6tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3EC433A6;
	Thu, 29 Feb 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221794;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5OpD6twN9JSzSjqldqkIJpFGBE04NuElU1yptiu1sL3FHXdTogsGFta2LsZlrWO4
	 SfpxhkhUbYKi39yNRhiTEg8bg0Yi9MmTzLQkOlwCd8NOjb5IRqNK3alYqW0Vowj6q2
	 itkybDeMjlQa9Y7L1mxX4KFqpuqhQ+cknyKzcEIeLno6Hs9dZI9hBl9upNe49rdoXL
	 GMEHLUYSFUK6aIblShFf/ezVazTW5kCIacwHe58ads7mtm88DNO9cJgUMBIcIxIkuM
	 iYyZV97yL0pg/KhMb4CzAKQmKGDVlqmCkpGuvffLd9m9z8k4nEsbqjuXnJwrGQGAfF
	 k7/M82p5kJhkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/21] ASoC: cs42l43: Handle error from devm_pm_runtime_enable
Date: Thu, 29 Feb 2024 10:49:24 -0500
Message-ID: <20240229154946.2850012-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit d1722057477a3786b8c0d60c28fc281f6ecf1cc3 ]

As devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240206113850.719888-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 5643c666d7d04..8015f4b7a5b32 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2175,7 +2175,10 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(priv->dev);
 	pm_runtime_set_active(priv->dev);
 	pm_runtime_get_noresume(priv->dev);
-	devm_pm_runtime_enable(priv->dev);
+
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		goto err_pm;
 
 	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++) {
 		ret = cs42l43_request_irq(priv, dom, cs42l43_irqs[i].name,
-- 
2.43.0


