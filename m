Return-Path: <linux-kernel+bounces-114586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62108888B29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D841C27D99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B721869DB;
	Sun, 24 Mar 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ77KIhc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E62310C2;
	Sun, 24 Mar 2024 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322239; cv=none; b=P+NJOnCVkexDWZLJNW5Em1ugI9tpzMU9xNKBbaGQHKz36NjV2GJ1BRrPUwHY0eN2xy1ihI0ONDnpLSXALWyR2ZZZoWjJYpZtq0A0Gtz2hPLG4nWqhv0BxryNsY4Gescjft7ZWwb7E5TN1EOFgJA6T+kL7KrPFnlVo6qBhl4k3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322239; c=relaxed/simple;
	bh=7V/ou0JHyZfb2bXwkJZOV950h06hGRhDhCaWaRkIyps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX9Tor+VSpRRyoHH43B2DmKD8wxMRuLmeAFQC/mVXJ71pPmB1Jm9oWeA/OXLe2bHios3iXDuWKSC4SyQ9R7fVTwsgui1xrS/ISq0/IJDBX5gVC1m2xSorm3lEZXEf7+II1u2y4n0AdYDgEqT7UOdIjFf7iEAc0x6wRV6q6n2P9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ77KIhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB07C433A6;
	Sun, 24 Mar 2024 23:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322237;
	bh=7V/ou0JHyZfb2bXwkJZOV950h06hGRhDhCaWaRkIyps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQ77KIhcp+KsAkjt3igr8RHfll1kPLK+tkI+WnVovHz0TddVB1N/rcp6tFbYrBegi
	 Ne2/mLf8WlBK1xMbXjzV0zm1++9wthTC5AOQr6FLnJnKbxn3t3CXgVrjZIPMwzgEmC
	 kNDRFAEygIn6gkQW0dLaYo2IE/7Urm283y6kwDVAXrz1YaqE6URkRA/tcpNDtppdo9
	 rmnXZVvZIC5uIlOlu3kDho1we23cffWW6JyIVdBOmAgPJpov/SCxpoMV+naYMrUyN/
	 90nO6KmcqzZExHlmYEKNI/u6xanCJomw4abgQhiLQsqFnWDwqrhcKYHnKyD6Cqe+Wq
	 cT2MU6Mu9Hsbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 319/451] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 19:09:55 -0400
Message-ID: <20240324231207.1351418-320-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit e3741a8d28a1137f8b19ae6f3d6e3be69a454a0a ]

By default, when mclk-fs is not provided, the tdm-interface driver
requests an MCLK that is 4x the bit clock, SCLK.

However there is no justification for this:

* If the codec needs MCLK for its operation, mclk-fs is expected to be set
  according to the codec requirements.
* If the codec does not need MCLK the minimum is 2 * SCLK, because this is
  minimum the divider between SCLK and MCLK can do.

Multiplying by 4 may cause problems because the PLL limit may be reached
sooner than it should, so use 2x instead.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://msgid.link/r/20240223175116.2005407-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index c040c83637e02..eb188ee950557 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -266,8 +266,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
-- 
2.43.0


