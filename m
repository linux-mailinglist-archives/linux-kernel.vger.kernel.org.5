Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A797B486B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjJAPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjJAPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:36:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47138DD;
        Sun,  1 Oct 2023 08:36:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so2062598466b.3;
        Sun, 01 Oct 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696174560; x=1696779360; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmdLpoJ6TcN7Xdipdv2nukhJol/4LCfAXEpvpvCd3Wc=;
        b=QNq6qhLtOR6sKTXXPQ+SXkh0Fzy4boKT6BNPweHkbqeGk/+WXAVC0ePac+2EjgCGIi
         e04titAOR2U0yuhsN8eruJRmn3W1JKNj9Ps7ONox9Oz1ctFPopvNLVI5EHCSD7WIzMQG
         usP2cj67Op+C3x9MUx90gSKecF+YsEvH5arsf4LDRkU/VsmXypoo6QnT3yBuw/htu9Gd
         N9w1OQYrjNUkI9B3+v56LCodkPu676I88jS7ovUdS3woHPVNw0lpbmQNbPJPZyG+FKwu
         gboVw5WTROJx8yV8Q8qBwQ9C8Lm/fEyxUUxspHitlsIVnBhzjphf1NYvfICVYU4CMA21
         zWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696174560; x=1696779360;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmdLpoJ6TcN7Xdipdv2nukhJol/4LCfAXEpvpvCd3Wc=;
        b=rwSvhS9/27B+OXMnKU4WfVTlzNXIeKbPpPhuFeRcO/nEwg33O66dnIHqhCOBH5K1mq
         g65dNJJZmmO8+63CJhPiPpVeuP3PVdXHknmp8Ly1rZSGBswkIvT0wXZm1UWuxTgwPtkZ
         xZpZvz2wSuniNW5DElXoJNE9tncEvFh1snnYG0TB3GisDG269dyyX7HqooLOKM1lzuV1
         WwdibhKTceTLuDgE0A18drFwLhD8deduFuxoHkX29fzLy/NxcOI9n8QZ1tFqx0clqlE5
         hzaFLlQ+aDrL7bbw31QxpK3yixC9V9SyvmfTtdkWVHXMgUNDRnxne0XtTAYizMJ7tsEI
         gWLQ==
X-Gm-Message-State: AOJu0YwQbtRTx6Q/8v23tvx59wqqjtOsdV+GiDzCRoG2/5fI/YkELspO
        IN31NMx5hn2ventSyyRo/hAtHuNXHJ2QQ0jy
X-Google-Smtp-Source: AGHT+IHliHGVaa9Yo7i43TH9XfQJbZUJ/anBQsIvay4h0thdPlBmXsIo5UBthZ5eG0K5mtydmw1Myw==
X-Received: by 2002:a17:906:7695:b0:9ae:6196:d80e with SMTP id o21-20020a170906769500b009ae6196d80emr9546815ejm.18.1696174559685;
        Sun, 01 Oct 2023 08:35:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-5ae5-46f0-649d-5d1c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5ae5:46f0:649d:5d1c])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b0098f99048053sm15741064ejb.148.2023.10.01.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 08:35:59 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 01 Oct 2023 17:35:54 +0200
Subject: [PATCH v2] Input: powermate - fix use-after-free in
 powermate_config_complete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-powermate_use_after_free-v2-1-505f49019f2f@gmail.com>
X-B4-Tracking: v=1; b=H4sIANmRGWUC/42OQQ6CMBBFr2K6toYWLdaV9zCElDqFSaAl04Iaw
 t2tnMDle4v//soiEEJkt8PKCBaMGHwGeTww2xvfAcdnZiYLWRZaKJ7ChJZP4QU0mgTNHKExLgE
 1jgC4rYrSVlppqwXLI62JwFsy3vZ5xs/DkOVE4PC9Vx915h5jCvTZTyziZ//uLYILLp0zZ6Uu8
 qr0vRsNDicbRlZv2/YFXa4MM+EAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696174558; l=1876;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=cdY7ZWhA2780etiMY3PUD6mlPqBBdhlQbgxc5gMNX8g=;
 b=HqbzC98LBwaKgok0oR2dFLJuh5YKaSB+AOJJ+nCWlBLU62BDK+LjjQSyxtCd33mKpaePXFw0x
 Lw574Hw24OlAa/lG7qyQZYsPGU0guqRK7GrMGZ0Nr9qyv7V1ve6pszW
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a use-after-free bug [1] in the powermate driver. This
happens when the device is disconnected, which leads to a memory free
from the powermate_device struct.
When an asynchronous control message completes after the kfree and its
callback is invoked, the lock does not exist anymore and hence the bug.

Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
device disconnection. Given that this action is already done on pm->irq,
reorder the code to have both calls after the call to
input_unregister_device(), which is the most common approach.

[1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
---
Changes in v2:
- Use usb_kill_urb() on pm->config upon device disconnection.
- Link to v1: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com
---
 drivers/input/misc/powermate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c1c733a9cb89..c0aea75eb087 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -423,8 +423,9 @@ static void powermate_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (pm) {
 		pm->requires_update = 0;
-		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->irq);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);

---
base-commit: cefc06e4de1477dbdc3cb2a91d4b1873b7797a5c
change-id: 20230916-topic-powermate_use_after_free-c703c7969c91

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

