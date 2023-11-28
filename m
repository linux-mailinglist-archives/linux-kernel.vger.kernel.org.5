Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E57FC886
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbjK1Vk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1VkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:40:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52943AF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cf7a8ab047so46540705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701207631; x=1701812431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7WtPwx8R41CBpic3+n2/ppAFMVmBycWDouGl52CdYE=;
        b=Cded5GjeiRvP8FmVaTNAkOTsvBgLg0RUOr0dNLlcDn6uzNeSqOzge5GakbuAQtYfHv
         Y8A33OD3UR9clg0H3XBJTJqsRCDCkBZjtOwQvatqQCrtFnYADgakYFKwx0tl0ROEHqpl
         bdtBMqsQgNYBXoMG4lpdLvmW5/3AzOmfVR878=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207631; x=1701812431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7WtPwx8R41CBpic3+n2/ppAFMVmBycWDouGl52CdYE=;
        b=voeDiWSaf1TZxcwz6Wen2Zm2vBf7dmoMyZUIdXX3T3XeSxos9k/Hy0QqU9AXfjG+JI
         ffSDKGLhKnrNDFcTe5hTeAIALHqmnPMzdtyJHKh48lDI6YyRrsU7h5i+OPZoTKMrE3b8
         KZSX5zcTO9CslCPWD0aiMLD72KWJNOgTcxD9eMCjUI/gOep/2dibyOntHv1auT+9n+PY
         nsWPa4S3OdHj+SwrR8qatUhdFJw7T9cWfH3Wrn+JxJbCkULlUjlg8s4zgZFdfUxl2Hy1
         33Upgfo6/syjiQtD8pO3i+j3PMTWpEorixUlO5UVQzSJiZg3VDtFzFWARG1/tHBm4Dg0
         YSDw==
X-Gm-Message-State: AOJu0Yz1idG4ZSliPkRuYrSRRnVAVTDgMDztKWF2EhQE39AfBL6NM0P0
        JldGANg52Qa2jKN1Iuq09rI2oSDwuijHEvdQqrpWRS5J
X-Google-Smtp-Source: AGHT+IEJ+SE4dwZTHDytLI9BLtPC9GXLT3KjeJbKe+slGaEI26L2BoS6OzMVsQ/lNtLzU8kXAIkLOw==
X-Received: by 2002:a17:90b:314a:b0:285:ada5:94e with SMTP id ip10-20020a17090b314a00b00285ada5094emr12093978pjb.32.1701207630705;
        Tue, 28 Nov 2023 13:40:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:fc3a:13ce:3ee3:339f])
        by smtp.gmail.com with ESMTPSA id ie24-20020a17090b401800b002609cadc56esm9634285pjb.11.2023.11.28.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:40:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        linux-usb@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v2 1/5] r8152: Hold the rtnl_lock for all of reset
Date:   Tue, 28 Nov 2023 13:38:10 -0800
Message-ID: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
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

