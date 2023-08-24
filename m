Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04D078786D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbjHXTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbjHXTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:18:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45A1BE2;
        Thu, 24 Aug 2023 12:18:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEJ9u009509;
        Thu, 24 Aug 2023 19:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=ie1xPRR4qBkUMu82YM5u8Hszy21ND7rb5N7h4LosZ3w=;
 b=v/FwLPmha//ef1DvHp9NjK4HEv9WfLz61mK2SZon+H86+5y6Qazgr7YzRTtRoJJr2SZO
 UNDWEwQa4av38dLLIYqhcsmoJ00vCjNRjBy2t0wamZt5L06a0zcTkjC94saHztCKvNBT
 gdkFCCDx+E/p8USePUOo7uxX5elyj0k33kM3ugReRg9MT627VgkULXYOKG+l3ySj/ijm
 UZrpsqZsD40xMbTqb/FXSqzqPakwrXTlGuaLdu1kwUKk6PFrXGoWsnGyTxb4slg8eDdi
 kj3HelVx8+xNTve5WX6QWwDUphv29y5nqmfBxyZWWat5SEE84KeP7pmKDhWbK+UF6o9p GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytvwwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 19:17:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OHjGq9036111;
        Thu, 24 Aug 2023 19:17:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywcs3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 19:17:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37OJEu7s015687;
        Thu, 24 Aug 2023 19:17:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywcs25-1;
        Thu, 24 Aug 2023 19:17:33 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH next] ASoC: codecs: Fix error code in aw88261_i2c_probe()
Date:   Thu, 24 Aug 2023 12:17:10 -0700
Message-ID: <20230824191722.2701215-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_15,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240165
X-Proofpoint-ORIG-GUID: 8ZmfQOOK_gXxcNqu5Djc4-zMwMTqRWbY
X-Proofpoint-GUID: 8ZmfQOOK_gXxcNqu5Djc4-zMwMTqRWbY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing zero to dev_err_probe is a success which is incorrect when
i2c_check_functionality() fails.

Fix this by passing -ENXIO instead of zero to dev_err_probe().

Fixes: 028a2ae25691 ("ASoC: codecs: Add aw88261 amplifier driver")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202308150315.CvOTIOKm-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is only compile tested.
---
 sound/soc/codecs/aw88261.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 6e2266b71386..a697b5006b45 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -1245,7 +1245,7 @@ static int aw88261_i2c_probe(struct i2c_client *i2c)
 
 	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
 	if (!ret)
-		return dev_err_probe(&i2c->dev, ret, "check_functionality failed");
+		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed");
 
 	aw88261 = devm_kzalloc(&i2c->dev, sizeof(*aw88261), GFP_KERNEL);
 	if (!aw88261)
-- 
2.39.3

