Return-Path: <linux-kernel+bounces-130525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C731A89796D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83135283C61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE4155A56;
	Wed,  3 Apr 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOGmFM7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC71553A5;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174306; cv=none; b=jaWuesU35gEEOJne9Pq6+NkwYt6mPT69b+vsvtnd4cmPjohiIF5nfDvo94/CN40NFVEDt3+I5bAXhx34xUFwFchoFUy7Yv4794Y+EpWqVUp9c5cpex55wed2Mg9htu4yYJPQxuIfbHK+8ePREqLaDY+Pwr759jwZ9raf0/vducw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174306; c=relaxed/simple;
	bh=IqIPQIciSC+G8wbu2TOoXnNswwUlzqvDJu3guik3ipY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bEebW/yP2q5o0lKkFvccXP3SoHL4urKXk60sswULGMutGcbQlgmh9K5ohaKGaBH9LI9t5zg0zyCfNy1cuqncZpUfRKt84uqVDrv15ZBg8i2CzLYKBZQXq13VQ71Hv30Ot/F2BJyidyxCzYN/yZnCpCDew1vvNFn2X9/SLUpDf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOGmFM7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34D30C43390;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174306;
	bh=IqIPQIciSC+G8wbu2TOoXnNswwUlzqvDJu3guik3ipY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rOGmFM7I72OEfBbpE8XJWXk7Dlzm+4/wgqcNPdyiaXzaWYvFLQ7ZVfi121UiqHxYj
	 sjlWPjRXUFU2aeVTyGkYZEarv6TiqQwyUGddfD9+jdH1IjiPN7sXds04fDhzrpu9jU
	 Li86Yk5Jamcbl2V67FesnScc4tKACmbaOjsPNxOaelKn8nWbAgG+rVMeaIU8VKXf0B
	 eIIkA6rCZGWnVgQzbn7zqJlftKzTZXp5QHEtlq0jgKQ5BSYD1L5OvE9FDxn0g1gbCQ
	 N1enLnGJ5oEN6B+UugqRjhR0s/cd49eGuRKY9gtuCt/s6guAV6Bx2oWvNzL+FpXR0S
	 Io82nmAIXwgxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6F2CD1297;
	Wed,  3 Apr 2024 19:58:26 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Subject: [PATCH 0/3] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Date: Wed, 03 Apr 2024 14:58:06 -0500
Message-Id: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM60DWYC/x3MQQqDMBBG4avIrB1IdaytVxEXIf5tB8SGRIMo3
 t3g8oPHOygiKCJ1xUEBSaP+54xHWZD72fkL1jGbKlOJEVPzmhx/dOOAyS6awH7ZOXpgZLEveTu
 xzdO1lAc+IJf3vB/O8wJibrxTbAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712174305; l=598;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=IqIPQIciSC+G8wbu2TOoXnNswwUlzqvDJu3guik3ipY=;
 b=YqSH99VMGYHqSaakMU0dMXr+sPWcobjWxzwD7W7pwM7ZSnRVX7rZ9y0gZPiPZzDPaEWb4Jlyz
 upcBbjTBMRDAsPhUQ7WETDyM75pN50qx1URw8zh92VxqbXn6aJVqvNQ
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
John Bauer (3):
      media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix
      media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix
      media: uvcvideo: Moved control checks to helper function

 drivers/media/usb/uvc/uvc_ctrl.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)
---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240403-uvc-fix-relative-ptz-speed-4a849c4a56c7

Best regards,
-- 
John Bauer <johnebgood@securitylive.com>



