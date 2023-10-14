Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD147C941F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjJNKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjJNKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:20:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E57BB;
        Sat, 14 Oct 2023 03:20:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32003aae100so2607010f8f.0;
        Sat, 14 Oct 2023 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697278818; x=1697883618; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ie5xf8EyweRzmPDBS9SvXeHusgJJJ9gjTy3vmvQyAo=;
        b=KcQwHAEg9fnSTGZuFDQfe4S958d1ABu66vJylb76e/YDU67frJmXYQm7G+UCRHRHNC
         9a6WpCjVPFL3w/UubDjtcl3lo+q3RYsczTiOfUWw1CaJrTrLAbGx3gjvEJVPmuuyWiC0
         0badNP988mOt3yZkMAPLTpXWkhsdRiiEos7RJXVaaVLDKp906u/J5tvhrddsYwSV5jHF
         y4+Y6A+SrJV/uFW+Nh2/eQGQYYJw2WA7BFB/VoJM3UmmZko2/fHwGAGdQysVu+EB/FXe
         Pkaqj42keS/MCwSHQ2eUG8ESkUVLKHwE/EPmcHd/jjhvlXq8h6e0Dh1b0cY7HIwSciaT
         VY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697278818; x=1697883618;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ie5xf8EyweRzmPDBS9SvXeHusgJJJ9gjTy3vmvQyAo=;
        b=jniV2DCQQOWA3caQytEwbx6I9RXldWLguRGQn6hZKfiR3AwA4NBkiVseJysQGuMWV1
         776FKpMUpx9Dh1vn854xmBxPWoEVTGHY+PtlqWnyeIXW1jKLqlw5/3f8CIHUIXQuuz/g
         6TV9VQXXq+o5+dS+3svEFXSrXnfTqL16d2VGtUwUMscA6wAWiPvvTtjye8J8SI2Lysfg
         dcKM1UYBsrQGNk3/X1/l0OoeKejkKy2fQTpQJBDR9rL/8J0goxOuApysyT1rbhJhhBwk
         GSyenHL7yjgqTICpj8yJmrwJ9c/G4Q0lnmjjuOYEEnCCOKP7sYxr/E9KTYqdnox0/x3G
         F1RQ==
X-Gm-Message-State: AOJu0YwvuOAKxP470kf9+5Yj6PZvlHvLERbf2vPtxc1Efkr9S0f8YsxC
        EjtlJ/7Sj/LfxHkepyv9ECjDXp1nr8YL7A==
X-Google-Smtp-Source: AGHT+IHv4+aMzxNgMkKxkfp1l7K1tJcDgPQsoAHsgt+Q6FwksWagNlKtvxEfQ9mafuFvwRzSb4YEpw==
X-Received: by 2002:adf:a351:0:b0:317:dadc:4a63 with SMTP id d17-20020adfa351000000b00317dadc4a63mr1809826wrb.8.1697278817516;
        Sat, 14 Oct 2023 03:20:17 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-57e7-d911-5fee-d153.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:57e7:d911:5fee:d153])
        by smtp.gmail.com with ESMTPSA id ce9-20020a5d5e09000000b0032d687fd9d0sm11052999wrb.19.2023.10.14.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 03:20:16 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sat, 14 Oct 2023 12:20:15 +0200
Subject: [PATCH v3] Input: bcm5974 - check endpoint type before starting
 traffic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF5rKmUC/4WNzQ6CMBAGX8X0bE1/gIIn38MY0y0LNFIgLRIN4
 d1tOXnS4+zmm1lJQG8xkPNhJR4XG+w4RJDHAzGdHlqkto5MBBOSM6boPE7WUDAur1R2h2f/oKY
 oQGUStAJN4hB0QApeD6ZLU6fDjD49Jo+Nfe216y1yZ8M8+vceX3i6/uwsnHIq8xywakpdl+zSO
 m37kxkdSbpF/FeIqGCCc8lNKbGBb8W2bR/LaZnsEAEAAA==
To:     John Horan <knasher@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697278815; l=3983;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=h8uSGsYbFKdFPkfSUQO12RQLGCv1L8JG0Pt1bF6waoc=;
 b=x0vhKkpSsHchHl8rbD0ZlRP2rJsgtYDu2P9fqM7Vk3UfPBV2oyep599AdTeNlt1lSTrTQ3WBs
 snMQLsuf7xvBAihHhpB8vQ+z37uLHOoEamq2jry6VjmVt4KRngL4iVQ
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

Given that there was never a check for the endpoint type, this bug has
been there since the first implementation of the driver (f89bd95c5c94).

[1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
---
Changes in v3:
- Use usb_check_int_endpoints() to validate the endpoints.
- Link to v2: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v2-1-021131c83efb@gmail.com

Changes in v2:
- Keep error = -ENOMEM for the rest of the probe and return -ENODEV if
  the endpoint check fails.
- Check function returns now bool and was renamed (_is_ for
  bool-returning functions).
- Link to v1: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v1-1-355be9f8ad80@gmail.com
---
 drivers/input/mouse/bcm5974.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index ca150618d32f..953992b458e9 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -19,6 +19,7 @@
  * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
  */
 
+#include "linux/usb.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -193,6 +194,8 @@ enum tp_type {
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
+/* maximum number of supported endpoints (currently trackpad and button) */
+#define MAX_ENDPOINTS	2
 
 /* trackpad finger data block size */
 #define FSIZE_TYPE1		(14 * sizeof(__le16))
@@ -891,6 +894,18 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
+static bool bcm5974_check_endpoints(struct usb_interface *iface,
+				    const struct bcm5974_config *cfg)
+{
+	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
+
+	ep_addr[0] = cfg->tp_ep;
+	if (cfg->tp_type == TYPE1)
+		ep_addr[1] = cfg->bt_ep;
+
+	return usb_check_int_endpoints(iface, ep_addr);
+}
+
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -903,6 +918,11 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
+	if (!bcm5974_check_endpoints(iface, cfg)) {
+		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
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

