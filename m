Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E380B660
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjLIUyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjLIUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:54:03 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F3D54;
        Sat,  9 Dec 2023 12:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702155248;
        bh=K7+F8UBwdHP2JyxVJukQdnPKrvxHr2vYJDtD03JJZ0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxyt+4iKg2AcLD96VI3OwQILuScYANkQyEo/mPCV0OKSYEOAGdh6SybPeA8+qmdqS
         CvHkop353eV/VcRY8O2Dg93sn9+HXOlWlA2fYVhQKjsqxlVQ7puD5Vxd+OK0HWRxQo
         G6KZ7dSUnThcJ0EPxqRYJxsstp2CqNzTlA9OD6Js9jcCkJpoa+VyaXN65HDdk15I2u
         O+oMcAipSkRYB54ZKONhwCTyV37wBJ8t3Q/rNk5px0RZHxZosZlPmv8pTnJdGQL+WC
         oO3yNsFAi+kLlNEj+riYE34f0ht5odZQ7KXn47P1TQGNgLOw/1+4/m2FLde+uwhsjT
         G07+CssTpEG3Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id D19E837813E3;
        Sat,  9 Dec 2023 20:54:07 +0000 (UTC)
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 05/11] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
Date:   Sat,  9 Dec 2023 22:53:44 +0200
Message-ID: <20231209205351.880797-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
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

Driver uses kasprintf() to initialize fw_{code,data}_bin members of
struct acp_dev_data, but kfree() is never called to deallocate the
memory, which results in a memory leak.

Fix the issue by switching to devm_kasprintf(). Additionally, ensure the
allocation was successful by checking the pointer validity.

Fixes: f7da88003c53 ("ASoC: SOF: amd: Enable signed firmware image loading for Vangogh platform")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 603ea5fc0d0d..c6f637f29847 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -547,17 +547,27 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->signed_fw_image = false;
 	dmi_id = dmi_first_match(acp_sof_quirk_table);
 	if (dmi_id && dmi_id->driver_data) {
-		adata->fw_code_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-code.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->fw_data_bin = kasprintf(GFP_KERNEL, "%s/sof-%s-data.bin",
-					       plat_data->fw_filename_prefix,
-					       chip->name);
-		adata->signed_fw_image = dmi_id->driver_data;
+		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-code.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_code_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
+
+		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						    "%s/sof-%s-data.bin",
+						    plat_data->fw_filename_prefix,
+						    chip->name);
+		if (!adata->fw_data_bin) {
+			ret = -ENOMEM;
+			goto free_ipc_irq;
+		}
 
-		dev_dbg(sdev->dev, "fw_code_bin:%s, fw_data_bin:%s\n", adata->fw_code_bin,
-			adata->fw_data_bin);
+		adata->signed_fw_image = dmi_id->driver_data;
 	}
+
 	adata->enable_fw_debug = enable_fw_debug;
 	acp_memory_init(sdev);
 
-- 
2.43.0

