Return-Path: <linux-kernel+bounces-99388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6E8787AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C162B22427
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927D5D464;
	Mon, 11 Mar 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxe+2nDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED15C90A;
	Mon, 11 Mar 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182245; cv=none; b=oj7B0YTkP2/Ngm+kuyF5bfOJ8lSYyHFAlixSv7up+3xBJWpXHbrdfSScZVr7KwKbHSTtCw1UXkQAZSLK/L5WpJz48RrSZV/WQkyjOJaOD/ThXzlT5foKIz6ngbSbVF2UGpIj4DPOuvLdanU8bE9W2ktbGen7UMMjjjsfMFqN4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182245; c=relaxed/simple;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QryTA9WOmDRHhyXJGkOE23XSSCyWlV41cTLBZxP1f/Lt4dPU6UVBSbGd2sGVn+pwPiT0o/z8DWXtyC5sEQmkGDel4hmu2LqmDzh+uOODogePwt7O7IM5G4Xarmt3T5+d/qCbhvglNDMr1s0B7CclmnQKRDn9U0ULyPiUuQ+6Gr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxe+2nDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2BC433C7;
	Mon, 11 Mar 2024 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182245;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dxe+2nDY7YIM4GTeabi7IPTExVCxzl4tizB/HP8eBeyDPntypoqg06mEurUMvSERx
	 GGqzubZdCUkRliD2pmsUsuZyDm3WAAreJQWuPZLwDwmLxNpLZbAGnu5kdlagErnGyl
	 ib+smzLSQu+NeJLHZrZbVEkRYxVTsS2x0gwW+q3vXNbz4TSgPxBctcHO81FW4t8V32
	 Zj0D+ycuH9hjq++XmHZyN9dCp/flXIpwm2ED8oMbWHr+KmC40ujepiyZFBRTv0y9Xx
	 JngDA4lMTmL4+Q3O0VFF8CD3VPwMXIb2qMsnrGWX6z4kQ2QtylZjRXEc2Ep+9612Te
	 BCAOQBuj0FDzw==
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
Subject: [PATCH AUTOSEL 6.7 14/14] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:36:17 -0400
Message-ID: <20240311183618.327694-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 2256cc0a37ebd..7c6ed29831285 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2933,7 +2933,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


