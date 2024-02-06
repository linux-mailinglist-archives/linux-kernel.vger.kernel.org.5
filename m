Return-Path: <linux-kernel+bounces-54637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D732A84B1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919F52816CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023812DDB1;
	Tue,  6 Feb 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jgiw2HAF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295812D76A;
	Tue,  6 Feb 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213671; cv=none; b=lJ86dw1qaYF/66L8WO/FHpOV9gQxVyddHLSadzBzhaS2rqK0CApChWn2EEeilrCB9eRe0r637d0G2bG8Hn5YUnR27JZtGXY63D0s1nKmHulhgRtjBTCfgWivaGPmL8INPhUFNxEJQqw45GFTOCdXUYik6b61iL4vZTWtAtq6Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213671; c=relaxed/simple;
	bh=caIhuFnf9m6uUHtJejN6SlEx1/ZYnJ+H0Oyxmyv7iJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2EjPMbDuMpy7Z8z2QGfHmjIExDFB9R6/dGIzHVBvwnP3uXx+g5cu81nZyYErP68MnuB+IeXYKmyfdmqgA0WEPdfwLHX827+rMAinQrj2mrGOw4QsQvyl0CKbatcw4079uFMl2Eccz5HIJ88SVxlHYLzr9JwDWqP1vZZO0o+sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jgiw2HAF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66648240010;
	Tue,  6 Feb 2024 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707213660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUJWIjAmpTeK0DOnMxXTc9XBVQpcoJptjS8WqnjLSo0=;
	b=jgiw2HAF8Q8IywjKf1MG+0thIFcS+T0a2c5kqWQZujBAQ3Fn2zlEP/+Jtm1Hzj9Eyhqv5w
	GgRvsMtR/nhUoC4lI9UmtNSTdF6u0y4eDraa3C4DrJ+wzUitChysh69teCCZYWn1OCBt2F
	7uXBgqvMm0XJFTDHKOkOWFEajJ7lYv0pilut0b7EYoILFtD+inlyfdFsKzAoW0tUGYxOcz
	M8K1CTLTkCJRVgAqXe1vjLM5DsU69uRe8iQKaEf006CMAFuL4wgSfEqd3s2uSyk6rKLXqb
	uJa1n+upHI+LMD8J80m0S3Bhlzeo3GApRmIYxhMxL5dwPbILpDgqSROqPaMvjw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/2] Add multi mode support for omap-mcspi
Date: Tue, 06 Feb 2024 11:00:48 +0100
Message-Id: <20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFADwmUC/42OTQ6CMBSEr2K69hlaEdCV9zAs+vMqL+kPaYFoC
 He3cAI3k/lmMTMry5gIM3ucVpZwoUwxFODnE9ODDG8EMoWZqERdcdFAHgmil6MAr3fvZzcVjQY
 BG2GbTrWdNFdWCpTMCCrJoIdSEWbnSjgmtPQ5Fl994YHyFNP3OLDwPf1ra+FQgeU3W4tWm7vsn
 irGyVG46OhZv23bDwdVj5zbAAAA
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=caIhuFnf9m6uUHtJejN6SlEx1/ZYnJ+H0Oyxmyv7iJU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBlwgNbLB+1zpm7eL2zv6gJppK6Owa87y0cH+wi62+Z
 nZ7h7VWJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZcIDWwAKCRAgrS7GWxAs4jmBD/
 4hY0z2ZjlRe0MRcrlVf8QNvw6yBFuXPP9MKdSl1nWMDqLilZHzVfD4u2j6o5TTmORnNVsAB8BTJp+6
 +smsa5CZoX9xEmjGPHQdBjVdjh0tF7lYE5ft+FPnvgJz+EeB1UQo8miY5mcxmMLeY9RtFwFaVT2Owi
 JhVPVIAfc8uPZ8r8gNiK7HYoSY/mUSND8rnECYPFd6cbp7ihldEtzh3jGGgIUaQg7qutUQVy5yYLD9
 HycvCeyOu9mrGa+yhAJPwtmJLOtT0dMkB/2pQY8MAeX2TNS53w7/ziadaf4dXNCsAqwP/YPYVxKlM6
 0pziVO+z22O9G+XTS2wk7qbNYk8Q4/VDbAi88mydWjWTlu84w/jmNpDmSyk0Q+p25WbBftP5yhqIzX
 E8+IXWtaomqxzObr54bVPWnV7uP7YSpwFXaL0ZnTfGDLVp3tSZFwJ19TriaYRniNrStKYFmRSmmuJG
 ukXaQfKhDfmsknd8mLdHD4rKc+FfqCxDECPkRuuDEHrz9qJWgrl57bzJkZgYZgMtOwE3Jwxd9yccgV
 FNVM9sDvRmooCe+O6ApXzF2NzW4zHrQTqA2MdNXf95i6P8HemCIXoEpXVnwAWp6Cm5ED3SuYr8lVty
 35x0qQ6QUUR5YqAas4NENJKwcN5buDNh8jY0l4CFI384yuwLv9Z8GVp9aycQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series add the support for the omap-mcspi multi mode. It allow 
sending SPI message with a shorter delay between CS and the message.

One drawback of the multi-mode is that the CS is raised between each word, 
so it can only be used with messages containing 1 word transfers and 
asking for cs_change. Few devices, like FPGAs, may easly workaround this 
limitation.

The first patch removes the current implementation, which is working, but 
don't respect what is asked in the spi transfer (The CS is raised by the 
hardware regardless of cs_change state). No drivers or board file use this 
implementation upstream.

The second patch adds the implementation of the multi-mode, which respects 
what is asked in the SPI message.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Louis Chauvet (2):
      Revert "spi: spi-omap2-mcspi.c: Toggle CS after each word"
      spi: omap2-mcspi: Add support for MULTI-mode

 drivers/spi/spi-omap2-mcspi.c                 | 72 +++++++++++++++++++--------
 include/linux/platform_data/spi-omap2-mcspi.h |  3 --
 2 files changed, 51 insertions(+), 24 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240126-spi-omap2-mcspi-multi-mode-e62f68b78ad3

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


