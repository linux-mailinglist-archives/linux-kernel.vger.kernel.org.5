Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285C97E7698
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbjKJBd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:33:54 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EF44A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:33:51 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231110013348epoutp046f7bc4b40c11f7b98b0951ece4a1bcc7~WHwfr3rNF1556615566epoutp041
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:33:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231110013348epoutp046f7bc4b40c11f7b98b0951ece4a1bcc7~WHwfr3rNF1556615566epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699580028;
        bh=EyjsNtWq3/Lnam+CZqeSLOeCVenh+Ro2Ki/oM0kxsak=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EAaKBC+YwwzCdQFQ+b9qwkqXExw6pne5eutUvn3Y8tHWwQJ2/0CVxGGGhA0l5JMqI
         tEGP4jMCUHQohQRbHP2X6rvinjHITTbCqFCe2OlTXlNkzhetc4x9S8UswFvma6fpzb
         Q4Nm3JDo6BGrhL8Au0KJY2DzaSL6z6EiPhWN6cXY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231110013347epcas2p2c50a5e6c3203c60d998d723ec60fca36~WHwfB3eUD1693116931epcas2p2E;
        Fri, 10 Nov 2023 01:33:47 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SRLvG5qflz4x9Q0; Fri, 10 Nov
        2023 01:33:46 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.23.10006.A788D456; Fri, 10 Nov 2023 10:33:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231110013346epcas2p37825f4b67674dd8aa3530f761256ef7d~WHwdzLUtB2802428024epcas2p3u;
        Fri, 10 Nov 2023 01:33:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231110013346epsmtrp19bb1f272e426e8ff4a946e6562eef2b0~WHwdya_6Y2199621996epsmtrp1J;
        Fri, 10 Nov 2023 01:33:46 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-99-654d887a314f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.97.07368.A788D456; Fri, 10 Nov 2023 10:33:46 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231110013345epsmtip2618c25208f5c03250dd104a12ae49541~WHwdiD7Om0278302783epsmtip2L;
        Fri, 10 Nov 2023 01:33:45 +0000 (GMT)
From:   SEO HOYOUNG <hy50.seo@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com
Cc:     SEO HOYOUNG <hy50.seo@samsung.com>
Subject: [PATCH v2] scsi: ufs: core: Process abort completed command in MCQ
 mode
