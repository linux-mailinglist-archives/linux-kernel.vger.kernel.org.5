Return-Path: <linux-kernel+bounces-116252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B9889DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781231F36E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C92935EC;
	Mon, 25 Mar 2024 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdBl9UmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169517F393;
	Sun, 24 Mar 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324021; cv=none; b=ufIsygVek+viVR9at5KqRkszSXSlPZTQkNj7fNfHPgmwWcgR8eE0bRFHfht8mA6ocLw6cka8cq+KrUDsfdFWdy3OopAjbFTKEozVkRR890hqldU5CKIdMGGW3g2gtl9A9DGsTDjm5KXbN92y3I/OyWbiMnwexnEin1lWbGN/BIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324021; c=relaxed/simple;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpMheJ7sG0eQ+GxKjA8ZYfSBPPVsWTHO1NKrW7kswk1PJQArpjArce7RX1mKq4BPJaK8doHfpSSzabt+gSlLFQ0D8GZe0di9Ii2G0rDi1SX8i9EdI32qMiqySJRQRW3wLR1BJgJZiPgI5enBGtfR5wYeMRtnho+6otJFYpS8Dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdBl9UmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79907C433F1;
	Sun, 24 Mar 2024 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324020;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdBl9UmAEGHVa5iTO0ggtJ6ztgYcxVFoZ9mrKltaMiBAdUXrv0yCVaaDS2iMrlI/o
	 K2etTUy/enOle0vKON/ZZYWJv5kBFs5/fHAnEs6WFaTpPGjV8rZc8mDGrwrxF4fVsu
	 dcx47vfNZQxqePHCY/hpgUFXaSETB67OC+3aNX0nJVC3L9a4kCdnG35W0Zjc3dnLzX
	 bocstqcPFQ37iT6/g2g6X+6NDGG2IEHb3hlfGxw1rDcjrtDsCEWg8S1OzXAGOKgcFK
	 TSwp22PBDMhSa1klr6G3kT7bpmWsLDG72VWwWBtSXz0vF4Xl+V/LovkkJuHZnDlQA0
	 f89PR8msGzmuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 021/183] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 19:43:54 -0400
Message-ID: <20240324234638.1355609-22-sashal@kernel.org>
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
index 9ccec511352a0..15828ae62f9de 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2908,7 +2908,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


