Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED46A80CE54
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjLKO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjLKOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:05:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E3449A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:03:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3E5C433D9;
        Mon, 11 Dec 2023 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303400;
        bh=Kb/hCA/NNWuX7ifXJpNPrwb6MlLuVpbHeb9xqr+8iZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBSpkhb/wRT9Xz2AYhtZ26I1ApTml2JsKHSxzocrQnaSJ2SogV2fk7LZh0UtLiXLO
         1UoVKViztPOs9pD4kFkDkTQEZt7/YH1bfQLu3r7EoI/ENOhpXvKtew5T1lmU13v2Oq
         GOrzQy45pk1tQWZ278WnyMONjXazNiinW2pFC0trxbyzW5SrSBLsQ6rBI7hRfqucNq
         7aifXn7/+3gdxCNfXViAAcBG5XYFWFrVgXmf+JHmytCnNBtxT4sBSfdcYzdfzeNyNQ
         BDWXnQqprQFVxaAlyG/ORs7dkrTFJq5tdQ+FM39IEy6tnzAF3LO4X4IyNV1eEuvMBC
         SUADBGL9nCdbQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/5] ASoC: da7219: Support low DC impedance headset
Date:   Mon, 11 Dec 2023 09:03:09 -0500
Message-ID: <20231211140311.392827-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140311.392827-1-sashal@kernel.org>
References: <20231211140311.392827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.332
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

From: David Rau <David.Rau.opensource@dm.renesas.com>

[ Upstream commit 5f44de697383fcc9a9a1a78f99e09d1838704b90 ]

Change the default MIC detection impedance threshold to 200ohm
to support low mic DC impedance headset.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20231201042933.26392-1-David.Rau.opensource@dm.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 793c8768f7c44..5a31a4db1e23a 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -650,7 +650,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_codec *cod
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(codec, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
-- 
2.42.0

