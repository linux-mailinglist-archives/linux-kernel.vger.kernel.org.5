Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68DF790FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 03:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbjIDBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 21:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350349AbjIDBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 21:42:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADEF100
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 18:41:54 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230904014151epoutp04264328e40a6939af46914e2d2c3a70fc~BjpZzOzZb2317323173epoutp048
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230904014151epoutp04264328e40a6939af46914e2d2c3a70fc~BjpZzOzZb2317323173epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693791711;
        bh=m6tNa1euH0CrBZM8YLUI+1xoSFOzw2Hl6DICf1W0u3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=D/po5D8g9Qy58xCa2XMn5j3b/vg5hU+cmMBRkRWSwZKG3rWwjo9OaEYpmAZh1PxYc
         BZn/4pxOZPRJl/+pYt+1oPoXTG751zaL0WZYNdjKH7Kv0lmCSmh1cGKudgi/3UWBY6
         i/sTQE4v7XnokhRvNQbFk8Jo9+6NRaeZfDqjXhZ8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230904014151epcas2p40465a203ed390b7d781e56715986275d~BjpZb8g-c1199211992epcas2p4u;
        Mon,  4 Sep 2023 01:41:51 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RfBFV3V1dz4x9QG; Mon,  4 Sep
        2023 01:41:50 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.7B.08583.ED535F46; Mon,  4 Sep 2023 10:41:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230904014150epcas2p251f19c2220ec8938559bc2873e8e265a~BjpYOi5FV1919219192epcas2p2P;
        Mon,  4 Sep 2023 01:41:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904014149epsmtrp2edda104effb058a4cb656c67c313a18f~BjpYNvK400621306213epsmtrp2f;
        Mon,  4 Sep 2023 01:41:49 +0000 (GMT)
X-AuditID: b6c32a43-6f7ff70000002187-86-64f535deede6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.DF.08742.DD535F46; Mon,  4 Sep 2023 10:41:49 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904014149epsmtip1fc51cc73d9cdae55403127b1af1ed537~BjpX_jc6c1092710927epsmtip1Q;
        Mon,  4 Sep 2023 01:41:49 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v3 2/2] ufs: poll HCS.UCRDY before issuing a UIC
 command
