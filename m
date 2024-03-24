Return-Path: <linux-kernel+bounces-116246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14D88A075
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2377B43D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D03C4226;
	Mon, 25 Mar 2024 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oene+j7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3CC17F37C;
	Sun, 24 Mar 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324018; cv=none; b=o6sYzTY0ClaFcy94zbKidXHZ18j8OI0HYtmnlWq+0ZY7+d7e/8zIkKAxIoQS/lB5A9SXEN3tqt02JB2b3g8qMIJrNqFvyNaGzugnPDhs94JefPBTgZ2WEsLvhY/hSxuNyUyyI5AKv1BMpaqp2XfpHtEH0jIIEk+xPeQzRl/XBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324018; c=relaxed/simple;
	bh=Omoo0aUsEXS6COkhR0n4ABgkiK51ZXRtWGZSWByn3pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4giCcINho+F+KsuqOC2h/xhSb248iot7x01p/WKJALxohxvDogAZmam4kxd5rKOxe0X1PE6oiapWUCF9xL8M54DAwf2BkaET+q1nq8+y8x8e9nm+SvYv0+2uzGnr3rfY5Czz0+mfdjo/TSPaGiJGXc9RKx1VDyS/MPkeHtWXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oene+j7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD6EC43390;
	Sun, 24 Mar 2024 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324018;
	bh=Omoo0aUsEXS6COkhR0n4ABgkiK51ZXRtWGZSWByn3pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oene+j7Lta5JLNJfd7QLXgL6ssa0lnFzcycWq0HiKtN6le5XOhoqjjxeb0aqet5rc
	 qsWlZHiKSzrWjFt1S6/1SjO1wyDOSQBQ+dUt/GPyz9OEn4LI+ulDcfsdvLeTbV+jC3
	 WxbUcQ+/CIm/h5qkVZLY8MYXa78JuJsl6S8/R22vSsJflk1mP+BV1KTtIM+WHPRPMV
	 vqmYsokSOtk8bETk5rsaSs4V/DHC2mxnth/611EP0aDSNm6N9AULOTc8+vnFHWG0T2
	 ScD5FWy9T0XVZOD65TJg/N5jjFfzekjLSu4qiQQgZWC3LVDPlouFHnPq9FZuO8S2QK
	 e4w3iv7RoGqSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 019/183] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 19:43:52 -0400
Message-ID: <20240324234638.1355609-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c384ca3681e9b..c84afc1d02dab 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2889,8 +2889,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0