Date:   Fri, 10 Nov 2023 10:36:16 +0900
Message-Id: <20231110013616.33590-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmqW5Vh2+qwZZDuhYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYvXiBywWi25sY7LYemMni8XNLUdZLC7vmsNm0X19B5vF8uP/mCym
        vjjObtF19wajxdJ/b1kc+D0uX/H2mLDoAKPH9/UdbB4fn95i8Zi4p86jb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzlg84ShjwTa+iufPulkaGE9wdzFyckgImEg8/HKPvYuRi0NIYAejxNsTv1ghnE+MEmtO
        NkBlvjFKPHi8kQ2m5fiXy4wQib2MEvf2fmaGcH4wSrSve84IUsUmoCGx5tghJpCEiMAlJonW
        e2vZQRLMAmoSn+8uYwGxhQWCJBr+7waLswioSnyZ0ghm8wpYSjQ2fmGEWCcvsajhNxNEXFDi
        5MwnLBBz5CWat85mhqiZySHR89sBwnaR2PP4BAuELSzx6vgWdghbSuJlfxuUnS3RuGctlF0h
        MXfzZKhdxhKznrUD2RxA8zUl1u/SBzElBJQljtyC2son0XH4L1Qnr0TDxt/sECW8Eh1tQhBh
        JYkzc29DhSUkDs7OgTA9JG5srgWpEBKIlVixZgX7BEaFWUi+moXkq1kIFyxgZF7FKJZaUJyb
        nlpsVGAIj97k/NxNjOB0rOW6g3Hy2w96hxiZOBgPMUpwMCuJ8F4w8UkV4k1JrKxKLcqPLyrN
        SS0+xGgKDOeJzFKiyfnAjJBXEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwf
        EwenVAMTv84mfr03MiJx+kZ9SWYX3vXL7/r+3HfjV5OvdwPjtqbtl3C7yMn6SNRh2eU5q86w
        uPxaoXT7jmrlq3/8pw1NLM4ULa6pawv7deTZmaTVLnXLF++ctdjV+WmkeFgKx/HPCReuz+Xj
        kL59QfeH46+3S1ybZ00v/vX9t9hUz4OLLvGeCX6TVspRriC/YafgxuzWKx08am2iajYbPvFk
        ysrGrzmq/3H/Css9/KsVzSXmn3865zXPoh96jQ/3emrN7hDPYsm69nebfrmSa/j5s5H7+aSj
        J2c0r7U6emOZ5KzpD58cvdX8wvm8rMVWYV2PaeyWXov3pXL1yec4XIy3/pO7Zv++gujJFWtv
        PAs/6V/uoMRSnJFoqMVcVJwIAJhFWx9QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG5Vh2+qwb7brBYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYvXiBywWi25sY7LYemMni8XNLUdZLC7vmsNm0X19B5vF8uP/mCym
        vjjObtF19wajxdJ/b1kc+D0uX/H2mLDoAKPH9/UdbB4fn95i8Zi4p86jb8sqRo/Pm+Q82g90
        MwVwRHHZpKTmZJalFunbJXBlLJ5wlLFgG1/F82fdLA2MJ7i7GDk5JARMJI5/uczYxcjFISSw
        m1Hi58oz7BAJCYn/i5uYIGxhifstR1ghir4xSiw6+IcFJMEmoCGx5tghsCIRgSdMEhObPUFs
        ZgE1ic93l4HVCAsESDye9A2shkVAVeLLlEawBbwClhKNjV8YIRbISyxq+M0EEReUODnzCQvE
        HHmJ5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwPGhp
        7GC8N/+f3iFGJg7GQ4wSHMxKIrwXTHxShXhTEiurUovy44tKc1KLDzFKc7AoifMazpidIiSQ
        nliSmp2aWpBaBJNl4uCUamDaue5VZfqCHvnmZPddf41+i/71rPOOED7leEdV5vyt1If754jr
        fjRlqFXw/OGstSjr7wZ944Rq9tUz4+a1OVju+8q589Kj7oLcy3u/dk5S3vkpzqiK751a4Y2V
        O95OkopXjpMQqFo871VMbADju4ch21ob3kcekXNqqTmTNLm6TnxSR66CT/PzuZVz3lw492Hf
        Xw/bt0vnfz81N+WaxuINkXnrCzaeNCq6+lM1eP3EwAMTTdT4i08sPBN7WD/hbKFs6d6Fd40L
        tM4aXr5ZIDCT+Ykmg6ybaf+pyLnuGhNeu0gsTWja8ffBiunGxbkbfmrUtiwsOuzttkQ16Ost
        uVs2JQ1z49SDbbi2vXDnnJ+rxFKckWioxVxUnAgAdU1E8vYCAAA=
X-CMS-MailID: 20231110013346epcas2p37825f4b67674dd8aa3530f761256ef7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231110013346epcas2p37825f4b67674dd8aa3530f761256ef7d
References: <CGME20231110013346epcas2p37825f4b67674dd8aa3530f761256ef7d@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MCQ mode, the case where OCS is updated to aborted is as follows
 1. when abort processing is completed
 2. When a duplicate command occurs

In case of 1 situation, cmd should be re-request.
So in the case of cmd whose abort processing is completed in MCQ mode,
the ufs driver needs to update to scsi with DID_REQUEUE.

v1->v2: change the method of determinging mcq and legacy mode.
check cqe value for checking mcq mode

Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
---
 drivers/ufs/core/ufshcd.c | 8 +++++++-
 include/ufs/ufshci.h      | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 68d7da02944f..9a730a794b66 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5307,6 +5307,7 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 	enum utp_ocs ocs;
 	u8 upiu_flags;
 	u32 resid;
+	u8 eec;
 
 	upiu_flags = lrbp->ucd_rsp_ptr->header.flags;
 	resid = be32_to_cpu(lrbp->ucd_rsp_ptr->sr.residual_transfer_count);
@@ -5371,7 +5372,12 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
 		}
 		break;
 	case OCS_ABORTED:
-		result |= DID_ABORT << 16;
+		if (cqe) {
+			eec = le32_to_cpu(cqe->status) & MASK_EEC;
+			result |= eec ? (DID_ABORT << 16) : (DID_REQUEUE << 16);
+		} else {
+			result |= DID_ABORT << 16;
+		}
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

