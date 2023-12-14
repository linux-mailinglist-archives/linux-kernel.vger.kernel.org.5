Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913B9812517
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443013AbjLNCOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjLNCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:14:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A09D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:14:11 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231214021407epoutp020f6b79d571aec1d204edcdaf90e2e38c~gkPZm5KHv2110221102epoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:14:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231214021407epoutp020f6b79d571aec1d204edcdaf90e2e38c~gkPZm5KHv2110221102epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702520047;
        bh=b5/GFqSR2OKWfDwUZwg7iNYOv07a+Rk2uyiw5sDY0+M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=d4gQcronWbN8/7aqED+PRixLmI09AR9Zv4LTeIsAQFuJXKxUghhC8WW1eTLXqqr9b
         9Zmh+CqyT8PeLSPdAG4cC3qMq1+vU4gNJaDEOpWn0a7FLlPs3H/ExuzsI5ZTr6W2wd
         OiFv+FDRJcX0kFxqQrmFzPAWhYRfJGz8VJvZd+yw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231214021406epcas1p4ea5a807d4b6edc0fe361344a50ff6c4d~gkPY1dQSG0793307933epcas1p4Q;
        Thu, 14 Dec 2023 02:14:06 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.242]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SrGB56ShFz4x9Q2; Thu, 14 Dec
        2023 02:14:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.5E.09731.DE46A756; Thu, 14 Dec 2023 11:14:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac~gkPYDUQ9o1539715397epcas1p3t;
        Thu, 14 Dec 2023 02:14:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231214021405epsmtrp12e3823d82bec7125fe1f9a4df51f9f69~gkPYCGKgn1831318313epsmtrp1d;
        Thu, 14 Dec 2023 02:14:05 +0000 (GMT)
X-AuditID: b6c32a36-2ef8ea8000002603-3b-657a64edf331
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.86.08817.DE46A756; Thu, 14 Dec 2023 11:14:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231214021405epsmtip144edfc6369f29825e45063e1b1e10619~gkPXx8rdv3127431274epsmtip1Z;
        Thu, 14 Dec 2023 02:14:05 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        ChanWoo Lee <cw9316.lee@samsung.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2] scsi: ufs: qcom: Re-fix for error handling
