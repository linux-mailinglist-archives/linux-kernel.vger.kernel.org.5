Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C67CE013
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbjJROgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbjJROfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:35:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1F194;
        Wed, 18 Oct 2023 07:13:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB8C433C9;
        Wed, 18 Oct 2023 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638436;
        bh=ugI4bNdB+LkM72VAXRe6Oef03e0Xgc0r5ZLnTsKxObI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTynJikBdn/ytk2qT2p84enGGk5nd/NLUQgNYzFs1ZUqInlUkvlOXAhnRl8Zmg4DH
         x55vV7PGkQFziHxlf34SCYlxgJX0Xe+TPKVanbjbkinxzVSReo5P0EJmIooVrHXLdu
         jn6FyqbwZCMtPMjIaVhr7As+uH+HuNwfmZt8wHode69yxy5X+TURPI3FNMTDDBbkuv
         EX+0BV9lLbHVnStXJ+vgQwtQvWmU0k4h0R+7wLo6hu9PSS8McMx09PmaUa6yyQn1Bx
         7flQWtf4esqwplJkpLjcTt5EymHteGtyZxEQ2tygsyc9X2hzCUTyKzokML0R6Liise
         L9W+4sXyltZKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christos Skevis <xristos.thes@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        maciej.szmigiero@oracle.com, jussi@sonarnerd.net,
        aichao@kylinos.cn, ltyl@hem-e.com, whalechang@google.com,
        john@keeping.me.uk, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 14/19] ALSA: usb-audio: Fix microphone sound on Nexigo webcam.
Date:   Wed, 18 Oct 2023 10:13:16 -0400
Message-Id: <20231018141323.1334898-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c  | 7 +++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9105ec623120a..783a2493707ea 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1204,6 +1204,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
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
index 80ee3b54bfe9c..6129a62316422 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2175,6 +2175,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.40.1

