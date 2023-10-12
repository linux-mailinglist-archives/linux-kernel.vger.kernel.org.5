Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0557C7378
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbjJLQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344025AbjJLQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:51:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEDCC0;
        Thu, 12 Oct 2023 09:51:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-32d849cc152so1163713f8f.1;
        Thu, 12 Oct 2023 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697129513; x=1697734313; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWIWibPC+lZXM3yshrS/ddiyrVa+kWvtvd0qlqC0KHM=;
        b=S5kW3vxrGqrfxr5izbzQJvRLtbRh4Ndoe72pjv1R5bNt8zJqH3f72/5OTlp6sMsp2P
         CgQIGvZSIL5qjc/JIBBzCZX7mSPbxuhH9wJ8X08dYvv9zz9ONICeGcWkUXQEgoBUaVAp
         45hvdMK5DwaWKe6JHlzzVxRcN2f/GyjEpFdO6LIFuV/B7uTeHk5KyxvD4rraR4lV+fTN
         nclm3xzibMwSRWRr5ele1R4OLKIKN2T18qgVYujXyqgEAk6mMDKykr4i1tFvXg45MS2R
         pB0kDhmprxjYHKmIBomUqypJIBtSmq7iS5l/khN1p5vY0k82vyyubNl+a9TYXUjcei6o
         ipTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129513; x=1697734313;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWIWibPC+lZXM3yshrS/ddiyrVa+kWvtvd0qlqC0KHM=;
        b=wpH7kPErXKfVWOWDdUmdXogeNluqGYGr5U/QJVFfgDo+/93Q+IiXt4xsoctiIKj1eh
         DplIW2AlmHUiUlvz1Bzw8+n5kGg9HCKkB3Q7VKF01DTX3Uf91F+S07GPZwCKVB1Qzizs
         fvorlhzST3TsbyrhABcfSVmRjTU64MQWhFfgF8uroKJm18E+qlPiZyslXNfl7lJ19xZc
         aovq+BlzOXiRPVkxAQIcYpgwpAEb40hVkiBwekzBzn0FhzlNQIB2p4H7/lW85nk8lpto
         Rwq962sWyoFxrx0qiUk/7gSC9nlCkYbB7QSljI6V4/DE7B21gMpme6rLa3gXHK9f5C+c
         mpfg==
X-Gm-Message-State: AOJu0YyA7Lbvz3HvesqaughWG4ZYAUNAytsKJUI61BbGhJ1cDML318Gx
        G9Cvr7AVyWyjttPJvRQwFgI=
X-Google-Smtp-Source: AGHT+IFVikZZcsmhkf4IY3YvUh0p56H1Un3OXiSxM9FhhQ6ne3DWgfOcNjKrRzoZ7VS4LS+hpY1m/g==
X-Received: by 2002:a05:6000:250:b0:32d:825b:e7da with SMTP id m16-20020a056000025000b0032d825be7damr4435591wrz.41.1697129512697;
        Thu, 12 Oct 2023 09:51:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-286e-16e6-ac28-b609.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:286e:16e6:ac28:b609])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm18841529wrp.89.2023.10.12.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:51:52 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 12 Oct 2023 18:51:49 +0200
Subject: [PATCH v2] Input: bcm5974 - check endpoint type before starting
 traffic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com>
X-B4-Tracking: v=1; b=H4sIACQkKGUC/32NWw6CMBBFt0L6bU3Lq+CX+zDEzJQCEyklLRINY
 e8WFuDnuTcnZ2PBeDKB3ZKNebNSIDdFSC8J0wNMveHURmapSDMphOKLm0lz1LaoVf7E9/jiuix
 R5RmCQmBRRAiGo4dJD4dqISzGH8fsTUefs/ZoIg8UFue/Z3yVx/q3s0oueVYUaOqugrYS994Cj
 VftLGv2ff8Bijh3j80AAAA=
To:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697129510; l=3614;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=kRntgPgZIrQXrR1MNd1CkRvqq0k+PSLVRxZtO8RvCqY=;
 b=C9XHmdN7Soco6HIBjGp9ScookTWELwm1IHdUdVPRUyrN8aCspgRlIgwMKlfEiwiwVuVH8AD6n
 FlIgEgG9IJsA/+kT8Q9EIDnd8CZHmoMetatKY3Nx2DxMnV8NZj79bWj
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Given that there was never a check for the endpoint type, this bug has
been there since the first implementation of the driver (f89bd95c5c94).

[1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
---
Changes in v2:
- Keep error = -ENOMEM for the rest of the probe and return -ENODEV if
  the endpoint check fails.
- Check function returns now bool and was renamed (_is_ for
  bool-returning functions).
- Link to v1: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v1-1-355be9f8ad80@gmail.com
---
 drivers/input/mouse/bcm5974.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index ca150618d32f..9fc9dd96c96a 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -891,6 +891,21 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
+static bool bcm5974_ep_is_int_in(struct usb_host_interface *iface, int addr)
+{
+	struct usb_endpoint_descriptor *endpoint;
+	int i;
+
+	for (i = 0; i < iface->desc.bNumEndpoints; i++) {
+		endpoint = &iface->endpoint[i].desc;
+		if (endpoint->bEndpointAddress == addr) {
+			if (usb_endpoint_is_int_in(endpoint))
+				return true;
+		}
+	}
+	return false;
+}
+
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -903,6 +918,18 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
+	if (cfg->tp_type == TYPE1) {
+		if (!bcm5974_ep_is_int_in(iface->cur_altsetting, cfg->bt_ep)) {
+			dev_err(&iface->dev, "No int-in endpoint for the button\n");
+			return -ENODEV;
+		}
+	}
+
+	if (!bcm5974_ep_is_int_in(iface->cur_altsetting, cfg->tp_ep)) {
+		dev_err(&iface->dev, "No int-in endpoint for the trackpad\n");
+		return -ENODEV;
+	}
+
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
 	input_dev = input_allocate_device();

---
base-commit: 401644852d0b2a278811de38081be23f74b5bb04
change-id: 20231007-topic-bcm5974_bulk-c66b743ba7ba

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

