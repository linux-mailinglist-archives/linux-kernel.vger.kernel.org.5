Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC879D27F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjILNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjILNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:38:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268410D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:38:55 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CDUBmf032495;
        Tue, 12 Sep 2023 08:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=i
        qMo1WYDhsCRU6fDQRu1ohzwNK+mWlIu0GTmbZzTtUg=; b=NcMixOk5ZGVECb6yV
        g1EWRRON131fgiJtEBiDLbLkhTwW1pcOOChkHg1p6pvsYhqGbW2AN6+yaq2IDcvL
        8PUnoCnORCnWlo0tZpHJR0rs+YGquye3qvXXW8CCV4yhvjsprMxskRiUkMENgQBm
        xbjWOkll4nhhLyBIsJ2GuID1WWJaYY/cQQOkpbJTdSfCvNa4340C8K3EWt0mg1gv
        gg/kz+pOVc//FMFtPwBZ2hq5LSjek7psWXkkH9qudIWTRzMGZcqkcV/EkXciQjW9
        KR10Qyio5x2xap98LIkvR3KhMJE9sJbguQCsaw7orPMvnlVd/e5oo0MGR+lifprW
        CFPbQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t0n4jb2wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:38:42 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 14:38:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 14:38:41 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 213352A1;
        Tue, 12 Sep 2023 13:38:41 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Disable low-power hibernation mode
Date:   Tue, 12 Sep 2023 14:38:41 +0100
Message-ID: <20230912133841.3480466-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _FpdWHdHakP3SNHYzSaj8a5hrimfKbEI
X-Proofpoint-GUID: _FpdWHdHakP3SNHYzSaj8a5hrimfKbEI
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow the CS35L56 to be put into its lowest power
"hibernation" mode. This only affects I2C because "hibernation"
is already disabled on SPI and SoundWire.

Recent firmwares need a different wake-up sequence. Until
that sequence has been specified, the chip "hibernation" mode
must be disabled otherwise it can intermittently fail to wake.

THIS WILL NOT APPLY CLEANLY TO 6.5 AND EARLIER:
We will send a separate backport patch to stable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
index 9f4f2f4f23f5..d10e0e2380e8 100644
--- a/sound/soc/codecs/cs35l56-i2c.c
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -27,7 +27,6 @@ static int cs35l56_i2c_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	cs35l56->base.dev = dev;
-	cs35l56->base.can_hibernate = true;
 
 	i2c_set_clientdata(client, cs35l56);
 	cs35l56->base.regmap = devm_regmap_init_i2c(client, regmap_config);
-- 
2.30.2

