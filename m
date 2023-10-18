Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B787CDE93
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjJROMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjJROMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F0119;
        Wed, 18 Oct 2023 07:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B34C433C7;
        Wed, 18 Oct 2023 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638335;
        bh=NpWOL949zjbv0453tfqLRDpLsMUhTAUanBD43aHGEEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFKeLM0Zs5+MzEYYy8UhLbqVx3lXaV8xyhtcBeKfwv3rc5pSxCjn008Ndhjc8afrh
         U7huOkpYkUYnX+rfpZ0QlLc7Od7srXGF0Y33gKhI07SnMYOn0u/Ze98q4U8I62hipG
         2mNZ37oOufu2zskr3spQTMMViRR0lPF3Ec6duB8ERchb9JhBCazPT/vjlauQPncBAx
         p3leaHdLvqngibnlw3T35PBpTlkkOITFVSv+1ChoFi8+PEon3RPIbCGvtHCqqIQ6do
         5CeKjYsGbqQ/kPRh+k9wiWTmuTdsEUZvjjoUfYcUKSTm6Wzrkpgolk6Ws5rjpNsYcl
         PJS8I8IWA6xhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antoine Gennart <gennartan@disroot.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shenghao-ding@ti.com,
        kevin-lu@ti.com, baojun.xu@ti.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.5 09/31] ASoC: tlv320adc3xxx: BUG: Correct micbias setting
Date:   Wed, 18 Oct 2023 10:11:26 -0400
Message-Id: <20231018141151.1334501-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Gennart <gennartan@disroot.org>

[ Upstream commit e930bea4124b8a4a47ba4092d99da30099b9242d ]

The micbias setting for tlv320adc can also have the value '3' which
means that the micbias ouput pin is connected to the input pin AVDD.

Signed-off-by: Antoine Gennart <gennartan@disroot.org>
Link: https://lore.kernel.org/r/20230929130117.77661-1-gennartan@disroot.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320adc3xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index b976c1946286a..420bbf588efea 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -293,7 +293,7 @@
 #define ADC3XXX_BYPASS_RPGA		0x80
 
 /* MICBIAS control bits */
-#define ADC3XXX_MICBIAS_MASK		0x2
+#define ADC3XXX_MICBIAS_MASK		0x3
 #define ADC3XXX_MICBIAS1_SHIFT		5
 #define ADC3XXX_MICBIAS2_SHIFT		3
 
@@ -1099,7 +1099,7 @@ static int adc3xxx_parse_dt_micbias(struct adc3xxx *adc3xxx,
 	unsigned int val;
 
 	if (!of_property_read_u32(np, propname, &val)) {
-		if (val >= ADC3XXX_MICBIAS_AVDD) {
+		if (val > ADC3XXX_MICBIAS_AVDD) {
 			dev_err(dev, "Invalid property value for '%s'\n", propname);
 			return -EINVAL;
 		}
-- 
2.40.1

