Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C680B64D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjLIUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLIUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:40:25 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Dec 2023 12:40:31 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A347AAC;
        Sat,  9 Dec 2023 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702153979;
        bh=t9K21dB2eGVbwhYMbpXT2V+irIdhqYrsMb8mLbK1jeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwtcUwdG0J0daLz6xwiYM5KvPMkGThjaofb4zw+1z85dMyMfVb0yFtfRA+9w78dVI
         S4ntPKu/7lkEIV2PfiVJaoSs/xVHTM5kZE9/EOEb+bXhGqTBrAAeyeVtl/g+L6yY1d
         Oepd0i2TPp/h6D6GqpCalsBgQnkHvLONZY+gJc10kG/knQb1bMJCHhBd4uZUdfTHNa
         xWwc+lWXxeInirk5SKXq/dby5FgNBsulntBW07A45tqZKal3fjUjJ/UPZRIysCei4n
         yTrbIiFCjwP5j7AKMJpEQ32LCi6sKwPulSn6EeH1SSWWU5Bb1LiFAPR/RUThQve+ac
         EKyB/5Hny3kQw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id F278837813DA;
        Sat,  9 Dec 2023 20:32:58 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 1/5] ASoC: amd: vangogh: Drop conflicting ACPI-based probing
Date:   Sat,  9 Dec 2023 22:32:19 +0200
Message-ID: <20231209203229.878730-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
References: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Vangogh machine driver variant based on the MAX98388 amplifier, as
found on Valve's Steam Deck OLED, relies on probing via an ACPI match
table.  This worked fine until commit 197b1f7f0df1 ("ASoC: amd: Add new
dmi entries to config entry") enabled SOF support for the target machine
(i.e. Galileo product), causing the sound card to enter the deferred
probe state indefinitely:

$ cat /sys/kernel/debug/devices_deferred
AMDI8821:00	acp5x_mach: Register card (acp5x-max98388) failed

The issue is related to commit e89f45edb747 ("ASoC: amd: vangogh: Add
check for acp config flags in vangogh platform"), which tries to
mitigate potential conflicts between SOF and generic ACP Vangogh
drivers, due to sharing the PCI device IDs.

However, the solution is effective only if the machine driver is
directly probed by pci-acp5x through platform_device_register_full().

Hence, remove the conflicting ACPI based probing and rely exclusively on
DMI quirks for sound card setup.

Fixes: dba22efd0d17 ("ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 35 +++++++++++-------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index de4b478a983d..7878e061ecb9 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -439,7 +439,15 @@ static const struct dmi_system_id acp5x_vg_quirk_table[] = {
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
-		}
+		},
+		.driver_data = (void *)&acp5x_8821_35l41_card,
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)&acp5x_8821_98388_card,
 	},
 	{}
 };
@@ -452,25 +460,15 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
-	card = (struct snd_soc_card *)device_get_match_data(dev);
-	if (!card) {
-		/*
-		 * This is normally the result of directly probing the driver
-		 * in pci-acp5x through platform_device_register_full(), which
-		 * is necessary for the CS35L41 variant, as it doesn't support
-		 * ACPI probing and relies on DMI quirks.
-		 */
-		dmi_id = dmi_first_match(acp5x_vg_quirk_table);
-		if (!dmi_id)
-			return -ENODEV;
-
-		card = &acp5x_8821_35l41_card;
-	}
+	dmi_id = dmi_first_match(acp5x_vg_quirk_table);
+	if (!dmi_id || !dmi_id->driver_data)
+		return -ENODEV;
 
 	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
+	card = dmi_id->driver_data;
 	card->dev = dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
@@ -482,17 +480,10 @@ static int acp5x_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id acp5x_acpi_match[] = {
-	{ "AMDI8821", (kernel_ulong_t)&acp5x_8821_98388_card },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, acp5x_acpi_match);
-
 static struct platform_driver acp5x_mach_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
-		.acpi_match_table = acp5x_acpi_match,
 	},
 	.probe = acp5x_probe,
 };
-- 
2.43.0

