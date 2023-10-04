Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C17B8023
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJDNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjJDNDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:03:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A48A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:03:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so3725391a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696424588; x=1697029388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcFoJma4HsSRYQOjS15Jla4T5NRg0e9bZhu1IrMhFVc=;
        b=aaCWuzyOZxe+RtqvWMFQfIvrGXvM/QDTocmx+ZsGmVLyucaprZlBp88UwLqclK0UEG
         dBjKJD4zX0laVAGduXD/MN45ySGZbcjJiOdy8f56mJamW8R46SYS+zPv5dlci6AYeWYM
         2t+Fafr/KKC1HEHrv2tgnWXUMuDBAAlLMqJ5QB7z6ibJIQQMLdyMI9pv/p7ssokLV7p3
         1KKIwqEkK8SiDgsoGEuZnw9GSeRqcf3XjW6f7d50q+DC6sT2GOx3BOewzso4xtwjuUde
         ZTdKcpZy+6f2VhV6qEBdGHMZluPAxl9J251X/2i0uvjsVT70Wel3rMUVHyZppU9xb9l3
         82HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424588; x=1697029388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcFoJma4HsSRYQOjS15Jla4T5NRg0e9bZhu1IrMhFVc=;
        b=PUZe6CI1DSKdbJI/9qSBqDL4ZracfyfbeS6O+GY67t32Erg1avTP/vmya982EvP+57
         6SSv8m83RBm7ALEMXaEDMh90uwSTyvL+KN2jxpBqRArM92VQUwz50/AwistTVNSLfrNO
         yMAln8MlZKKfTif0Z/ASuLnoQpXHJrgm7tem9gzsfngKOFFeuo62yo1A1g7jBQ0e1Tni
         /NnwJAGQmZdbgavVvbto+e2c8fcQCdeV0K0+Hr+yKnwhcAr2BjMweyYAdTzNa04o+nUe
         4ryekAg2NVqZajXAHobo4iC9FgI2kTlPGANBH7U40A57Fd4Icu5jQ1dG80D7nYZnkeTo
         JpaA==
X-Gm-Message-State: AOJu0Yz4lkuJn0pMLMVtZ+BPkINiyWTD3bQE6ZLAvXGogc0Sm9YZyP9j
        cmz5WNsE0S5maUDIX8aH3jxRDA==
X-Google-Smtp-Source: AGHT+IHWViklCkFuofuCVXfDhfGBadhs+Z24ra+EL/fJ15/9k73iL5cn7B/Y01gFA1SHuQdewQRFGw==
X-Received: by 2002:a05:6402:205:b0:534:8bdf:a258 with SMTP id t5-20020a056402020500b005348bdfa258mr1969252edv.31.1696424587666;
        Wed, 04 Oct 2023 06:03:07 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id m3-20020aa7d343000000b00530ccd180a3sm2394704edr.97.2023.10.04.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:03:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] soundwire: fix initializing sysfs for same devices on different buses
Date:   Wed,  4 Oct 2023 15:02:43 +0200
Message-Id: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If same devices with same device IDs are present on different soundwire
buses, the probe fails due to conflicting device names and sysfs
entries:

  sysfs: cannot create duplicate filename '/bus/soundwire/devices/sdw:0:0217:0204:00:0'

The link ID is 0 for both devices, so they should be differentiated by
bus ID.  Add the bus ID so, the device names and sysfs entries look
like:

  sdw:1:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6ab0000.soundwire-controller/sdw-master-1/sdw:1:0:0217:0204:00:0
  sdw:3:0:0217:0204:00:0 -> ../../../devices/platform/soc@0/6b10000.soundwire-controller/sdw-master-3/sdw:3:0:0217:0204:00:0

Fixes: 7c3cd189b86d ("soundwire: Add Master registration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Sending as RFT, because I did not test it on that many devices and
user-spaces.
---
 drivers/soundwire/slave.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c1c1a2ac293a..4db43ea53d47 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -39,14 +39,14 @@ int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.fwnode = fwnode;
 
 	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
-		/* name shall be sdw:link:mfg:part:class */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:bus:link:mfg:part:class */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
+			     bus->id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id);
 	} else {
-		/* name shall be sdw:link:mfg:part:class:unique */
-		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
-			     bus->link_id, id->mfg_id, id->part_id,
+		/* name shall be sdw:bus:link:mfg:part:class:unique */
+		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
+			     bus->id, bus->link_id, id->mfg_id, id->part_id,
 			     id->class_id, id->unique_id);
 	}
 
-- 
2.34.1

