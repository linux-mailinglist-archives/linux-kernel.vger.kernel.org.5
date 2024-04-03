Return-Path: <linux-kernel+bounces-130527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5A897973
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA041F21DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4E156239;
	Wed,  3 Apr 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCxaN5Zv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE71553BA;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174306; cv=none; b=PEIIOJucOmmqrSo8QVjSsuxR6kc+kXOuFLRDW3T5txYPZ0csHmEjUCGSaflVRHRXyXoLOqAkIKovme5xmcDDX10Qx4oEqazClhhDz3p/SaOXle+YC883c8bJdS/njYjNBkPw9EbP0VEOhjY6umowpZl/xM5dj3WNf/MeH7UJSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174306; c=relaxed/simple;
	bh=ZolPI/SXOoFRlsyA2xZ/MLjL4K5rdMbF7iCV+sPToAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPmCcUCUc10kG4/JULHFtj+waa+vVgGzCwfzsuOj4Myan9qHasYqzmEfyciV0yPBUZI9T8Zqza36dfyv4VdxjljM2+50rAwHh+mf1q1fMXgD6fGCtzbwT1pD8jqDa0JczPHxlbjT/qkmg+NUg3RsV5pm4jYLVuU4GbEOTNmeIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCxaN5Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61B79C433A6;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174306;
	bh=ZolPI/SXOoFRlsyA2xZ/MLjL4K5rdMbF7iCV+sPToAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DCxaN5ZvrL7/ojIbXsbJ8aeApY/jESwu3jMVvhco88jNo1zYd8RnULzubi7I45Iyr
	 S98AmEEO3ie1jLlYw4mBm4VzSdNrHgLtcIEevu7Y3LJ+Z6A1m32EY/6h0KGggTU8me
	 dHoNt6PiLhQavARzPr8K2X82IiGhu8GoRFUvl8k1mYGe4ibN+PxoTy2gy2sITlvesZ
	 jt3KG3DQs2KkGfqG1sB5Tn+6Dfr1Bf/rTKhJsnLONBQqsneLB8iyEFP1d5MZIyuQKT
	 Gu6uijcRoeC9A75//hhkkYyze48RRxgRgGMpbTja9wPiUxdmyhKVjg2SesmcvF5RwX
	 MxDY2UO7vZ1bA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57305CD129B;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Date: Wed, 03 Apr 2024 14:58:09 -0500
Subject: [PATCH 3/3] media: uvcvideo: Moved control checks to helper
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc-fix-relative-ptz-speed-v1-3-624c9267f745@securitylive.com>
References: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
In-Reply-To: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712174305; l=2692;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=2nl53Ftu6Hpf35R3FNa8JPbVSTHm2rJO1iLfSKB2ysg=;
 b=BhLEBiU0ZU86ee4ynGsqy1lFJdDPqxN8ydK1MeNxTyyuxPXHnWaLEAdFaP4ffI6z2Y/HjSzDy
 AyLB7FWoRxJDQTr3AuakRSnCoM6/nkz7NOiXW7IvPBYLDKLc86/p+QM
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

From: John Bauer <johnebgood@securitylive.com>

Made additional recommended changes from Ricardo. Relative
controls are now checked with helper function is_relative_ptz_ctrl().

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 04300a782c81..34a9a29b0754 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -441,7 +441,6 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
 		return (rel == 0) ? 0 : (rel > 0 ? data[first+1]
 						 : -data[first+1]);
 	case UVC_GET_MIN:
-		return -data[first+1];
 	case UVC_GET_MAX:
 	case UVC_GET_RES:
 	case UVC_GET_DEF:
@@ -1233,6 +1232,17 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
+static bool is_relative_ptz_ctrl(__u32 ctrl_id)
+{
+	switch (ctrl_id) {
+	case V4L2_CID_ZOOM_CONTINUOUS:
+	case V4L2_CID_PAN_SPEED:
+	case V4L2_CID_TILT_SPEED:
+		return true;
+	}
+	return false;
+}
+
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
@@ -1327,22 +1337,16 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
-		switch (v4l2_ctrl->id) {
-		case V4L2_CID_ZOOM_CONTINUOUS:
-		case V4L2_CID_PAN_SPEED:
-		case V4L2_CID_TILT_SPEED:
-			/*
-			 * For the relative speed implementation the minimum
-			 * value cannot be probed so it becomes the additive
-			 * inverse of maximum.
-			 */
+		/*
+		 * For the relative speed implementation the minimum
+		 * value cannot be probed so it becomes the additive
+		 * inverse of maximum.
+		 */
+		if (is_relative_ptz_ctrl(v4l2_ctrl->id))
 			v4l2_ctrl->minimum = -v4l2_ctrl->maximum;
-			break;
-		default:
+		else
 			v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
 						uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-			break;
-		}
 	}
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
@@ -1935,14 +1939,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		 * value cannot be probed so it becomes the additive
 		 * inverse of maximum.
 		 */
-		switch (xctrl->id) {
-		case V4L2_CID_ZOOM_CONTINUOUS:
-		case V4L2_CID_PAN_SPEED:
-		case V4L2_CID_TILT_SPEED:
+		if (is_relative_ptz_ctrl(xctrl->id))
 			min = -max;
-		default:
-			break;
-		}
 
 		step = mapping->get(mapping, UVC_GET_RES,
 				    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));

-- 
2.34.1



