Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B638064A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376541AbjLFBmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376507AbjLFBmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:42:46 -0500
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 17:42:50 PST
Received: from mail-m25491.xmail.ntesmail.com (mail-m25491.xmail.ntesmail.com [103.129.254.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32B1B9;
        Tue,  5 Dec 2023 17:42:50 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=AaurLE93EkPtxzsiE2lc3GGq8jzl/D4grIG8JIVgkIitxQAg/LPM2VhiQMzVz6lWBj6YfmFwRft3ss1PeS95se6vHNs0PhocLhaNnV9z7CHVI//OF84CTUGfSDi7rSZnzbieU2ECm0gBLOdRniBhHddNWo7nW4IU7M3t+FQeNr8=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=v4SJYmtYRkvhafgduYRH51SkhMDvfniryqNGMH783sY=;
        h=date:mime-version:subject:message-id:from;
Received: from DESKTOP-TIABR87.localdomain (unknown [58.22.7.114])
        by mail-m12745.qiye.163.com (Hmail) with ESMTPA id E6F2B9A04DF;
        Wed,  6 Dec 2023 09:32:41 +0800 (CST)
From:   Jason Zhang <jason.zhang@rock-chips.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Zhang <jason.zhang@rock-chips.com>
Subject: [PATCH] ALSA: pcm: fix out-of-bounds in snd_pcm_state_names
Date:   Wed,  6 Dec 2023 09:31:39 +0800
Message-Id: <20231206013139.20506-1-jason.zhang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1LQ1YdH0saS0JPS09JTUlVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8c3cc17acab218kuuue6f2b9a04df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Cyo6LTwxLAIQUTMeOQIB
        TkhPFDNVSlVKTEtKQ0lNSE1JTk9CVTMWGhIXVREaCBQVVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0pMSTcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcm state can be SNDRV_PCM_STATE_DISCONNECTED at disconnect
callback, and there is not an entry of SNDRV_PCM_STATE_DISCONNECTED
in snd_pcm_state_names.

This patch adds the missing entry to resolve this issue.

cat /proc/asound/card2/pcm0p/sub0/status
That results in stack traces like the following:

[   99.702732][ T5171] Unexpected kernel BRK exception at EL1
[   99.702774][ T5171] Internal error: BRK handler: f2005512 [#1] PREEMPT SMP
[   99.703858][ T5171] Modules linked in: bcmdhd(E) (...)
[   99.747425][ T5171] CPU: 3 PID: 5171 Comm: cat Tainted: G         C OE     5.10.189-android13-4-00003-g4a17384380d8-ab11086999 #1
[   99.748447][ T5171] Hardware name: Rockchip RK3588 CVTE V10 Board (DT)
[   99.749024][ T5171] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[   99.749616][ T5171] pc : snd_pcm_substream_proc_status_read+0x264/0x2bc
[   99.750204][ T5171] lr : snd_pcm_substream_proc_status_read+0xa4/0x2bc
[   99.750778][ T5171] sp : ffffffc0175abae0
[   99.751132][ T5171] x29: ffffffc0175abb80 x28: ffffffc009a2c498
[   99.751665][ T5171] x27: 0000000000000001 x26: ffffff810cbae6e8
[   99.752199][ T5171] x25: 0000000000400cc0 x24: ffffffc0175abc60
[   99.752729][ T5171] x23: 0000000000000000 x22: ffffff802f558400
[   99.753263][ T5171] x21: ffffff81d8d8ff00 x20: ffffff81020cdc00
[   99.753795][ T5171] x19: ffffff802d110000 x18: ffffffc014fbd058
[   99.754326][ T5171] x17: 0000000000000000 x16: 0000000000000000
[   99.754861][ T5171] x15: 000000000000c276 x14: ffffffff9a976fda
[   99.755392][ T5171] x13: 0000000065689089 x12: 000000000000d72e
[   99.755923][ T5171] x11: ffffff802d110000 x10: 00000000000000e0
[   99.756457][ T5171] x9 : 9c431600c8385d00 x8 : 0000000000000008
[   99.756990][ T5171] x7 : 0000000000000000 x6 : 000000000000003f
[   99.757522][ T5171] x5 : 0000000000000040 x4 : ffffffc0175abb70
[   99.758056][ T5171] x3 : 0000000000000001 x2 : 0000000000000001
[   99.758588][ T5171] x1 : 0000000000000000 x0 : 0000000000000000
[   99.759123][ T5171] Call trace:
[   99.759404][ T5171]  snd_pcm_substream_proc_status_read+0x264/0x2bc
[   99.759958][ T5171]  snd_info_seq_show+0x54/0xa4
[   99.760370][ T5171]  seq_read_iter+0x19c/0x7d4
[   99.760770][ T5171]  seq_read+0xf0/0x128
[   99.761117][ T5171]  proc_reg_read+0x100/0x1f8
[   99.761515][ T5171]  vfs_read+0xf4/0x354
[   99.761869][ T5171]  ksys_read+0x7c/0x148
[   99.762226][ T5171]  __arm64_sys_read+0x20/0x30
[   99.762625][ T5171]  el0_svc_common+0xd0/0x1e4
[   99.763023][ T5171]  el0_svc+0x28/0x98
[   99.763358][ T5171]  el0_sync_handler+0x8c/0xf0
[   99.763759][ T5171]  el0_sync+0x1b8/0x1c0
[   99.764118][ T5171] Code: d65f03c0 b9406102 17ffffae 94191565 (d42aa240)
[   99.764715][ T5171] ---[ end trace 1eeffa3e17c58e10 ]---
[   99.780720][ T5171] Kernel panic - not syncing: BRK handler: Fatal exception

Signed-off-by: Jason Zhang <jason.zhang@rock-chips.com>
---
 sound/core/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 20bb2d7c8d4b..6d0c9c37796c 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -253,6 +253,7 @@ static const char * const snd_pcm_state_names[] = {
 	STATE(DRAINING),
 	STATE(PAUSED),
 	STATE(SUSPENDED),
+	STATE(DISCONNECTED),
 };
 
 static const char * const snd_pcm_access_names[] = {
-- 
2.25.1

