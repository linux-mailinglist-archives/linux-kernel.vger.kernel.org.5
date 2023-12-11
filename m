Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8329880CF96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbjLKPdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:33:04 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616ADF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:33:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5be30d543c4so2577181a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702308790; x=1702913590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9nyIKtamCpicw2WPRHA84FcbnZ7MvQb17dWhMR1seM=;
        b=bHOc7iw1f4LInPU0QY/OUI5mmSiPL9kHRlaIduOgjj64lFRxdRmMH3bCzmKG2qpTS+
         jcg99u6XCshn+QB6m/gKVtGCLws1aYJKdq26J0SgtYK5Q2bSPGLnqos6P2Q6XQYENYwB
         57KZA6CfkPopVR7wkD0qLH1LSTscBL6xIYqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308790; x=1702913590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9nyIKtamCpicw2WPRHA84FcbnZ7MvQb17dWhMR1seM=;
        b=skQ6YGg2HzUk6Qn62HttzpzTVJ0t1/et1HvuGIxvbSPNQ7Ec4VS1uSbFH8SZXPAy83
         aoSv/M+TcpYMMoUyITQIbnTEBwS7vuXgGeW/yDEw3ButRcBsdNw3LBkVStddT/+0eczh
         qgBNQJpM8dFNco9t75+PfUGGALuq//sSMrkQoWHS2qFAjbFcux+598v9Ib+tkk9F7V41
         CL7xmrDKAc3eSIKj1Xheo1Z1umLnhCzBSg3puCyp2QvcJWtUDs/7mhl2FAVpsgGGwWju
         4kN+Tn/iG/SnRydapFaFuuzdqx1+UtcuhUCSYf6ZaMe4BMf0yKHxVUJwI9fFpAe9h+39
         m01g==
X-Gm-Message-State: AOJu0Ywo9tk+uCAyCC4qyyiftnUjMz8DywhhTvq5NWNckjycg3sttQjq
        MSutt795t7q+JBHmJKpwqUIsWQ==
X-Google-Smtp-Source: AGHT+IEJ82IJ2l2KnYVTDw2r7IaBgHAFat5OWA0r+Y0uPDs92zOArKh4IAJKuOYTNG1KJWot5LRlFQ==
X-Received: by 2002:a05:6a20:8f08:b0:18c:3260:e20f with SMTP id b8-20020a056a208f0800b0018c3260e20fmr2612497pzk.33.1702308789981;
        Mon, 11 Dec 2023 07:33:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id x1-20020a63cc01000000b005742092c211sm6299572pgf.64.2023.12.11.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:33:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Paolo Abeni <pabeni@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Grant Grundler <grundler@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date:   Mon, 11 Dec 2023 07:32:41 -0800
Message-ID: <20231211073237.v3.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
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
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Add comment in code, as per Alan.

Changes in v2:
- Return immediately if no driver, as per Alan.

 drivers/usb/core/generic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..b134bff5c3fe 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,7 +59,16 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
+
+	/*
+	 * If a USB device (not an interface) doesn't have a driver then the
+	 * kernel has no business trying to select or install a configuration
+	 * for it.
+	 */
+	if (!udev->dev.driver)
+		return -1;
+	udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
-- 
2.43.0.472.g3155946c3a-goog

