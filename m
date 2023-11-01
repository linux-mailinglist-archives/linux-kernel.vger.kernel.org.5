Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585B17DDDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjKAInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjKAIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:42:58 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7629107
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:42:51 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231101084248epoutp040a4c8432fd5f875a69562b71154d16d3~Tczf3_cwr2849528495epoutp04B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231101084248epoutp040a4c8432fd5f875a69562b71154d16d3~Tczf3_cwr2849528495epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698828168;
        bh=Ueeq4gnoEMe7xuekvlOF7idWvlky879rxssZHhVOM/8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HY07nAUQDZHGWWAKeFA/vUcQCWMAhpWG/EOlNUkKlMrBxh9KS73ijuJ7CSq6OtaMx
         8xCrO3zqORG+hPGpbiiTz1jRnXl/AvT2e1err8Qx2oZjP4zfWhWB64QexgrUQVGKMm
         JpIcP7pYLNRaBbQeH71NkBfatD5stIoI+aQuPidg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231101084247epcas2p2129462642c0fa24c56898cea2d244538~Tcze5H8Pb1183311833epcas2p2B;
        Wed,  1 Nov 2023 08:42:47 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SL0rQ5Sxfz4x9Pw; Wed,  1 Nov
        2023 08:42:46 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.91.18994.68F02456; Wed,  1 Nov 2023 17:42:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519~TczdoeD_I3146031460epcas2p3o;
        Wed,  1 Nov 2023 08:42:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231101084246epsmtrp158e8cd269db0d28b000847452d7fb6df~TczdnmD-42468024680epsmtrp1n;
        Wed,  1 Nov 2023 08:42:46 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-57-65420f8613a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.3C.07368.68F02456; Wed,  1 Nov 2023 17:42:46 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231101084245epsmtip21d55f2f4788dcdc8c75e98354b95ff9c~TczdW-MP92863528635epsmtip2i;
        Wed,  1 Nov 2023 08:42:45 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v1] scsi: ufs: core: Process abort completed command in MCQ
 mode
