Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744F7CDF02
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbjJROPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbjJROPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:15:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD1D4E;
        Wed, 18 Oct 2023 07:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F08EC433CC;
        Wed, 18 Oct 2023 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638424;
        bh=tlLALlZc8lRhCcdrr02v5GI29jD6SXikxOtIkZKF5ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hnnh/WsVc+gpmr6pfPxfxkwjE8A2RzHuNE3wAcTUGd+Qwc/fPCGCgXTxYKRYqSAEd
         KY5CHzChFQK2ao0u7Xyia5ty0fxYj1Z+I0CY4RKtjGJpTAsVzmnNZePZL2S9qw67Lx
         FtqXn+r5SAt5kkC8OLh12FDqFIgiFtkPV0ON+b1LJ7j96rFoB57Pi6f/xgsP0uh120
         zx9IxaGkogshP6GjHRQJ4xBnTDvb7ctkNS4aSu1NDjt7zS5emxTMVSq8kG4Z7fvoDq
         ND3h7hMLcQAwvbffAXdbqLbioycC3i24AVrMUrzAKxpMiv/IYvJ8jia7SY8FKsm9gQ
         GXJm+npYiiwdQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     WhaleChang <whalechang@google.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, jussi@sonarnerd.net, aichao@kylinos.cn,
        john@keeping.me.uk, ltyl@hem-e.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 09/19] ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset
Date:   Wed, 18 Oct 2023 10:13:11 -0400
Message-Id: <20231018141323.1334898-9-sashal@kernel.org>
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
index 4667d543f7481..80ee3b54bfe9c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1992,7 +1992,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
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

