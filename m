Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7377BB5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjJFLK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjJFLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:10:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C89FCF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:10:51 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 396An4mF006823;
        Fri, 6 Oct 2023 06:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=n31ClrR7pAHjPb9Ka48kOGEYMP6+xN1DN1qSQpeBfl4=; b=
        PddZTK8FflKwXLmBVeQPRdvarSPJ9RBGhnLcI5SzrrPi0E24dDEzzyAfPDK9LISE
        Al23Ti7d7cwhyXuQFs/t+Gcii4M6O+GiPmXpPkSobjjcFe8Ctd4+Li23xg1B78Lu
        AFxhbwd/APlNDs3RjehEOqdofA66GlHbqfgoQjkjNEPzVNfP05z7rgxCZzIm5I5b
        PQFXufE06gveYUDJ9eapfS1vHt6DWz4b9NU7dfn9KHEq1dVTWk9NqHlDUSFFgXpw
        q6hwmWJ+3KpxUfn5/W36P6zrfyHeV1GVoPthFvXrnEVj4m4Hz7oEzUIGLwA1iAwi
        ZIR3xdfflOEoQ+LKmY/ZnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3teg3k812p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 06:10:45 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 6 Oct
 2023 12:10:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 6 Oct 2023 12:10:43 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6AE18357D;
        Fri,  6 Oct 2023 11:10:43 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: cs35l56: Enable low-power hibernation mode on SPI
Date:   Fri, 6 Oct 2023 12:10:39 +0100
Message-ID: <20231006111039.101914-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231006111039.101914-1-rf@opensource.cirrus.com>
References: <20231006111039.101914-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t_TLtslMzrYc01xR3S83o8_ipRHwwlvM
X-Proofpoint-ORIG-GUID: t_TLtslMzrYc01xR3S83o8_ipRHwwlvM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hibernation can be enabled on SPI-connected devices now that
the hibernate and wake sequences have been updated to work
with wake-on-MOSI.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index 768ffe8213dc..b07b798b0b45 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -32,6 +32,7 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 	}
 
 	cs35l56->base.dev = &spi->dev;
+	cs35l56->base.can_hibernate = true;
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
-- 
2.30.2

