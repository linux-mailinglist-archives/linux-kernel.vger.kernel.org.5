Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E6784F85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjHWEIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHWEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:08:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F68E46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:08:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso34020455ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692763688; x=1693368488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBhEGG+ClTjVSBF2+FWZ6qlB0RipiK12gm3vVvhGHF4=;
        b=3orXEGVhh6pN+1ABGWxYrkdjANIO1F55DmVrh/ZxM+sTpnC236j4AyAoJOYGofo7T0
         RkugKm5JbpiMpACvETyM3hPUuVeX8ByVKpR3/RUvX21ctpQjjiu5HlonJrkRfsqbBGQi
         2wwemKq9S4OgCLGatg+TiKEwTN4mWv/M+dwqTLM0ACe5mBBHn1sOmgt0PBHy4lEvFPZ7
         XqC189Tu0X0GvAo2vR4NARIUJtdTnJFV9gtwO961yXFt9wtrR2hV7a9VnvujTbFd6jh5
         UL74mN7TNg81K/0iFE2bfwpglxzNsgd4p0l0BbEcnNX9stfuB/nefxXOe3k22Zz6AZSP
         WNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692763688; x=1693368488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBhEGG+ClTjVSBF2+FWZ6qlB0RipiK12gm3vVvhGHF4=;
        b=S1coLr3mJlm+1/E4Lkuo5Q7YCByjNfnOCqDu2aMjk9tjgXUeU6YS1SVsBead2EHY96
         hpelbcMuZ2UvJnDPo6QdgCyLiyFFoX4RL/+0qA9kOe4nzk1UKBXLkwvYrmdqkaQDXNZK
         3fYR5tdt06gvT8fFUp5vw4sP/gxht6tGco7fFNAfPVHp3jX877MJ7KeztDeSvp5ZVPda
         h+XGSxH+nf94ph66paWMhVY7oURgeLzk6CgWNiUwhQ5xoDckS4Ig/jSa9RSJ2jLRkVEC
         15nRaLXWqtf5JFVU9VxoleVA2Eo9yiqLET45M543nbPPNRCBpry7DHUCNwUAMj5BoQyU
         oySQ==
X-Gm-Message-State: AOJu0YxGCZKsGM6jFIOfwPXuxyJE9I9wyGb4JYIETB+xlFhX5eh3YEK+
        gXX5oLgWjf1t7U9hGCVbadn6YFJp/uaUb9Qes9O8rQtM
X-Google-Smtp-Source: AGHT+IGmPW1I50BeWuD4Y3xMRlxyksUP9t/Tz9yZNhZoYw/MNuClm66cutpxb36rRLJP5d1PTRWerQ==
X-Received: by 2002:a17:903:2644:b0:1bd:b79:3068 with SMTP id je4-20020a170903264400b001bd0b793068mr7963342plb.48.1692763688001;
        Tue, 22 Aug 2023 21:08:08 -0700 (PDT)
Received: from localhost.localdomain (1-171-147-46.dynamic-ip.hinet.net. [1.171.147.46])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001bdcde49bc3sm9784332plb.119.2023.08.22.21.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 21:08:07 -0700 (PDT)
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Terry Cheong <htcheong@chromium.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, apoorv <apoorv@intel.com>,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v1] Revert "ASoC: Intel: Add rpl_nau8318_8825 driver"
Date:   Wed, 23 Aug 2023 12:07:55 +0800
Message-Id: <20230823040755.2217942-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6b8b6892e43419f5339c47d307b1baac0eea036d.

Report from kernel test robot <lkp@intel.com>, that
in broonie/ci.git file0yZ50U, it's redundant
commit 6b8b6892e434 ("ASoC: Intel: Add rpl_nau8318_8825 driver")
because commit 273bc8bf2227 ("ASoC: Intel: Add rpl_nau8318_8825 driver")
was committed at 2023-08-14.

 All errors (new ones prefixed by >>):
>> sound/soc/intel/common/soc-acpi-intel-rpl-match.c:369:41: error: redefinition of 'rpl_nau8318_amp'
   static const struct snd_soc_acpi_codecs rpl_nau8318_amp = {
                                           ^
   sound/soc/intel/common/soc-acpi-intel-rpl-match.c:359:41: note: previous definition is here
   static const struct snd_soc_acpi_codecs rpl_nau8318_amp = {

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308221955.FkglAuTF-lkp@intel.com/
Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 103490ac7c838..122673c1dae27 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -366,11 +366,6 @@ static const struct snd_soc_acpi_codecs rpl_rt1019p_amp = {
 	.codecs = {"RTL1019"}
 };
 
-static const struct snd_soc_acpi_codecs rpl_nau8318_amp = {
-	.num_codecs = 1,
-	.codecs = {"NVTN2012"}
-};
-
 struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 	{
 		.comp_ids = &rpl_rt5682_hp,
-- 
2.25.1

