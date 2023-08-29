Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887EF78BF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjH2Hhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjH2HhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:37:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C0B5;
        Tue, 29 Aug 2023 00:37:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6hrr0012633;
        Tue, 29 Aug 2023 07:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=BxK/SLJlbdVlGnbew4iPZrnJYslywfcoRRZh2jM1k9s=;
 b=EllaCH86CU2gCGrCfkwY3+/SvX7f3qdiZMddx0EVfjGXAb4l6Ql8MUZ77unC/FhSahbG
 v/C4yr8ri5EzG8AOCp5UReRiRQJTTZpKdS29TOqN/PCh9wChl8p9//Tc6/YoMwLI2Qj1
 iEUk4jvDm+oHL360V6VUIr6pvTdSEAfbMOEiDK7QVHpXz+Z7xkUI0eIqW4DqxdjqNqnb
 h9c7jCF5YKNWxqusZmCtifGF/koRBGdUzdZC6KYiSo9O4yQjvO27ra0qpeEOK+3nSYJN
 GhMo/UaKDj/QTW504zfiHSjgTFfaolpFB6YFmlegmZHS28YYZWjtyixlK1XpnZuZMZIX HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcmarf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 07:36:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37T72EXE032686;
        Tue, 29 Aug 2023 07:36:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dn7sm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 07:36:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T7acCA027124;
        Tue, 29 Aug 2023 07:36:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sr6dn7ske-1;
        Tue, 29 Aug 2023 07:36:38 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next] ASoC: cs42l43: Fix missing error code in cs42l43_codec_probe()
Date:   Tue, 29 Aug 2023 00:36:35 -0700
Message-ID: <20230829073635.1877367-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290064
X-Proofpoint-ORIG-GUID: kw1aQ_vsj7yYeDlYbURxPTCNSw0YSGst
X-Proofpoint-GUID: kw1aQ_vsj7yYeDlYbURxPTCNSw0YSGst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clk_get_optional() fails, the error handling code does a 'goto
err_pm' with ret = 0, which is resturning success on a failure path.

Fix this by assigning the PTR_ERR(priv->mclk) to ret variable.

Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on static analysis with smatch, only compile tested.
---
 sound/soc/codecs/cs42l43.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 24e718e51174..1a95c370fc4c 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2205,7 +2205,8 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	// Don't use devm as we need to get against the MFD device
 	priv->mclk = clk_get_optional(cs42l43->dev, "mclk");
 	if (IS_ERR(priv->mclk)) {
-		dev_err_probe(priv->dev, PTR_ERR(priv->mclk), "Failed to get mclk\n");
+		ret = PTR_ERR(priv->mclk);
+		dev_err_probe(priv->dev, ret, "Failed to get mclk\n");
 		goto err_pm;
 	}
 
-- 
2.39.3

