Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3F7CDEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjJROPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbjJROOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:14:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D7B1BD9;
        Wed, 18 Oct 2023 07:13:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B54C433CC;
        Wed, 18 Oct 2023 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638411;
        bh=Gsovutsyfar+JfL4/SkAYHJpb42XHNzbvNfzmg5s2gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST+W4HFzD9Dh8FinGGsXe4qUn7/XECbizB5pW+DH9YYb4OUcaPGqS2VZIBjCaPFaP
         DT1rRiMbbyX/35JTlG9CHKMK8bxB1208bHd48Yvf91jlZ/MTfr6RfdZSRrtd5Fo7r1
         X1Gk9Ki3S4LIe802FHCaTmlMIEFfL3Bnnbwf1vf8gyDm/VA4Ej83KGTbI2faTx099s
         TBrtd7rnLo0nPnfkFe+WmZ8TMPHK2coHXjrogQzPllIvePkTfPGoP3ImhQH8hPi730
         Hs5q3yST7bznyJ1Z0LClLm/R6/WPJjZ8rzQ96epS2jL6ILyc+nHKuUvfzpOlt878Qx
         Mit3CHRsz395g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, herve.codina@bootlin.com,
        christophe.leroy@csgroup.eu, spujar@nvidia.com,
        astrid.rost@axis.com, aidanmacdonald.0x0@gmail.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 02/19] ASoC: simple-card: fixup asoc_simple_probe() error handling
Date:   Wed, 18 Oct 2023 10:13:04 -0400
Message-Id: <20231018141323.1334898-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
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
index fbb682747f598..a8bc4e45816df 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -678,10 +678,12 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		struct snd_soc_dai_link *dai_link = priv->dai_link;
 		struct simple_dai_props *dai_props = priv->dai_props;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -690,7 +692,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		cpus			= dai_link->cpus;
-- 
2.40.1

