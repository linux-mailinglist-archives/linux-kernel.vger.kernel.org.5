Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90580CCEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjLKOFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343935AbjLKOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:04:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BFA35B1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:02:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C250C433C7;
        Mon, 11 Dec 2023 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303364;
        bh=QGhlk4gEo3s8s3IBmJeEEF0vXrwRRttuu1SRLWN+zGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KngyXh66kYftjBwDrgXQ2AeA4zyyjENfXvAx/I39ErUI1nhIN+y6yH3DFer5y7E+a
         U/rofkckW86BnI8eIKetc/vvhzWUsLAodgwOised8Go1gEYHaPSB2YVJ09C+PriyT0
         PNHUvMIb5WmGrFEiXU50ETM81Mt+8NEyTzPyuKzgwKrQiTsBfPXjKBu8A8t+ppTzUb
         KAmrUlPrzWOCR5DsxSFVbI37zmweHK7oGxVtrJA8Laa6mhOGKpacreRxyoY9qa51AL
         P6ONquhhW2XR0sJl88qt5mYJtJAWM6OT494KzNIf0IdGW10N1X96xXyMmF0dPQAyOe
         KOSfcXMfDfiVQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/12] ASoC: da7219: Support low DC impedance headset
Date:   Mon, 11 Dec 2023 09:02:02 -0500
Message-ID: <20231211140219.392379-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
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
index befe26749bc2b..e4e314604c0a1 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -655,7 +655,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_component
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(component, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
-- 
2.42.0

