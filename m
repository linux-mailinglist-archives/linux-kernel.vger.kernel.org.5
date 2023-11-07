Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34FB7E4D29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjKGXZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjKGXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:25:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2C1FFD;
        Tue,  7 Nov 2023 15:24:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C39C433C8;
        Tue,  7 Nov 2023 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399443;
        bh=spoou1fQGxcmL1A5+u2uQy123FFjHiyb6mxfu4lt4q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqiHDXk5pZAE0ujAe1KGNsu+qUtz2M2LCfAEZT+SCC7LvcvcDskDtAGn5cG0aeFck
         a0FBBQGOjcR4NNfM6chFYFd9mH5g6Zn5/Wvs/TpNG+Q7NFzEXqytkYm8A5+kzBJ2Lh
         D6XjyENCZApGEzPdK5LYSHXKwtAybaOtWuYf00d0TIkNRYQLl/jteM6j2ntk7TE4xy
         lef85NLJX+IxSIpQd/C1caI82dJPFOzMNRu1KKuv+PpvepAXHR/3A30wgW++mHY1/H
         aGXWISYvzeL9zYjzS8KxPxKhy1RcxvdEjq8F0RlQe2HU4OlMuXeXDm6HfgA3qMVSxH
         nSZj+I/wWH4Hg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 15/18] usb: host: xhci: Avoid XHCI resume delay if SSUSB device is not present
Date:   Tue,  7 Nov 2023 18:23:10 -0500
Message-ID: <20231107232330.3776001-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232330.3776001-1-sashal@kernel.org>
References: <20231107232330.3776001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 6add6dd345cb754ce18ff992c7264cabf31e59f6 ]

There is a 120ms delay implemented for allowing the XHCI host controller to
detect a U3 wakeup pulse.  The intention is to wait for the device to retry
the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
by the time it is checked.  As per the USB3 specification:

  tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")

This would allow the XHCI resume sequence to determine if the root hub
needs to be also resumed.  However, in case there is no device connected,
or if there is only a HSUSB device connected, this delay would still affect
the overall resume timing.

Since this delay is solely for detecting U3 wake events (USB3 specific)
then ignore this delay for the disconnected case and the HSUSB connected
only case.

[skip helper function, rename usb3_connected variable -Mathias ]

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20231019102924.2797346-20-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fae994f679d45..82aab2f9adbb8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -968,6 +968,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	int			retval = 0;
 	bool			comp_timer_running = false;
 	bool			pending_portevent = false;
+	bool			suspended_usb3_devs = false;
 	bool			reinit_xhc = false;
 
 	if (!hcd->state)
@@ -1115,10 +1116,17 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		/*
 		 * Resume roothubs only if there are pending events.
 		 * USB 3 devices resend U3 LFPS wake after a 100ms delay if
-		 * the first wake signalling failed, give it that chance.
+		 * the first wake signalling failed, give it that chance if
+		 * there are suspended USB 3 devices.
 		 */
+		if (xhci->usb3_rhub.bus_state.suspended_ports ||
+		    xhci->usb3_rhub.bus_state.bus_suspended)
+			suspended_usb3_devs = true;
+
 		pending_portevent = xhci_pending_portevent(xhci);
-		if (!pending_portevent && msg.event == PM_EVENT_AUTO_RESUME) {
+
+		if (suspended_usb3_devs && !pending_portevent &&
+		    msg.event == PM_EVENT_AUTO_RESUME) {
 			msleep(120);
 			pending_portevent = xhci_pending_portevent(xhci);
 		}
-- 
2.42.0

