Return-Path: <linux-kernel+bounces-115325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED4889AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F31C33714
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7D1DF7B9;
	Mon, 25 Mar 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGRpm29b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702241411EC;
	Sun, 24 Mar 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320519; cv=none; b=Vn5ZKxLqCoET0mqxlBxNeR+/4PdoHmyOYsBpWkVJgYHMTgKwCepgs+o5cVwSssg56yO4mIo5glyAGr9yyrXbEXmvzhu1eCGE4YFVj8xr1hV+lYdnLSB3TUU31QAdrXUUpjJNBqhrI5r6eGMbUmeviVeeRRHy8sQBba/o8rFBSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320519; c=relaxed/simple;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXK3VMfp1aoR8LwJZFhvVsd0XmvHxuiux1fgZtCuU5PvsMBjGp2VBCrshRLgrZi96v1oEZeSNrbfLnH/7udoME61l3x5+4V/l4/1UHbay5Ej/mgXkF55zLm9I4vJINi97AMPNZmN1q7Ybgg6Lvh306u4BVurjxWlSXlPX5ZWZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGRpm29b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7E0C433C7;
	Sun, 24 Mar 2024 22:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320519;
	bh=KK0r7HLEGlnhN25/A0rpX5LySpg3lS7iiWtkuou51PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGRpm29b1+o44XAddPtujYuo3fsWO20xR013CHD/4nHES6Wd0mBxjK9po7Zgw0LDI
	 3nL+vL7Gp/Xz4CXjA0JOa/y+JvIjpPvRJ3sIigyAJE7++IWNIYNCe8Yd10rrTZMLPJ
	 CiLxgkLkp9W9/TLEoSHPfZRv/A3sZQk5uplB2JI3TyzX8b8IQOQrWNyrRaUNCQqWtC
	 MJlEf8DavKJrD8Tl9Q2M62bxN2PfvNXT2GQ9arqWLG4AuiF5LUdtNyfDG5oyxd8ckG
	 ObREQFDVDKl4UosBrg2LV19lzA/Uu8/JGkclzzzYOD5L9XHSNZknHJfy8E0715XuFP
	 FPR/ZC5+zReZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 080/713] ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll
Date: Sun, 24 Mar 2024 18:36:46 -0400
Message-ID: <20240324224720.1345309-81-sashal@kernel.org>
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


