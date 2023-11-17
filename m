Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E297EF93C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKQVKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjKQVKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:10:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDA1732
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:09:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c115026985so2493391b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700255397; x=1700860197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wz1t+l8RssdWaevpsmYkaZfUjbmCNYMu71lLo08Sgs=;
        b=kAkHxOwrS5quIbPQh6wjHSXX9Wot39Bcq6Hp/m+/pqUFUhGnZcRl+7btX1SmFR0D5I
         FXtC3Gt36Tpr0pbSdj9GU10CilJmHWfjMp0fKpb9IqpC1Rlkmw3iLhfeeXSbNQCkN568
         K1hyi32Ruf/h0r0k/6VGfXpiaGAnqDc9ctJAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255397; x=1700860197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wz1t+l8RssdWaevpsmYkaZfUjbmCNYMu71lLo08Sgs=;
        b=nA+tub9S7G4yg2violb5uKcowlg7+CtxfmhcgvonF2KVM/s/FYxwKfEY2FKR7xWL8U
         PxbyeMnFRSEZJaZx2nWQtFwKrlU4R3zn0btjU1+fhLWULCl/GycPlQNLYrnMdV2cwipL
         F7+mH0KKdHX7SMGTJ2SBmZ50W9yWbqZaG/Mfqt6i2jNwaDGFgRXpcIPlvuVrMmWlLMjC
         Wc9gASDXRoinOirnFaOe5pesZC9812tIAr63TKdINeZFBMm9w7FpzlgmNf2bOw87l5nu
         DMQ9QtIMsjYgSlfSyhb0CWxlHK5DUxzIi3UJy0vJ4QP3LgKW6ixBDhIgLghbRQ2NMAsV
         eg/Q==
X-Gm-Message-State: AOJu0YzWhZNLxZAIdfoX7Y7CQKcIhqMo79mNSnt9qpbDg8spJYnVVrs7
        2nu4OCuBWvayXXGaTMMSjCZyPg==
X-Google-Smtp-Source: AGHT+IFZoUAtpbAt9CjRIaojkHmlFqJvZdW1uuO02moJ36Q0TclS9DzF+qPPY0wh7Twfrp1yLU3GPQ==
X-Received: by 2002:a05:6a20:748e:b0:187:fe09:272a with SMTP id p14-20020a056a20748e00b00187fe09272amr424763pzd.49.1700255396830;
        Fri, 17 Nov 2023 13:09:56 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b953:95f4:4240:7018])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00219400b006c624e8e7e8sm1780587pfi.83.2023.11.17.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:09:56 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
Date:   Fri, 17 Nov 2023 13:08:41 -0800
Message-ID: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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
2.43.0.rc0.421.g78406f8d94-goog

