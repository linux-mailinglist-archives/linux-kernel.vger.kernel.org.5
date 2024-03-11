Return-Path: <linux-kernel+bounces-99413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAB2878808
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC56282FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDD58AD6;
	Mon, 11 Mar 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTXHmUai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A562816;
	Mon, 11 Mar 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182362; cv=none; b=glEvD5X3O/lP3S3oKdoCorUlD11cqjv0Zw/ZwE9RRVxqM/mt8P9BUOUBJlI53Fp9NR7cSfgA4afLvyubWJ2e4Aw+xYFPKqdN9avA/GMo4XyP9SVXT4LxEUIOlgZ2EcKzGhhLJQfoDEx4OwWdATiTYTUVspcnDwAH+3AGD0R1bvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182362; c=relaxed/simple;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV/vLj1PfXH88rmppXw1LlCbWpp/r5c8SdHOmlUvf6bFO8eseZ3A6zBQQkUedQZmNo05w7RQmlhbo/vdwrNz9c+8e+kwg+U1A8UPYTguIDlxdOt1wWlwSI0dkblow5yzz5M0Bl2zfULa6+HojGu2iihU1vP2tGpZEo8QosMoVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTXHmUai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3030FC433F1;
	Mon, 11 Mar 2024 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182362;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTXHmUaigIlkKK2eLP2GU9gQF9xJcdz0jVEAhsiLt5aLDnSU/0e00I0D3x2Qnbbho
	 baJa00yavtyCxoH6vnua9XJcIxzAxTorotNzqKlTT+A4EM7ictWnyhx+JmVfW6aQZc
	 pJPKyplAOikOYT8qy9UvJrsZ0ypULTRi2ko2dNyYCSRVUnc/FbXZ/IR4s+dQzRHPll
	 ZFqylER9W/WPiZNKlmSAelRo188DJCWotPr28jKDRdzZ16ALA5IJcoCqutb0Tjp+pX
	 kpdEpDod5YTY7Tw30PTdYgprHIVkaDcoKmyQPpyoRznrmo9sgnzWekAEnnP0w4Wwwo
	 GMGidm5/YNb/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.15 5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:01 -0400
Message-ID: <20240311183901.328749-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183901.328749-1-sashal@kernel.org>
References: <20240311183901.328749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 897f38758a230..b5a35999d8dfa 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2920,7 +2920,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


