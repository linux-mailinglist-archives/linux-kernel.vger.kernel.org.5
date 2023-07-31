Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2E769362
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGaKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGaKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509AAE46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF7661011
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6365AC433CA;
        Mon, 31 Jul 2023 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800432;
        bh=jfPcQDQQ9NxIL14JjRxj4GHbXkTl80Z6WGewjirrcc4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kPkCWhYRl1FDao9RD3qbwS3/23Lm2IkNgwe6dPGQMga1KWGZrZSyB4GlPCT4rdmix
         MMthLOQcMzm4YAYV8KT5XqtxVuw/icG9LrdEnDG0CwDC/bsFZhfYdl78qhZeGaolOF
         88Plx9WToq6U3yWp3eANp9IX1gNRu0y/Rskvx4T5xzOECnXXwL0pFaWR0OJ92ODd3v
         9j4SFUTlNHj+WscVgMJ1VnAqqZNbD4NX5863Cf4F1zM9Rf3mjONqKEeFEs01fpypqh
         lDQnlrlfI2EoVYlTRmINlYa5tGOufXRj6G2iRFa5lpbFwoX63Qb6/ky0CoSWVLQ2ZN
         N09kE38Gr6w2g==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 11:47:02 +0100
Subject: [PATCH 1/2] ASoC: wm8960: Read initial MCLK rate from clock API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-asoc-wm8960-clk-v1-1-69f9ffa2b10a@kernel.org>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
In-Reply-To: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jfPcQDQQ9NxIL14JjRxj4GHbXkTl80Z6WGewjirrcc4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx5EpYLSag08ByPKzevSqFb8As1JhRsoipRsvS
 33EN7MkCTSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMeRKQAKCRAk1otyXVSH
 0J8pB/9ECMm/qvY122kBK3IPcbjpRU277KyyeoX6335LwYOrZttI79ho7mfy+W9WEmaENIm7AAA
 amf6+C8nFcMxiKVMaZRB84/N8sxFv337ukGohaUgPoN4ES5cXyrh3z0pS0ZYVzlqGJRjU31lOgk
 4XqCchdcIwRDlbtqxiVl7SX7DDcyz9wtYQtK/Zrd3lqw95KIj9R9Ei5OqvWoWe+cuMFYdL9rz/u
 27H41koXZvzPNU5O4s0F+v1heZplNZ3N9UwPN4dKmaTjDjlJCxngPl5ZDUa7Iql2C+Fqohnmmkg
 C/HhvLns7vLCvcKGGRJyq/RhyJhGt7doUg6p6TtG1KIBgthc
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

When we have a MCLK provided by the clock API read the rate at startup
and store it so that there's something set before the machine driver has
done clocking configuration (eg, if it only configures clocking based on
sample rate).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 366f5d769d6d..c0ce1ef75a74 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1425,6 +1425,14 @@ static int wm8960_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(wm8960->mclk)) {
 		if (PTR_ERR(wm8960->mclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+	} else {
+		ret = clk_get_rate(wm8960->mclk);
+		if (ret >= 0) {
+			wm8960->freq_in = ret;
+		} else {
+			dev_err(&i2c->dev, "Failed to read MCLK rate: %d\n",
+				ret);
+		}
 	}
 
 	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);

-- 
2.39.2

