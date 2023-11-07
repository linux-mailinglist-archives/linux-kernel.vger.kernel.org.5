Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FE7E4466
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjKGPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjKGPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1619172D;
        Tue,  7 Nov 2023 07:49:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61BC433C8;
        Tue,  7 Nov 2023 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372170;
        bh=fEtMn1hCvtVi25a3tRCRxH8zwGvDPOKB7irIAeWf0tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Py8TFnHDGufZA63xD5gRBWiUTUGw5UhwyNEZVBdaQ9bsqh1IJ10D9wlrfN3k1rF4J
         NY+l4BP+O/KQzjlL+r5I7zG18Zri5ORmJtSf+5qKGrJzlPdKgfIYLYucmyplQpi5DG
         2x9j/k7YeA5MMz3BpnX4Y4lKnCmakVhM2ohuKP22BxaKIBjaWhVjFh1T2mBvB06DCp
         zZgYpahRhjPx71Fp/rARhXTXWT+NOTplVwbRHQBSm1r0fJNiHZcjsY8vdOC7hpQU/E
         JW381gTaH2GJ+dIlR/tTbQbXgK7TdDXw/+v1KkOmY2nDrBA3TQYKjbrRi+y3Wvf9nN
         5s6UQa261j8EQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, chenhuacai@kernel.org,
        siyanteng@loongson.cn, zhangyiqun@phytium.com.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 16/34] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:47:56 -0500
Message-ID: <20231107154846.3766119-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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

