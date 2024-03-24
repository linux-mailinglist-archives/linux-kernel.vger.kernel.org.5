Return-Path: <linux-kernel+bounces-115795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25E889C24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C7EB2B876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933101703B9;
	Mon, 25 Mar 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilwrwybi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A5145341;
	Sun, 24 Mar 2024 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321984; cv=none; b=pDipymZV0BgqGKoGtwasa+1FDLZoRGjQM0QQ464LTLFe9eO7gidyQEDxVs1hQtIAfBLEjv/O+eE3ed3qApfXcZlyFc/mZUivMnuRz3MvZQ9JFXgQ2uij5+x87g8KLCwo2JKga64Onb9PDdZ+qX2F5bcdO0WDIU33rMynz6PHLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321984; c=relaxed/simple;
	bh=TIf3s6V5bENwoiLVAZ6jPbBX6LcknLpg34pqRGhwQso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9LYUAWjJd6kWRqTpeN51qy1uxsQxopwx5XCJQ3LpcIE2kyR+4IipYqHfG1XwPP6iM76Ce0Ekkyc1s7UtIl3P+U4gV0stE7iszPfZI2pSk7OD/E2UZg95CFGF09SPvTWdqtBdbdmXewmsOBfHUT4m58RJRRDQM81P4DT/ufW3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilwrwybi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0101C43399;
	Sun, 24 Mar 2024 23:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321984;
	bh=TIf3s6V5bENwoiLVAZ6jPbBX6LcknLpg34pqRGhwQso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlwrwybiE6iek3AdMs8CubEipBGUAocs7nlf6qMCk3juHz8bSzQlQJ+uXd/nMnZ3E
	 NfkI8UqD14BlzNeQBAV9EQUAnMNNAQxpH8Ac6X5j4P1ufRKvTtiJv5U2DcO5ZE4z9V
	 kt3c05w6W9A+o3MTWB8g2oh6N5EGOxEeBdqqtGu+sUmD5W/VJUxA1e4HTPeLSpoc4S
	 5V7OKt5vsCZljI1VuLRn0l0JZBmPzJFhKBrgHkiLcC74m7HM8mo7SHjIJop3Dbg+Sd
	 +x0jEfaij9p3B19P2Wz+sfZxbiZ2oJ8deLyggIcnLB+ulXIs10Qiy42nmpQpdCRTML
	 OcLtcs+F6xaog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/451] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 19:05:33 -0400
Message-ID: <20240324231207.1351418-58-sashal@kernel.org>
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
index 806b69c9b2e36..d215e58c4a7b3 100644
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


