Return-Path: <linux-kernel+bounces-113866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D4888EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CA91C297E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F5137C47;
	Sun, 24 Mar 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3scmx6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC61EAD4E;
	Sun, 24 Mar 2024 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320920; cv=none; b=Nl09935TqS5dr6/QQoTn7SrokVHz+y4W8IDDz9/mK+HvlXXmRdER6A3tW8kIsBHa64Umt8x1cKfbPO6MQoYUdcjRjnyJZKxl3AEdV7+Oi7VRgVEGEWSN+mK+hsuco6qpqWEljEVG+3FZ/Y73ZkfEaRC1P24RfC3T4lSMvsP54/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320920; c=relaxed/simple;
	bh=olyr5yeonu8HwmXycVe5CPG9wjhCKW83dLTgGlAk8GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/9wchCXOY9SMvwd8/mGp9XlDCHu1DYROBhYqACgD7+tvMWCksaTWSfNDgbai6QxizjFqURjtm4SKc8qNM3KlPCyfD9NcK8Gu0o6QIB/5gcCdKBN2GXgtvPVkG/pabuREJAayiZvGZTNNx20FYcg93VrjSYo/e2CQ/OAgZG47Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3scmx6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EB7C433C7;
	Sun, 24 Mar 2024 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320918;
	bh=olyr5yeonu8HwmXycVe5CPG9wjhCKW83dLTgGlAk8GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3scmx6hlLnpKqH1c3cPrXFc622GYnl24wn41hxObhFR83TQRbawoongglDrqTvLC
	 k5byREhC1cFHRN8YG7VLIhyqM45zYJDPm1RMj/TMbZW8e503fuYn5KfQcP9gcqPZXf
	 OmJPBShaNNwJh4Us1AwoH7mBfbwHYfyWkc9k2+aKQic53NxwOlYyoehXMeyj30ljqK
	 ykqbbelXIjylTBEC5wkSXLxRPO57S56TPmtCaLoPJiQlwV9rwRbR5f+dJ4t9mG2Rsy
	 zciO1U32442ufcjGQA5h1L5b5t5EUkjHv7K2rBmoyTdkzX4WJ8H8RPnm2acaxqyixt
	 tsuT9a95QDUUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 482/713] drm/bridge: adv7511: fix crash on irq during probe
Date: Sun, 24 Mar 2024 18:43:28 -0400
Message-ID: <20240324224720.1345309-483-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>

[ Upstream commit aeedaee5ef5468caf59e2bb1265c2116e0c9a924 ]

Moved IRQ registration down to end of adv7511_probe().

If an IRQ already is pending during adv7511_probe
(before adv7511_cec_init) then cec_received_msg_ts
could crash using uninitialized data:

    Unable to handle kernel read from unreadable memory at virtual address 00000000000003d5
    Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
    Call trace:
     cec_received_msg_ts+0x48/0x990 [cec]
     adv7511_cec_irq_process+0x1cc/0x308 [adv7511]
     adv7511_irq_process+0xd8/0x120 [adv7511]
     adv7511_irq_handler+0x1c/0x30 [adv7511]
     irq_thread_fn+0x30/0xa0
     irq_thread+0x14c/0x238
     kthread+0x190/0x1a8

Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
Signed-off-by: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240219-adv7511-cec-irq-crash-fix-v2-1-245e53c4b96f@bang-olufsen.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 8be235144f6d9..6fc292393c674 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1277,17 +1277,6 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
 
-	if (i2c->irq) {
-		init_waitqueue_head(&adv7511->wq);
-
-		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
-						adv7511_irq_handler,
-						IRQF_ONESHOT, dev_name(dev),
-						adv7511);
-		if (ret)
-			goto err_unregister_cec;
-	}
-
 	adv7511_power_off(adv7511);
 
 	i2c_set_clientdata(i2c, adv7511);
@@ -1311,6 +1300,17 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	adv7511_audio_init(dev, adv7511);
 
+	if (i2c->irq) {
+		init_waitqueue_head(&adv7511->wq);
+
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+						adv7511_irq_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						adv7511);
+		if (ret)
+			goto err_unregister_audio;
+	}
+
 	if (adv7511->info->has_dsi) {
 		ret = adv7533_attach_dsi(adv7511);
 		if (ret)
-- 
2.43.0


