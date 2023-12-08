Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221580ADDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574712AbjLHUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:32:02 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420A10EF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:32:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cedc988cf6so742688b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702067528; x=1702672328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2mQlIlH8/Z8tgvJ/zwHnI8QH4gOVcIFjCJw+TXnnTk=;
        b=C4BlyNZuX0vmWiywMiDGcgYLLtThyzY7EqukTWLvqaoLBkfEkaOCCAlU9XXuJPMOqF
         MxSr6/JUGCvuEKavfvhjy+99Y2Y66ayNTY8LzDl2kIvmsfphNMKQpAmheuyYS5KuXkhT
         Met10JV2pE+2z7KRmybincabz6tU+eRbChw0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067528; x=1702672328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2mQlIlH8/Z8tgvJ/zwHnI8QH4gOVcIFjCJw+TXnnTk=;
        b=ZmTapdJZQW0lwbixKOxzNPgnYhznv65++fP26D7b26xrMz/iaDGUINLq1Gk/RMXjYf
         i1K8cYMQNdhvyc2BrH/WyvMvV5iSdg/rigvqD47LTuLKGQQJHxdo4lOvdz0+Vz17w2jw
         2XWT6i6K5dYliQDXLzOVFgeENQqzHBZeBJcK/969j/s2EjmZ4RiSYiLwtQG4pizWdlNx
         vEjbqZWy3fXfJLmfbzKjGPo3zY6bp0FPvsTk6S2TRnoaIEjtSNosmwZ5lJcXSutJIjwr
         nMBhYeo/OI5NAkpE4OCO6Tmm0bJN6ctIlGfSUvq/GzykJjCz1Mf7tya5J7kCRXLi51gJ
         r3XA==
X-Gm-Message-State: AOJu0YycWhtCu/uBk3Byc5wosJm3AOAQwm2g4ZL94lwj7fCjSxTYQLff
        kZMcm0/ksLIDoW4DHipRoKVonQ==
X-Google-Smtp-Source: AGHT+IECgUmTr570zRuFQm0Wq6yqwNKiCLWdOUXopkyxmxMUTqTpcoylkRBQTtmdDdr1KFvNsC8w6w==
X-Received: by 2002:a05:6a00:2387:b0:6cb:bc06:b058 with SMTP id f7-20020a056a00238700b006cbbc06b058mr775362pfc.0.1702067528378;
        Fri, 08 Dec 2023 12:32:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e1ca:b36e:48ba:c0e0])
        by smtp.gmail.com with ESMTPSA id n24-20020aa78a58000000b006ce4965fdbdsm1995691pfa.116.2023.12.08.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:32:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Grant Grundler <grundler@chromium.org>,
        Brian Geffon <bgeffon@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date:   Fri,  8 Dec 2023 12:31:24 -0800
Message-ID: <20231208123119.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/usb/core/generic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..365482347333 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,15 +59,19 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
-	if (udriver->choose_configuration) {
-		i = udriver->choose_configuration(udev);
-		if (i >= 0)
-			return i;
+	if (udev->dev.driver) {
+		udriver = to_usb_device_driver(udev->dev.driver);
+
+		if (udriver->choose_configuration) {
+			i = udriver->choose_configuration(udev);
+			if (i >= 0)
+				return i;
+		}
 	}
 
 	best = NULL;
-- 
2.43.0.472.g3155946c3a-goog

