Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43B87BBD2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjJFQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjJFQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:46:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F712F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:45:10 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3965fxui025983;
        Fri, 6 Oct 2023 11:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=p
        H+b7cTnbRfSavq8cBv4h/A1y4bvx50yn5YvvvNOCj0=; b=hN1uLARqUxZxNaej5
        5gux3uKBYvy/j2b8lnFGtq4n8vdSjuXAnXV/WZIHiS9XabcXwFE5sRogoiHpeBs0
        UpYYbxzylxn54K2IkLihlN4tQOOjfc6GOf0YeJ/J7ZVi4+hWewm2uzNq9YEBLBFc
        2x9nzxNKOH8n2iHpCTAnJ6qm4VoBKgiB6JcXmCe6txiPllpKKrXQooZGJX6xAK9p
        cKdy9z4WUwinbqPVeOevciZE+9OCz4+hji5A5pDIXlW6yTxNt73Y7DjY/dWlJxbH
        Td/obIFZ7TCI+6BSQv7vwTUseKAZtOUuLRoCdVcHsyOMilaGRkxf3SJynoRxpPWl
        y5LZg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3th2dtc30q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 11:44:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 6 Oct
 2023 17:44:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Fri, 6 Oct 2023 17:44:08 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0E3B2B2F;
        Fri,  6 Oct 2023 16:44:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Fix illegal use of init_completion()
Date:   Fri, 6 Oct 2023 17:44:05 +0100
Message-ID: <20231006164405.253796-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y9UfC_QQ_r_8KptxzeJwrtZ5C0U7ECQu
X-Proofpoint-GUID: y9UfC_QQ_r_8KptxzeJwrtZ5C0U7ECQu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cs35l56_patch() to call reinit_completion() to reinitialize
the completion object.

It was incorrectly using init_completion().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 232af4e8faa4..8ccdd3f134a5 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -708,3 +708,3 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 
-	init_completion(&cs35l56->init_completion);
+	reinit_completion(&cs35l56->init_completion);
 
-- 
2.30.2

