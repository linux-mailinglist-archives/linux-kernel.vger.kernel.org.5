Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4CB7DBBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjJ3OYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJ3OYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:24:48 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3138B7;
        Mon, 30 Oct 2023 07:24:45 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1ead2e6fab7so3085555fac.0;
        Mon, 30 Oct 2023 07:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698675885; x=1699280685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KURySP8CPvB4/y1EF5BKpqCgD6RX//UEPazzHu4/yag=;
        b=dASuz5UGtcQlLW+7S0/B0BmwTP2o43A5/uec+82Rd+DJVMU5uaqti1XFzUuzMdq2fd
         maSkpdpMeiTjT3Uo01Y9W0aZub0kNF4FlDqn7CLrW93OD+Xr151NFg+F+XRyPdwe19Dy
         CQ9UpNZGXOtOpnQNBxYADf2/b68R0eNO88pvVAcf0n+OV/WRB+vzlWQDWw6vDlcvsEeG
         dCFm2snynFK/hXQ2U8RcmGJvoaweB3sw8x62+Rmiy42NJWlXbdk7k2OxP3OSUm7KJaS1
         jU2k9ve7NM/jZ/OA/I5eZRfO/LTs9VKEIrt7gqudOTNRRhghPBjbN2KP3fKErtpk5ZjN
         a5Yg==
X-Gm-Message-State: AOJu0Yw0242temY7pCHDuU+1I1CoFa7F+vzQapxqLuwFxq/xDyLf4Q56
        AgZ2oQfa97IkKqgntqsRXvOg9Vm3Eg==
X-Google-Smtp-Source: AGHT+IG976VSsNVNGrcLtXF9kn5Tt4rIHb5nwu/RGtnSoO1PHC/WESbhx3GE6OQSIrDTedgOFiLmLA==
X-Received: by 2002:a05:6870:1382:b0:1e9:f09d:3736 with SMTP id 2-20020a056870138200b001e9f09d3736mr9855710oas.45.1698675884893;
        Mon, 30 Oct 2023 07:24:44 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s16-20020a05683004d000b006b8af3a2599sm1413313otd.73.2023.10.30.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:24:44 -0700 (PDT)
Received: (nullmailer pid 816585 invoked by uid 1000);
        Mon, 30 Oct 2023 14:24:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     kernel test robot <lkp@intel.com>,
        linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ASoC: rockchip: Fix unused rockchip_i2s_tdm_match warning for !CONFIG_OF
Date:   Mon, 30 Oct 2023 09:23:38 -0500
Message-ID: <20231030142337.814907-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9958d85968ed ("ASoC: Use device_get_match_data()") dropped the
unconditional use of rockchip_i2s_tdm_match resulting in this warning:

sound/soc/rockchip/rockchip_i2s_tdm.c:1315:34: warning: 'rockchip_i2s_tdm_match' defined but not used [-Wunused-const-variable=]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver.

Fixes: 9958d85968ed ("ASoC: Use device_get_match_data()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310121802.CDAGVdF2-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
Mark, another one that probably didn't get sent to you...

 sound/soc/rockchip/rockchip_i2s_tdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 5c51dbef6e86..860e66ec85e8 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1757,7 +1757,7 @@ static struct platform_driver rockchip_i2s_tdm_driver = {
 	.remove_new = rockchip_i2s_tdm_remove,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(rockchip_i2s_tdm_match),
+		.of_match_table = rockchip_i2s_tdm_match,
 		.pm = &rockchip_i2s_tdm_pm_ops,
 	},
 };
-- 
2.42.0