Date:   Thu, 14 Dec 2023 11:14:01 +0900
Message-Id: <20231214021401.26474-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHOb2Xey/DkkvH8KQkGzYjZhig5VFuFTaT4dIEWFAzSZaYckPP
        oFLa2tsyB9HMIYUBsYwmbrw2JbBlzIWsMl7bKBalMBGdICBPyViIpMhAng6cpS26/36/3/l+
        zvf3Ow8KE9wnhJRKY0B6DasWEfvw1p4jURGLynwkrl0RM4OPn+HM0he9gGktSWCuPDT5Ml0j
        /STz904zydSPtfKY9vkBkimxtOHMJduPJDPUWUswZaPtBNP9tAkwNxz/8Jip6T6cubDdhb9J
        y61NFwn55Mh9Ql5R3w3ky0/Gcbl5Ryxf6vqVkH/e0gTkf1kPplGncxKyEatE+lCkydQqVZqs
        RFHyu4rjijipWBIhkTHxolANm4sSRUkpaREnVGrXAKLQPFZtdJXSWI4TRR1N0GuNBhSareUM
        iSKkU6p1Ul0kx+ZyRk1WpAYZXpeIxdFxLmFGTvbd6UJSZ+N/tDKzBc6Db/xLgR8F6Vh4caEN
        KwX7KAHdDuAFRx/uSVYALC1zkp5kHUCnZdx3D7n9QxnPs/AAwK3y3738KoA9G/NEKaAogg6H
        E73Ju0AQvQOgeSpgV4PRVgDrawfcO+2nj8LNh5vYbozTYdDeuIbvxnz6Dbi62Ep63A7B7Zly
        zFMPhP1Vc24N5qoX3q1xG0O6kYLXHRuEB0iCFmuNt9X9cMHR4t1ICP8wm0gPUAjgV06Hl64A
        cHV5wksfg4VFhe4RMPoIbO6M8pRfgR3P6oDHOQD+uVbuuyuBNB+WmAQeyWFYWzpI7Hktjz32
        9iCHpvVv3aiAfh+O3anCK8Ch6hfmqX5hnur/jb8EWBMIRjouNwtxEl30f/eaqc21AvczDpe2
        g8rFp5F2wKOAHUAKEwXx+9vPIgFfyZ7LR3qtQm9UI84O4lwnfAkTHsjUuv6BxqCQxMrEsdLo
        WCZGFiMVvcwfGM5DAjqLNaAchHRIv8fxKD/heV7I0q1rc4KbPh3rzZOXLa+qz8z3HVMG2IsC
        Z4wPQMFo3Fv1OY9Sv+f6rDcantS9pO1dSlcqUjfCnD224cCQ9GR/bG52M4RcS0+pzIhv+FQS
        4Oy/2kUiM1kdM/lxQYXq9GFN3Wxb6LTPvYbir98elL13Uliw2fFOcWc1fyin5NpikO7ezxuz
        eOAJ/5+Kun/J+HBgftK4YLCcKmNem2r0q8k6aLpz9gNF/3Stfsunap0zP7/iP7z0SJyf/8ko
        /8COI0+hih+qHG9xrh5v87v1fPs7YVjX9RFTm+m3k0IoOZc0bjvz2eWh4LibRewpbWrwbURN
        2FJ0ydsyY7FtR6pLtk+LcC6blYRjeo79F2KkgRNPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO7blKpUg4OzhSzOPf7NYvF+2jFG
        i20dNhYzTrWxWuy7dpLd4tff9ewWi25sY7LY8fwMu0XH5O0sFhP3n2W3uLxrDptF9/UdbBYH
        PqxitFh+/B+Txd17J1gsmv7sY3EQ8Ni0qpPN4861PWweExYdYPT4+PQWi0f/XwOP9/uusnn0
        bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxtZ7zewF+3krPt3/ydjAuJm7i5GTQ0LARGLt6W6m
        LkYuDiGB3YwSbSvbWCASUhK7959n62LkALKFJQ4fLoao+cQosfXVDLA4m4CWxO1j3iBxEYFO
        Jom7B2aB9TIL7GCUuNLECGILC9hJ/Dj1gxnEZhFQlTi09CtYDa+AtcSXt9vYIXbJS/y538MM
        EReUODnzCdQceYnmrbOZJzDyzUKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5y
        fu4mRnBkaGntYNyz6oPeIUYmDsZDjBIczEoivCd3lKcK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwCR46Upy+6/HldfzbHcwTJJgPjepQurNK8/5vX4P
        zgosvt0y97ToqeVXN7hXnlhk6tZpqiMzqS6rcNr53LnTvHrWNqyWfv/i+KEmu0nbU4quycz8
        c+6FtNmL9QX3JEINz9rdStqZnGVX1vzqkper2HnOxSp2ai8unQt/ufSq81ouo0m9Ieb7J+6K
        ensp8a2tla+1bs76mddeX8jepGg/r6Kq87buCv0nsU1f11y9+KhZNOxtzVVd+7A/scXx/v4N
        xnmHVJ9tnrOSTfRu5flt+VMW5O++O7dvQ/Rt45VdC+uqZ2QsTv1nZ3RFMDGJ+fKWHSxG2Tmm
        T7XZkudWPLCQXaT2pfnCwUSLuqh5XUbXRU4osRRnJBpqMRcVJwIAGRtIxvsCAAA=
X-CMS-MailID: 20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac
References: <CGME20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac@epcas1p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

I modified the code to handle errors.

The error handling code has been changed from the patch below.
-'commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")'

This is the case I checked.
* ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;

It is unknown whether the above commit was intended to change error handling.
However, if it is not an intended fix, a patch may be needed.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
v1->v2: Remove things already in progress
 1) ufs_qcom_host_reset -> 'reset_control_deassert' error -> return 0;
   -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-8-manivannan.sadhasivam@linaro.org/#t
 2) ufs_qcom_init_lane_clks -> 'ufs_qcom_host_clk_get(tx_lane1_sync_clk)' error -> return 0;
   -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-2-manivannan.sadhasivam@linaro.org/
---
---
 drivers/ufs/host/ufs-qcom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96cb8b5b4e66..17e24270477d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 			err = ufs_qcom_clk_scale_up_pre_change(hba);
 		else
 			err = ufs_qcom_clk_scale_down_pre_change(hba);
-		if (err)
-			ufshcd_uic_hibern8_exit(hba);
 
+		if (err) {
+			ufshcd_uic_hibern8_exit(hba);
+			return err;
+		}
 	} else {
 		if (scale_up)
 			err = ufs_qcom_clk_scale_up_post_change(hba);
-- 
2.29.0

