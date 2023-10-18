Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E437CDE91
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjJROMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjJROM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F511D;
        Wed, 18 Oct 2023 07:12:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23010C433C7;
        Wed, 18 Oct 2023 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638344;
        bh=nVcIiEHY2EosQ4wSCJl9q/5UDKUS1EHQmF9SC/TidPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIJ4RtcE1qELN0rYpCIuDXseEA1cDWp+1dhsMmyeKjrmFgJnPbvsCiSuqPtdSAeVo
         KIhpY5K0Lw445U5eWJCxi3iy5vG6BT4Y4+78NHNN8lZ7OCI7sySLxjK3D1rI6CI1NU
         wcdHwEYvmtbfvjHCFOmsyq6M9CUDEvZpbsj5spv0wbrMmYAB7kV7k7qZ23AdsEQGUt
         oKVGWHzHOOQseRYHsPA1hqacZik+9+S7UTgAXM+mR/PyHRBkm/AtPaoBfJplI0Vvpz
         S+dKebD0ysus8lKFHo05H5vZ3snOZFYG16IxCYBxMQLmhrhS843yX6AeB/PtRgk5j4
         Rpau3RBYaUwZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     WhaleChang <whalechang@google.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, jussi@sonarnerd.net, john@keeping.me.uk,
        ltyl@hem-e.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 13/31] ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset
Date:   Wed, 18 Oct 2023 10:11:30 -0400
Message-Id: <20231018141151.1334501-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WhaleChang <whalechang@google.com>

[ Upstream commit 6a83d6f3bb3c329a73e3483651fb77b78bac1878 ]

When a Opencomm2 Headset is connected to a Bluetooth USB dongle,
the audio playback functions properly, but the microphone does not work.

In the dmesg logs, there are messages indicating that the init_pitch
function fails when the capture process begins.

The microphone only functions when the ep pitch control is not set.

Toggling the pitch control off bypasses the init_piatch function
and allows the microphone to work.

Signed-off-by: WhaleChang <whalechang@google.com>
Link: https://lore.kernel.org/r/20231006044852.4181022-1-whalechang@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 598659d761cc9..d4bbef70d2f7b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1994,7 +1994,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 
-- 
2.40.1

