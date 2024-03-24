Return-Path: <linux-kernel+bounces-115342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64778889AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E412B1F34C33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788931E6F65;
	Mon, 25 Mar 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgNI9aIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25851411D0;
	Sun, 24 Mar 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320517; cv=none; b=MrK5lErEJium9FEtGpMkdFCLqCkGDx4Fn9iMlQL25L6zDVvaNDAXaatTjTC5J671cpzWJxAZZ9qUZaGS/r3h/9Q7ENADsDlumrBt00fguMUgdPO3P+ut6EI7Xg2XaV2gaXGLbLss8yqT7nIg5DU0jw7zsqCdB7t+ZMAFhH2KJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320517; c=relaxed/simple;
	bh=+QnN6eBvfT5YP0LZVKnQaEsUmmjbX3a5mPdlwG1VBws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrdZSWWRT4nRWWFzDfn3Poh5BzhXc7R019Kf0w+0fE90g03nWLBu3q7VsgyeWok2oDakJceAdOZaY+PU9HZZeaUC4jSPaZUoKTTLVBzLy/eQKLiy7qM5W89WvGulEvDP70Q7LvgUIMWqHLm0rQ4JOzx9wyRhQLsfSUhhydZllM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgNI9aIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0928C433C7;
	Sun, 24 Mar 2024 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320517;
	bh=+QnN6eBvfT5YP0LZVKnQaEsUmmjbX3a5mPdlwG1VBws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgNI9aIWo5eohKg5YV4WK/+v43SYMYjO2L2MuU5UxLmYTO38FozwkiEUSQju+iTiL
	 E8T24LAEm/PKKYGx+ixc0zwJLYcm1oHKxLLM8o08qqJEwrwD6ODsRYFS8yNk9sZHgX
	 M4cydsjfWGlxkLX8K7MFs0Tq77aaYBo53kw1R4Jn/0cDucaz5c7AO64lpR0HU0f0Pp
	 qXvu3xtmB189ULRV3vUh6vt/P7WTVe0tVGXEdmIRdS0bh2uZZNXqHLZil8EWBzspJt
	 YsKcd1fFElb7g9ZjfHXTQDqrbRM7e+qQioWoQUkV0tZlAbGB9RCZxDo4Bw3wOfYlr8
	 WUfsjIuDy8I3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 078/713] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 18:36:44 -0400
Message-ID: <20240324224720.1345309-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index fb90ae6a8a344..6d7bb696b1356 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2914,8 +2914,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
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


