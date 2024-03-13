Return-Path: <linux-kernel+bounces-102065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B080787AE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2398EB22353
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4815959A;
	Wed, 13 Mar 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce/riHKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5A15957E;
	Wed, 13 Mar 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348445; cv=none; b=GeUgRdQoHx8oPxEQzHLSk5/FdkWXYkvumfsax9gU/zsfag/hmYDIsSD4tcNUKGP5zcl5GKTngYHG3DbzblMQAGZZI1Q0NOSxVGJ3cjgNhmStR1fjmrJovrh18r8tVvrLSQUIwt2d5CEqfxJFfdhAabus929RsaTDJIeNnB7d1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348445; c=relaxed/simple;
	bh=+gJvZK5uEADMDRO1Qiqp9iXZojO0nQHMf8DGFsBi2kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+E0Ngvt2KYTSUNJOSvSz3LjkTcgBHqVSluDny7g+HLJ2Luaas4emUS+sgFvD6Uko3vqqdDg9vDl8e7nWCyxjD6b+6a/5ubIqX1XQflywvqf3jAAehT5hkpQIKCPtIasqbg3VESD9vzk3UIoCo5BHNyDJzdKJ3MtFv4SMyjghiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce/riHKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F53CC43399;
	Wed, 13 Mar 2024 16:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348445;
	bh=+gJvZK5uEADMDRO1Qiqp9iXZojO0nQHMf8DGFsBi2kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce/riHKTpWXcBiIEqQCGbhixYP5AhRf1W69q6Ru12WZEofi2vixnFVE6gVuHHfhrj
	 5vyzFAbCsK2Os2plUW93pusofc25IlQfhRYJCs7dBI8+JX+7p2+a5mjLsiXZrpNfrT
	 itm8bOwssN8iGkiGc03LJo95hMovCaCV6Nxd2iEymCc1CR5PZfVEn15FbpN1xo7TeO
	 WD5OHi5SYD9aEvd67SQx22V0+ofnPRg9GsshiacgzCxIYNCx3nKpI0ZCx1TzNhZZ2T
	 Z1PHlpckXV2MOwpRAEbMqMrzHYOXdpH0bp+ZV8ekKZmk3MHgY6Wil1W+nCPQypsOQk
	 azhizZGBT8o4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 39/73] serial: max310x: fail probe if clock crystal is unstable
Date: Wed, 13 Mar 2024 12:46:06 -0400
Message-ID: <20240313164640.616049-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 8afa6c6decea37e7cb473d2c60473f37f46cea35 ]

A stable clock is really required in order to use this UART, so log an
error message and bail out if the chip reports that the clock is not
stable.

Fixes: 4cf9a888fd3c ("serial: max310x: Check the clock readiness")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://www.spinics.net/lists/linux-serial/msg35773.html
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240116213001.3691629-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e0f778d75cd4..bbf45c0626681 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -556,7 +556,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -626,7 +626,8 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
 
 		if (!stable)
-			dev_warn(dev, "clock is not stable yet\n");
+			return dev_err_probe(dev, -EAGAIN,
+					     "clock is not stable\n");
 	}
 
 	return bestfreq;
@@ -1266,7 +1267,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	u32 uartclk = 0;
+	s32 uartclk = 0;
 	bool xtal;
 
 	if (IS_ERR(regmap))
@@ -1350,6 +1351,11 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
+	if (uartclk < 0) {
+		ret = uartclk;
+		goto out_uart;
+	}
+
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


