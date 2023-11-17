Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5F7EF433
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjKQOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKQOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:14:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A06D4E;
        Fri, 17 Nov 2023 06:14:02 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AH8IefI017599;
        Fri, 17 Nov 2023 08:13:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=6nw9/LmGLszAOwC3SVOIkEn6mwCimN6BH+fyeN1E600=; b=
        JY4FcnGfg/NLLmPgZ6b4ftgL57/L0XL0ft2i5nU/bd6onECrHuBqBo1kKFzL0nEk
        GF0pLqfbyTRpb9c9F5s8a6du9UJAicD7t0uqpKV9KhPmtMyzFRKaipyODhVrtQCE
        QDuXNJOSdQ3obq6/udukjoWgpEkvvKz8K6GOwtHXqnOmK0v2Ot7hNPr5uVOrMMzP
        g9PyGfYcv6EXqMdrBZ8gay4i+8HZhAHXj3pdEvvkFNMfTtBwV2ppCEdHRLyB/D7r
        cJuRhUjyyTWRfsuSiSr6uJGkkREpU2xVTa1x4tkuH9o2YM23wc+p0l5PIMErBrsJ
        wwsreBaxI2YS3sy5gBD3Tg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 08:13:49 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:46 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C5BC73581;
        Fri, 17 Nov 2023 14:13:46 +0000 (UTC)
From:   Maciej Strozek <mstrozek@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH 2/7] ASoC: cs43130: Fix incorrect frame delay configuration
Date:   Fri, 17 Nov 2023 14:13:39 +0000
Message-ID: <20231117141344.64320-3-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xMJZgkaxrt8opvDPw-9hKzLQEeckuZRw
X-Proofpoint-GUID: xMJZgkaxrt8opvDPw-9hKzLQEeckuZRw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/soc/codecs/cs43130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 20f06679b8f7..d8ec325b9cc9 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -578,7 +578,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-- 
2.34.1

