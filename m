Return-Path: <linux-kernel+bounces-123812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA8890E67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D011C267D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA97D1386B2;
	Thu, 28 Mar 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piSpR857"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362182D66;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667893; cv=none; b=kf66Un1oFS386bOC5bGODcKCs9cr5k8leOkkJ3VMVn9EeTB1oerJ4Xk0coxY4VT7QXQ/kXPbLJz7VzEwWqSiL77HVi0rEF3QYu1FTfOzZboBuHoBi540Ydlia7vMEwuNQtYvJPr1Dj2FvCZhBLn4NmsrmNBYL1ddfliub43ZTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667893; c=relaxed/simple;
	bh=ufR+0iHCmEICheDCukK6osbbIBOdgkBNn3yKED5Aw2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShZ2vhhPqWyzxBDyacrwUJA8DW0jPJ5eZeCBg8iq41qMQq1LjJvEEqNS6byAOfr5sJD1UFQ0xnAkntHWIWvPlu1gZTuX8AlL3MYCy9W4F6eoQhHgZOiTfxkyq0sajDPmKLfiBahFSPSbxka1znkHX3A6AFtbF+5Fq0ueSbq2Aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piSpR857; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEDCCC43394;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667892;
	bh=ufR+0iHCmEICheDCukK6osbbIBOdgkBNn3yKED5Aw2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=piSpR857SPHOLL5t/cpgDNsoTLyhQubz359xYKrG+jIcd7bKxthfWV+aXB5ln9uAE
	 z1ZTl8vGmoeWf2KhF281yPql0JN8Ce9ovn6w4CoVIelRIXhvoEZm9BcXyHZ8bKQUzN
	 wNnxUvcqy1LxoJzITptvK4FNOuZ8tBLbUg+DZjrenAbeaEyeMnUDLebWZF5o5GWf2v
	 s7xIOgZKCo+JTnqr6zgqjuNPp20lxE7Di1rEN+Kj1utMiikSZDpH1X9oQp6iUcCo4q
	 +k3SZlN0Om/w92TsCF60eO+wiAebbMAxoADfBj6sTY/QXeXJvuFLK4kFDBcHG9fpWn
	 pzJqOxH5nCSLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBADCD128D;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Thu, 28 Mar 2024 18:18:07 -0500
Subject: [PATCH 2/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-uvc-fix-relative-ptz-speed-v1-2-17373eb8b2be@securitylive.com>
References: <20240328-uvc-fix-relative-ptz-speed-v1-0-17373eb8b2be@securitylive.com>
In-Reply-To: <20240328-uvc-fix-relative-ptz-speed-v1-0-17373eb8b2be@securitylive.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711667891; l=2237;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=XaPSPVobhTGsOxP+SRJcTVrPmARlAP4ikC9wTaKg0Fw=;
 b=DAxSw7/KC1Ex96mac6VlcslTse6QSo8x/qs+vdoNIONBKk4gX417XmN7X3tUGfZEQLjLjIPYh
 JF5NO8Bkd3yAoRt3qihsFZlCJ4onvkikTHXSH0AkVt/iVxj47/82DDL
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



