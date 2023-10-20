Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7307D17A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJTVAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:00:14 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318DD61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:00:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a669a4ec51so43041339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697835607; x=1698440407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo+YzGcf5ti2JGohRAjm5fHeXV6DLkhxTHbBeTwM3H0=;
        b=MljrZ35fuWC/vULrQCsvfEHcgSbKShqFujcpQzw+LM6LYimQz73S2hLDLLswYoQ265
         VEeXEhLrQiXDtowKBzqB3sYAPVLuTpW8qnHeOm0fmYReqCkCwLg6/NgolDORzd2GkJgQ
         3Ou09kSKdh25ZajWZz9RttoxC0oTGc9O5WgTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697835607; x=1698440407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo+YzGcf5ti2JGohRAjm5fHeXV6DLkhxTHbBeTwM3H0=;
        b=qR+YyFkXV0BwHDUZhmlZ9IZplcVcsUqZS7zDCsV6L0MEbgL2GzZRg2ZlY4gsAB29BP
         4c5VSHti4fSHSgNWVrdKag5MjLy16DE62D2pCejl80hi4frlTAaGP8uNSvsboTq2niZN
         MkeHqlnHgxV57VpR2xARNqnt8yDvmuB1kzrACYPRphQXMMG+25C6NGKhOSc7QnI1IR+e
         fnLfnfP2bmyB85saiYbfc7rV3YNGnRJia7+0abylCpnqfJaPe8k0xIxRz96y4y/4jcgH
         TmuFqjDO1UQ/QrnNE68dvFcvT8wH+k+OGGT5YtX14bp9vsNOctllXJBkiuIw64KhJXz5
         PbwA==
X-Gm-Message-State: AOJu0Yz7GaZ8qf7YgPH4tijlRiOm1u83JwczNTjqIztv1E/kiFDRGBiO
        jnNUlksPN2L8ZM48GaXnVgi4+kHLGfTeg/tzHts=
X-Google-Smtp-Source: AGHT+IHLHEyod+8rFouea36HiEYaF4mxyr+6M++FfbGIBZU2nDJ69584ByMJ7vuTFzTPPec8CAEqCg==
X-Received: by 2002:a05:6602:1355:b0:7a2:a6db:9a58 with SMTP id i21-20020a056602135500b007a2a6db9a58mr3565751iov.15.1697835607174;
        Fri, 20 Oct 2023 14:00:07 -0700 (PDT)
Received: from markhas1.lan (71-218-45-6.hlrn.qwest.net. [71.218.45.6])
        by smtp.gmail.com with ESMTPSA id y127-20020a6bc885000000b0076373f90e46sm850966iof.33.2023.10.20.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:00:06 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>, stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH v1] ALSA: SOF: sof-pci-dev: Fix community key quirk detection
Date:   Fri, 20 Oct 2023 14:59:53 -0600
Message-ID: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Chromebooks do not populate the product family DMI value resulting
in firmware load failures.

Add another quirk detection entry that looks for "Google" in the BIOS
version. Theoretically, PRODUCT_FAMILY could be replaced with
BIOS_VERSION, but it is left as a quirk to be conservative.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 sound/soc/sof/sof-pci-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 1d706490588e..64b326e3ef85 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -145,6 +145,13 @@ static const struct dmi_system_id community_key_platforms[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
 		}
 	},
+	{
+		.ident = "Google firmware",
+		.callback = chromebook_use_community_key,
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+		}
+	},
 	{},
 };
 
-- 
2.42.0.655.g421f12c284-goog

