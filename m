Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF47E451E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbjKGQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjKGP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00F273B;
        Tue,  7 Nov 2023 07:53:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE934C433C7;
        Tue,  7 Nov 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372397;
        bh=Wspxi7izpOnuU7N2S9ML1xipS+KJcQybj1hbm+wsaCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iybQmi3so90G6tVO/URPsS27IAAN3ns73xt0lYmaAY+MEb64yHoGmgcXuvgiEkEj7
         qQQGkoqBMqtwrb17a8qUIsO3xe9xxTJJLf2/pong99VMPWFxP4Y3juBquOV0Zk50fG
         amjaPnxgItSmKSEMN7nPJhDgr/MojApYx32FDu45CsOGKwfNls1akA/LT92MkA4tRZ
         8BmkaYvoHocPE4RJpef3YVObNJ703ApMof0O/zuOyEZYkFmMbHYb7bBwvGq4/NvZot
         haqai+FS9gpzaLTwOhnReRl506QmuoFAq7h2Sr7JgtkcnR45pJ5L62aM2jfykHyDAN
         ZwtJNAPSKPWvw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        divya1.prakash@intel.com, mengyingkun@loongson.cn,
        siyanteng@loongson.cn, zhangyiqun@phytium.com.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/16] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:52:29 -0500
Message-ID: <20231107155249.3768098-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index 1e0f61affd979..5570722458caf 100644
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

