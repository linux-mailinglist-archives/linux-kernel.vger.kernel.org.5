Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D9756E46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGQUd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGQUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143081A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 975DA61254
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94ECC433C8;
        Mon, 17 Jul 2023 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689625999;
        bh=cdhA/uWMGFYNLiuZXNgnxDS/KR9lMC2udWWSbRYPndE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gLZUVojg4jKy4PTMuuRaJRkPy+KTOrIc2UqPsvLIftUTjRU0kvMiaTuoTgweG9Bht
         gDFKrXKBxBCs+bnehoD3lhqDPcmEDlSGL6Idg9YliOGb435aFLHWn5PHm8/uCb3Kpm
         LDaOJU5IrN8F5ERCzO4kozWw4HWr+CTKw9cPrimuqScteGzPG3tEnRkSJ+YGKLXLYF
         8oV/pREqjmFcItdEBJncwBwbGTV6R7uYNsU0Mkp+/0bZfzDp9mXJptYkw//OTqgE0E
         RNPM3BrwctvGv3QNMKYhdq3dEbQCBp8UIOVb909e4fIhvossYCCIUNYtbLks91BjZ1
         MGv+Am4MHzkGw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 17 Jul 2023 21:33:05 +0100
Subject: [PATCH 3/3] ALSA: hda: Use regcache_reg_cached() rather than open
 coding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-regmap-cache-check-v1-3-73ef688afae3@kernel.org>
References: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
In-Reply-To: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cdhA/uWMGFYNLiuZXNgnxDS/KR9lMC2udWWSbRYPndE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktaWHp8xs+otXp3Fz83pPngNJL1ch5h3eptyOK
 9g68ULu8WKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLWlhwAKCRAk1otyXVSH
 0FCcB/4/yqh/MT+mdIfR75L/u63k+FCJNO88xJeft85zjt58cF6oIUCQASp6BHpO+VK0Mqo+gaj
 vG2O+pbUy5tqfb6sVSbE3smMne18FuwqkldckIQsIxAQsJmjZgroJDCXgjiFqmIpfURfXQE021y
 kBTCvDuGa4jfVy7zC5w8JYa6TabufjXiuWOZ04u9a+8ngQjVvPbJFxFEG3OMKpGdOx/mHIhyFj/
 OjMt+3AN1u3TX69YaRBa+908Tpc7x20j2RZro3hA/wiZ8Ogw2Xj1C//ABatTJx3oh57QxhcfXqC
 oMyVfCXaeM3x8HbZiNxXDtBC/mob9h9QTvXJLImqCDortOj+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDA driver intentionally drops repeated writes to registers in some
circumstances, beyond the suppression of noop writes that regmap does in
regmap_update_bits(). It does this by checking if the register is cached
before doing a regmap_update_bits(), now we have an API for querying this
directly use it directly rather than trying a read in cache only mode
making the code a little clearer.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/hdac_regmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 9b1bcabd8414..97cee096a286 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -556,17 +556,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw);
 static int reg_raw_update_once(struct hdac_device *codec, unsigned int reg,
 			       unsigned int mask, unsigned int val)
 {
-	unsigned int orig;
-	int err;
+	int err = 0;
 
 	if (!codec->regmap)
 		return reg_raw_update(codec, reg, mask, val);
 
 	mutex_lock(&codec->regmap_lock);
-	regcache_cache_only(codec->regmap, true);
-	err = regmap_read(codec->regmap, reg, &orig);
-	regcache_cache_only(codec->regmap, false);
-	if (err < 0)
+	/* Discard any updates to already initialised registers. */
+	if (!regcache_reg_cached(codec->regmap, reg))
 		err = regmap_update_bits(codec->regmap, reg, mask, val);
 	mutex_unlock(&codec->regmap_lock);
 	return err;

-- 
2.39.2

