Return-Path: <linux-kernel+bounces-132524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925F899634
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3E41C22E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB92CCDF;
	Fri,  5 Apr 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWwwoFzG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9428E11;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300829; cv=none; b=Mm5Z2gcne/5Ji16z+JyVRPM+nrwjPZrQmbJtpozcKpFGWPg050mo0a58bFmR06uXqO0MccW1hlGNlj0xPwLf1lXxdTbThXfAVcUanqsXuZTsNLZwESeQoMBOXYfoZjic4grl7Fg7TqQGFFGytoO+MBbgpfRPOnkPO7spJneA0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300829; c=relaxed/simple;
	bh=40uh/wKUId8Vzuahx/WopdPsq9bSrg4TfoGpA2V/BrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsxGrlANZdRoOUg13ygP4rpWBpre9Q5w6p++hHljcqtRPZQqWfPuRcLMXPDHgdyG2q43olWgPPe6s6QJ+fr8JbGVc/nwb+hHDZvB64kmkVQpLj40dQG2UmiIF83Yb8NNuR/4K9gOd0JW0flu+eoJuk6H1DCyyckKu0OSYW2s1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWwwoFzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30265C433C7;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712300829;
	bh=40uh/wKUId8Vzuahx/WopdPsq9bSrg4TfoGpA2V/BrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QWwwoFzGAnZBTrihhdbRIVkYJu/SJOTAnAOThmuSGRng8dmoTgZS8k4fijd6E24Ym
	 2dv3RB9Cq1vUe/bpAeGTJM7YssokS6WEnvGKBUzKm45h26/LJzxHC24wMrk4vH77ne
	 zHGqWPp+nhgJisShoz/VnTQBMrCqPN701aDoLAwIVPnMetaqOceB09dV9rO0PrjtZv
	 HfclPyTWB3QUxma6aNaEkBKmcrIskDaMg5n5A/PVPkoQMXtvRoZjJNBN7cmcGCj+5a
	 2uk8U8QGEAAUkxIUcChtRmGB4rvkCabK8+UXkACLIJ0zI45/+rj09vL2fIkSI8637I
	 9na3Zw86O5hfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6DCD1284;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Fri, 05 Apr 2024 02:06:26 -0500
Subject: [PATCH 1/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-uvc-fix-relative-ptz-speed-v1-1-c32cdb2a899d@securitylive.com>
References: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
In-Reply-To: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712300828; l=2495;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=QZxJ8IkQ+0S1QgP+EtdvdygUUbw+bFRKj/oMsKdGp5w=;
 b=ltsEsCOxbxu0ln1jKn94gzFOMCRQv1XgcnCc6pRVSUAWgUf6DNec5T22UbznyJx0gzeAmMde/
 DvcEhFrQZohAEFPBCPrMov5E8JyalYW1JQtxMYUDblNjqEu+ljLuakL
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

From: John Bauer <johnebgood@securitylive.com>

The minimum UVC control value for the relative pan/tilt/zoom speeds
cannot be probed as the implementation condenses the pan and tilt
direction and speed into two 16 bit values. The minimum cannot be
set at probe time because it is probed first and the maximum is not
yet known. With this fix if a relative speed control is queried
or set the minimum is set and checked based on the additive inverse of
the maximum at that time.

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e59a463c2761..b389ab3ee05d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1322,9 +1322,25 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		break;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
-		v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
+		switch (v4l2_ctrl->id) {
+		case V4L2_CID_ZOOM_CONTINUOUS:
+		case V4L2_CID_PAN_SPEED:
+		case V4L2_CID_TILT_SPEED:
+			/*
+			 * For the relative speed implementation the minimum
+			 * value cannot be probed so it becomes the additive
+			 * inverse of maximum.
+			 */
+			v4l2_ctrl->minimum = -1 * mapping->get(mapping, UVC_GET_MAX,
+						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+			break;
+		default:
+			v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
+						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
+			break;
+		}
+	}
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
 		v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
@@ -1914,6 +1930,21 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 				   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
 		max = mapping->get(mapping, UVC_GET_MAX,
 				   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
+
+		/*
+		 * For the relative speed implementation the minimum
+		 * value cannot be probed so it becomes the additive
+		 * inverse of maximum.
+		 */
+		switch (xctrl->id) {
+		case V4L2_CID_ZOOM_CONTINUOUS:
+		case V4L2_CID_PAN_SPEED:
+		case V4L2_CID_TILT_SPEED:
+			min = max * -1;
+		default:
+			break;
+		}
+
 		step = mapping->get(mapping, UVC_GET_RES,
 				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
 		if (step == 0)

-- 
2.34.1



