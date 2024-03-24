Return-Path: <linux-kernel+bounces-113341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA288838D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6E7B237BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D96D1C1;
	Sun, 24 Mar 2024 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsYJ9LzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC1198324;
	Sun, 24 Mar 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320142; cv=none; b=adoNOanJ+Mbndi2eW6Kj65bOgeVQ7jv9KjW3G+xESm5j11mzwqBQwSZe8XgDAj5QfoomW8EoNWriMYTI1Gf1hPNvkMNg7Yj0c+SiLaLPIu7O/YtgBh82r+ukJi7sZAwsax18tXqRKGzfoLwCvd1u3AhHu2zD3USV95O5RskTsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320142; c=relaxed/simple;
	bh=olyr5yeonu8HwmXycVe5CPG9wjhCKW83dLTgGlAk8GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELvWuO5aq/r+Xs8L8vN/3Umb6ph4PAuN2CTAn3RnPq7GvTOH4kXbFyVlEs5n4yeAh83POtomkm8dmPzjKnoBMq88ze6ISo9d8idexO9BrgQnEJBIReyEE5VcFc1Zn0vQaACZ4LXxj07wD1Te8Su6nbZmokvwPsaHRl4dyUNYPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsYJ9LzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C40C433B1;
	Sun, 24 Mar 2024 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320142;
	bh=olyr5yeonu8HwmXycVe5CPG9wjhCKW83dLTgGlAk8GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsYJ9LzVVD68/jP+bG4Qgh+OHrqW0bg0k8jzaE3tQjQJ3eWVqn4fuAIY/GYBlvupe
	 lBXHkXtAW3CVDAQJJTl+3gfHiSpcq1+DmQ/7/q2WkiD2NEJske/vwkZi8sor1OLpdM
	 uIGT+9+7r1D5/YjLX3GZFb0J04Wv6UU7vIDbwDhF7VdrGmjS4IVMm86e876riroD2V
	 M+OmFwMwHXJou8RGMPKMNrNI0POrNM97VXoWejQCeDeAWIogseUe8h8q7E/6Trxnkx
	 CQUIfaPBx24tX4KdxuD6Dz8SoLpGBZZEkpa+BACyNPyAaBIyREVY+ghGeweXLqyK72
	 lfhi7ujMnyssw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 450/715] drm/bridge: adv7511: fix crash on irq during probe
Date: Sun, 24 Mar 2024 18:30:29 -0400
Message-ID: <20240324223455.1342824-451-sashal@kernel.org>
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


