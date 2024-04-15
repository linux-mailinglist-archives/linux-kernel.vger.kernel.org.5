Return-Path: <linux-kernel+bounces-145169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39558A5057
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1C284749
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346BE137908;
	Mon, 15 Apr 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4sRyVXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3E137772;
	Mon, 15 Apr 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185476; cv=none; b=K6IxOvYISdHhTEL9Gf2Zra+vzSmJz2+14EsPDueDpbcDXBl3r876KUxZyXMEgLi8GDDfIEs3MybRtsaFXenu1K8GJOn89Icbr9GzEwCwBLS9Fv7/mOhzKHzVtxTZXwRfr2rqdF5rwftz1EoRUdT0k4sI26u8oNzuUwMmTc0a0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185476; c=relaxed/simple;
	bh=uu+46JBT3zvw2c9/PefIG4AGdzXeYCSxhwWtOIoo9xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPLO8d79ofKWaa6YKjglHkS2JxpkAzUV8dzV+i1v5tbNv1e+osbcsOMU9cPb71PyGWVydgh08bR08XVK+qXF8YjET1ILcVBp/XaL9vkbP3iniJAe52veVnYJfnTWS7kn42LAkTehsj6SxZTSerVT2MmedzgFlWygAVZiVgi4+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4sRyVXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628FFC2BD10;
	Mon, 15 Apr 2024 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185476;
	bh=uu+46JBT3zvw2c9/PefIG4AGdzXeYCSxhwWtOIoo9xI=;
	h=From:To:Cc:Subject:Date:From;
	b=Q4sRyVXYrUS764VhrNtxHvT4YFw6t4E7rY15RpPA8utDroe8o9a7zGLUc+4a6pbDI
	 +bdhfjXqhr+XfD5cRrpHeURx7bHquuRiSbm8bacUE0S9MmEqqCftjpU83+7pKdN2/h
	 o6pusiUQs9OY9i8MOfgkcy0jHHHDJAbrZG9VPv4i+9K3O137zBSeqEG6lKizdwzJ8V
	 ngPiyoZmVINqcGTsRmXePHYWisZ+vMrUhIMc4jS+uJbI+OhuyZ2RvckG4yvbIFGEwM
	 RG+DX/vxwqF//XN6LbQDTBrXBecQfZqAC0QKseXZCUfaDxSfAAbm2fb7tmhTl2fSAX
	 C8GHowjA1/DQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/4] ALSA: line6: Zero-initialize message buffers
Date: Mon, 15 Apr 2024 06:05:14 -0400
Message-ID: <20240415100520.3127870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c4e51e424e2c772ce1836912a8b0b87cd61bc9d5 ]

For shutting up spurious KMSAN uninit-value warnings, just replace
kmalloc() calls with kzalloc() for the buffers used for
communications.  There should be no real issue with the original code,
but it's still better to cover.

Reported-by: syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000084b18706150bcca5@google.com
Message-ID: <20240402063628.26609-1-tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/line6/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2399d500b8812..8970d4b3b42c3 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -216,7 +216,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	struct urb *urb;
 
 	/* create message: */
-	msg = kmalloc(sizeof(struct message), GFP_ATOMIC);
+	msg = kzalloc(sizeof(struct message), GFP_ATOMIC);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -694,7 +694,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	int ret;
 
 	/* initialize USB buffers: */
-	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	line6->buffer_listen = kzalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
@@ -703,7 +703,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
-- 
2.43.0


