Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2337E44CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjKGP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjKGP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:57:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FBA5B8F;
        Tue,  7 Nov 2023 07:51:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECE3C433C7;
        Tue,  7 Nov 2023 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372263;
        bh=iGDcDMie/bLvpR3Y+sCBSpuRZWNrFFZtivyhaL3/FlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2xDL0jq4d+iVXk5Zt18DoHSsUc5sn/xkm6PQf2v7/sq93F+pZP/ABBZtxTXnaiaq
         LA0nJi5TUjtDRqkq3Lk0//fxZaWRhl9pg5ls+EaRcqk6FnEG41DmpS5H1g66fLh3Hn
         /7t/sbnYSQ26MZfxi1KsULW8hNDtBYQyq51u9O0kCY/ZdXYMJcpBqcgweBs+8zJCB5
         lrEbBqRcz8eZxNkaxUX/Q2YZ8X1fvRr613yqDszn6v9QCGchW9iwUSRQJhugS5yAbE
         1ymY6wWkhWrnKvbWkGkkxCE+O4UfJ+MUnwbSHYZ7WtrrzbH5e7eSzFHe6quprEYvuO
         fhhRWdo12w8/A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        chenhuacai@kernel.org, mengyingkun@loongson.cn,
        siyanteng@loongson.cn, zhangyiqun@phytium.com.cn,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/30] ALSA: hda: Fix possible null-ptr-deref when assigning a stream
Date:   Tue,  7 Nov 2023 10:49:49 -0500
Message-ID: <20231107155024.3766950-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 1b8be39c38a96..741a5d17ae4cb 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -338,8 +338,10 @@ struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
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

