Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8B76C25D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHBBkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHBBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:39:55 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FEF30D5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:39:29 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230802013853epoutp04116c28c90da81661379e96dd3c9ddbe4~3bUYneskX2489224892epoutp04I
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:38:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230802013853epoutp04116c28c90da81661379e96dd3c9ddbe4~3bUYneskX2489224892epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690940333;
        bh=ihr6uri5JQnq5ljeBYFG+iPe4bTktOiMFmEJJkwqkcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:In-Reply-To:References:From;
        b=u2ox0P21xjAYOor1Uv9Kh7bXBuI7cTNlaOsrwJ67+yRpDJhqsye/Cmz6M1Wh2e5V1
         eecJBqnQ+lv5m5KYKhHN8Qw+aHwlQWvS47JtrZfh+hx+YE3M7VfIzar5IpPs06nLr5
         vOQtMyrgj08MGvgIk7412+/0OSuCndJVF1rDQtac=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230802013852epcas2p3c32f4170fc907af69e1aae8d4421ec61~3bUX4ZTJU2061320613epcas2p3O;
        Wed,  2 Aug 2023 01:38:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RFvlH4pmkz4x9Q1; Wed,  2 Aug
        2023 01:38:51 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.1E.40133.BA3B9C46; Wed,  2 Aug 2023 10:38:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230802013850epcas2p4a813b26e15c261d180ee3b46651e1534~3bUWkDZIK2137621376epcas2p4L;
        Wed,  2 Aug 2023 01:38:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230802013850epsmtrp1c83c7bc31c3e08cd619e98035c25c12c~3bUWjHXtl0762607626epsmtrp1Z;
        Wed,  2 Aug 2023 01:38:50 +0000 (GMT)
X-AuditID: b6c32a46-4edb870000009cc5-12-64c9b3abec6d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.DD.30535.AA3B9C46; Wed,  2 Aug 2023 10:38:50 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230802013850epsmtip2c24f4449926aa574eccc72a31ecade23~3bUWRhEaV3236932369epsmtip23;
        Wed,  2 Aug 2023 01:38:50 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com, wkon.kim@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [RESEND PATCH v3 1/2] ufs: make __ufshcd_send_uic_cmd not wrapped
 by host_lock