Date:   Wed,  1 Nov 2023 17:45:04 +0900
Message-Id: <20231101084504.79087-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmqW4bv1OqwenpWhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYvXiBywWi25sY7LYemMni8XNLUdZLC7vmsNm0X19B5vF8uP/mCym
        vjjObtF19wajxdJ/b1kc+D0uX/H2mLDoAKPH9/UdbB4fn95i8Zi4p86jb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzljxeylLwTneihVvnrM1MP7k6mLk5JAQMJGYeOsyYxcjF4eQwB5GiafbtrNAOJ8YJVae
        +sYG4XxjlDi5bSUbTMuurb+gWvYySsyZNQ+q6gejxM9dp1hAqtgENCTWHDvEBJIQEbjEJNF6
        by07SIJZQE3i891lYEXCAkESTcfOgdksAqoSq1btYwKxeQUsJT6+bmeGWCcvsajhN1RcUOLk
        zCcsEHPkJZq3zmYGWSAhMJND4uKH71ANLhK/r3UzQtjCEq+Ob2GHsKUkXva3QdnZEo171kLZ
        FRJzN0+GqjeWmPWsHcjmAFqgKbF+lz6IKSGgLHHkFtRaPomOw3+hOnklGjb+Zoco4ZXoaBOC
        CCtJnJl7GyosIXFwdg5E2ENiz7c54DAUEoiVeNW6iG0Co8IsJH/NQvLXLIQTFjAyr2KUSi0o
        zk1PTTYqMNTNSy2HR3Jyfu4mRnBq1vLdwfh6/V+9Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlal
        FuXHF5XmpBYfYjQFhvZEZinR5HxgdsgriTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1
        tSC1CKaPiYNTqoEpyWGhb23MiavVT+KFyup+dLPyz5Vc+S5K2zn//Vp2mcCvrlsu+n2ITvOr
        CGD6XPFym6qYMYOcNdPDRW/UH7c3Lzvx5+zkfY4PPnIXcHrvuRE1tYZNwTascd6Xr/Y9asqF
        e5dl7BYsa71wRi/KWr2Of4XaAmtNnZzDrSt+3Z+1h3+tKkf2o5dTPmzN4z4fxfrho91Rv/0i
        mpNK3/a8rZnwpbZH+XFmOZvCybITCzZvMJTbvE+vbmoWZ9mJW8qlkiut7ogGT4tptWZZKZs/
        IaBeQ62l9dtKjbRP7KfMOLPYLm9drRFldt9m68SE7g+u0/f3vG41eTTTPEPlXKLV5O/cV7yf
        cKZFtzc9ltnx6r0SS3FGoqEWc1FxIgATzG1RVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvG4bv1OqweFLbBYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYvXiBywWi25sY7LYemMni8XNLUdZLC7vmsNm0X19B5vF8uP/mCym
        vjjObtF19wajxdJ/b1kc+D0uX/H2mLDoAKPH9/UdbB4fn95i8Zi4p86jb8sqRo/Pm+Q82g90
        MwVwRHHZpKTmZJalFunbJXBlrPi9lKXgHG/FijfP2RoYf3J1MXJySAiYSOza+ouxi5GLQ0hg
        N6NE05epzBAJCYn/i5uYIGxhifstR1hBbCGBb4wSbyaVg9hsAhoSa44dAqsREXjCJDGx2RPE
        ZhZQk/h8dxkLiC0sECCxbM0hsF4WAVWJVav2gdXzClhKfHzdDrVLXmJRw2+ouKDEyZlPWCDm
        yEs0b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYKjQUtj
        B+O9+f/0DjEycTAeYpTgYFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0
        xJLU7NTUgtQimCwTB6dUA9Oqsyo8puKKvDULwjs8XDpdL2RfVb1j8PvNmxl3mWOLDm7s3/d8
        5YG7KgnZu79JrupsFN8eXMmzdOoWqeJXez42sQp7xjzq/3vzcd/2jSs49vzTfqDRPePa8Ysv
        8msTNaKjLPf57+uec4KFR/yHY0+s3NFfV76/tfkTMPtDTN7Cl7mqgnFzOD7t+Vr3bHLkR0HF
        A//fbFl5c+GxNRIvre/faN/NcElfbf23YH2H09lf/JdMmf3/REUvc0SoiseyBMFXyyxTZ2zR
        mWP4ortllkfoYZsHyZLJyjfYrhW++bDilsYz072H66ZbnVvzhNfqRug0MXZ9P42D73xserqN
        sz8muDdq9vrv6kx3vvck3LVMiaU4I9FQi7moOBEAg+SBdvUCAAA=
X-CMS-MailID: 20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519
References: <CGME20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MCQ mode, the case where OCS is updated to aborted is as follows
 1. when abort processing is completed
 2. When a duplicate command occurs

In case of 1 situation, cmd should be re-request.
So in the case of cmd whose abort processing is completed in MCQ mode,
the ufs driver needs to update to scsi with DID_REQUEUE.

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 9 ++++++++-
 include/ufs/ufshci.h      | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68d7da02944f..234b7d7ec037 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5307,6 +5307,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 	enum utp_ocs ocs;
 	u8 upiu_flags;
 	u32 resid;
+	u8 eec;
 
 	upiu_flags = lrbp->ucd_rsp_ptr->header.flags;
 	resid = be32_to_cpu(lrbp->ucd_rsp_ptr->sr.residual_transfer_count);
@@ -5371,7 +5372,13 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 		}
 		break;
 	case OCS_ABORTED:
-		result |= DID_ABORT << 16;
+		if (cqe)
+			eec = le32_to_cpu(cqe->status) & MASK_EEC;
+
+		if (is_mcq_enabled(hba) && !eec)
+			result |= DID_REQUEUE << 16;
+		else
+			result |= DID_ABORT << 16;
 		break;
 	case OCS_INVALID_COMMAND_STATUS:
 		result |= DID_REQUEUE << 16;
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index d5accacae6bc..9aefc7e6d0fc 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -465,6 +465,7 @@ enum utp_ocs {
 
 enum {
 	MASK_OCS			= 0x0F,
+	MASK_EEC			= 0xF0,
 };
 
 /* The maximum length of the data byte count field in the PRDT is 256KB */
-- 
2.26.0

