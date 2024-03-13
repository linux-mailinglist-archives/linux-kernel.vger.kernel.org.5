Return-Path: <linux-kernel+bounces-101977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEEA87AD45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD05B246F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C59634FD;
	Wed, 13 Mar 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNTLZ8LC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A8145B34;
	Wed, 13 Mar 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348186; cv=none; b=NLqDX5r51oXR8rmtbNyGljUG5/PQrjXI8+hQVz3VICP7sGxdC2vI5pZPzjy0vOkI8N6nTTMNH2kDfzDDSSZ5o4alDo3BowlcsNBAJpkr39wtrlhAlfxbJFIKYJ1KhxVnlovURRJYXxZsGYKyfVBfvEVMt8DjR0bD2pIFiZ31+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348186; c=relaxed/simple;
	bh=rOcQLc+c5oGpLCDyOwWmMShv+flioNNcrK/cP/qzZAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQXqjsZ9f2gcdBzQNKeZlQjN2Gv1j1M2vq8ADoxSbG1T047MhIeoYEt2MFPhfZYaac1rEi9YBCNhIzuqpvArP888wD5E34QXpaZQJ/zrXOrTbQRHlRdkTgMj3xR50T+bevOwk2KsB9Y0TGWjuqE4dc2tjHYmYdRUmzbupfRxPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNTLZ8LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6115DC43390;
	Wed, 13 Mar 2024 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348186;
	bh=rOcQLc+c5oGpLCDyOwWmMShv+flioNNcrK/cP/qzZAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNTLZ8LC1Ir6gmxStyRYU6n0wgJOkToIblA+kduo/sonDsI7Grxh8kx1GlVlVLyhs
	 eGtWlRsJk6ttk0LuaC7OmXV7ax6LiNQg1s8aWTyMAV5qvm2oDMCystmXXz8AWra1JT
	 zIpe9zZsEM2M8Tjlzb02iWh4HNm2RGVV4azIU+2b+3XgSnltouFcnSJCxeR2IK+3UO
	 IltqO9oRylfLrYUkeB4FOUwSZ1HzLIcdHrZf0kIKxeiRd5ZP/2VnLduKajzCajF5yt
	 Tkn5cyIIzpp/1WJtRlygbUXaJSl3qv3b/bpAwEaWLJk5MK2UOfI+IvtUxRAJRLcl3o
	 njA0gCyRBZUUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christos Skevis <xristos.thes@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/76] ALSA: usb-audio: Fix microphone sound on Nexigo webcam.
Date: Wed, 13 Mar 2024 12:41:44 -0400
Message-ID: <20240313164223.615640-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christos Skevis <xristos.thes@gmail.com>

[ Upstream commit 4a63e68a295187ae3c1cb3fa0c583c96a959714f ]

I own an external usb Webcam, model NexiGo N930AF, which had low mic volume and
inconsistent sound quality. Video works as expected.

(snip)
[  +0.047857] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[  +0.003406] usb 5-1: New USB device found, idVendor=1bcf, idProduct=2283, bcdDevice=12.17
[  +0.000007] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000004] usb 5-1: Product: NexiGo N930AF FHD Webcam
[  +0.000003] usb 5-1: Manufacturer: SHENZHEN AONI ELECTRONIC CO., LTD
[  +0.000004] usb 5-1: SerialNumber: 20201217011
[  +0.003900] usb 5-1: Found UVC 1.00 device NexiGo N930AF FHD Webcam (1bcf:2283)
[  +0.025726] usb 5-1: 3:1: cannot get usb sound sample rate freq at ep 0x86
[  +0.071482] usb 5-1: 3:2: cannot get usb sound sample rate freq at ep 0x86
[  +0.004679] usb 5-1: 3:3: cannot get usb sound sample rate freq at ep 0x86
[  +0.051607] usb 5-1: Warning! Unlikely big volume range (=4096), cval->res is probably wrong.
[  +0.000005] usb 5-1: [7] FU [Mic Capture Volume] ch = 1, val = 0/4096/1

Set up quirk cval->res to 16 for 256 levels,
Set GET_SAMPLE_RATE quirk flag to stop trying to get the sample rate.
Confirmed that happened anyway later due to the backoff mechanism, after 3 failures

All audio stream on device interfaces share the same values,
apart from wMaxPacketSize and tSamFreq :

(snip)
Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           8
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             1
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x005c  1x 92 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
(snip)

Based on the usb data about manufacturer, SPCA2281B3 is the most likely controller IC
Manufacturer does not provide link for datasheet nor detailed specs.
No way to confirm if the firmware supports any other way of getting the sample rate.

Testing patch provides consistent good sound recording quality and volume range.

(snip)
[  +0.045764] usb 5-1: new high-speed USB device number 2 using xhci_hcd
[  +0.106290] usb 5-1: New USB device found, idVendor=1bcf, idProduct=2283, bcdDevice=12.17
[  +0.000006] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000004] usb 5-1: Product: NexiGo N930AF FHD Webcam
[  +0.000003] usb 5-1: Manufacturer: SHENZHEN AONI ELECTRONIC CO., LTD
[  +0.000004] usb 5-1: SerialNumber: 20201217011
[  +0.043700] usb 5-1: set resolution quirk: cval->res = 16
[  +0.002585] usb 5-1: Found UVC 1.00 device NexiGo N930AF FHD Webcam (1bcf:2283)

Signed-off-by: Christos Skevis <xristos.thes@gmail.com>
Link: https://lore.kernel.org/r/20231006155330.399393-1-xristos.thes@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c  | 7 +++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 567514832b0df..d818eee53c90a 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1205,6 +1205,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2283): /* NexiGo N930AF FHD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a765da40eb27d..39313db7aed3f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1898,6 +1898,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.43.0


