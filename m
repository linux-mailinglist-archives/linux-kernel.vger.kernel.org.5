Return-Path: <linux-kernel+bounces-64540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE544854016
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F41F26414
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999A6341A;
	Tue, 13 Feb 2024 23:28:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753D63100
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866905; cv=none; b=ZpOY/uVWqIuSSKqFC2/ChmeViZ45n7omfEnozpx+RkI6OWb3zxPWiBaLk1nDUBqKRkg4K50cQy4n2pg6rPy8JyJZ86Cn7Loyxi+frExVeL39rhMBx/FqBjmPhfNCif5iYn0OlS0H96/LQNTL55+7R4Cm2rSVwdYp2h9yWLYEPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866905; c=relaxed/simple;
	bh=CVvV8hDYr9bL6m/v186v76mN5LV1BfGeIcNkfm5yuxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBb16mw4KHbyJwRaSFR6JOb6WuOGU3aKAgcGCF6OAar5naAs2RhuJAp+L71oGxoI08bBs/GBJzsqhauJ2aGK1+vB5izHS4PnftvJ5l/f+jdcnA4PlSJZmjuiSYDUSU1hTBmpg6/2hjeIATPJmrYiyjtJ8IG5zeif2AF4vtmcNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CI-0000eT-Ig; Wed, 14 Feb 2024 00:28:18 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-000Zco-UN; Wed, 14 Feb 2024 00:28:17 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-002uYW-2s;
	Wed, 14 Feb 2024 00:28:17 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Feb 2024 00:28:00 +0100
Subject: [PATCH 1/3] usb: gadget: uvc: drop unnecessary check for always
 set req
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-uvc-gadget-cleanup-v1-1-de6d78780459@pengutronix.de>
References: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
In-Reply-To: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=CVvV8hDYr9bL6m/v186v76mN5LV1BfGeIcNkfm5yuxU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/sQQgP/ZZy8ylorPv7GT/3A9CuCeeR014oGi
 9Gb6LEjUnKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv7EAAKCRC/aVhE+XH0
 q4VlD/9MdVUKJntclRLZA9+6LfgBeSjMnA8IU3fGMyrHpVnji8ec9PYNN6B32ZBAwLVrXO2AJMe
 /uwnF1rwcMZh3SNwuYd8/F4KNHoGczMBLKde7lMbMqe/dw/ZMFmfu+X8vSFtsEiG7tglYclDVF9
 b7dPDaWNtDfC8NFeDDSpEBXKt6IXAmvrmnU7O2gjA/C7jEwRiVNlwNHemS5aGag001x+ZMCePUJ
 ERP9/oKtX/YbayjsgX8ELtbKtTXP7JafYBCluP2wVCi61KH3hsAr2htd64TEj6Rt9g6F0oWYqqj
 dAgf+AxbexdinTMdIIeUX/pzFKsIQ6vMUctyzGEzRvjrK7YoIIE4SC4ojlEWYqajkKs68KFUvS0
 zVld8t8K7bXeOQjBd5b4p5glYwR5pelkZbqansD/CF105Bg5slCKJeAXb1XEQaN11HtATeYsjkj
 wsSHPL0KuzvE2+BGCSpkRWT+HgiYpDk+k/iAm3i5p8EGPWcFmAlVWzitrbGfxDBQoRiSVbJj12g
 8WkmKm194XIg11UAXmxfLaOHF7N285QK816uedbPsDfKpebN8nbGjZxdNQOpXbVvH+CVNgBZtJ8
 o5uqotVDYFQLZxDLd30L6W5x68yJsfNr+BhHIYBga1tPOXKeBITfsn7ku/Win2YMAuqmrK8qYJ4
 aeAfTYjv/EL7ImQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The pump function is running in an while(1) loop. The only case this
loop will be escaped is the two breaks. In both cases the req is valid.
Therefor the check for an not set req can be dropped and setting the req
to NULL does also has never any effect.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd3241fc6939d..b17c61c932652 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -623,14 +623,7 @@ static void uvcg_video_pump(struct work_struct *work)
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
-
-		/* The request is owned by  the endpoint / ready list. */
-		req = NULL;
 	}
-
-	if (!req)
-		return;
-
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (video->is_enabled)
 		list_add_tail(&req->list, &video->req_free);

-- 
2.39.2


