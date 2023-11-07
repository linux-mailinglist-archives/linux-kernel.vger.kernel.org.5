Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F347E45D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjKGQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjKGQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:20:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456333C34;
        Tue,  7 Nov 2023 07:54:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D1C433C8;
        Tue,  7 Nov 2023 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372494;
        bh=I2CHZ9wd0uCeF6OSY/9nvcGL7/hxfer4R5tJQPKhdg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4D/RvhGfL+JV6Vohi2/FzaOEFwWMohiGGvOwf3k+32u4JGO/saC9STo7NMqlK86N
         S4HNh9GAitlDQb47ziNP2xDqxePTUC6t28IY5xYWbxGtYpdrhMhpuSi6JSZiFIMCBh
         31V+SAumRXIx4jll0TckSuMz0DohaEvAJX0ccmfLdV9PMPAJBi3+Z7xx9IOi8cvnYq
         mL/x6s5czudlOq28FskZkil3Zb1UrAC6K88rCVDHu4uSBiJU8FkxUbxkT8jnrLHAHg
         0/BvMtKfmlzK6MQSBWbKtW/PgH6yvmUtf6QvaeD9CQtLTtc6pMuSVfFpXpbWCEOhrO
         KlZtR+EHNK25w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mengyingkun@loongson.cn, pierre-louis.bossart@linux.intel.com,
        zhangyiqun@phytium.com.cn, siyanteng@loongson.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/11] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:54:16 -0500
Message-ID: <20231107155430.3768779-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155430.3768779-1-sashal@kernel.org>
References: <20231107155430.3768779-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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
index eee422390d8e2..2569f82b6fa02 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -241,8 +241,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
 	struct hdac_stream *res = NULL;
 
 	/* make a non-zero unique key for the substream */
-	int key = (substream->pcm->device << 16) | (substream->number << 2) |
-		(substream->stream + 1);
+	int key = (substream->number << 2) | (substream->stream + 1);
+
+	if (substream->pcm)
+		key |= (substream->pcm->device << 16);
 
 	list_for_each_entry(azx_dev, &bus->stream_list, list) {
 		if (azx_dev->direction != substream->stream)
-- 
2.42.0

