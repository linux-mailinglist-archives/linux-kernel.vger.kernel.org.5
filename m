Return-Path: <linux-kernel+bounces-99430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A387882F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C70B2429D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3F664DB;
	Mon, 11 Mar 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZrX1bLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7F664D4;
	Mon, 11 Mar 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182437; cv=none; b=tZV7hmf1mR7evqAsejS3GikNmrLnx66WKB/y5mq4eZ8D2ONJdcQVAWqN3vySqv2UMelPNVs7xMYAOfYkEPh/OBtzjYGRdf/iVj3BKbhwiMKiyLiXGsLpaUKq/OFW/swN2c+R/zbC7bcfvLhTDa5b7S62cO9YEa5oyDU6FCf7mfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182437; c=relaxed/simple;
	bh=NbFoFKDFJZ/lAIRyGGvrwioKM5cI7LsQ0SBfnOwu3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpA4+3MKvBVJzZiPKjoFGHOxbkGecGk394QzxG2rCa4vLv1FIhbzjbgSsrK6Ow1z3LevJW9l/Tfjwhs+yl7MhUvo2SpipdhLCFd6vf1UGswhe27YdbOkBrqjTg456A8g/+n82EVpJdENeR1zR+Ofl++BmflJYBwK+clbBa5WVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZrX1bLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B7EC43399;
	Mon, 11 Mar 2024 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182437;
	bh=NbFoFKDFJZ/lAIRyGGvrwioKM5cI7LsQ0SBfnOwu3Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZrX1bLyIzljat8nEoaKKSd2xkU1YoZFY0lNKZarRlrtwm87McyvJbOFyIhgPS3Oq
	 xSlcaE/s6dag8E9JSBWQKLcx23JGnxwHvPReBsjXiUBqQYweGpFOffDNuLPBUHvrco
	 qCpf7rQvBS2uGv4oMpAzd3KQ/wSWPLu3M0MfGmtZqlJHMs0zCqFlE7fYbSB/1jJ9FM
	 C+miP+9lMGbLDU+G+tx5f4Uw9WiuZGfj3aTBjfas3wkm9D0mCR5wzlZQ7Jb87fr9uk
	 DWzRGp0HCcfIzGBcMRuxTY8xx7aKd+oCAUfMJlUVyAsIYuB02zOQ6CwHfgLxa0GFQT
	 M/TuksDGEh3TQ==
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
Subject: [PATCH AUTOSEL 4.19 5/5] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:40:11 -0400
Message-ID: <20240311184011.329314-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184011.329314-1-sashal@kernel.org>
References: <20240311184011.329314-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.309
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
index 55e041031d398..74321c16e41f4 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2867,7 +2867,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


