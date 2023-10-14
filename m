Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EDC7C95F7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJNSqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjJNSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:46:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A53CE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:46:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so514700266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697309174; x=1697913974; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tIlXDMVoyF2wOerT2pUZ66SV7AxP60ec1UuPn6vb9Es=;
        b=Iygpm4ufPnV1SrVov1/WohDpC/5TvXpnZDY8onEHX51cCSTaC72er3caFu9GuwN0iQ
         Gnsk+2QU/+zRH3i2h/Sm4nxJj6+haH/0/di6/BiCDIfVM1WXN1uwkFfO0dQZzaSwjJwZ
         EjzqSgftwGCPsX74K6/9tRcbrMRDcRZqjXuAjpcPpJ2yUbEWiX3551a0O4wt4sXMvCoU
         Xk2owSRX7nWg9YAy8bnVg/nlE5+4/7JZhdVmj9pZ/9Wy+bpPfTRREtTolnEEhngDJ/3s
         U0Co0t4sZJo6z5NZ8cHi5wu1LBa+gddBwmpkGPHYp+trRmyVXNADQQxopzM3kvoUkwnV
         rcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697309174; x=1697913974;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIlXDMVoyF2wOerT2pUZ66SV7AxP60ec1UuPn6vb9Es=;
        b=d8N+0xkhiIeFwbM7sfixHtoY7RFfCq85yoyumGr3C1wDw4fBzxcgr3yffpQz7hGPSI
         knpDcrXBDclSSZ/zT6DcTOxbm19FeK4/tfyXyHLrq/hvup98MJ/ItEFfx0VZf3vmlm9s
         FWYrli9MKswxwxzUcPNHkXf6SlLG2UqiYgXUVb77dyoMQxtBJkLp9GiP9IOijEkACrYN
         BBMVwXMXyUCPhcklQcYOO5+ZLOUvSpR3OZCbZNtBx2dVUF88u4OcV79RmY4uok8shMM+
         +V82n0vy9PCTgYuFeUU6qV9gDLdXXC1L0VbsIzwJViZlfRuMJBi8tjtYXEJJxiWh8jCt
         +hzQ==
X-Gm-Message-State: AOJu0Ywwrx6CUwT9XhOObkXcRP10MmQB6j+HqOmbDs7sh8lWXUMxWLf6
        NIEWNdLPQoG6BwgkYNgfHbkJlg==
X-Google-Smtp-Source: AGHT+IF+7WIY16A5/2sv3aIp1+eguS3ta+rt4Qb673/yL+hg4WTNOXpRq6ByJp4xrL7dhwv9TdBY1g==
X-Received: by 2002:a17:906:478a:b0:9be:7de2:927a with SMTP id cw10-20020a170906478a00b009be7de2927amr2183584ejc.74.1697309174209;
        Sat, 14 Oct 2023 11:46:14 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id hz14-20020a1709072cee00b009b654ba498csm1235222ejc.90.2023.10.14.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 11:46:13 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Sat, 14 Oct 2023 20:46:12 +0200
Subject: [PATCH] drm/bridge: adv7511: fix crash on irq during probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231014-adv7511-cec-irq-crash-fix-v1-1-3389486c8373@bang-olufsen.dk>
X-B4-Tracking: v=1; b=H4sIAPPhKmUC/x2MSQqEQAwAvyI5T6Djin5l8NAkUXNxSYMI4t9tP
 FZB1Q1J3TTBUNzgelqybc1AvwJ4ieusaJIZylBWFKjGKGfXECEro/mB7DEtONmF7STSh74S7iL
 kfnfN+nv/x+d5AS+DayNrAAAA
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>

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
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index d518de88b5c3..71022cb8abe4 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1291,17 +1291,6 @@ static int adv7511_probe(struct i2c_client *i2c)
 
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
@@ -1325,6 +1314,17 @@ static int adv7511_probe(struct i2c_client *i2c)
 
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
 	if (adv7511->type == ADV7533 || adv7511->type == ADV7535) {
 		ret = adv7533_attach_dsi(adv7511);
 		if (ret)

---
base-commit: a48e2cc92835fa1d9b373b804b2173c779387b8e
change-id: 20231014-adv7511-cec-irq-crash-fix-6fdd9093dc7a

