Return-Path: <linux-kernel+bounces-145164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5778A504B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0121C229BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76768134408;
	Mon, 15 Apr 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnMuy7yx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE168132C19;
	Mon, 15 Apr 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185466; cv=none; b=NBOwh4T6FzGrGt0K/D6lDPZhhoh/GSZdmTmVbpnM4l6fIjnGGo2sQKsxxrYY1N6rhG956teADgmxXDQd66TkooCMecCN54ONO8qhieYi+qXERNfzQ/I8lRKtvH5QdNJ/5A4Y4RVSRS+FebQK5FObrEG0x17jQqoTQdaCEHeVldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185466; c=relaxed/simple;
	bh=rMTXzkrVMwHWTz+d7d9laA8+1YjXeVMCFa4NLOSuDQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIQ8LLWP03CN6YAAo6q2J7kWZRyRhHvtcG2NW6zzx+EWZApFYYPLcytS5qSRLM9hMRH0dbqZa+Hy5kYVTK0RThb2c7r+oz0+fXSyR494YDy8EfOJXzx0sGTlScFSLlvi87pH/NJP7cHUonJBdazJCniRnsbvo1ZE5C4+nOVb6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnMuy7yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EBAC113CC;
	Mon, 15 Apr 2024 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185466;
	bh=rMTXzkrVMwHWTz+d7d9laA8+1YjXeVMCFa4NLOSuDQc=;
	h=From:To:Cc:Subject:Date:From;
	b=mnMuy7yxHyf68CXLMPiKbia50BopUQmztH50wJAfqiV6W0TS25Lrx9LakcyXEdfcJ
	 588eamT/DNV8hhgE8O/1DkVD+BQQKmYct2T+ZgqImVS39H4Eamy9fQS4cj0r1/JpFC
	 +BvneNmZdYsH6MeQLL4EjebZdqxPcR+kBZeJuoN6wYcSJPY1f06gRK69E7I8dPiZGu
	 ZVlYmtSn7+fMyfqHfvTAtwROXVKjkWiZwINZyLrIRjBaHUQOpRVREuufm4zkdyBWhK
	 FgmPDhDrZF8FmWsWQ8X/PkIpqb8yCj8iyLvFJWeA6gMG2MwHbIaqKwnlbBi0CHbI0n
	 0scRullUZGL8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+7fb05ccf7b3d2f9617b3@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/4] ALSA: line6: Zero-initialize message buffers
Date: Mon, 15 Apr 2024 06:05:04 -0400
Message-ID: <20240415100510.3127774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index 22104cb84b1ca..efa8fb59d3ad2 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -201,7 +201,7 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 	struct urb *urb;
 
 	/* create message: */
-	msg = kmalloc(sizeof(struct message), GFP_ATOMIC);
+	msg = kzalloc(sizeof(struct message), GFP_ATOMIC);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -679,7 +679,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	int ret;
 
 	/* initialize USB buffers: */
-	line6->buffer_listen = kmalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
+	line6->buffer_listen = kzalloc(LINE6_BUFSIZE_LISTEN, GFP_KERNEL);
 	if (!line6->buffer_listen)
 		return -ENOMEM;
 
@@ -688,7 +688,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 		return -ENOMEM;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
-		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
+		line6->buffer_message = kzalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
 		if (!line6->buffer_message)
 			return -ENOMEM;
 
-- 
2.43.0


