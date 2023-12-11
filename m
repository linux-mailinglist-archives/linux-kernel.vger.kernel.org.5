Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1F80CAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbjLKNZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbjLKNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:25:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1603E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:25:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53085C433C7;
        Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702301145;
        bh=/z+1W086U9uqPBNKB8aX+O++X4c1G0rkhD8UdWMNhzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS/iWytVlYQM0gozRB+Upq9CcIRrAvHsRFH6RQAkA1LWOcZagdgs3QQjBjKh2pVvG
         ZFWp+/Z3CseCAgK6+JwoLQpZpkj8yhwlr0hISQFT4+CvkKkYX7VZZuoLBnJTKe5++f
         Gsty+T7k9GY3hBQYrmPQUkNNCVbun56KPl7tMCQcMoKyIq7eg1aj+o11ffMLX3x7CT
         Qa3ZO0/Ce82thdg6p9AwPChR7f+GWLnKW1/ImDclts5x8ABjzTr4pICELFPQAH+5hN
         1w5BBDgSEwzP5ZtaGCJeM8iwGrNBi5Om+KLerFSJYLnfA8TnXkf6+OVc1+L/C3Bx/r
         h6ARAZJ3U+NZA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rCgIq-0007Fj-10;
        Mon, 11 Dec 2023 14:26:32 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Date:   Mon, 11 Dec 2023 14:26:08 +0100
Message-ID: <20231211132608.27861-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 716d4e5373e9d1ae993485ab2e3b893bf7104fb1 upstream.

Limit the speaker digital gains to 0dB so that the users will not damage them.
Currently there is a limit in UCM, but this does not stop the user form
changing the digital gains from command line. So limit this in driver
which makes the speakers more safer without active speaker protection in
place.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ johan: backport to 6.6; rename snd_soc_rtd_to_cpu() ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 14d9fea33d16..c61cad0180c8 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -27,6 +27,23 @@ struct sc8280xp_snd_data {
 static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		/*
+		 * set limit of 0dB on Digital Volume for Speakers,
+		 * this can prevent damage of speakers to some extent without
+		 * active speaker protection
+		 */
+		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
+		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		break;
+	default:
+		break;
+	}
 
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
-- 
2.41.0

