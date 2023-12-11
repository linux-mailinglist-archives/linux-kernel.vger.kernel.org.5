Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFACC80CCF0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbjLKOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjLKOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:04:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F633877
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:02:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9250EC433CA;
        Mon, 11 Dec 2023 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303378;
        bh=BuHKqMd7L6hJUMKqGXVpnwJckHYtw9yzl+qIn3moBgE=;
        h=From:To:Cc:Subject:Date:From;
        b=GqUXPSwqO9gcjR0hRnkNZlaBCUbYXvYOQkeOzhD4HXi3pFPRExyAxHXdw0Wcs8RkE
         JfQaQleefeude45KBaUjv6Ek2PFGmzP6wNx7/YbBWq2GPijXGjueYXKfymDAnr2nZP
         w5NBCGOMFKb09tF9EugOmQORTjKPkvl/R5dlUK64Jkr9rOrvCyHF1vSUrod3OXWCTV
         aPSlA7mZ5oOmp5mj8c2PZqRV3Naox07QcG2ieEU3z4O/NgOLSFw7SHD+IvTSzQxl2q
         6UO3Bp6t7o5FYP3WTkHVW5VGogzIMfw1P4t37Fzs1bpSk2rgiQPuHyhpzZn+D95AMR
         mT4JIjvobI5XQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kamil Duljas <kamil.duljas@gmail.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        suhui@nfschina.com, kuninori.morimoto.gx@renesas.com,
        zhangyiqun@phytium.com.cn, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/7] ASoC: Intel: Skylake: mem leak in skl register function
Date:   Mon, 11 Dec 2023 09:02:44 -0500
Message-ID: <20231211140254.392656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.301
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamil Duljas <kamil.duljas@gmail.com>

[ Upstream commit f8ba14b780273fd290ddf7ee0d7d7decb44cc365 ]

skl_platform_register() uses krealloc. When krealloc is fail,
then previous memory is not freed. The leak is also when soc
component registration failed.

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20231116224112.2209-2-kamil.duljas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 6b2c8c6e7a00f..5195e012dc6d4 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1450,6 +1450,7 @@ int skl_platform_register(struct device *dev)
 		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
 				sizeof(skl_platform_dai), GFP_KERNEL);
 		if (!dais) {
+			kfree(skl->dais);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -1462,8 +1463,10 @@ int skl_platform_register(struct device *dev)
 
 	ret = devm_snd_soc_register_component(dev, &skl_component,
 					 skl->dais, num_dais);
-	if (ret)
+	if (ret) {
+		kfree(skl->dais);
 		dev_err(dev, "soc component registration failed %d\n", ret);
+	}
 err:
 	return ret;
 }
-- 
2.42.0

