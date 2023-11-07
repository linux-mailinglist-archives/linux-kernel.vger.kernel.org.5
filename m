Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E07E455A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbjKGQEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344619AbjKGQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6D4680;
        Tue,  7 Nov 2023 07:55:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E5C433C8;
        Tue,  7 Nov 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372531;
        bh=AT8Ep9jVru7y0uF6kBsIgOjwtbJ9Xpn/TacX+DjZS0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgs/Foz25p2Qm9uvIri1C+xEF+Oz9Ia+V13QxIQW//OwoJLSuo8/drNv+GccBBvW5
         qOnv3vlfYAqNjyiD9EZftvyck6NwUj4SZ7FyEr1uA4BpuUFFbrgKcfRKUcvAR7U5gt
         OeCpkBQlt7OHEPgaDPAZCRz8iYJIdHpG5JBl5YsYgYVwZT4xmgrWW/6TxUPG2tzfUA
         bCZMbRceKP5FqPCfYOxhxNqvuMrWGkQOYgMnZnGHsFbh5DkwZ3pzIV05tuIQIGwurM
         svMhYbD5v15rOsNoQH0/IBDU6qmcpYJ5fjhbboEttDfVIXHGyTfvlxj/Rj/KRU+g0H
         yvctMYBQQxvaA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, mengyingkun@loongson.cn,
        zhangyiqun@phytium.com.cn, siyanteng@loongson.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 7/9] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:54:57 -0500
Message-ID: <20231107155509.3769038-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155509.3769038-1-sashal@kernel.org>
References: <20231107155509.3769038-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
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
index e1472c7ab6c17..609dc5133fba9 100644
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

