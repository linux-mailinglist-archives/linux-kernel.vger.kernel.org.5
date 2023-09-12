Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC879CA86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjILIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjILIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:47:37 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F0DAA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UUNaZ
        GGbls46jLI+B/C/K14g49rwHi1RLoMHof9iMLo=; b=VJ0PMyRI8vrBIOjmk9aUO
        pKAA9Z+gBp3CWM7Kjkj6q4JS7kH2slEfkSQmtz7LihoWMSTPB8HPw9LYydxKbq0h
        KFEhhZ0hBrTZQFrJ7z2ic6vgF93nUIVkqiAIxD4aJAhlc1m76QvG49pn7zzXChHE
        Mi9QYhOxJNg4f9WOsCxUbs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wAnfEExJQBl10RRBw--.47327S4;
        Tue, 12 Sep 2023 16:45:46 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     perex@perex.cz, tiwai@suse.com, cujomalainey@chromium.org,
        maciej.szmigiero@oracle.com, clecigne@google.com,
        make_ruc2021@163.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: control: do not access controls without possession of r_w lock
Date:   Tue, 12 Sep 2023 16:45:30 +0800
Message-Id: <20230912084530.3307329-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnfEExJQBl10RRBw--.47327S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1ruFWrWw18tw48XF43Wrg_yoWftrbEgF
        48XF40kr4UuFyI9FnYy3WrJFWFkF1xAF1kK3Wftr13CFy3tr9IgF1UXFZ5ZryDuFs5ur18
        Jw18Kr4ava43tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKSoXUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiVwnoC1etsTPt4gAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we should not access any of its memory when we don't ensure possession of
a read/write lock. Otherwise we risk a use after free access, which allows
local users to cause a denial of service and obtain sensitive information
from kernel memory.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 sound/core/control.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 59c8658966d4..98782cc68ee1 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -590,7 +590,8 @@ static int __snd_ctl_remove(struct snd_card *card,
 		remove_hash_entries(card, kcontrol);
 
 	card->controls_count -= kcontrol->count;
-	for (idx = 0; idx < kcontrol->count; idx++)
+	count = kcontrol->count;
+	for (idx = 0; idx < count; idx++)
 		snd_ctl_notify_one(card, SNDRV_CTL_EVENT_MASK_REMOVE, kcontrol, idx);
 	snd_ctl_free_one(kcontrol);
 	return 0;
-- 
2.37.2

