Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ECB75E979
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGXCEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjGXCDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42C5FCF;
        Sun, 23 Jul 2023 18:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6905860FFB;
        Mon, 24 Jul 2023 01:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B91C433CA;
        Mon, 24 Jul 2023 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162397;
        bh=8hK+dgPatDV1HxA1X+qNNVXvqz6JBIppiONjrSHEvsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l931QGT4mrpSpmVU8Wt4ZkAwHxAvLVjy8QAS+NXlvckMfD/R5S0VsQy6ylsDxfNSR
         kdTvsOkxfOumN6VPXng+zVMNtKp8hF1DtGK3wJEwHLkMmn3/yERPdjRRjNH/f0gBP2
         jiA4FY2wlkvKcdbTowaFHBXMJyxFyqFJqRHNCmtZiCszDsM1NJ7qa8eamLlMv+2ymg
         FZ7e/xoWhUKRFOqsl3+xzdE1XKMV0TU80oaIzbaLlmAGkjs/cuFPCZBC/PqRcwFBKd
         7E4pEuHmNE6XypCroYpV0QobYOfxXhbYfqlUY7tp10JGXrr+CpMu1PU1EjLyMFJ7Ge
         EoiQEvJT2xE2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     dengxiang <dengxiang@nfschina.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 29/34] ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
Date:   Sun, 23 Jul 2023 21:32:32 -0400
Message-Id: <20230724013238.2329166-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

From: dengxiang <dengxiang@nfschina.com>

[ Upstream commit 73f1c75d5e6bd8ce2a887ef493a66ad1b16ed704 ]

These models use NSIWAY amplifiers for internal speaker, but cannot put
sound outside from these amplifiers. So eapd verbs are needed to initialize
the amplifiers. They can be added during boot to get working sound out
of internal speaker.

Signed-off-by: dengxiang <dengxiang@nfschina.com>
Link: https://lore.kernel.org/r/20230703021751.2945750-1-dengxiang@nfschina.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eb049014f87ac..ce560129e2faa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11235,6 +11235,7 @@ enum {
 	ALC897_FIXUP_HP_HSMIC_VERB,
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
+	ALC897_FIXUP_UNIS_H3C_X500S,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11674,6 +11675,13 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
 	},
+	[ALC897_FIXUP_UNIS_H3C_X500S] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x14, AC_VERB_SET_EAPD_BTLENABLE, 0 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -11835,6 +11843,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_USI_HEADSET_MODE, .name = "usi-headset"},
 	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{.id = ALC669_FIXUP_ACER_ASPIRE_ETHOS, .name = "aspire-ethos"},
+	{.id = ALC897_FIXUP_UNIS_H3C_X500S, .name = "unis-h3c-x500s"},
 	{}
 };
 
-- 
2.39.2

