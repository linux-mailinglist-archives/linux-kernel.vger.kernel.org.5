Return-Path: <linux-kernel+bounces-102150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E5387AED6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105DDB23F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BA75801;
	Wed, 13 Mar 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvfBZDbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78913757F1;
	Wed, 13 Mar 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349366; cv=none; b=jkuIuAScQYDJsNE0hzy2duDNPoygJuee5EMbrbXHaD9W50lARXATgQhRGJclYLYFI3G4RH3lJwjNdQyK5tM7YS+xF/mlGvTaYKysJKrjgdlHE/ftW326Yxg5Ei24CQIZsXfwOTxNXyWIDdHvRQqO5TKg6j/+mtUQRjcx1Th46Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349366; c=relaxed/simple;
	bh=+gJvZK5uEADMDRO1Qiqp9iXZojO0nQHMf8DGFsBi2kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gicT7sxFuf5xcVxDgDtjQ9axjU1WcUk8Gf3nTT9oaqtBQg27s02PYr7RPmby9jFzESb4b+1r6Lpct4luIaGeY+Eq2o9hLPT8Or7hMHYaiIU39yU0w0nos+qY4kGuGPGoqyM9XRE0uzngBNRwmd05adk53y2gzcmfg2R612tz0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvfBZDbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89956C433F1;
	Wed, 13 Mar 2024 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349366;
	bh=+gJvZK5uEADMDRO1Qiqp9iXZojO0nQHMf8DGFsBi2kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvfBZDbJw9FjCiEWcC+1qTO3NpwvocYO6Sqz0+cXm7U838qDK95o2VHcdpEU/+kFu
	 5y4Az5yhmENWzN2Vt7zlFZGvysllPU8uM6EyyOIGmbxLkx1b4Skf8vRsWlHOe4QXkG
	 T9i3JUygTCHPqFReDh4hb8uzeBccO6YphFitzHTYlRFtE+TP6eBDSrLDp0OLjZoVz2
	 iVB8dEiRxFpUgXSRLa5aYtA3n6ZRBTFKapZY9s4+Hs9kbDM0/FFUaJE96LL5Gy1LMA
	 tvRTjvC4iYFF0IwqKsWyCJli47UZi7uaxXBUr+cCCdZeQz6ILbvLr84tLEK9C2zMPZ
	 5EwGGapZMG/lA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	=?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 29/51] serial: max310x: fail probe if clock crystal is unstable
Date: Wed, 13 Mar 2024 13:01:50 -0400
Message-ID: <20240313170212.616443-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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


