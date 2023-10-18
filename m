Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F657CDF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbjJRORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345001AbjJRORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:17:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99A12A;
        Wed, 18 Oct 2023 07:16:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E840C433C9;
        Wed, 18 Oct 2023 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638577;
        bh=mfNwd8a18pGzt/476le4pukhmP7xf/WAildRBkKKafA=;
        h=From:To:Cc:Subject:Date:From;
        b=loM5Ep0BKd1itNamwAUkp0Jqptl05SFilNLMZuRvU5H3mgbCEBDfwDLNqE7r/ReAd
         NVv+YVn6KCgaJSDySUbRimuON8yBydsNn4Y9R6AgPWI11eeVZwvmlF0wvEA5yrP+Ay
         9XEuzjYtMmwy/QcEBetCEdNQCpk9Djri8oRy1SGEv3dMq0GlNr/JCa1aFCnlWYK6Kc
         IVhwMPz47KkCCDGnAp4/mVxx7w+CHN9FW3UN13/cnY5eh6OldmuuESr4SmqljDedHP
         28bEn/cLVOkADYnBIcqWThi73+1tCiTUw2hjGPxF8qAb+x9WurnXaDZumJerL/2lJL
         5+8v/F/THh07w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, herve.codina@bootlin.com,
        astrid.rost@axis.com, christophe.leroy@csgroup.eu,
        aidanmacdonald.0x0@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 1/7] ASoC: simple-card: fixup asoc_simple_probe() error handling
Date:   Wed, 18 Oct 2023 10:16:06 -0400
Message-Id: <20231018141613.1335848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.327
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 41bae58df411f9accf01ea660730649b2fab1dab ]

asoc_simple_probe() is used for both "DT probe" (A) and "platform probe"
(B). It uses "goto err" when error case, but it is not needed for
"platform probe" case (B). Thus it is using "return" directly there.

	static int asoc_simple_probe(...)
	{
 ^		if (...) {
 |			...
(A)			if (ret < 0)
 |				goto err;
 v		} else {
 ^			...
 |			if (ret < 0)
(B)				return -Exxx;
 v		}

		...
 ^		if (ret < 0)
(C)			goto err;
 v		...

	err:
(D)		simple_util_clean_reference(card);

		return ret;
	}

Both case are using (C) part, and it calls (D) when err case.
But (D) will do nothing for (B) case.
Because of these behavior, current code itself is not wrong,
but is confusable, and more, static analyzing tool will warning on
(B) part (should use goto err).

To avoid static analyzing tool warning, this patch uses "goto err"
on (B) part.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87o7hy7mlh.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6959a74a6f491..c5db2d9d44edd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -441,10 +441,12 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	} else {
 		struct asoc_simple_card_info *cinfo;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -453,7 +455,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
-- 
2.40.1

