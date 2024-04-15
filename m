Return-Path: <linux-kernel+bounces-145107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2C8A4FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4ABE1F21493
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7078676;
	Mon, 15 Apr 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujUxwP+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313078C92;
	Mon, 15 Apr 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185367; cv=none; b=YbsI+/XVPzGQhJH3odEQG/FcHxtpFH+aENJ3zDjfbby69NtGmUw9ZTpeauEKQz2ovlcEhm2uqklkomw2osn+FhCDZHOnGUMU5ii0uUZvsY53YX5QaLk3865UB6gJ99gkL1n0lQYYO/lLeLhMWVjQoqpnRKvFzH6j7Skz6I6gT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185367; c=relaxed/simple;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMNTZTveLVi9xCMXs+siK2UPcrufgEvuoJLGvhjaV6NE662w/tMfGkDUlCOdQKV2YvKD1m3vfIzmoNWrkl3gO02uIUno66EgPKLptH0JiRFshP3eEXwz+G4vmeK2mIpaMNLTZCkPEwCj2sZeyuiMVtlT25+7Sb0G3KnK/sbBaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujUxwP+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F17C3277B;
	Mon, 15 Apr 2024 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185367;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujUxwP+a+Zjx8ptfATC1pk3sC4sSbnTbK5IhAJpea9+wZbNd6uXPS0DXKu6u0Kz8+
	 qYmqzIwLPyFVQP7kL9ntERfT/Guvnnu5e6naakEwJN9TCljjn00FMXLAve/n5Chs5p
	 3dFZ9IjyN79DmyyXqppNkt86kIQTf5/Rsq7IRIv8x0vAoVMNBVDvVMK/gm/J010AKe
	 +S/5y3TXsctKZXY+LRMb+leu+VL6jasrX50JeoEXNN1A5tM+5skFYtkmfKUXafFvsQ
	 j1W4vQYgntNBhkbtVINhz6YNWvsN379c3Kq6hucYADlrbFnr3Y1Pdqf85LSUJdotH3
	 iFBYomjJZ8Oxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/15] ALSA: line6: Zero-initialize message buffers
Date: Mon, 15 Apr 2024 06:02:48 -0400
Message-ID: <20240415100311.3126785-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
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
index b67617b68e509..f4437015d43a7 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -202,7 +202,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	struct urb *urb;
 
 	/* create message: */
-	msg = kmalloc(sizeof(struct message), GFP_ATOMIC);
+	msg = kzalloc(sizeof(struct message), GFP_ATOMIC);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -688,7 +688,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	int ret;
 
 	/* initialize USB buffers: */
-	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	line6->buffer_listen = kzalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
@@ -697,7 +697,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
-- 
2.43.0


