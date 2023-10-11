Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5ED7C55E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjJKNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjJKNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:49:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729892
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:49:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39BCWGUf016437;
        Wed, 11 Oct 2023 08:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=PODMain02222019; bh=XoD01kMWN4fQN1
        wdVZoXVYabTLtU/S3zUI9m0HUgYB0=; b=o5bALYg81rbqCJxnx1hQfHijMVC8A4
        mi8tdTg9oYwk8Q15IhuK21igirptUF4Y6TsN+VScLoXeVPd+v5Dvhyr7sUekoJZc
        3ijw6MlAAkV0qhDzka5nKA2+CzgJzGyeXFqKbCBSXUlao5EMvWnqRYvSFnBYpw65
        CPF3n4gGLSXNdmWrrcbnzhJNCdk9Zk/gSiWZBhdcUfzSw3SQUASiqoA4YPyRqw/0
        2w5k+QlDq5Qqg8lwtJbV+8lFsDrwzXPEq6CscbOVoWVCVFnpo9HE65pC4yRZHgCK
        4hKUX9+b0Gy8PPtWl4c4K09pZZ3QpqbbcaCT0vVtiWsLkxaN7bPNwPIQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tkhhaku6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 08:48:57 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 11 Oct
 2023 14:48:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 11 Oct 2023 14:48:56 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CC49746B;
        Wed, 11 Oct 2023 13:48:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Fix missing include of gpio/consumer.h
Date:   Wed, 11 Oct 2023 14:48:53 +0100
Message-ID: <20231011134853.20059-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _RkLyYYvkM4NTf72gbXnrIdESanvKDDc
X-Proofpoint-GUID: _RkLyYYvkM4NTf72gbXnrIdESanvKDDc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to gpiod_set_value_cansleep() in cs42l42_sdw_update_status()
needs the header file gpio/consumer.h to be included.

This was introduced by commit 2d066c6a7865 ("ASoC: cs42l42: Avoid stale
SoundWire ATTACH after hard reset")

and caused error:
    sound/soc/codecs/cs42l42-sdw.c:374:4: error: implicit declaration of
    function ‘gpiod_set_value_cansleep’;
    did you mean gpio_set_value_cansleep’?

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2d066c6a7865 ("ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset")
---
 sound/soc/codecs/cs42l42-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index 974bae4abfad..94a66a325303 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -6,6 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-- 
2.30.2

