Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1311774764
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjHHTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHHTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D436871
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122A86253F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7EDC433C8;
        Tue,  8 Aug 2023 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691499430;
        bh=S0FBs7xD3Rf0XgcDIGN+SZnoxzu5hScAnRLm9gSsKfo=;
        h=From:To:Cc:Subject:Date:From;
        b=ALuJOr5zjEN0HXUfZj23CYhl/qslnq1Ul9nu3AiwMPIfPvJxHwRaegVzju60uur8J
         bxVTyQn9a7pQID1YwvQ3TVHiikXZM1AmhN5BNVELbwnMc8OTuZ1NsJNERgjxihgX2S
         pKSUqZ5hvzW9S9flCMuRgZKlCnC3T/DVApS/RFXg3p5EDvA7MYF1/bWBt8TT3PvvlH
         Dgo/3KPmI7ch1A15zpeyGO1dvP81nxbIj6IiYRwEDWpWh8fVHB6LXElveU+E4tgvd3
         EAQMYZQwCf7CrbdlXAhZm1vtzl98mEbsXttJ17Er5BgOz1bwuD+EObjpfj7EPhBtRF
         9XR+xjzLgvYWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Weidong Wang <wangweidong.a@awinic.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: aw88261: avoid uninitialized variable warning
Date:   Tue,  8 Aug 2023 14:56:54 +0200
Message-Id: <20230808125703.1611325-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

aw88261_reg_update() returns an unintialized error code in the
success path:

sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                if (aw_dev->prof_cur != aw_dev->prof_index) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
        return ret;
               ^~~
sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its condition is always true
                if (aw_dev->prof_cur != aw_dev->prof_index) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Return zero instead here.

Fixes: 028a2ae256916 ("ASoC: codecs: Add aw88261 amplifier driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/aw88261.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 82923b454dd47..6e2266b713862 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -652,6 +652,8 @@ static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
 			ret = aw88261_dev_fw_update(aw88261);
 			if (ret)
 				return ret;
+		} else {
+			ret = 0;
 		}
 	}
 
-- 
2.39.2

