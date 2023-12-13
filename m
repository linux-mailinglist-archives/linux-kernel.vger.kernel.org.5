Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B6810838
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378339AbjLMCZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378305AbjLMCZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:25:27 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7AA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:25:31 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231213022527epoutp04289413997050434965bb46a3abcf5046~gQwA78Ndw1937919379epoutp04d
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:25:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231213022527epoutp04289413997050434965bb46a3abcf5046~gQwA78Ndw1937919379epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702434327;
        bh=llvFRz0oCIQGbziuHlF3lamYUb4g/Mx7VDSl7Hr2w70=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MREF7QEXKe+dQZ+lY1apYWdgC1csNidjjpTUwXMhX0irDESLtcqQrYmeHkRW8gJU4
         yTSSXcfmrnAIX0xsH8g9ctcoYP5ZRBHnvcKAuUrMegg141wB3MUaZmxaxWGOFVbvb9
         UYKfruGoJpFrwqVC0Z+jstWRx/1+2UGkcW4gfQWU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231213022526epcas1p2768b522dbed430c04325c5b3cbf83748~gQwAMzc1f2140721407epcas1p2U;
        Wed, 13 Dec 2023 02:25:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.222]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SqfTf1kQzz4x9Px; Wed, 13 Dec
        2023 02:25:26 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.46.09744.61619756; Wed, 13 Dec 2023 11:25:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231213022525epcas1p219483a7572a12394c5852cd53a367da4~gQv-VaPJX2004720047epcas1p2x;
        Wed, 13 Dec 2023 02:25:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213022525epsmtrp16b95d43d02cf2ec71c1652b30a3c6ee1~gQv-UfYN22117621176epsmtrp1m;
        Wed, 13 Dec 2023 02:25:25 +0000 (GMT)
X-AuditID: b6c32a35-107fa70000002610-2a-657916166080
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.34.08755.51619756; Wed, 13 Dec 2023 11:25:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213022525epsmtip24ac15f90dc60a39a5845e2e7522a8a28~gQv-E9HGZ0163101631epsmtip27;
        Wed, 13 Dec 2023 02:25:25 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] scsi: ufs: qcom: Re-fix for error handling
