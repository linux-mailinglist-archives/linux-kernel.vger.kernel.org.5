Return-Path: <linux-kernel+bounces-99420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE7878818
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C0D2828D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2464CE8;
	Mon, 11 Mar 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLR/kYdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255E64CD0;
	Mon, 11 Mar 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182388; cv=none; b=GgBJhaxEhOkkxYGrV9W8pncaHphQccpMEm84bOb/2KgFZ1BRWqOd15xhJcITuoqOE2031lmnKKOYX+qlMwC6AQZ4YfesgCRtYFzRQ3yTW+oMHCJHSBBINLYl3G+SxoZkcBktHI+d30g9IChLiZK1ymmYs9Ec7hCjcDRnTfkmfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182388; c=relaxed/simple;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWB3Eu2Sxvw0kxiqpjPh6L4VAPXwELPTrtTB3lyOWZp3UwqcHrnBdOPees+S098CHUhk+5Hat3ejo0+APTalY747htwZZm1g1j3rPG/IzK/SC3mQUdT8xBiJZrNjL9eiBddJhA0TL+aqzH6dFkF+gJVpzp1ML1s/OfDeWCoGOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLR/kYdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B5C433F1;
	Mon, 11 Mar 2024 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182388;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLR/kYdKusZtsgmUX/cUeEI5nQT/nU0rDO/0SWKSRByQwPKEKvY7e42GBh03mk0iL
	 Swf+CH6V/33OzGpjqzQDAzKIQ6nSCmArY8HSyg1I65QP9p1enk7XJGpJP8515VgrRC
	 7/5AzcgQdDR1XXlCixXNMA0yHhy8YqNwcEae8XKsZSr3QCXwviUwfx1m2Xew/9SJXB
	 ifpRfOekG7nGn8PKV7SPzBd97fVobdxsfKqR+FaILTE5t1X6ujcED7sY7vu/1dbQNJ
	 No9rR0wLilns0oJ1HyATYPtOCQfTQ9rgrq1Py+yuXxJXYCNGmvGB2zAO0nmmhN9tf/
	 jK1uR5JomrFVw==
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
Subject: [PATCH AUTOSEL 5.10 5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:22 -0400
Message-ID: <20240311183923.328881-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183923.328881-1-sashal@kernel.org>
References: <20240311183923.328881-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.212
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
index 030471248e0e4..272932e200d87 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2917,7 +2917,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