Date:   Mon,  4 Sep 2023 10:30:45 +0900
Message-Id: <550484ffb66300bdcec63d3e304dfd55cb432f1f.1693790060.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1693790060.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1693790060.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmue49068pBqsmS1qcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4ueUoi8XlXXPYLLqv72Cz
        WH78H5NF190bjBZL/71lsdh86RuLg4DH5SveHov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR
        4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJS
        S6wMDQyMTIEKE7IzrjxtZS54ylPx4NMBtgbGc1xdjBwcEgImEg8m8XQxcnEICexglGi7cpIF
        wvnEKPHz/1dmCOcbUOb9DLYuRk6wjtmfl0Il9jJKTOvrYgZJCAn8YJTo3M8DYrMJaEo8vTmV
        CaRIROADk8T/5dsYQRLMAuoSuyacYAKxhQUCJW69Oc4OYrMIqEqs2DyXFcTmFYiWWPjoKhPE
        NjmJm+c6wRZwClhKfPh0hwWVzQVUs5RD4mfLYRaIBheJnyuOMkPYwhKvjm9hh7ClJD6/28sG
        8XS2xJ6FYhDhConF095CtRpLzHrWzghSwgz0wPpd+hDVyhJHbrFAXM8n0XH4LztEmFeio00I
        olFZ4tekyYwQtqTEzJt3oHZ6SCxs/sMOCaoeRoklR9azTmCUn4WwYAEj4ypGsdSC4tz01GSj
        AkN43CXn525iBKdVLecdjFfm/9M7xMjEwXiIUYKDWUmEV077U4oQb0piZVVqUX58UWlOavEh
        RlNgME5klhJNzgcm9rySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KLYPqYODil
        GphYZ0QpSPyfzle5+9ZhofX3dNK4Q2dVe827uuX8zxzLJUsVNj/qXarBH5Jhe2mF1MwdmuE7
        hA7k61R8my8jM2kyl5DuvltJLjOLI96fVvv8q94oL38Wcx9z+ISGWBHVhZsVJ5Ue//Hu2qSn
        e38f9/m3Y1u7rK27y+nevFrJiT9dvITuVc6Xff5RIOVF5RpD46NpEcbPdbbdMHarWWRSLlOR
        qxH0TVJPw3Dd932bHuy7o2r+eNrsL8fm9viu0l13tPWtodW1tASHpZv7EtZMEslb4GLQxHJ/
        jqG8/pWGYw6Zm0plnAre63u1J8zf/Mlteb1JxK2wnVaO85/3P3KbvqJbPt/x7o/FzqXSb7s/
        fNuhxFKckWioxVxUnAgAEBWYvzQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO5d068pBmc7zCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZ
        LD/+j8mi6+4NRoul/96yWGy+9I3FQcDj8hVvj8V7XjJ5TFh0gNHj+/oONo+PT2+xePRtWcXo
        8XmTnEf7gW6mAI4oLpuU1JzMstQifbsErowrT1uZC57yVDz4dICtgfEcVxcjJ4eEgInE7M9L
        mbsYuTiEBHYzSvzp3MACkZCUOLHzOSOELSxxv+UIK4gtJPCNUWJTjwqIzSagKfH05lQmkGYR
        gSZmiUuzp4M1MwuoS+yacIIJxBYW8Jc4sbsNLM4ioCqxYvNcsEG8AtESCx9dZYJYICdx81wn
        M4jNKWAp8eHTHRaIZRYSa9Z8Z8ElPoFRYAEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjODo0NLcwbh91Qe9Q4xMHIyHGCU4mJVEeOW0P6UI8aYkVlalFuXHF5XmpBYfYpTmYFES
        5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYLIoaU4q2qPyTmhvm+PK/5Nnfmi3vfY09N8tiXLN
        l52rTu7zXbU1YM2xj2pRtewZygd9zl7XnRYj982W9d8XfbGNwd/cRJPrbb/vlJ28fJN52tPQ
        7HizRZc3HKv8danQM2L9hRtH7d/nKpzQrrRne6uSf6tbVO3h4t2nTWyN1sgIdPIt6F/993/v
        9wNvyq/V8nJrvHtQ3HV+UsiB7ywye9esft5Z+jEiqmZPsP/he151a7Ijfnz8+6xyZcWEI4/z
        A7ftcpylzXVYR5j5Pp/b7vYl20VqhIvmSBVMFlDtZHc5+WvO8hUajxnNPvxzzZb48NEh+grH
        PEal532X3opMrply3mnRNo6tZ98aJk7MLzNVYinOSDTUYi4qTgQATHfpoP0CAAA=
X-CMS-MailID: 20230904014150epcas2p251f19c2220ec8938559bc2873e8e265a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904014150epcas2p251f19c2220ec8938559bc2873e8e265a
References: <cover.1693790060.git.kwmad.kim@samsung.com>
        <CGME20230904014150epcas2p251f19c2220ec8938559bc2873e8e265a@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With auto hibern8 enabled, UIC could be working
for a while to process a hibern8 operation and HCI
reports UIC not ready for a short term through HCS.UCRDY.
And UFS driver can't recognize the operation.
UFSHCI spec specifies UCRDY like this:
whether the host controller is ready to process UIC COMMAND

The 'ready' could be seen as many different meanings. If the meaning
includes not processing any request from HCI, processing a hibern8
operation can be 'not ready'. In this situation, the driver needs to
wait until the operations is completed.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/ufs/core/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6300ed6..7bc3fc4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
+#include <linux/iopoll.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -2322,7 +2323,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	u32 val;
+	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
+				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
+				    REG_CONTROLLER_STATUS);
+	return ret == 0 ? true : false;
 }
 
 /**
-- 
2.7.4