Date:   Wed, 13 Dec 2023 11:25:00 +0900
Message-Id: <20231213022500.9011-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmrq6YWGWqQccmbotzj3+zWGzrsLGY
        caqN1WLftZPsFr/+rme3WHRjG5PFjudn2C06Jm9nsZi4/yy7xeVdc9gsuq/vYLM48GEVo8Xy
        4/+YLO7eO8Fi0fRnH4sDv8emVZ1sHneu7WHzmLDoAKPHx6e3WDz6/xp49G1ZxejxeZNcAHtU
        tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0NlKCmWJ
        OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
        tgXnWAue8lcsbJzB1MD4naeLkZNDQsBE4vShq8wgtpDADkaJ/y8luxi5gOxPjBL717UyQzjf
        GCWe/drHDNPxc1cnG0RiL6PE5nMLoZwvjBIrP58Hcjg42AS0JG4f8waJiwj8ZZRYfKaLEcRh
        FuhilPh1sIsFZJSwgLXEjLdr2UBsFgFViZYPjxlBbF4BK4l53x9CrZOX+HO/hxkiLihxcuYT
        sF5moHjz1tlg90kIzOSQ2N90mR2iwUXi3qMnbBC2sMSr41ug4lISL/vb2CEamhklFr45DtU9
        gVHiy8fbUB32Es2tzWA/MAtoSqzfpQ8RVpTY+XsuI8RmPol3X3tYQUokBHglOtqEIEpUJOZ0
        nWOD2fXxxmNWCNtD4s7vKeyQEI6V+Pi+l20Co/wsJP/MQvLPLITFCxiZVzGKpRYU56anFhsW
        GMLjNTk/dxMjOPFqme5gnPj2g94hRiYOxkOMEhzMSiK8J3eUpwrxpiRWVqUW5ccXleakFh9i
        NAWG8ERmKdHkfGDqzyuJNzSxNDAxMzKxMLY0NlMS5z1zpSxVSCA9sSQ1OzW1ILUIpo+Jg1Oq
        genEjS7nw9VHT1rcXReypvIqv0H0tdDNRWYGf+cc+l364sIu+WtvQxWtdtmsqXZ963dE3KvJ
        srGhXuPjh6Lbs57Vtk562fh636ejvr/C2v1VHl5Ju/wwwHT5tUa5c88qBYUshPUjinYZPf99
        yHv9P6XWmVaxD9zb5zooxiYmrDfquMqxZ+HptGURzPP8jmSeTb9QXV/sNveRQvt2ay7rrR11
        e7Tzt91NXB6Sdjma9b9f1EPdnn9V6d+Py96+9qTA4pb+6s0sU9fYK92ysOVcwLKg/ZC5lttM
        6b2qD5wPryn1D2edO8l2Gcf1K6v+mG9iunG8e1vcls/lty3y7VcWvCpiP37Od+H9z+c27rqQ
        OnmNEktxRqKhFnNRcSIA88H7vUUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvK6oWGWqwZOpyhbnHv9msdjWYWMx
        41Qbq8W+ayfZLX79Xc9usejGNiaLHc/PsFt0TN7OYjFx/1l2i8u75rBZdF/fwWZx4MMqRovl
        x/8xWdy9d4LFounPPhYHfo9NqzrZPO5c28PmMWHRAUaPj09vsXj0/zXw6NuyitHj8ya5APYo
        LpuU1JzMstQifbsEroy2BedYC57yVyxsnMHUwPidp4uRk0NCwETi565Oti5GLg4hgd2MEhMe
        7GWESEhJ7N5/HijBAWQLSxw+XAxR84lRYtP5O4wgcTYBLYnbx7xB4iICnUwSq6Z+YAVxmAUm
        MEosvvKWGWSQsIC1xIy3a9lAbBYBVYmWD4/BFvAKWEnM+/6QGWKZvMSf+z3MEHFBiZMzn7CA
        2MxA8eats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcBxo
        ae5g3L7qg94hRiYOxkOMEhzMSiK8J3eUpwrxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIk
        kJ5YkpqdmlqQWgSTZeLglGpg2mBQ7uCgV5VwPSxCq+hkonPy4w230vdf/bbvx2Ptg5NmXLaX
        9jkkt5J7w8TXOYace4v49saphzApPpqsqyJw8FVwRe4h8dS/rok96QFveiJM/3o8/XuVb3vH
        x44NdW/XOcy2C1T7lX390O5FTEnJ6m32DJwn/Xsc0mqfzFtqwxBaIvT+f67Kqu7FhXOufred
        9iPz/VkL7/9eHmdyrqwz+bnqtIyZjvvdG3t8Nde4uVfOTvh//15zB49IeF7mI41j7D7Hvk5Y
        /ro4VVT7/U/m2qLADUtmnD0kaeYz88KCE0nnXCskHy1dwuIn3LvPOue/wcbpWZ2397zyLAwx
        j0sqOmu2MWVb2h+x1a/2n2Pcr8RSnJFoqMVcVJwIAD9GZU/yAgAA
X-CMS-MailID: 20231213022525epcas1p219483a7572a12394c5852cd53a367da4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213022525epcas1p219483a7572a12394c5852cd53a367da4
References: <CGME20231213022525epcas1p219483a7572a12394c5852cd53a367da4@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

I modified the code to handle errors.

The error handling code has been changed from the patch below.
-'commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")'

What I have confirmed are three cases.
1) ufs_qcom_host_reset -> 'reset_control_deassert' error -> return 0;
2) ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
3) ufs_qcom_init_lane_clks -> 'ufs_qcom_host_clk_get(tx_lane1_sync_clk)' error -> return 0;

It is unknown whether the above commit was intended to change error handling.
However, if it is not an intended fix, a patch may be needed.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/host/ufs-qcom.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96cb8b5b4e66..8a93d93ab08f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -313,6 +313,8 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 
 		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
 			&host->tx_l1_sync_clk, true);
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -404,9 +406,11 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 	usleep_range(200, 210);
 
 	ret = reset_control_deassert(host->core_reset);
-	if (ret)
+	if (ret) {
 		dev_err(hba->dev, "%s: core_reset deassert failed, err = %d\n",
 				 __func__, ret);
+		return ret;
+	}
 
 	usleep_range(1000, 1100);
 
@@ -415,7 +419,7 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 		hba->is_irq_enabled = true;
 	}
 
-	return 0;
+	return ret;
 }
 
 static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
@@ -1535,7 +1539,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 		ufshcd_uic_hibern8_exit(hba);
 	}
 
-	return 0;
+	return err;
 }
 
 static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
-- 
2.29.0

