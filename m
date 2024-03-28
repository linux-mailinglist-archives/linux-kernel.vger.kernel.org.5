Return-Path: <linux-kernel+bounces-123813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979DC890E69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203AEB240AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C31386A4;
	Thu, 28 Mar 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNz8zjNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EC7E772;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667893; cv=none; b=A3Mir7bhaBlG8gSagmeJNK0OMgJa9r4SdD3b9YxKrmZtJPZG5F80jKBhfeQk3LV9Sb8DZTWNkXkbhIi0wbrfAlwcNvNBUCwL7PEvZ46Z8jT0oAEDgl2EhKEr3wgYp5FN+TM+fd6qN8AtYT2OjO4RCC9G5ONeJzFxi/yycsbOlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667893; c=relaxed/simple;
	bh=f3ER3lZAYli1BTrR2dAmxpU9ysqv5W9r0F8k8nlkK5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5UYJGja3ruhI0PIxGxze/MPV6gjJirjwol1T3CYkMv+ELqyFjoQYsO9XBEvTp3jvTyisaQjij6VN2XA+eUkpywpI+datbgPpPH9+0whdRQGOdWhfEAe7Cxx6iA/IXg3oDBqHf+b6mj1LjAqroVB2g3sssR9CoBbgOtsVeBYx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNz8zjNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A09DC433F1;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667892;
	bh=f3ER3lZAYli1BTrR2dAmxpU9ysqv5W9r0F8k8nlkK5Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FNz8zjNz9UpbRQarXzPAL60jfsG7jyRNnys3XgmXNWFBOSuQH7I0DeBL5AxL3E8mb
	 tkn2cWPjq+iL0uElzW+EVuNCuu8gtr7gvfWAJJkz+4OmFxz2RLzwoz47Dgnj9++1oR
	 nnQRKHjkEBeyeqKPjo04kjAjIyBE78dk4JKEBH6xMzU6D0DuEsSG/R08+GxTKGThTT
	 kfMX+mw/Dv7bD0ZgtoktrfHoMxS+dvdGUTXtuV4nvn9OPoTYjeldYUNO/VFM0HT3Qz
	 XgMefU/K7kdo/wEdY3K9SpJA1n61R3YaGSOedObOVzYQlAyYCA5HG5zR0IUdpki6oL
	 il8r1GDi9ndBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E145CD128A;
	Thu, 28 Mar 2024 23:18:12 +0000 (UTC)
From: John Bauer via B4 Relay <devnull+johnebgood.securitylive.com@kernel.org>
Subject: [PATCH 0/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
Date: Thu, 28 Mar 2024 18:18:05 -0500
Message-Id: <20240328-uvc-fix-relative-ptz-speed-v1-0-17373eb8b2be@securitylive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK36BWYC/x3MQQqDMBBG4avIrDsQk6LVqxQXQ/yrA2JDokEU7
 97Q5QePd1FCVCTqq4sisib9rgX1oyI/yzqBdSwma+zTOPviPXv+6MERi2yawWE7OQVg5K6Vzrr
 GGZGGyiBElPI/fw/3/QPi6nT/bAAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linh.tp.vu@gmail.com, ribalda@chromium.org, soyer@irl.hu, 
 John Bauer <johnebgood@securitylive.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711667891; l=534;
 i=johnebgood@securitylive.com; s=20240325; h=from:subject:message-id;
 bh=f3ER3lZAYli1BTrR2dAmxpU9ysqv5W9r0F8k8nlkK5Q=;
 b=v11UhZCjK2Fzq3kTdttmdGe03+xpcVvouWoO7MkzV1sdmnOvb4rhi0uVTu+uOyWqKH4wyymSd
 4MCUjKTBH65C/s/paT5Hg34iQn5AHtreqgE7wDUze6dMqPYAUzGy/DO
X-Developer-Key: i=johnebgood@securitylive.com; a=ed25519;
 pk=RN31Fmrxbidp1TwtZGNmQwTDjUWMPnewQJfA/ug2P9E=
X-Endpoint-Received: by B4 Relay for johnebgood@securitylive.com/20240325
 with auth_id=143
X-Original-From: John Bauer <johnebgood@securitylive.com>
Reply-To: johnebgood@securitylive.com

Signed-off-by: John Bauer <johnebgood@securitylive.com>
---
John Bauer (2):
      media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix
      media: uvcvideo: UVC minimum relative pan/tilt/zoom speed fix

 drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)
---
base-commit: 23956900041d968f9ad0f30db6dede4daccd7aa9
change-id: 20240328-uvc-fix-relative-ptz-speed-97a923630aa6

Best regards,
-- 
John Bauer <johnebgood@securitylive.com>