Date:   Wed,  2 Aug 2023 10:28:32 +0900
Message-Id: <bec84ee1ce8f5c5971b98d8e501aeabb9b5b26d1.1690939662.git.kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1690939662.git.kwmad.kim@samsung.com>
In-Reply-To: <cover.1690939662.git.kwmad.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmue7qzSdTDM7fV7I4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1WL37AYrHoxjYmi11/m5kstt7YyWJxc8tRFovLu+awWXRf38Fm
        sfz4PyaLrrs3GC2W/nvLYrH50jcWBwGPy1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWj
        x+dNch7tB7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgD5QUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+Wl
        llgZGhgYmQIVJmRnfL43g6XgM1/F3CtnWBsYD/F0MXJySAiYSLxq7WXtYuTiEBLYwSjR/uUq
        E4TziVFi89nTUM43RokVHScYYVoObJzMBpHYyyhxcetUFgjnB6PEtvvtbCBVbAKaEk9vTgVr
        FxH4wCTxf/k2sHZmAXWJXRNOMIHYwgKREpenngSzWQRUJdq/vWAGsXkFoiU6b81ng1gnJ3Hz
        XCdYnFPAUuJCzzYWVDYXUM1SDolbV+ewQDS4SGw7cZwVwhaWeHV8CzuELSXxsr8NyOYAsrMl
        9iwUgwhXSCye9haq1Vhi1rN2RpASZqAH1u/Sh6hWljhyiwXiej6JjsN/oYbwSnS0CUE0Kkv8
        mjQZGj6SEjNv3oHa6SFxe9dHaPD0MEps3DubZQKj/CyEBQsYGVcxiqUWFOempxYbFRjBYy85
        P3cTIzi1arntYJzy9oPeIUYmDsZDjBIczEoivNK/j6cI8aYkVlalFuXHF5XmpBYfYjQFBuNE
        ZinR5Hxgcs8riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoFJsKI0
        7/Hcgt5/opuPTDr31uzX4qwzv44ZqTbw/nnB2PrRaA/jepNZ28/c+hT07fnzVQ7l3yOulEyY
        d+Sr2owfnL+WqNwTTZFnPT7n9HL934p6HF38/i7if0tus3nO0p//qGX13mvSkltmrDv2Les8
        Z+5qx10hW482MegLsgjoRcQ3zvUoNxJO385xhG95u+Fthy3fN1y9fCggXunS1u+ln//lvsi6
        auPu13uyu61t5TTO4At/dkXvD362mO/cOxGz6yVHGaquLZxlo/QocIbJ87t3LFv+PQiVSg7o
        Pp7t9iB7TthCBp+SH2+uTl/tJ7u82vzPh3SFkpkcZ/kTtz7Llondp5XUK2tZNNdFYZW6mhJL
        cUaioRZzUXEiALh8t6c2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO6qzSdTDF7/NLQ4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1WL37AYrHoxjYmi11/m5kstt7YyWJxc8tRFovLu+awWXRf38Fm
        sfz4PyaLrrs3GC2W/nvLYrH50jcWBwGPy1e8PRbvecnkMWHRAUaP7+s72Dw+Pr3F4tG3ZRWj
        x+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDI+35vBUvCZr2LulTOsDYyHeLoYOTkkBEwkDmyc
        zNbFyMUhJLCbUeLk5f0sEAlJiRM7nzNC2MIS91uOsEIUfWOU2H35PxNIgk1AU+LpzalMIAkR
        gSZmiUuzp4N1MwuoS+yacAIowcEhLBAucfiVNkiYRUBVov3bC2YQm1cgWqLz1nw2iAVyEjfP
        dYLFOQUsJS70bAMbIyRgIXF+8xZ2XOITGAUWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvX
        S87P3cQIjg4trR2Me1Z90DvEyMTBeIhRgoNZSYRX+vfxFCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK83173pggJpCeWpGanphakFsFkmTg4pRqYliQ5/fm74d76UHm7qh8fbxTZ9lfUGGmbLX8U
        eG1+mKMFA9/tZoNvFyS9dv3L3ShX++jCpZuNUdN41P3LjP3eblXcHKYd8sS7s2viKjHhdNOz
        v+qEhUp3/6+e8eRbc2XU/NNp/VObPvJ89LjxVHrFo893P1YUMH9Zs5lljenWN/ddt5ppdpVz
        cv87de/8+7KJqsFCk+dX935m9Niz+2xGR39e/CnJWmNTlrZQW0ezhG1HKtZZdvb+28fyYcn5
        /rUO4cnbeeoynr0P1pmYselv2mPN9de459noLhEQvvZ41n5+0RVvDh88mz1bZXNR93zbCasm
        Tt1YdGnP99TF97K1GgqSpqxYcsvU46Ip/5MTr5VYijMSDbWYi4oTAfRjVdT9AgAA
X-CMS-MailID: 20230802013850epcas2p4a813b26e15c261d180ee3b46651e1534
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230802013850epcas2p4a813b26e15c261d180ee3b46651e1534
References: <cover.1690939662.git.kwmad.kim@samsung.com>
        <CGME20230802013850epcas2p4a813b26e15c261d180ee3b46651e1534@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ufshcd_send_uic_cmd is wrapped uic_cmd_mutex and
its related contexts are accessed within the period wrappted
by uic_cmd_mutex. Thus, wrapping with host_lock is
redundant.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9434328..a89d39a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2457,7 +2457,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);
 
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
@@ -2484,7 +2483,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	int ret;
-	unsigned long flags;
 
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_UIC_CMD)
 		return 0;
@@ -2493,9 +2491,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -4180,8 +4176,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		wmb();
 		reenable_intr = true;
 	}
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	if (ret) {
 		dev_err(hba->dev,
 			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
-- 
2.7.4

