Return-Path: <linux-kernel+bounces-145145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE18A501A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2062D1F22C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8212C481;
	Mon, 15 Apr 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYJ+K9L/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D012CD82;
	Mon, 15 Apr 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185433; cv=none; b=DzUtt6mow2dgLwYdO5YGnH7KzbzKPRB8cgnJVsiOvhlG0+KiorzaCL3z7Ys80fYyvGsos0d7ky7byaPZy5CimQwB6dJKRtT6XDalqkZAWFots0U/pVeOz2BT8XX9HLyFhRSWQjLsXyHZKfnKgbn68yCECkcCNBVlEJ8JlSnaqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185433; c=relaxed/simple;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iue6d2t+O+rCdnLe16b9dRM+MKlvUif/OKBttQpFia3P+wWQmG4BgGUo5X4AwLj6yJvHNC9yCQeFhMtxCBKkI7QIyFpOF8rH86aMONeBQ1cznVS2leFpnJRg0md5D1LQOk4h0+aZMlpX7BspbEVE/Yi0mwkUojStsF5VxsBUqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYJ+K9L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7516C2BD10;
	Mon, 15 Apr 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185432;
	bh=9WgubhEyjIntDb8goamQgfEtmkM2n3g7m1ut+oETaNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYJ+K9L//+TPx44jcx6XrQlLLbxHbl9ZQ2nq5p/Ei/LZuxPJCcZ7V8p/yg5pKTdwg
	 3DNEnNig8Y4idrJN4YaOpt7633/B00gg7de31E8wnu+mzfRKwa1cMZ+01uDAE3HUDW
	 HGy6duA/gANbimV3//NaCXxq1oUdZlKFZ8vo/YDdIvRcX4Px9rOIoMc99aXY0G5x+2
	 0wiqbTy/Lz+a9QhZPLoMtLWfOEzZGPH6W0CVJ1ihe0otreDV2LVso0FXiwVQVADnxa
	 IIjn4V32EZp3AGslBa11WLThOsu7blXu6jraVVUEsRYWYpfzN2PdSEBNIQeAYU3xqu
	 DbxkNWkTMiaJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/6] ALSA: line6: Zero-initialize message buffers
Date: Mon, 15 Apr 2024 06:04:23 -0400
Message-ID: <20240415100433.3127434-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100433.3127434-1-sashal@kernel.org>
References: <20240415100433.3127434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.86
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


