Return-Path: <linux-kernel+bounces-101978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5087AD47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BE5283F81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11440634FF;
	Wed, 13 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LslA6w0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC6145B27;
	Wed, 13 Mar 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348187; cv=none; b=qWEM5oTRSXUncT0QhzvuTvqiflD/qywT20nYI6dsEohbT/6SZhDCsSc7iMbLPZIiFZIO9yHrf0b9zk3NA+/d31TQ85iBVLfgWIzOpw/6VNGOpayu/tZourH+kUQe94HvABsQG0MsgNvGjSFXLK4X/Wj1dc0bkJOFBI4DQAA4uYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348187; c=relaxed/simple;
	bh=l7C8ExZm8/vajn99EmHxXsg/No9nGsLLD1RgbmkFRlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmKYZIv9dvWXQKaha05hJKDpzYRT+sAmb2JjbNh1qxoCJWy2Spm+sYBubOo3muBNzlYG97fWjUq0s4+fS1nzDUX9CDbfWXq0CjMqasbyUdGYcfD3Eg4mERs2aXi9VsFuvsDaWPFn7TuLGF2tNdcSyD5kvpm17W2TQjWhC6TzHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LslA6w0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADE9C43394;
	Wed, 13 Mar 2024 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348187;
	bh=l7C8ExZm8/vajn99EmHxXsg/No9nGsLLD1RgbmkFRlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LslA6w0Vbo+ivLPXQO+zOsIp3VboYVCLBcbZNGmhI5fxQJ9MKUIPSzXeUDhLFaNIU
	 fcMAK40NVMozOOGZyhJFfaZKaaEbHNG+m0Oviv0VrLtaVDPIFeSoBRDisV1JjcZiHR
	 biyWsHg5IAUPeZ9VSYTfWZHKrIw9ThcDfMw74p3n1JqFEJbmCKNqXdtCoBTfUCuhpA
	 nIh2W4Aj0dJqzbNApwfPswBIAYULRDT63lGL/MPrn1MiOtvRjqrZGHS1TuR6o5yxs0
	 1NFkBHVk1qDU2DuqzgTUL6asgWyw5/09nWGoazNCLhfjD3Ilindy9MIChLQUQwa/1y
	 /oR0r490JLhDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 38/76] ALSA: usb-audio: add quirk for RODE NT-USB+
Date: Wed, 13 Mar 2024 12:41:45 -0400
Message-ID: <20240313164223.615640-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sean Young <sean@mess.org>

[ Upstream commit 7822baa844a87cbb93308c1032c3d47d4079bb8a ]

The RODE NT-USB+ is marketed as a professional usb microphone, however the
usb audio interface is a mess:

[    1.130977] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    1.503906] usb 1-5: config 1 has an invalid interface number: 5 but max is 4
[    1.503912] usb 1-5: config 1 has no interface number 4
[    1.519689] usb 1-5: New USB device found, idVendor=19f7, idProduct=0035, bcdDevice= 1.09
[    1.519695] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.519697] usb 1-5: Product: RØDE NT-USB+
[    1.519699] usb 1-5: Manufacturer: RØDE
[    1.519700] usb 1-5: SerialNumber: 1D773A1A
[    8.327495] usb 1-5: 1:1: cannot get freq at ep 0x82
[    8.344500] usb 1-5: 1:2: cannot get freq at ep 0x82
[    8.365499] usb 1-5: 2:1: cannot get freq at ep 0x2

Add QUIRK_FLAG_GET_SAMPLE_RATE to work around the broken sample rate get.
I have asked Rode support to fix it, but they show no interest.

Signed-off-by: Sean Young <sean@mess.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240124151524.23314-1-sean@mess.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 39313db7aed3f..6cd7f77779159 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1900,6 +1900,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.43.0


