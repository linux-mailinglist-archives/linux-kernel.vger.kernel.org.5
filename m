Return-Path: <linux-kernel+bounces-114945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB6888C17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B25293B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25062DB384;
	Mon, 25 Mar 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy/9QRGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC617A382;
	Sun, 24 Mar 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323656; cv=none; b=nTQM/X1wUmZneMFNmWGgwQl4JvxIX/DZrl50Ex+S8NQ32k9sxIG6V12iX+f7mvyaVRRpLp8SbU51jdQkypUVrXqm9+OE+u4rxRyQBB0/flOQiDYT8ugsYw0gabSrqxqvnw1KiVcHC46BW9cmU6z0T3PehVsBTbZwxy7u8pkG7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323656; c=relaxed/simple;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le0I0NnrpMtAr0NuON4WSLBW91y0y2pn2Ow336F2qavNIfaJMf00tuG8HvfdBnx7SgQwl8qrt0LvVPdu3Y0+fDwQ6zHo7SFMA+3iZ7thK3cJavdZjLWKN2zEH+ZfuR5brvFrXXc540mniFQlqUCqAU72LiwWX2pKU7eTflUiaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy/9QRGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7274C43394;
	Sun, 24 Mar 2024 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323655;
	bh=iu26nAz5LeR10kqCU52zW6G6ji5s+n5Q4x2xWSNy2VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dy/9QRGun6yb9JlUBh3VcEBYX2/q1fOh1scaPDatNdj5gzVGuh406yHIRcin+KMO4
	 ebCY7dzmY51eO3/ZUWafJYtE7ydXMpUwF+UPFUOxH1Guvpzd6TLKIJGACQFV3Wymik
	 Db5PkRbcTACPvChRxlbqPY1IchN4BjMG9qbfGqJh90/VQ1YbWq3FZHbGdVZCQyQB+u
	 4ahngzhsCgPQ1eZh3Hy44W2OQfZucA8gbsiibGqpAij3si07/dilSwOZGPNUeFWWtX
	 eiIE2t1YJEV6oZcU+SLTIVyzUdsr7cOWG55hZ34PrVuW7OZ3FQP3ASklKePM/TJbjw
	 q92pyrTTNU36g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 027/238] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 19:36:55 -0400
Message-ID: <20240324234027.1354210-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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


