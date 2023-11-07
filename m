Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5067E43DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjKGPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbjKGPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F82B10C1;
        Tue,  7 Nov 2023 07:47:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B64C433CA;
        Tue,  7 Nov 2023 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372060;
        bh=fEtMn1hCvtVi25a3tRCRxH8zwGvDPOKB7irIAeWf0tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsNplp6cDDHq8kOp0LhHsrN1fCrBlgG8So2/sNuWN1D8z3lR+sSXDzqo7krjkPazF
         aLdFwtDze9ohLnlOLYMIbr8IIO1xPRxab5/eEnU8VZKZbL06lGFonVbVzADsG4wh1N
         sEqVS8t5Yxl7Tm3lRbkW79vWbBq2iX4WWD0NDcmBTNIaaMK18n/HG4UgGOw/7SbtsG
         /uOZDJeIgxgTOm8EgtSMTfORUpFDfjHSHI5/xi/zvl4Xo0FiUvCUydtXgeDX5aYHEu
         w/KMCHx9MZXvJ7QIokKHhqP+cX1MNbIw1tvkgEs8hAx0rq1Zo1FtzIWL0QBD9lBHub
         RmRN0gmvll9eQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mengyingkun@loongson.cn, divya1.prakash@intel.com,
        siyanteng@loongson.cn, zhangyiqun@phytium.com.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/36] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:46:00 -0500
Message-ID: <20231107154654.3765336-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 2633a4bb1d85d..214a0680524b0 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -354,8 +354,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
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

