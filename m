Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C976C25F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHBBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjHBBkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:40:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF4271F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:39:33 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230802013854epoutp02c8a77d1e84434f523930c293e9f50a0d~3bUZyDr-f2439324393epoutp02a
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230802013854epoutp02c8a77d1e84434f523930c293e9f50a0d~3bUZyDr-f2439324393epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690940334;
        bh=g9zuD5hWV3D8uTkBVam4nTayIg9/mAMH6WeokaMNnoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=Q7/G1xf57h4I9U9M15LQGS+NCCq8/hiozjobr8sTT4rJlPSwCG3s2fmp8PmfVgn6a
         ViigLHqC/iNz2MuOXxFlxVG87Nzq76Ci1gQPJeZnXHtRReUA1BWbLlM3Uy+gMNqCnO
         b5AxbWzbReYX5DKcYfgQ87C8li3qGYxyebm7crbA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230802013853epcas2p2656d4b70c08b5659aabdcfd71a680e58~3bUZHHhv71353713537epcas2p22;
        Wed,  2 Aug 2023 01:38:53 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RFvlJ6JMZz4x9Q0; Wed,  2 Aug
        2023 01:38:52 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.31.49986.CA3B9C46; Wed,  2 Aug 2023 10:38:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e~3bUXxWJJw0899308993epcas2p2p;
        Wed,  2 Aug 2023 01:38:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230802013852epsmtrp2e05a35e0d4183772cb2d420996e2a11d~3bUXwe5-Y1331913319epsmtrp2H;
        Wed,  2 Aug 2023 01:38:52 +0000 (GMT)
X-AuditID: b6c32a43-5f9ff7000000c342-df-64c9b3ac0181
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.DD.30535.CA3B9C46; Wed,  2 Aug 2023 10:38:52 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230802013852epsmtip22f4387cc888d17bc1d6714c205f46d6e~3bUXh3_Er0113401134epsmtip26;
        Wed,  2 Aug 2023 01:38:52 +0000 (GMT)
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
Date:   Wed,  2 Aug 2023 10:28:33 +0900
Message-Id: <9c7ccbfb8fe05c29ab3e31d9cd14e6b91065b8b0.1690939662.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1690939662.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1690939662.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmqe6azSdTDI636lucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4ueUoi8XlXXPYLLqv72Cz
        WH78H5NF190bjBZL/71lsdh86RuLg4DH5SveHov3vGTymLDoAKPH9/UdbB4fn95i8ejbsorR
        4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJS
        S6wMDQyMTIEKE7Iz5h29w16wnqfi8Mlm5gbGuVxdjJwcEgImEt+Wv2TpYuTiEBLYwSgxa8cx
        ZgjnE6PEpcsLoJxvjBJHdr1hg2np2djMDmILCexllPi5RgOi6AejRP/2fSwgCTYBTYmnN6cy
        gSREBD4wSfxfvo0RJMEsoC6xa8IJJhBbWCBQ4tab42CTWARUJRZNeAlWwysQLXHg7GkmiG1y
        EjfPdTKD2JwClhIXeraxoLK5gGoWckhc7j3CDNHgInHn5j4oW1ji1fEt7BC2lMTnd3uBXuAA
        srMl9iwUgwhXSCye9pYFwjaWmPWsnRGkhBnogfW79CGqlSWO3GKBuJ5PouPwX3aIMK9ER5sQ
        RKOyxK9JkxkhbEmJmTfvQO30kDi18gITJHh6GCUmr7vBOoFRfhbCggWMjKsYxVILinPTU5ON
        CgzhkZecn7uJEZxYtZx3MF6Z/0/vECMTB+MhRgkOZiURXunfx1OEeFMSK6tSi/Lji0pzUosP
        MZoCg3Eis5Rocj4wteeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp
        1cC0xywwdM/PZ5r25hyr2p2PVvjIhczxPb241z2ANfyIs+S5U0dvNqh2bNVfcIs96sN3fV6P
        8kN6fJ82m8Ztjd+oLt76qSNetuuiQNhz+6Y01kPWehd5t114/W5Cy9J1Z0u5XzmFbBcO3pnW
        c45n30ObwH6OeBtek5AMc4eX7rzxl6/+nPvFbeGX55U/5obZJ+f6NxU/WHzo1tXL/N0HXq/9
        Z6235t2+YyWet0/uXFGcc1pzav2viEPr96ZsmTvpfI6vdsY+yy1P5JinvNKM8z8WVKWV/LJR
        512D+Vfeuz8cy96urf7/wqV50kzHCGfjwn9nJlzvOf9H7YrizpW/7wSrpIksWXTwtIrCxwWL
        GvjslViKMxINtZiLihMBUsavtTUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO6azSdTDPac4rA4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1WL37AYrHoxjYmi11/m5kstt7YyWJxc8tRFovLu+awWXRf38Fm
        sfz4PyaLrrs3GC2W/nvLYrH50jcWBwGPy1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWj
        x+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDLmHb3DXrCep+LwyWbmBsa5XF2MnBwSAiYSPRub
        2bsYuTiEBHYzSvzatYkJIiEpcWLnc0YIW1jifssRVoiib4wSq7beZQVJsAloSjy9OZUJJCEi
        0MQscWn2dBaQBLOAusSuCSfAJgkL+Euc2N0GFmcRUJVYNOEl2FRegWiJA2dPQ22Tk7h5rpMZ
        xOYUsJS40LMNrF5IwELi/OYt7LjEJzAKLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpec
        n7uJERwfWlo7GPes+qB3iJGJg/EQowQHs5IIr/Tv4ylCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MGlGTHne5Xqm99ykyHcvy/PE/v6c8sPZaOme7e7S
        sj0WfrWpm14uelOsPGmBmopDp0Hz2zKzR53Kizj6GLSi1hzx+lK3JKux+OPRV0kzGqYJRly+
        bVnJv2abTsObpCOmn6u2urYqdZpHshxcYLgjqL+1yfwC9wVm/YC9042sfTfvmLs+XVnw66/5
        zR+/1i7f9/PiG7P3L0R3lmXvibc8yRn+JSKrKrpkTrqh3eZDmWYm30+tl0zzibF7qs5/zPPe
        TAdl/2NpB5gXLHhZPtXNsbl82cnd//uYPz3e0+nqEf76VtyqPdW77jMrpsvdqtL2/KyTdiOU
        KcErSC3lJKvcme3Z4geOHA1ZoOl63SVohxJLcUaioRZzUXEiAAILymf+AgAA
X-CMS-MailID: 20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e
References: <cover.1690939662.git.kwmad.kim@samsung.com>
        <CGME20230802013852epcas2p2334d33036d7d1a0bdbefaf5bb844928e@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 drivers/ufs/core/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a89d39a..10ccc85 100644
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
@@ -2365,7 +2366,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
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

