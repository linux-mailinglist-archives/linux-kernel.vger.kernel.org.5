Return-Path: <linux-kernel+bounces-113527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4BE88850B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BF31C240B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA21BEDCC;
	Sun, 24 Mar 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUhz9/i7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4C1BEDB3;
	Sun, 24 Mar 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320329; cv=none; b=r83WCzj8I0S6zmeHa1dFsNR7L7ek3EwHh8MhdZ0q87IrGXGMh0hPeLe5ytybbR3iVK33r5udclzOVNT/eglD7FiCiBFP+keAHKW5rtwN9Pr58ZNoyEIXtY0wESJSV1ivPlpmufMAhnGmvKXducbSpDiyFvEoLJov6FVjq8ASQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320329; c=relaxed/simple;
	bh=6DQJougX0ptKj6bY2XsiqJrGTso8eSy+jqQnXQDK+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIVqXpg14Oc0MjJb6KMOYAtIC6bjkyj3ZGI6ESPU5N13E0JxAcKZuXHhScZ2YrArfdqJahm8Laevj8o4oycP66hElq0P7YaCMkJVjkLxG54769elNo69YksoBANZAkzq6cWmNwrr9hygzd/ZZSjWHJmdNAvMsfz9XbB7gjhRK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUhz9/i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5EC433F1;
	Sun, 24 Mar 2024 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320328;
	bh=6DQJougX0ptKj6bY2XsiqJrGTso8eSy+jqQnXQDK+8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUhz9/i7PRpN1OB2789f1rlQr9ICwxkY1IplZrP/yNVlxA6QSFm205lQHvqq0Jcjt
	 MFhEmM3m1JANx21+WEFlER6IT5KXOpRy7WObvS3Im9lQdceiQGIFatU+iOEh+IDxNn
	 OZFMm0p/CQaSRn+N/fW/JzM2Tz432VRhdj/1b35iWCeoMIl17z1WRBBlhBhyV9+LVN
	 W1ioi6lNrRcsKnhUZ0CICNwQ1goI6e51mp0h5Lm0+R6aEJ4+SAweQAjzJ91C9PTpZo
	 XOlyVtifTBLo+9tPRhsybjWcZJXVuBYBmcXYRZXYtwxl5PyIpwnEc2ufCM2QkqfDgI
	 V5RFiYAdgeJSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 636/715] ASoC: tlv320adc3xxx: Don't strip remove function when driver is builtin
Date: Sun, 24 Mar 2024 18:33:35 -0400
Message-ID: <20240324223455.1342824-637-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit f31e0d0c2cad23e0cc48731634f85bb2d8707790 ]

Using __exit for the remove function results in the remove callback
being discarded with SND_SOC_TLV320ADC3XXX=y. When such a device gets
unbound (e.g. using sysfs or hotplug), the driver is just removed
without the cleanup being performed. This results in resource leaks. Fix
it by compiling in the remove callback unconditionally.

This also fixes a W=1 modpost warning:

	WARNING: modpost: sound/soc/codecs/snd-soc-tlv320adc3xxx: section mismatch in reference: adc3xxx_i2c_driver+0x10 (section: .data) -> adc3xxx_i2c_remove (section: .exit.text)

(which only happens with SND_SOC_TLV320ADC3XXX=m).

Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://msgid.link/r/20240310143852.397212-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adc3xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index 420bbf588efea..e100cc9f5c192 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -1429,7 +1429,7 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
-static void __exit adc3xxx_i2c_remove(struct i2c_client *client)
+static void adc3xxx_i2c_remove(struct i2c_client *client)
 {
 	struct adc3xxx *adc3xxx = i2c_get_clientdata(client);
 
@@ -1452,7 +1452,7 @@ static struct i2c_driver adc3xxx_i2c_driver = {
 		   .of_match_table = tlv320adc3xxx_of_match,
 		  },
 	.probe = adc3xxx_i2c_probe,
-	.remove = __exit_p(adc3xxx_i2c_remove),
+	.remove = adc3xxx_i2c_remove,
 	.id_table = adc3xxx_i2c_id,
 };
 
-- 
2.43.0


