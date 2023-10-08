Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B832D7BCFC8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbjJHTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbjJHTQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:16:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5848AC;
        Sun,  8 Oct 2023 12:16:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1088092966b.0;
        Sun, 08 Oct 2023 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696792592; x=1697397392; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsylpQf7X1mm72N/86c1cHvtLeAB33CaIt+8Z0lEbY4=;
        b=KHku8+/DgmVOCdcDcPUYzTcfJtmFVZYTcEmF4jcjkYwaYjx+Fv+AHRdvbHh/x7J5cA
         W2RLgmAX0yOMTUF7AayfA6r/+CXSkdkGWK1F9O63SVoJKi3moZ0p1uNDijo/0bZ8ui/l
         QZDbDJlPSirWP+ILfqX151HlO1DMT5gwGJznoN8LHz2eFf33G8I0hJtrU/7gZdTxDm/W
         n7HPAUWjKitN5bbYWyKUBZjyF5uDVvuk5hb4BmIMcMldcm1fL/T+yGtOBwLJN2UYEnnr
         +gTgxbSxsm505VXfFF4jfx3dyE+WvjZALXBRP3jiGDt9A1FaPoBQdXrbEflh8HS28KaG
         eezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696792592; x=1697397392;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsylpQf7X1mm72N/86c1cHvtLeAB33CaIt+8Z0lEbY4=;
        b=lzA7EA3HcsWAgw1Lw5rCeqXloFNF3s7s1Hd62PbiN/OGo1tGPXyvJtWqLTWhmFAfQi
         kg+XV4gCdojO7SFNf4FNqs5+hMdQyswvM8TwAspTtA/cEoYaEns7Fuc0UUXW5X4VfKex
         Y7pReSw4MkiOMC4QR5cPh/tq0SU2ghcV/ar3iiOvjXGwVcnoQPv+prT8uNFseA8JAB8V
         BBnDRaUIw+3Io7Aq0KqMnTsw/BeK3g98TAFtfaJrJuqxEIy3lMdINVI6O/bxSI4DU+XP
         dOPa23el3FeXk0In+h9t/OyBJa+jE186rL0QF5Xyo1LsAEIumVUEQSGGY8o4nWi7k1Hp
         dWqg==
X-Gm-Message-State: AOJu0YygEkYR9onSHSzn+C7jR6RDhSry0khwf+A0vzmIE3KqrOiGT+OU
        +YxR6x5Rnpdv5oZ8nx6rZ+kYJu0GQyY1xQ==
X-Google-Smtp-Source: AGHT+IEKqFGjF2KU+uQE7lfBOyp33gaom5ee6pCL9uzsv5SBhwf9sC0jIeRa3A4k1uLud/H4Hi0YQA==
X-Received: by 2002:a17:907:2ce7:b0:9a5:9f3c:961e with SMTP id hz7-20020a1709072ce700b009a59f3c961emr9927426ejc.18.1696792591788;
        Sun, 08 Oct 2023 12:16:31 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-4a45-171a-1368-697e.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:4a45:171a:1368:697e])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00997cce73cc7sm5796251eja.29.2023.10.08.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 12:16:31 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sun, 08 Oct 2023 21:16:30 +0200
Subject: [PATCH] Input: bcm5974 - check endpoint type before starting
 traffic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231007-topic-bcm5974_bulk-v1-1-355be9f8ad80@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA0AI2UC/x2N7QqCQBAAX0X2dwvnRx71KiGxe265lKfcWgTiu
 3v2cxiGWcEkqRhcixWSfNV0ihnKUwFhoPgU1D4zVK6qS+c8LtOsATmM54tv7vx5vzC0LfumZvJ
 MkEMmE+REMQxHOpItkg4xJ3no73+7ddu2AwiOEAJ9AAAA
To:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696792590; l=3489;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=veOgRjNyPagrKkSeY1Im90/VmK4rAwlN1gcQaLDbDUo=;
 b=2Uz0XsmVKpvoU9ILu7CY8nKQ26vz7KFXoUj2TcriMNmjUbj/90H3Lfy2M2t9JgueYar+OrLID
 bJKck+Do5S4AmiHwi0xaRQYP1d04UcmYoYphjgMypkB953SLa/GZhqf
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

syzbot has found a type mismatch between a USB pipe and the transfer
endpoint, which is triggered by the bcm5974 driver[1].

This driver expects the device to provide input interrupt endpoints and
if that is not the case, the driver registration should terminate.

Repros are available to reproduce this issue with a certain setup for
the dummy_hcd, leading to an interrupt/bulk mismatch which is caught in
the USB core after calling usb_submit_urb() with the following message:
"BOGUS urb xfer, pipe 1 != type 3"

Some other device drivers (like the appletouch driver bcm5974 is mainly
based on) provide some checking mechanism to make sure that an IN
interrupt endpoint is available. In this particular case the endpoint
addresses are provided by a config table, so the checking can be
targeted to the provided endpoints.

Add some basic checking to guarantee that the endpoints available match
the expected type for both the trackpad and button endpoints.

This issue was only found for the trackpad endpoint, but the checking
has been added to the button endpoint as well for the same reasons.

[1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
---
 drivers/input/mouse/bcm5974.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index ca150618d32f..eb552bb4751e 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -891,6 +891,26 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
+static int bcm5974_int_in_endpoint(struct usb_host_interface *iface, int addr)
+{
+	struct usb_endpoint_descriptor *endpoint;
+	bool int_in_endpoint = false;
+	int i;
+
+	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
+		endpoint = &iface->endpoint[i].desc;
+		if (endpoint->bEndpointAddress == addr) {
+			if (usb_endpoint_is_int_in(endpoint))
+				int_in_endpoint = true;
+			break;
+		}
+	}
+	if (!int_in_endpoint)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -898,16 +918,31 @@ static int bcm5974_probe(struct usb_interface *iface,
 	const struct bcm5974_config *cfg;
 	struct bcm5974 *dev;
 	struct input_dev *input_dev;
-	int error = -ENOMEM;
+	int error;
 
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
+	if (cfg->tp_type == TYPE1) {
+		error = bcm5974_int_in_endpoint(iface->cur_altsetting, cfg->bt_ep);
+		if (error) {
+			dev_err(&iface->dev, "No int-in endpoint for the button\n");
+			return error;
+		}
+	}
+
+	error = bcm5974_int_in_endpoint(iface->cur_altsetting, cfg->tp_ep);
+	if (error) {
+		dev_err(&iface->dev, "No int-in endpoint for the trackpad\n");
+		return error;
+	}
+
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!dev || !input_dev) {
 		dev_err(&iface->dev, "out of memory\n");
+		error = -ENOMEM;
 		goto err_free_devs;
 	}
 

---
base-commit: b9ddbb0cde2adcedda26045cc58f31316a492215
change-id: 20231007-topic-bcm5974_bulk-c66b743ba7ba

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

