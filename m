Return-Path: <linux-kernel+bounces-118608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AA88BD35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1344B21AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682D4F215;
	Tue, 26 Mar 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUhnNeYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9441740;
	Tue, 26 Mar 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443758; cv=none; b=BTNkq7gLhkQJe4DVy8u96S9YRuZHUoYFCSRCk1Y0k8GdCDwpMDXzqz0X1OVvvDWAne5NcsqKSl12m/o/3E5n4fT3N/CejXzudWE/nP5T/vuNLVVNNmIm/lxyjiAv9ApfnEyInqair+WAps+wMEr821sIk/qmOTxGEMjZuOZ7PCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443758; c=relaxed/simple;
	bh=j31hZnf3HSLY75FSzBYdn9Bwf2m2ebswAGH7XLqTlOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DffV8ndY/AlybF4Q5KbjhZcH5yURr4H2k954Fe79CG5vJ1t+kGOGQBEN2j+xsKfniJdvFYZrskaXl/0E31fmHLhmSkLDlRVr7rTxLLh6hfeLzUFknqwtFK3z8ObMzsJ9i4joOlqQ7w8/PTGFgZQ23MQaOEK92D/CrPHWzTIwc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUhnNeYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8F6C43390;
	Tue, 26 Mar 2024 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711443757;
	bh=j31hZnf3HSLY75FSzBYdn9Bwf2m2ebswAGH7XLqTlOU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oUhnNeYixVTEXLpJD+lAfTLE7O7E6p0tevhXPcd+Qa2Be9FVGpMz+i0Q7XXh3Rrqm
	 ZqUrgV0pH1EFESZEVsLz0wWZLBrmIyZYjud85Ewc/xtb/Fa2cvc2rjrhFvjhGOjjp+
	 bDcCwVwlFoKIlJwaonpygDjo328BwSiNpoaIuIy2JBEhfmMjFG7cDNkktjM0p3tlNI
	 80JC/58oAfJAumZq7F3Dy2dStN22B70/NP7Jp8ot5m32TnSqmKDU3jFJDs8uvYawal
	 QdkOpTaFwryZAjGCe97JAl1rOpFhOURkQjxwb3DSZO20+HGfMfJslXOKCDbjefdgkB
	 vXJhXaLRSROEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD001CD11DB;
	Tue, 26 Mar 2024 09:02:37 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Tue, 26 Mar 2024 04:02:35 -0500
Subject: [PATCH] media: uvcvideo: UVC minimum relative pan/tilt/zoom speed
 fix.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-uvc-relative-ptz-speed-fix-v1-1-453fd5ccfd37@securitylive.com>
X-B4-Tracking: v=1; b=H4sIACqPAmYC/x3MQQqDMBBG4auEWTuQpFqkVyku0vjbDhQNSQyie
 HeDy+8t3kEJUZDopQ6KKJJkmStMo8j/3PwFy1hNVttWP2zHa/Ec8XdZCjjknVMARp5kY6uNcXD
 P/tNNVAchouZ7/h7O8wIzonqgbAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gergo Koteles <soyer@irl.hu>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linh.tp.vu@gmail.com, 
 ribalda@chromium.org, John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711443757; l=3347;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=J5cUwDm8JSMrStvNfFZtZHjj3H7C9GUHhWu66GtOqLc=;
 b=BhUk8Rlx7w70KHg9iaN556luombmQ9OTlYd4HYzcPcA2k9Qy41j2jFBBrVlg4FHJGX2/tC8Hc
 7E1dxaiwbGrBMlF1+/NgafN1YdVz6ZHfyQNDf9MwBRpy7Q62W7qt8Os
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
Gergo noticed that a quirk fix would not be needed and the just 
the minimum value needed to be set. Thanks Ricardo, Linh and Gergo 
for helping me along here. The reason the problem presented is that 
the minimum probe is done before the maximum however the way the 
driver has condensed direction and speed controls 
(with great simplification benefit to the user) the minimum
value must be derived from the maximum and negated. This
fix gets/checks/sets the correct relative minimum value when 
needed instead of of at probe time. This minimum value does not 
reflect the UVC 1.5 spec but the simplified condensed 
implementation of the driver; it's beautiful.
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

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240325-uvc-relative-ptz-speed-fix-2011aea68b5f

Best regards,
-- 
John Bauer <johnebgood@securitylive.com>



