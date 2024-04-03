Return-Path: <linux-kernel+bounces-130526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C489796E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1281C26483
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FF156226;
	Wed,  3 Apr 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozy/iK1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AA155753;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174306; cv=none; b=RzQsDqUY3/8P+I5m+7l9oub2e7vNNPPVqhhV8PDp69dIMfUebQmG4ZoY4arFe5YLAc37HLBQLy6ZaVRbZ03A4LSFdFyrWlpjSo8yH1lfR1CcI2h6csVp3V+zJ6ode1iAKLZohOq5wuFgOSaZePkJQZrRpl3p71lk4Adpjr3v0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174306; c=relaxed/simple;
	bh=ufR+0iHCmEICheDCukK6osbbIBOdgkBNn3yKED5Aw2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7+50tZRChc/lcT/vtjzjitgCPtSAohIrDIy5Pa+zbxnvhSquGFOVnHRHBnmSc9462CoBiZvV4CAx1H3msQvKy/hWqDbapb8nxTN/wLH2eBIB+XIsuFPjiTy1wE7ajXiWm7vNzQ5hWtG3gJDFaQkR1/j9Xoj0oqr2keVCpy8q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozy/iK1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56232C43399;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174306;
	bh=ufR+0iHCmEICheDCukK6osbbIBOdgkBNn3yKED5Aw2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ozy/iK1uxFAo3jgwMa8FTA2qfb4vGjJQUtDVWtFHwZdaU2EmwDUPcDozrvU9HKKqP
	 RHByqs0qO2iAr3J5gljKWxwNaDDSltjQoJX0Me1+1xojzFyUuynJjJteYHmz/aEPQQ
	 4gzfz/lq/PJ9eTMW4tEhjSzPY9F0ZQHfo9pZjZbbbmVf8BPnYc0WSqO8k4YU0RvJWl
	 ifHuvfa+I8JRn9cKqbRT1gmOwaDr6AzO63O/xuJdSa4rJ2qsTAprg3Y4hA/rm5OL5D
	 P/oyGbvBqQl5XHb1l5ZTQf/O3H8hRv0DfsDOQS4hI3ISkO/Nea62R0oIYCRUFGeMd0
	 zVHWoxY9XK/ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDFCD1299;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Wed, 03 Apr 2024 14:58:08 -0500
Subject: [PATCH 2/3] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc-fix-relative-ptz-speed-v1-2-624c9267f745@securitylive.com>
References: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
In-Reply-To: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712174305; l=2237;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=XaPSPVobhTGsOxP+SRJcTVrPmARlAP4ikC9wTaKg0Fw=;
 b=pCd2bn9MLzzfJObg+LGhmAA/y7OKa/cYDJqI58Jva6YEELnlKpa+7FsgXS4EJ9XW0+7eazURY
 V+EaB3xg7KfBeYqsRyAUMfHDiF83T2CgL/6+t+7KnFhS78zvRIdy3nJ
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

From: John Bauer <johnebgood@securitylive.com>

Made recommended changes from Ricardo. I explored the case where
the minimum could be > 0 but less than the maximum. If this were
to occur the range of -maximum to maximum would still apply correctly
however there would be a range from -min to min that would possibly
not apply. It would be possible to capture the probed minimum and
check against that when setting the controls.

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b389ab3ee05d..04300a782c81 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1322,6 +1322,10 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		break;
 	}
 
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
+		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
+				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
 		switch (v4l2_ctrl->id) {
 		case V4L2_CID_ZOOM_CONTINUOUS:
@@ -1332,8 +1336,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 			 * value cannot be probed so it becomes the additive
 			 * inverse of maximum.
 			 */
-			v4l2_ctrl->minimum = -1 * mapping->get(mapping, UVC_GET_MAX,
-						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+			v4l2_ctrl->minimum = -v4l2_ctrl->maximum;
 			break;
 		default:
 			v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
@@ -1342,10 +1345,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		}
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
 		v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
 				  uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
@@ -1940,7 +1939,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		case V4L2_CID_ZOOM_CONTINUOUS:
 		case V4L2_CID_PAN_SPEED:
 		case V4L2_CID_TILT_SPEED:
-			min = max * -1;
+			min = -max;
 		default:
 			break;
 		}

-- 
2.34.1



