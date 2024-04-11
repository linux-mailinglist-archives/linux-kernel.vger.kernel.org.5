Return-Path: <linux-kernel+bounces-140707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB7D8A1802
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E828601F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CFEAFA;
	Thu, 11 Apr 2024 15:01:10 +0000 (UTC)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9CDDC5;
	Thu, 11 Apr 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.59.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847669; cv=none; b=ClKelO+Zpzvulj+7C4v6ZY10YWMlwiNGEFwEk353aTuT144WKDbkAUtqLVsRXGLePOFCvaCnxPups/01djiVr/eEK/6p1D9qloxQhnlOS3PzTcqO4cA8b213tsGc5uZaMRXA5m/3L4dc1yLaNFYyzZsC10BZllWzWT5hmjCv/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847669; c=relaxed/simple;
	bh=tmaDp/QcCqlmZkdQph/55Yo3msDZ1EbEfOjyva7sbr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ6H7js6wqjkcktavgD4oFW4WMI2Dkk6GW6DXNzRpwxKFFDvk+njdpT4KvMSfMQE1vub4/eqs0aeBxUFZDdl9gNp43K6Tye97cPr8mfG+wJ+1iZf3sjS3vB+8XDA091dz8yxsDjD/SFFPwWW/k5azOId1dyMonXNFPtPJTyak6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=80.241.59.204
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4VFjMk09PRz9t9r;
	Thu, 11 Apr 2024 16:52:02 +0200 (CEST)
From: Marcello Sylvester Bauer <email@web.codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>,
	Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	=?UTF-8?q?Matthias=20St=C3=B6ckl?= <matthias.stoeckl@secunet.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] usb: gadget: dummy_hcd: Set transfer interval to 1 microframe
Date: Thu, 11 Apr 2024 16:51:29 +0200
Message-ID: <6295dbb84ca76884551df9eb157cce569377a22c.1712843963.git.sylv@sylv.io>
In-Reply-To: <cover.1712843963.git.sylv@sylv.io>
References: <cover.1712843963.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcello Sylvester Bauer <sylv@sylv.io>

Currently, the transfer polling interval is set to 1ms, which is the
frame rate of full-speed and low-speed USB. The USB 2.0 specification
introduces microframes (125 microseconds) to improve the timing
precision of data transfers.

Reducing the transfer interval to 1 microframe increases data throughput
for high-speed and super-speed USB communication

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index dab559d8ee8c..f37b0d8386c1 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -50,6 +50,8 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
+#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
+
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
 
@@ -1302,7 +1304,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1993,7 +1995,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
-- 
2.44.0


