Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8D7FE1C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjK2V0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjK2V0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:26:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE06D7D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c27ee9c36bso213679a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293182; x=1701897982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNCUzlT66xSSzQeRG+3/Vjdg0+tkFMt3clYOj0yBxCw=;
        b=ZPvbimEBh8xSzwTEtOWWe8MrLkwmup8mXmlIf/LDDw3wIQZtQKqvu4z4cZG3icQ545
         xazyz2ORF4ObT7bM6rXCBKc1U1zseYGa29BjCouutJ6/+yohq4zgKUds36bgl4iOPy6B
         4+ds8kxiTIR0fxRSi5Pz+t2uldV7nCBzVbQk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293182; x=1701897982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNCUzlT66xSSzQeRG+3/Vjdg0+tkFMt3clYOj0yBxCw=;
        b=AqFbuVF0nS9hdTWqMCYjmYATGcY1QmevrFn6KxhljFvi/UXqDCRofcLegg5/6Z/Y9y
         eK0Vv0y9ZDBhoFFIgrAbblXVsMIx6Pk3Z78aanGtq/fjsJ8L16sWRdP7bdrOgjinvM4L
         qB4mzxbhMJ6OPcoR3QAEIBZUbnbkJ2BDlhqtBssa/yxSkT9bwanFPXblbQYkDPVqn4fk
         aWUqiQS46wu7bT0AfrHr37Rf6XvsqTcRf5CCCIhOIu1PK90/LKL/Z66ozXP1r8olB0Q+
         pOE57N6Lbx8qNYVbJD4d6lGTcQYJ233yCN7Ls+psIS0BPW82LdH0wPWOJYCVhRYOHvQI
         FTIQ==
X-Gm-Message-State: AOJu0Yx5EHanU/w1UXeJNP0apJ2ZDDVzslZ0Q5An1NruOUBCBPss850f
        qZQYHNQLgLB/0qwe+jsfXnbATg==
X-Google-Smtp-Source: AGHT+IGOwv+JMe9LhytdON3udR8lCNrEUEhKRkteEYEJXfm1i3wfjX3UCluoIHcPnUFu32ZmHv+K/A==
X-Received: by 2002:a05:6a20:244b:b0:18c:fa:17f7 with SMTP id t11-20020a056a20244b00b0018c00fa17f7mr24241206pzc.46.1701293181673;
        Wed, 29 Nov 2023 13:26:21 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:dcf:15e4:5f50:e692])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm11816336pga.70.2023.11.29.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:26:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v3 1/5] r8152: Hold the rtnl_lock for all of reset
Date:   Wed, 29 Nov 2023 13:25:20 -0800
Message-ID: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
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

As of commit d9962b0d4202 ("r8152: Block future register access if
register access fails") there is a race condition that can happen
between the USB device reset thread and napi_enable() (not) getting
called during rtl8152_open(). Specifically:
* While rtl8152_open() is running we get a register access error
  that's _not_ -ENODEV and queue up a USB reset.
* rtl8152_open() exits before calling napi_enable() due to any reason
  (including usb_submit_urb() returning an error).

In that case:
* Since the USB reset is perform in a separate thread asynchronously,
  it can run at anytime USB device lock is not held - even before
  rtl8152_open() has exited with an error and caused __dev_open() to
  clear the __LINK_STATE_START bit.
* The rtl8152_pre_reset() will notice that the netif_running() returns
  true (since __LINK_STATE_START wasn't cleared) so it won't exit
  early.
* rtl8152_pre_reset() will then hang in napi_disable() because
  napi_enable() was never called.

We can fix the race by making sure that the r8152 reset routines don't
run at the same time as we're opening the device. Specifically we need
the reset routines in their entirety rely on the return value of
netif_running(). The only way to reliably depend on that is for them
to hold the rntl_lock() mutex for the duration of reset.

Grabbing the rntl_lock() mutex for the duration of reset seems like a
long time, but reset is not expected to be common and the rtnl_lock()
mutex is already held for long durations since the core grabs it
around the open/close calls.

Fixes: d9962b0d4202 ("r8152: Block future register access if register access fails")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
In response to v1 Paolo questioned the wisdom of grabbing the
rtnl_lock in the USB pre_reset() and releasing it in the USB
post_reset() [1]. While his concern is a legitimate one because this
looks a bit fragile, I'm still of the belief that the current patch is
the best solution.

This patch has been tested with lockdep and I saw no splats about
it. I've also read through the usb core code twice and I don't see any
way that post_reset() won't be called if pre_reset() was called,
assuming that the pre_reset() doesn't return an error (we never return
an error from pre_reset()).

If folks have some example of something that's broken by the current
rtnl_lock strategy used by this patch (or if folks feel very strongly
that it needs to be changed) then I can spin another version. ...but
as per my reply to Paolo [2] I think that does have some minor
downsides.

[1] https://lore.kernel.org/r/f8c1979e2c71d871998aec0126dd87adb5e76cce.camel@redhat.com
[2] https://lore.kernel.org/r/CAD=FV=VqZq33eLiFPNiZCJmewQ1hxECmUnwbjVbvdJiDkQMAJA@mail.gmail.com

(no changes since v2)

Changes in v2:
- Added "after the cut" notes about rtnl lock strategy.

 drivers/net/usb/r8152.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2c5c1e91ded6..d6edf0254599 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8397,6 +8397,8 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	struct r8152 *tp = usb_get_intfdata(intf);
 	struct net_device *netdev;
 
+	rtnl_lock();
+
 	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
 		return 0;
 
@@ -8428,20 +8430,17 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	struct sockaddr sa;
 
 	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
-		return 0;
+		goto exit;
 
 	rtl_set_accessible(tp);
 
 	/* reset the MAC address in case of policy change */
-	if (determine_ethernet_addr(tp, &sa) >= 0) {
-		rtnl_lock();
+	if (determine_ethernet_addr(tp, &sa) >= 0)
 		dev_set_mac_address (tp->netdev, &sa, NULL);
-		rtnl_unlock();
-	}
 
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
-		return 0;
+		goto exit;
 
 	set_bit(WORK_ENABLE, &tp->flags);
 	if (netif_carrier_ok(netdev)) {
@@ -8460,6 +8459,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	if (!list_empty(&tp->rx_done))
 		napi_schedule(&tp->napi);
 
+exit:
+	rtnl_unlock();
 	return 0;
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

