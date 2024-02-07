Return-Path: <linux-kernel+bounces-57160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB984D49C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE515284B68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83646157E75;
	Wed,  7 Feb 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo5VHiyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B6157059;
	Wed,  7 Feb 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341128; cv=none; b=PS1jHzstMCBdIAEDf25uo9FlSgAC4i9osQlX1/E6/T3VcWB2Hx3dl6w/EiKAZkZrzTro1Xu0KcCzsGOIXqvcmtqBQyV2XTcVtgGwg/6vmVH+kRqbAx51j1/dnwxtAXtcnoSUJel2ou4PdBFcnUh6T3gMeFPC3eRliHIdvxsvqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341128; c=relaxed/simple;
	bh=pUapY0eizi0jwq6pjThZK/3NtTcTS8vPfN1bWyS0kSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzy3ARcKiGii0ZU6LiF9dyXEuO4GPpmPKZSW5TtkuRAkIEMC8C7pTMHNLI2oqiuwQ14yHYNAIZ35Ti32xl2f+JQgotpQ+Ey21KG2/f/KVHgdD8+7mpJa+Koww1DeDBNHePm5mhn3mdnG02lzaMRkDYB5h3ChIBWNPJ+C85CapzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo5VHiyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD34AC433A6;
	Wed,  7 Feb 2024 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341128;
	bh=pUapY0eizi0jwq6pjThZK/3NtTcTS8vPfN1bWyS0kSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jo5VHiyDz8wz/3+MmzRYRYCvpkq3lQL6IVOUD7qjtjV59KLB/mRxppak/AVSNmTFp
	 Tyu/CMc9gCqWrvH9YAkx7wt04SUUisUGNHKV5L9uXiBV8ID8le+AZh5qE5UJCOTvu9
	 Kf/xH0RORqF5TrdlIcllAlkjkmN5bO9SsixSTTodzjdbVY16MwnEmR2B07sA87Cpnb
	 Qoqx5zPI0V0zjvytVDVuorTP3Oac/4ARgs8Yv37FHyDhGfgHCt57LMZi3P+/Aj/gyU
	 gY831TD4E8PLURdjvAjnzz94r8BBEbN0WQ6PKmcmeEkTKKOlcKVx0z2tzsYYmsl4Kv
	 NWEqBywoieyzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/29] spi: sh-msiof: avoid integer overflow in constants
Date: Wed,  7 Feb 2024 16:24:37 -0500
Message-ID: <20240207212505.3169-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 6500ad28fd5d67d5ca0fee9da73c463090842440 ]

cppcheck rightfully warned:

 drivers/spi/spi-sh-msiof.c:792:28: warning: Signed integer overflow for expression '7<<29'. [integerOverflow]
 sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://msgid.link/r/20240130094053.10672-1-wsa+renesas@sang-engineering.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 51ceaa485724..ec3a4939ee98 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -137,14 +137,14 @@ struct sh_msiof_spi_priv {
 
 /* SIFCTR */
 #define SIFCTR_TFWM_MASK	GENMASK(31, 29)	/* Transmit FIFO Watermark */
-#define SIFCTR_TFWM_64		(0 << 29)	/*  Transfer Request when 64 empty stages */
-#define SIFCTR_TFWM_32		(1 << 29)	/*  Transfer Request when 32 empty stages */
-#define SIFCTR_TFWM_24		(2 << 29)	/*  Transfer Request when 24 empty stages */
-#define SIFCTR_TFWM_16		(3 << 29)	/*  Transfer Request when 16 empty stages */
-#define SIFCTR_TFWM_12		(4 << 29)	/*  Transfer Request when 12 empty stages */
-#define SIFCTR_TFWM_8		(5 << 29)	/*  Transfer Request when 8 empty stages */
-#define SIFCTR_TFWM_4		(6 << 29)	/*  Transfer Request when 4 empty stages */
-#define SIFCTR_TFWM_1		(7 << 29)	/*  Transfer Request when 1 empty stage */
+#define SIFCTR_TFWM_64		(0UL << 29)	/*  Transfer Request when 64 empty stages */
+#define SIFCTR_TFWM_32		(1UL << 29)	/*  Transfer Request when 32 empty stages */
+#define SIFCTR_TFWM_24		(2UL << 29)	/*  Transfer Request when 24 empty stages */
+#define SIFCTR_TFWM_16		(3UL << 29)	/*  Transfer Request when 16 empty stages */
+#define SIFCTR_TFWM_12		(4UL << 29)	/*  Transfer Request when 12 empty stages */
+#define SIFCTR_TFWM_8		(5UL << 29)	/*  Transfer Request when 8 empty stages */
+#define SIFCTR_TFWM_4		(6UL << 29)	/*  Transfer Request when 4 empty stages */
+#define SIFCTR_TFWM_1		(7UL << 29)	/*  Transfer Request when 1 empty stage */
 #define SIFCTR_TFUA_MASK	GENMASK(26, 20) /* Transmit FIFO Usable Area */
 #define SIFCTR_TFUA_SHIFT	20
 #define SIFCTR_TFUA(i)		((i) << SIFCTR_TFUA_SHIFT)
-- 
2.43.0


