Return-Path: <linux-kernel+bounces-132523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B204899633
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC141F236EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F12C86E;
	Fri,  5 Apr 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBldpRfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC42C19C;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300829; cv=none; b=ItKsA6FoOt9pIxrROBolpFGIEuMiR47gpJZL56HZEGZIMgv1EBwlxXA/CBpbJWeLfXJynbsApiC5EzFWJ52/qED4IcxmhWxBgONTNSHdt0ag3qvqOW4lAbCcg098ku4QvB6BU7+DjYrFEQZ256VmtWxmi0i3/fM6/dKsz/Sws7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300829; c=relaxed/simple;
	bh=vWdDvQvrENGQo9KBPUCLq8na6ixMNl29inEeYMGCOec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VJy63cLWwPUICbb9omS437DYPZS6kLi049vZFkvWsJU4DcfSnbZH8U8vIkh2A5u8pKo5MrV/7FR3MHA+dQOD5KsRSzeOZQGzBJWu/pyk4kgEyPtgaJ39mClJby7PSP2WGvuAxXol7UD0gSj1+g3O4Ylkb23NX1zCvUI2ATnWgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBldpRfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180CCC433F1;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712300829;
	bh=vWdDvQvrENGQo9KBPUCLq8na6ixMNl29inEeYMGCOec=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fBldpRfsz6JZRoJp7bzm0G0kuVqIf9miSp/53VjgMt41jyy77W0pVSDU+e0GIu/dN
	 5Dzi5MBe0fmn+9oM64/fiRIqiP1sPvMT4552EtJES0L2f7QAF4XFzX8cOCnhIWkq64
	 wo9fLUOIXhTef0TYGuSdklaVSUGiLv1zeWQ/LrMmBbGBxdhb7pvaoUGKfmXIHyoWIx
	 m2tIOo6MpEDLGjp/SfonqMa10yEPuvPg53F9v0Nic2g35AsHxUJkPYGCcYzuFaxeFp
	 DFxs7VGXQU8MkEfTeV/GiG8/eHnXIDP0wq5OiQqBl6WVLYXt1Tz/17QVv3IFNCVzo8
	 IXWufAUt7WlhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064D1C67861;
	Fri,  5 Apr 2024 07:07:09 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Subject: [PATCH 0/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Date: Fri, 05 Apr 2024 02:06:25 -0500
Message-Id: <20240405-uvc-fix-relative-ptz-speed-v1-0-c32cdb2a899d@securitylive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPGiD2YC/x3MQQqDMBBG4avIrDsQ7ajYq5Qugv7RAbEh0VAqu
 bvB5QePd1JEUER6VScFJI363QrqR0XjYrcZrFMxNaYRI6blI43s9McBq901gf3+5+iBidH1tRv
 sU0QGKgMfUMp7/v7kfAHS7EJsbAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712300828; l=799;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=vWdDvQvrENGQo9KBPUCLq8na6ixMNl29inEeYMGCOec=;
 b=MrcgdX8BLXzN1cCZJQbgDOPiYx5DkwRkQp6jOO/LD12fHWhxmBMlwFZ19UrHVUR78lMNwYgMZ
 ojDA5+mlrvLBipCuVGZaq4OLLJal72cBzXGZ1DNIZPf21YA+IlB00jQ
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

Thanks for the help Ricardo, still figuring out this whole workflow.

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
Changes in v2:
- Made recommended changes, moved control check to helper function and removed dead code.
- Link to v1: https://lore.kernel.org/all/20240326-uvc-relative-ptz-speed-fix-v1-1-453fd5ccfd37@securitylive.com/

---
John Bauer (2):
      media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix.
      Made recommended changes

 drivers/media/usb/uvc/uvc_ctrl.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240405-uvc-fix-relative-ptz-speed-e671f9a34449

Best regards,
-- 
John Bauer <johnebgood@securitylive.com>



