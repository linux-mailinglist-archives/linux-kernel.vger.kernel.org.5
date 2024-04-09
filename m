Return-Path: <linux-kernel+bounces-137638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8D89E4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2821028406C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E3158A27;
	Tue,  9 Apr 2024 21:25:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36C158851
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697905; cv=none; b=aPWdHWnt/rPbP/E16dtNNfZJQ/MZjSVozlz3AYdFDuHTiu9SVPpqk1OrCaBNgOlcc5vqfhFACzbkjKP19WAVc+9SVn4xsQpVymzXRvRxBSy9vYxvIH6EhiANterjIRW8H/0wPgluZz1iGwsQzdUoUkMUnTMIIGyXp3d7hZJoQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697905; c=relaxed/simple;
	bh=BXSDolwWzU5tAWjmREDmfTdkudqshVOcwopesXpiiLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uWgvVbxLXMzEZ9rE4YgJaRVymT3fUQhBgi3LfZXiPqpvlxF9rL/6fgBZAs57MSqSd+/jZaz+FK+Eh/k03V9AH766C2UR/PGeL+7Yf2Bs0uQoV5GX3X+xuB8Bk/lJ/4UCy8k85hF8KcbceF7aBp+unP05nKxdXnpmHymDSvJcRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxf-00081b-FR; Tue, 09 Apr 2024 23:24:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00BNAf-R4; Tue, 09 Apr 2024 23:24:58 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00FQKu-2R;
	Tue, 09 Apr 2024 23:24:58 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Date: Tue, 09 Apr 2024 23:24:56 +0200
Message-Id: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiyFWYC/x2NywrCMBAAf6Xs2UBsq1V/RSTksW0XwqqbB0rpv
 xs8zhxmNkgohAlu3QaClRI9ucHx0IFfLS+oKDSGXvejHvWgSvVG8F0wZRORl7wa9zXEGaXaqOy
 EczhdpnA9D9AiziZUTiz7tWW4xNjkS3Cmz/96f+z7D/EVBJKFAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=BXSDolwWzU5tAWjmREDmfTdkudqshVOcwopesXpiiLw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmFbIpHaFNod1WQlhnldeCskg5hmmieH2EkxFzp
 FyRMtNS/2WJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZhWyKQAKCRC/aVhE+XH0
 qzIAEADCiH8P3Z9MDcX2+X8cFt7JEd/bYDEkkmp6aDKGKge65CvUKi5XCy/3B3N45610qbSNWlD
 uAgYUOGeyARI165tSAc61FRS2jyMApjjdh5qPBMOyKFzzLcfk9XwAvysSWUDGc7oGDOxvTANRxW
 sCZw944vxOd9nMDPIQzioOhhtScIhwyva1m8fqe8HMln5NKUfp9j1yrmGtPXlCfXca0jzgz+fw6
 juYtOhpQHv76+2tsVbv7bbs4GuJ0V6n+g0DPIi7U5cdOb9WLvDOlF+KNVvKAFLeoQ0KptpcsQbZ
 wrGi463NMgH91ikBStP03B5vtmtwB+7OLk+Chm3UNw6dPEkrmxbFHRCcl4JSO2e/+smw+HiCMlQ
 PO/mErKCtNXCBvxvZDZoQ9TvzIKGfo1XcNrpcDqMZZ3cHpGTdU6QKm1ipmUJjRgdp0O6JVgH+YP
 6GgeJe3FASut5Qk04RcKVcGD1h31gImlhDLLBP1CR/44ryG3Mnmx8+/ZkESpx1FEOhxKwYWTUHH
 qAjRfy4iIl58bMdKqD/dnxBsgBShPwbAw33NEiJrDbSBAoNxTPHT1wwnwFQPSurFPUdCowfUstp
 WF9tpEyRAI49W4s7SBLsS9jRAVeSTo8HrbqWzAYFyrYPhT68eoL8CsujBM5braGaxY3/+gMBclv
 nM5Knp1ysIkDPAA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch series is improving the size calculation and allocation
of the uvc requests. Using the currenlty setup frame duration of the
stream it is possible to calculate the number of requests based on the
interval length.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Michael Grzeschik (3):
      usb: gadget: function: uvc: set req_size once when the vb2 queue is calculated
      usb: gadget: uvc: add g_parm and s_parm for frame interval
      usb: gadget: uvc: set req_size and n_requests based on the frame interval

 drivers/usb/gadget/function/uvc.h       |  1 +
 drivers/usb/gadget/function/uvc_queue.c | 30 ++++++++++++++-----
 drivers/usb/gadget/function/uvc_v4l2.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_video.c | 17 ++---------
 4 files changed, 79 insertions(+), 21 deletions(-)
---
base-commit: 3295f1b866bfbcabd625511968e8a5c541f9ab32
change-id: 20240403-uvc_request_length_by_interval-a7efd587d963

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


