Return-Path: <linux-kernel+bounces-64549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9054854033
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E53286400
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB47633E0;
	Tue, 13 Feb 2024 23:38:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786456310B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867485; cv=none; b=Spku/KlYkUygQ31qivzzrshx+FDWdQCmuo++pBInGJq/MVwVKSW491kmQdSThc9ln/nc9LidBPda+hjSmihw9wh8q05z3D29cfe4dk+NbhLKCGHJDS/WHr4bIzOUGG5yB6FnKgzY5UmmyX1ECbsI+ifANOyP0HIvp+1Tj8yg4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867485; c=relaxed/simple;
	bh=BaS/LDmT6doANyq4gk8E+Sg9Eq8IsEg++C7h6qSGKsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXd9cHWhTpX0NdUelrZkcQqMqbQ/tYPfU++aHfmSeWqyOt7L6t0rIBTr895rNj0qZ78GeFfxmVpBpePZ5Xk2xLDA+qnEF0iG9lG7er8LgwEZC+YCoPju9Li/bklFbh7gl4yrfm15sifAUUKD4igG8w94tuwdL/WiL/Ah5jcTkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lg-00013L-2r; Wed, 14 Feb 2024 00:38:00 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-000ZgZ-JR; Wed, 14 Feb 2024 00:37:59 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ra2Lf-0032pb-1j;
	Wed, 14 Feb 2024 00:37:59 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH 0/2] usb: gadget: uvc: improve tagging transmit errors
Date: Wed, 14 Feb 2024 00:37:53 +0100
Message-Id: <20240214-uvc-error-tag-v1-0-37659a3877fe@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFH9y2UC/x2NwQqDMBAFf0X23AUNFkt/RTwk8UUXJJZNFUH8d
 xePMzDMSQUqKPStTlLsUmTNBs2rojj7PIFlNCZXu7Z2TcvbHhmqq/LfT9yFbnTv+AFSImuCL+C
 gPsfZqrwti8mfIsnxTPrhum4MRXQ1dAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=BaS/LDmT6doANyq4gk8E+Sg9Eq8IsEg++C7h6qSGKsU=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBly/1TiHAEaBtYlsWu5sPIVYw2S2Hj8gn6VkDlh
 N7zCWQ++WyJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZcv9UwAKCRC/aVhE+XH0
 q9i9D/0cN97B/pYGrXtWzqIp+tg5E7dfGN1GOw2RI8J9cQjiiUSb604/0G2kNlhYLWeYQaWJxp+
 VtmK8EB4kszSMK2hhnmfSE1yEyWFE2JADoF+lTi1H1T9EgDiNnmvUTL4KTxPzExAbSbjgh6qDqL
 iKOvvKZZ1OEE4Sn3+2UUMGi6BeeiD76slrSCI+Koc8I9NfmZQcga85VMLnciLcgBURWfcVYqwSB
 jux8qeaOK7XgC4RHHETA/SWNO3K0659yQWbDqqc1/CKSZ8Swi+UPYvK6P7buIHQTGTNRkhGxSgD
 wPheNS65muaFDIEdESKu5WEAcg7gDOzxqH2f4RJKXYsPy99SPX24h7pAuSA7SacY1/um4xraIjv
 1Wz9m0PZ35cORUZznEUEhUBpCEPYSf9OJyJ91obW4w7/D7Rdo+cps0QxNKEk2kTm/2wU+ElxRVD
 GzMXgcgO8mLWWMb6mC6vf7RkkIyO4NCgH+XqM66GSdoFci72FK83YpdKD8Inw2PVj9/RhGPlY2U
 7ZAhAVPz2yqJs96K70Y2bBalcP22y5squePPkNRqqvoNbNAEb68OcH4eueDNbNfDCbxt6jk6sbr
 qQx8UIOLQMDP4eX1RmgjH2jo3l8tnx+bPPzlwvZ6vHYcHr0KZTk07vC5pS1pB8AzRc+jAW7uHOa
 Y5zQiY6RFKloSlw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series contains patches to improve signaling of transmit errors on
gadget and host side. The gadget now will tag an frame with
UVC_STREAM_ERROR in the header for the host to know that the transferred
frame has errors. The gadget will also skip tagging the frame erroneous
if the request that got not transmitted to the host did not contain any
data.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Michael Grzeschik (2):
      usb: gadget: uvc: dont drop frames if zero length packages are late
      usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR

 drivers/usb/gadget/function/uvc_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 88bae831f3810e02c9c951233c7ee662aa13dc2c
change-id: 20240214-uvc-error-tag-7b7d25c8eeff

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


