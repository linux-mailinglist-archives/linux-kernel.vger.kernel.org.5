Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ED980CF16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbjLKPLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343701AbjLKPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:11:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E3ED8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:11:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0bcc0c313so24686615ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702307473; x=1702912273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjZ1Q3i+wwEmoaOAEivvc7ulbH4UVbA72KsZePqHS/s=;
        b=HOuflSDFImwQKauYTvTgDYF3QpXRZVnrThFvyJyMCZ1o4kJUJnqppZbYcddW2t+cGE
         +Q8mqfPOdC5SmVxey9C1YiXiL2Ova2ht6hGA6rnX74X3GJCTCEEWW+lGv9tJu/HR7L3M
         /LWmrEb42+9zVbmB/HvszMEjHqWoYb4G/jX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307473; x=1702912273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjZ1Q3i+wwEmoaOAEivvc7ulbH4UVbA72KsZePqHS/s=;
        b=sOGBIIr3C1PkU98qKkcW5F90vq50hFru2jcGstD4usYCq+VYdaOv/NpIqKeBhD3F0s
         PDi+MIr3PMOevKSJKR558F51y7G34PCIVRGozK1PuIamBWlOLpRBZUxYqL26z0KnZ6A+
         EXJvMkglHGSny5YX4nGH/9QewVVthMJ20rBjLLji3MyW4r88TaZpUU9hXqWEMmx9YVzI
         D9V0ZKvPxzN3w/REUa4N2I+/dBY19CKVBdg+5Xs9I3qIUb9Ijh0bC6RalphwxK6EF3GE
         nY1lYyvNmVfnl0RzVUlYdZdv4ch8ov8Ip7Gp85HcdJPsUIKaBlg3b/b2dqwm3DDz9R3K
         Cs9w==
X-Gm-Message-State: AOJu0Yy9c++mNB0iHvenvbQ/+fovJy+iy4IDT75LgaPKo7phFrZiYAig
        hfFPJbMJgpPM1GI4c+voWk3OYg==
X-Google-Smtp-Source: AGHT+IFpOCNYQ3yPBkwpNjfl9h9ryDhS2AHuurPpRtWodHZQ65S7qlnZant5AJQUmuF43IAOCxjBCg==
X-Received: by 2002:a17:902:e74e:b0:1d0:6d5d:5e4d with SMTP id p14-20020a170902e74e00b001d06d5d5e4dmr1735616plf.59.1702307473507;
        Mon, 11 Dec 2023 07:11:13 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001d058ad8770sm6787897plh.306.2023.12.11.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:11:12 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Brian Geffon <bgeffon@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date:   Mon, 11 Dec 2023 07:08:14 -0800
Message-ID: <20231211070808.v2.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that usb_choose_configuration() can get called when a
USB device has no driver. In this case the recent commit a87b8e3be926
("usb: core: Allow subclassed USB drivers to override
usb_choose_configuration()") can cause a crash since it dereferenced
the driver structure without checking for NULL. Let's add a check.

A USB device with no driver is an anomaly, so make
usb_choose_configuration() return immediately if there is no driver.

This was seen in the real world when usbguard got ahold of a r8152
device at the wrong time. It can also be simulated via this on a
computer with one r8152-based USB Ethernet adapter:
  cd /sys/bus/usb/drivers/r8152-cfgselector
  to_unbind="$(ls -d *-*)"
  real_dir="$(readlink -f "${to_unbind}")"
  echo "${to_unbind}" > unbind
  cd "${real_dir}"
  echo 0 > authorized
  echo 1 > authorized

Fixes: a87b8e3be926 ("usb: core: Allow subclassed USB drivers to override usb_choose_configuration()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Return immediately if no driver, as per Alan.

 drivers/usb/core/generic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..2be1e8901e2f 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,7 +59,11 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
+
+	if (!udev->dev.driver)
+		return -1;
+	udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
-- 
2.43.0.472.g3155946c3a-goog

