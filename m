Return-Path: <linux-kernel+bounces-64538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD7854011
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50731C2418A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11463111;
	Tue, 13 Feb 2024 23:28:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1863105
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866904; cv=none; b=o05TU0dOSRZqev+S/g4uYpWVa+3idUl+6qdVqcKvxZRQgRbQgjWC/ULWQPvl2qiVCYhnt8PJihquq/8GnQCoDohSfKoILi68afxqukRBDrR8vqLegHTHCwCtfXaAVvLUivUbBcmvfhC+9v8TvwrmVRTClul/ssbMbQ9mQ/icIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866904; c=relaxed/simple;
	bh=2XHPW0IeDzyoUhCFA+2qg9dfudNUT0CpxgadG/4rkZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DCOq2Y1ND0oQWq8bYXaKGAF/YL2CT0PYy+w+7210nBRyZih+qLpNPFX+nPaMQcUITi67umfrH0e4ZqfrJRg6LFvj6iJZB/7Rd3Nui4dq9++sk3xlWkcl8zOLCGE7xHPk+UjfZf0mYRbxbyoQimtnVCtKm3iipaNIjxSi9CaI4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CI-0000eS-Ig; Wed, 14 Feb 2024 00:28:18 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-000Zcn-UO; Wed, 14 Feb 2024 00:28:17 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2CH-002uYW-2r;
	Wed, 14 Feb 2024 00:28:17 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 0/3] usb: gadget: uvc: refactor and cleanup the pump and
 complete handlers
Date: Wed, 14 Feb 2024 00:27:59 +0100
Message-Id: <20240214-uvc-gadget-cleanup-v1-0-de6d78780459@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/6y2UC/x2N0QqDMAwAf0XyvICWbpP9ythDjLEGSibtKgPx3
 xf2eAfHHVClqFR4dAcU2bXq2xyGSwe8kiVBnZ0h9CH2YYjYdsZEc5IPchaytqGMcYzL7X7lQOD
 hRFVwKmS8emotZ5dbkUW//9PzdZ4/cKxtsnkAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=2XHPW0IeDzyoUhCFA+2qg9dfudNUT0CpxgadG/4rkZE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/sN+xx0LGEW9HGwwH094+bPtpfsSrcdxPADI
 795T6oH9w2JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv7DQAKCRC/aVhE+XH0
 qzdzD/4s8xWWvujBAqeGrs9leLb+3uZe+etQd8yJMCCikhv8XmiUNzOBDeC5LaHaz6iGyo/Fbby
 uvtg+d8tW20/liJVKihR3BCs+WszQ3Z6YNc4pDoDXIEjXt5F0isDWl+J5e40D5QsdgHTQyN/ALv
 xHg26SyIDBz8bf4AMjYlQqrAFeY23gbzcWCNm3zDQyY4BM2SEea1OGWwSZab6bZLFoYC0/65yHh
 CYg2/7RJTsO3vt+OpEvwAL+rCLYDNuiBv9IQ2ID0zRVzozmUtPr2YV+1vAPNt6v1zJhSpKlAjRj
 nDqlJdMT3weks9wooTxok2UhcGqX9dMt9Y7yev+g7U3L0A/bXeOLk4NrLCZ9e442oiEE0ZmzPFD
 3PS8L/e45mSBkoKkxeVJ3jTK0mlb+w1gHrZZOTkXYq8mpFvSMlFc0+LxLXBCUsEpY6xgjhwF6oD
 FSx6iyUw5fJ4D6ocjgk1KLKZjujAYDjD+uo7x4Z975qVMBGNGavwtk70i8IPhoW/vW4j0SnGjpk
 4P9l+4H5XLTHxH9QJ1QQYwualyPwRFR+hR+5VEYMSuDIeSRr85LNNk+2EKOJqgn4L7P07s2K9ag
 bJLNBxsy8LEoSwfZCcfEAFci9yjivrY8lmXbVzqnpPP3C3WsmbZz5FX0oq862+3mwZkfLoYwUwO
 B72wUYnJNDp1CYQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series is cleaning the complete and pump handler to improve
the code quality. It got really hard to follow the locking and escape
cases since the recently introduced patches.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Michael Grzeschik (3):
      usb: gadget: uvc: drop unnecessary check for always set req
      usb: gadget: uvc: refactor the check for a valid buffer in the pump worker
      usb: gadget: uvc: rework complete handler

 drivers/usb/gadget/function/uvc_video.c | 109 +++++++++++++++-----------------
 1 file changed, 51 insertions(+), 58 deletions(-)
---
base-commit: 88bae831f3810e02c9c951233c7ee662aa13dc2c
change-id: 20240214-uvc-gadget-cleanup-e8484f675c2a

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


