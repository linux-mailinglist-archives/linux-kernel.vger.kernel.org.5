Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D230B7E45A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjKGQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343530AbjKGQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:16:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDF1BCA;
        Tue,  7 Nov 2023 07:52:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CD8C433C7;
        Tue,  7 Nov 2023 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372337;
        bh=Hi4ahaJUaPkJz0w6M6TzWZNeU9v/cKUfV97yidC2350=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsxcy4MGdGP4D+1sz0xIJbO4dAi12hl86q91Dj6eY+CrTKA/SVpL7l3VeJQo5zq04
         Bs9JgOOtJRmq1XZPdjs01mDTbd6L5K/+ho8xJCoOyAyHi9rgM94n9+dVsCMEpDZlhb
         dDDNDpsIsTGGmvnanFKW/2FM5KW58sx0rdfom6LknsCVtxvjTY9YDLG8Y9lC2eanPQ
         9RjNGC9uQmP+EHZXyZAyDj6IcqOx2Yi0GTIm15Mc15Pt3oOhik6lIXVmzKi5oGVOu2
         CvHApCTm3V7dHid22wyeFQAF8ZwrFhu3y4Dj3K8lgnbIwX2ZEG2ycY431/y1RDNTwD
         zVLDEt4srHmcw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        siyanteng@loongson.cn, zhangyiqun@phytium.com.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/22] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:51:21 -0500
Message-ID: <20231107155146.3767610-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit f93dc90c2e8ed664985e366aa6459ac83cdab236 ]

While AudioDSP drivers assign streams exclusively of HOST or LINK type,
nothing blocks a user to attempt to assign a COUPLED stream. As
supplied substream instance may be a stub, what is the case when
code-loading, such scenario ends with null-ptr-deref.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20231006102857.749143-2-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index eea22cf72aefd..ec95d0449bfe9 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -320,8 +320,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 	struct hdac_stream *res = NULL;
 
 	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
+	int key = (substream->number << 2) | (substream->stream + 1);
+
+	if (substream->pcm)
+		key |= (substream->pcm->device << 16);
 
 	spin_lock_irq(&bus->reg_lock);
 	list_for_each_entry(azx_dev, &bus->stream_list, list) {
-- 
2.42.0

