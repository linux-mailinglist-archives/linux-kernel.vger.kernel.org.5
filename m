Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86877F7B17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjKXSBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjKXSBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:01:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6E19B7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:01:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so2943539a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700848899; x=1701453699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMxbVR2rLfAZt5vPU+lVR4wGuvIRl6WENNaqc0E73kg=;
        b=OJg5E7MzJPj/XknQ1CDmY8DoUtfbmvTequeSFNmbX5G5XmluhYnnB50gct0FfoiwU8
         5k7Izwn6ae8L+CQqdwDxiK5D13fV0AdjTb2gtsrdaGNqM4KvCw9ru75MhZonj5jt1cnQ
         8DnkN+5+RSfbT3haFXkzS7AG5kwSd6P4D106WG2RrMm3aWCPpBuSRKM1b6mmhze4EE5F
         ydx6qvrydOLUCNOofQszOrH7R5oAOKlvrTqgPAhZLVvjpCsbr5+BguimVhFFalWcVtJS
         oX+M4uDhNz+CqA0/ZWYmbc6AlgqXZURT9b8vXHc7qX4Bthltt5jb1mZpFtCOMx9/bH50
         fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700848899; x=1701453699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMxbVR2rLfAZt5vPU+lVR4wGuvIRl6WENNaqc0E73kg=;
        b=ZPoRFXhp1F18dO/Db0sJZnyT1r/Dw6dN7BFe87fpn7Y3nG56bLTI+jFH8b5FNbFC4X
         /Siue/C3+3W4Y//fr1upDf6GoyDbOiIXGUh8nrZp93E0G9jHQwKIEieR0UKSuFjYNQxy
         zzHY5cLSwAgDUp3EjnIdyLtRA3iyqYLrvUBfIavLvJco1I+oQrbxGWXPaxT5z9KVFuBZ
         h0Wcybx0q8Qq6KF4l/WU5vGcLx6mgF+v6qc6i1/Qn43WJ0qrloKaHnfybamTcgyfmmZc
         t6n5/xIECQ+0NGLqyww261wecEHZFlshVhTGBoiU6U4GcYaJEA4HB6+3HELI4Z7hH0su
         kilQ==
X-Gm-Message-State: AOJu0Yz5xr5qJnTmUzalRi+/qaqWrPb/HD0lKvGcuU03VUNW2A4vIJJM
        Spfm9eXeImkmLJGMafOji4r63A==
X-Google-Smtp-Source: AGHT+IHsz3LcGDH3Rt86rCdvS80rKeIS5a4qh2ZQvdfnBPgmrONEFonUhMa3/w580MfYUG2pVVWF3Q==
X-Received: by 2002:a50:c042:0:b0:543:bf55:248b with SMTP id u2-20020a50c042000000b00543bf55248bmr2619735edd.13.1700848899134;
        Fri, 24 Nov 2023 10:01:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id bq2-20020a056402214200b00548a0e8c316sm2010965edb.20.2023.11.24.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:01:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] soundwire: stream: fix NULL pointer dereference for multi_link
Date:   Fri, 24 Nov 2023 19:01:36 +0100
Message-Id: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bus is marked as multi_link, but number of masters in the stream is
not higher than bus->hw_sync_min_links (bus->multi_link && m_rt_count >=
bus->hw_sync_min_links), bank switching should not happen.  The first
part of do_bank_switch() code properly takes these conditions into
account, but second part (sdw_ml_sync_bank_switch()) relies purely on
bus->multi_link property.  This is not balanced and leads to NULL
pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  ...
  Call trace:
   wait_for_completion_timeout+0x124/0x1f0
   do_bank_switch+0x370/0x6f8
   sdw_prepare_stream+0x2d0/0x438
   qcom_snd_sdw_prepare+0xa0/0x118
   sm8450_snd_prepare+0x128/0x148
   snd_soc_link_prepare+0x5c/0xe8
   __soc_pcm_prepare+0x28/0x1ec
   dpcm_be_dai_prepare+0x1e0/0x2c0
   dpcm_fe_dai_prepare+0x108/0x28c
   snd_pcm_do_prepare+0x44/0x68
   snd_pcm_action_single+0x54/0xc0
   snd_pcm_action_nonatomic+0xe4/0xec
   snd_pcm_prepare+0xc4/0x114
   snd_pcm_common_ioctl+0x1154/0x1cc0
   snd_pcm_ioctl+0x54/0x74

Fixes: ce6e74d008ff ("soundwire: Add support for multi link bank switch")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 9dc6399f206a..f9c0adc0738d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -742,14 +742,15 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
  * sdw_ml_sync_bank_switch: Multilink register bank switch
  *
  * @bus: SDW bus instance
+ * @multi_link: whether this is a multi-link stream with hardware-based sync
  *
  * Caller function should free the buffers on error
  */
-static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
+static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
 {
 	unsigned long time_left;
 
-	if (!bus->multi_link)
+	if (!multi_link)
 		return 0;
 
 	/* Wait for completion of transfer */
@@ -847,7 +848,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
 
 		/* Check if bank switch was successful */
-		ret = sdw_ml_sync_bank_switch(bus);
+		ret = sdw_ml_sync_bank_switch(bus, multi_link);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"multi link bank switch failed: %d\n", ret);
-- 
2.34.1

