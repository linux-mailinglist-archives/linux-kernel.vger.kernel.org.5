Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F38012CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjLASbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379323AbjLASb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:31:28 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F17129
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:31:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cdd9c53282so2193100b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455494; x=1702060294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb01GRQ68eUgyc84/+R565jrsla/E08IXGMB+9OJhaQ=;
        b=CDMaHPE9v+9nZO1+SszfsPXIqd5f9EKU4uSBGbv1Y4TY0nJrfMWfAWojTNRklK2zbC
         hR+5Yj8xV5FTAQgFbGKrhcgCqH2GfoamqawzP3Yk2fZV5Mz3MRIe3bJvEdBIV8bghoNk
         hZXDMoPP+Xpadr+B1n0cyypEy99oKiAsU5V0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455494; x=1702060294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb01GRQ68eUgyc84/+R565jrsla/E08IXGMB+9OJhaQ=;
        b=s76i6TRzBZjDDVwkabF4SQEgRXbEe3M1oJ5gFYJNsAzImTJQlMofJ76AQFEzVBOrOV
         +G3aR5i8ndhoy3ub4Obyq3riK/ShJWO7CUwPthiJcWmX1il0nstauraMWWy0P7HMLFb7
         jol/JXSc8XS9RMkDmuNkOGb31as0KtKIrlDZTwSQWIK4AWRQUWFpm6dTQpzKC42fCWz/
         nv8vaXk3CONysMT1eN/z7V5uvu3dAGTgV/jaM5tJIiuQntYJ8LQ1htQtwk9OtD8hcjQ9
         oqyXF5u7EK8JtUvw+U/ghIqAY5J/h6DgN8AAQAAH51JaeGULh5PeeM3dPVbxww9AlVPQ
         bBUw==
X-Gm-Message-State: AOJu0YyUp2ou98d60i6zKyHq34D7bNBfoEX28eoQR1VqKv8EO9Z8I6Su
        mWJb3E/yVqLy/Peu9PLaAvpg+A==
X-Google-Smtp-Source: AGHT+IE8ytyPVbqRYk7CYLOc1dseuNIRRK2+hGKn1jZLFV3Q171b71RSlG8/WIPvAesDpkr5kxX5YA==
X-Received: by 2002:a05:6a00:3016:b0:6cd:dc2e:a444 with SMTP id ay22-20020a056a00301600b006cddc2ea444mr8860209pfb.27.1701455492435;
        Fri, 01 Dec 2023 10:31:32 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11eb:92ac:94e:c791])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cdda10bdafsm3306926pfu.183.2023.12.01.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:31:31 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: core: Allow subclassed USB drivers to override usb_choose_configuration()
Date:   Fri,  1 Dec 2023 10:29:51 -0800
Message-ID: <20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some USB devices we might want to do something different for
usb_choose_configuration(). One example here is the r8152 driver where
we want to end up using the vendor driver with the preferred
interface.

The r8152 driver tried to make things work by implementing a USB
generic_subclass driver and then overriding the normal config
selection after it happened. This is less than ideal and also caused
breakage if someone deauthorized and re-authorized the USB device
because the USB core ended up going back to it's default logic for
choosing the best config. I made an attempt to fix this [1] but it was
a bit ugly.

Let's do this better and allow USB generic_subclass drivers to
override usb_choose_configuration().

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Allow subclassed USB drivers to override ...") new for v2.

 drivers/usb/core/generic.c | 7 +++++++
 include/linux/usb.h        | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 740342a2812a..dcb897158228 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,10 +59,17 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
+	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
+	if (udriver->choose_configuration) {
+		i = udriver->choose_configuration(udev);
+		if (i >= 0)
+			return i;
+	}
+
 	best = NULL;
 	c = udev->config;
 	num_configs = udev->descriptor.bNumConfigurations;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 8c61643acd49..618e5a0b1a22 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1264,6 +1264,9 @@ struct usb_driver {
  *	module is being unloaded.
  * @suspend: Called when the device is going to be suspended by the system.
  * @resume: Called when the device is being resumed by the system.
+ * @choose_configuration: If non-NULL, called instead of the default
+ *	usb_choose_configuration(). If this returns an error then we'll go
+ *	on to call the normal usb_choose_configuration().
  * @dev_groups: Attributes attached to the device that will be created once it
  *	is bound to the driver.
  * @drvwrap: Driver-model core structure wrapper.
@@ -1287,6 +1290,9 @@ struct usb_device_driver {
 
 	int (*suspend) (struct usb_device *udev, pm_message_t message);
 	int (*resume) (struct usb_device *udev, pm_message_t message);
+
+	int (*choose_configuration) (struct usb_device *udev);
+
 	const struct attribute_group **dev_groups;
 	struct usbdrv_wrap drvwrap;
 	const struct usb_device_id *id_table;
-- 
2.43.0.rc2.451.g8631bc7472-goog

