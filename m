Return-Path: <linux-kernel+bounces-114421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B813C888A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB01F23470
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CAC1774FF;
	Sun, 24 Mar 2024 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPF0Qnqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC2514037E;
	Sun, 24 Mar 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321846; cv=none; b=R+ktJeXE6LQVRJveqUxLvyzE3IJQTjVyM53hpiZ6a3TPlEMWvwexPRQFb18o5q8RKEAt3dd7ejAZRK75LwLalJHaT9A+Boyku/O/gR/uXbhPIZtgCbUOkKxwpSu7DnXL6r3pT2ksXUGkFZe0BfsJIxDMpz2DdOFvABVNG3gbcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321846; c=relaxed/simple;
	bh=6DQJougX0ptKj6bY2XsiqJrGTso8eSy+jqQnXQDK+8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL5CT9XWVF7xc7CHrdmHevYI/tDUYXro2t6G/TRn+z2BbM8O/XhcMkHgQu1jOie1D+5a8SNjTgVtVmDZLrOZk+v0o/w5kxcmNJuIIMHv5Z6AC5O2HZ+N4/vNH/X1cemkomLdwe2/eD2ApDl9RAzx8413caT612l/VvKWN0+Lz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPF0Qnqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43396C433A6;
	Sun, 24 Mar 2024 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321846;
	bh=6DQJougX0ptKj6bY2XsiqJrGTso8eSy+jqQnXQDK+8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPF0QnqjNIh0OpTVzldSnQP+G46iIhwtaDgoq9q2/AghlAEBfiumVI3AKUcQuIxj6
	 WcjovJHzlMtp0zC+nKoRaFyzKvW+aMES/B1+EGNtuhevc/yzWTK+ohGlDqECyj9QU8
	 4ISTXnRW6HJCApOlqSDnlV+tyujpGaWxgh7lLdI1pHsTPmZp7V/7N0yF4w4VMm83Fp
	 qFW4oa+czXrWMzqEqzyIVn1SMknjJHBGWrKQeWwqVyhO79Rg2bX93/LhA0BQidHo0k
	 qlib9sF5waHbwTMbKQqEEIhFAv88spHlF8lge22mGSR6X/3bn8jGoXWJ99iNaloAQh
	 qrgbbxBQKSRBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 574/638] ASoC: tlv320adc3xxx: Don't strip remove function when driver is builtin
Date: Sun, 24 Mar 2024 19:00:11 -0400
Message-ID: <20240324230116.1348576-575-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


