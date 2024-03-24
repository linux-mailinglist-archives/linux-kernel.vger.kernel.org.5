Return-Path: <linux-kernel+bounces-114059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606A8891BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421F6B21CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E52319F6;
	Sun, 24 Mar 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3EiC3Yy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DD14F10C;
	Sun, 24 Mar 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321343; cv=none; b=PcHrPBsyIQcA9aVNQMNx5sz/HVD9S8uIGZJEbw4LVXDyWn/ySotZ1/TBkkA7WClstslckQ0shPgFM+w0zguzzDslav7+x8xolbShv8D1uiIEQf46LbtCgu/d+fpfMP5iWiGlLw8/mOU0CSJA8Ud47hgejJVgp9+xy8WzdoDevOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321343; c=relaxed/simple;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTNFIlr9Iy2uwr0NbIUAyy53EB98MFQ4KPB+nLXQ9b1pOG+9+urRcQtir8IrU+axvRfdP1/vxrU/oL8NiXa7sh4dM5ewlwG0fer1mHuMAAbQ5mZcpqZPux3ZD2xSVdZadExsuPPfdfme5/EPeApcllST2cyVcWrZZHVSGNzSAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3EiC3Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B515CC433F1;
	Sun, 24 Mar 2024 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321342;
	bh=6i6wxaZzYQIHnPtoUFQzJHucGTNeOHrxMItXv93pAgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3EiC3YynrLOMpX7NFZvLh/vCMWmGrGuwvqxxWoP0fYZMPF0AqlFT0na6BHCohE/j
	 tj71hmoDhtkfIqgVGdEe90aBKxmYIH72bDeEVWVfiKwqrvg3Xv8F1ckmVkpLFcuScK
	 wU9s7PmoCFgiQ11UpQns2uR1LT28hFAqBG710WwchJTQhyxukaNNwz/WHXsUou+PBE
	 1KkNFZUDUReu4HYB7bisYWNW46DhtQxBHm5hxsuYU9OlolZV2Adan7lb9uYUnbG/I9
	 1GHlxKJZszhtKYz4GRLrANVxREdD0Zeck/Tg5YxaonRyJt2ooM5KrhzbMOu+XBFDw6
	 oLiHOmuhtKuHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/638] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 18:51:43 -0400
Message-ID: <20240324230116.1348576-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 914f8eb418357..4f50b07848fd8 100644
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


