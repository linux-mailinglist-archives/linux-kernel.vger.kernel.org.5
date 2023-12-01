Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851778012CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjLASbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379334AbjLASb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:31:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB58194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:31:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso1993202b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455494; x=1702060294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QGkTsdRERlNpczcwqSp2Og8v+XNs9gRL2qzJvnknds=;
        b=NAm7TJYYWKXNyXJQqhfgCjmvkRz0pVGCxouKfwO38mMJeiJ23rVzMICF/GVfMZ8ppf
         XDm6mJRBLudjMjQjlp47m2wVOs4IifZCBN/9iMaEIbDOoAiAPXb3AFkjVjvVTzWBlTiZ
         GkP5lpvIVvdufNP1MS3ttUlFaQMJJJEgB4Q1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455494; x=1702060294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QGkTsdRERlNpczcwqSp2Og8v+XNs9gRL2qzJvnknds=;
        b=LDCEHU328gzqq+mHG8TU7bbXMA7B8cHRsTLDy7CMiAOmLgxq46s0YjozfYLs5hXnpY
         A1nqnAMFOfU6Um4IGut3pR0kvK/Ot/OEnkphztktoI8uyPsP340iunUlYIPgjFP0JL7w
         lWpHuLFM4mQpM3KPzVhuSJQ+tQYjxbsnQ2sKucA/w3PqBZo56I77Ge4apQ9/jyZGuXcm
         PYgfOTVy+TQDPDRf+ASORaXCswNXosLhot1teivDaZrUxBmZ5MPmAKHr8Y5XEs7OiapF
         psW9REALrFtWVsYps9vwIV2a1i3NBsVnBI2RmdqjIB/qHUJro5r6i1Q8gnLW0QKMwP5H
         vYAA==
X-Gm-Message-State: AOJu0YzincsHJsW4ZWejqZdr2wXMlB9Ln1Oz0nEaX2YYvXGtWv7q9cZh
        yz6HWb98elWGZzuWrWTM/sfHyA==
X-Google-Smtp-Source: AGHT+IEVreiCKxTXFQEfBUwM2+9H3I4ehz8qYButpoJ4w50/BJH9JRBwy33v+a0gi/YRn62yOPKwgg==
X-Received: by 2002:a05:6a00:430e:b0:6cd:fe6e:ac9b with SMTP id cb14-20020a056a00430e00b006cdfe6eac9bmr3530436pfb.0.1701455494239;
        Fri, 01 Dec 2023 10:31:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11eb:92ac:94e:c791])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cdda10bdafsm3306926pfu.183.2023.12.01.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:31:33 -0800 (PST)
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
Subject: [PATCH net v2 3/3] r8152: Choose our USB config with choose_configuration() rather than probe()
Date:   Fri,  1 Dec 2023 10:29:52 -0800
Message-ID: <20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
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

If you deauthorize the r8152 device (by writing 0 to the "authorized"
field in sysfs) and then reauthorize it (by writing a 1) then it no
longer works. This is because when you do the above we lose the
special configuration that we set in rtl8152_cfgselector_probe().
Deauthorizing causes the config to be set to -1 and then reauthorizing
runs the default logic for choosing the best config.

I made an attempt to fix it so that the config is kept across
deauthorizing / reauthorizing [1] but it was a bit ugly.

Let's instead use the new USB core feature to override
choose_configuration().

This patch relies upon the patches ("usb: core: Don't force USB
generic_subclass drivers to define probe()") and ("usb: core: Allow
subclassed USB drivers to override usb_choose_configuration()")

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Choose our USB config with choose_configuration()...) new for v2.

 drivers/net/usb/r8152.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2c5c1e91ded6..0da723d11326 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10053,7 +10053,7 @@ static struct usb_driver rtl8152_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-static int rtl8152_cfgselector_probe(struct usb_device *udev)
+static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
 {
 	struct usb_host_config *c;
 	int i, num_configs;
@@ -10080,19 +10080,13 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
 	if (i == num_configs)
 		return -ENODEV;
 
-	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
-		dev_err(&udev->dev, "Failed to set configuration %d\n",
-			c->desc.bConfigurationValue);
-		return -ENODEV;
-	}
-
-	return 0;
+	return c->desc.bConfigurationValue;
 }
 
 static struct usb_device_driver rtl8152_cfgselector_driver = {
-	.name =		MODULENAME "-cfgselector",
-	.probe =	rtl8152_cfgselector_probe,
-	.id_table =	rtl8152_table,
+	.name =	MODULENAME "-cfgselector",
+	.choose_configuration = rtl8152_cfgselector_choose_configuration,
+	.id_table = rtl8152_table,
 	.generic_subclass = 1,
 	.supports_autosuspend = 1,
 };
-- 
2.43.0.rc2.451.g8631bc7472-goog

