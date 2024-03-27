Return-Path: <linux-kernel+bounces-120563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68B88D960
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFB1C26D91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE1381A4;
	Wed, 27 Mar 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gVC7Biy8"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAD36139;
	Wed, 27 Mar 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529030; cv=none; b=sfbyDh7SzJdI5eReq+qBUjdljw6hVl2Q70oJ2tzqmibE+JQYsBCThgiO3mTVntI29QQhOv0LbhvMvLNeWIeLHdpahIh+yTuudVN+EqeMhJsVgYVo5G8RrQwmbQ0xhx1G38WfeaMdMfk3YHQR+on89964YWKEEsJoK7wRok6Pvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529030; c=relaxed/simple;
	bh=cbd6GULlhJHFj+W57GD2PRSA9IAx+XadTpMqn6sKLXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFr6g8qk3USx7VFy6sMXW3NQIN6TFody6FEM+Q2EbpHsFJP4u5pxxoTnRa11SbUiBRVGEvtZYxuwjq2kDFacNwxLat893fSdIoAvt6C/EkzB4SwNRdEOVcThFzSCQKJgv8lpOhWPFFh3SjXN7pcHoJi7k3aONz19ACNn/ZruR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gVC7Biy8; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F285FF80E;
	Wed, 27 Mar 2024 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711529026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES9AYn9DDU2tdqD0EP064jr5Z2SbWzjTTb1Ww7Q0SZk=;
	b=gVC7Biy8Y13RV03xjjvfVigmmpyXTBmLYp7EGeQTclWgVI4zKSsBCGt+HYNpudpETKPtP0
	tocr1x5ijZ0bBcj7o8lZJzUXzENZobQ9KYE6wbNLxa4K+NrCX6KbqfzS37ZJbMBQpHfSFH
	5dpbnSW5fxv2pvQzwQVAm/L9I5s2dwJoLhr7YnX/izKKz48p4nC3iClA8DPc3OExfj5p+/
	rb07KHdSG2lTlk1nriYAF/4V3RY09qkoVX31WwCmjNggk0+Tu4W0ISfZkFCCVJpGBAvhjg
	3yWlcCl4yyBdtJHcshiKCAVSvo9SZD3L45OtBlUrx4Rk7k8fVguPeKHRn+gk5w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 27 Mar 2024 09:43:38 +0100
Subject: [PATCH v3 3/3] spi: omap2-mcpsi: Enable MULTI-mode in more
 situations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-spi-omap2-mcspi-multi-mode-v3-3-c4ac329dd5a2@bootlin.com>
References: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
In-Reply-To: <20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Miquel Raynal <miquel.raynal@bootlin.com>, 
 yen-mei.goh@keysight.com, koon-kee.lie@keysight.com, 
 jeremie.dautheribes@bootlin.com, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=cbd6GULlhJHFj+W57GD2PRSA9IAx+XadTpMqn6sKLXU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA9xAmZq8OlpvK656DoBX54JytpZ8m1w4dOlDkNzX
 jgKH6UeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPcQAAKCRAgrS7GWxAs4pF1EA
 CkMw4PGPP4k3fo5bX3sCIYZlP3+TQ7DmgnF8RzvIyEugtDwbhe8tVz/xGRYduFgVQGShiJ5j92VvNW
 FTd9MMl/iG1DCQ0QIkktuB/ml3spIVcX0ChiTZcSkNdhrFXvVj4ldMtv4SXqItMnZP6fx0aFEXpVAp
 LyZpYwJYQoMSNKIL6emVbzCZUK+gY6f88q0g3Q76+pTu7LUAHjDsWdOFA89cctkhKnlZ0ycCxgHsCP
 vHQXe9yd/zb6k+vVDC+vypHL9/lugDF3marizLxtOkESbmgZv/Z14HVCXMKsDSX6N1ITaWx+sockff
 qfq++43/oOT2Gf6YL/VvA0VWHyYBHrySahcTrnK1ZC184RQ92wpc0Pws7OhnU0kQgU9+NgV3K1irdf
 oOQphnzj3xZATv/vm7ChWVj0oU3W86xc5Lv7SsSyoSvdUS3SQjERFlnwbyx6YivIDiCH/tQTVdn9z9
 L3gUyb57zXckhZeVRr0NU9Qs2DgCKf7uDWdTYPj08sFr2JUszYSjAsXzYW1+W6PEdslQhs93nFfESA
 krqaJPo6LrAy8Q8LFP9iQcq2SRSL6oleJ4abxk5/kW1P2udRmms4Wm/WPEluY49ivt7x3UczLS3LSI
 2QBOqlxo3B5i0rupnkegGX/eNZrqLkjuYiFZsa98UyZ1fnOipzjFPCXUjCyg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Enable multimode when a transfer of multiple small words can be
transformed in a transfer with a single bigger word. This is allowed as
long as the result on the cable is the same, so word_delay must be zero.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

---

I am not sure if this is the best place to put such "optimization". I
think this improvment should be in the core, as it is not depending on the
driver itself, but I think Mark suggested something like this so if that
fits to what was expected, I am happy to share this small improvement.
---
 drivers/spi/spi-omap2-mcspi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 002f29dbcea6..7e3083b83534 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1277,11 +1277,24 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 
 		/*
 		 * Check if this transfer contains only one word;
+		 * OR contains 1 to 4 words, with bits_per_word == 8 and no delay between each word
+		 * OR contains 1 to 2 words, with bits_per_word == 16 and no delay between each word
+		 *
+		 * If one of the two last case is true, this also change the bits_per_word of this
+		 * transfer to make it a bit faster.
+		 * It's not an issue to change the bits_per_word here even if the multi-mode is not
+		 * applicable for this message, the signal on the wire will be the same.
 		 */
 		if (bits_per_word < 8 && tr->len == 1) {
 			/* multi-mode is applicable, only one word (1..7 bits) */
+		} else if (tr->word_delay.value == 0 && bits_per_word == 8 && tr->len <= 4) {
+			/* multi-mode is applicable, only one "bigger" word (8,16,24,32 bits) */
+			tr->bits_per_word = tr->len * bits_per_word;
+		} else if (tr->word_delay.value == 0 && bits_per_word == 16 && tr->len <= 2) {
+			/* multi-mode is applicable, only one "bigger" word (16,32 bits) */
+			tr->bits_per_word = tr->len * bits_per_word / 2;
 		} else if (bits_per_word >= 8 && tr->len == bits_per_word / 8) {
-			/* multi-mode is applicable, only one word (8..32 bits) */
+			/* multi-mode is applicable, only one word (9..15,17..32 bits) */
 		} else {
 			/* multi-mode is not applicable: more than one word in the transfer */
 			mcspi->use_multi_mode = false;

-- 
2.43.0


