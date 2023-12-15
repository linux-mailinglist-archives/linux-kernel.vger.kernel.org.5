Return-Path: <linux-kernel+bounces-291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82F813ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E426B21E67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E50390;
	Fri, 15 Dec 2023 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XQdT6vv0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E80360
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231215003819epoutp030e7b8ee999b8534ef51e19ca66cea122~g2lCyO8en0850208502epoutp03U
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:38:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231215003819epoutp030e7b8ee999b8534ef51e19ca66cea122~g2lCyO8en0850208502epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702600699;
	bh=95AfQQIEWcWv/QpLd8Ep2JX/E1UWLzdDdHMdPDHDoZE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XQdT6vv0VKChkQq7oSdh0eTAIr/rx8UFjX26rAguEtMy7KDZx+oPMGBfEFZhU6quh
	 MnQTGmhTAHtTWTKKWmmzHIfIrHtktrNy1G34oE+Bm5JzTfQSyODFgbpyxCPhryxu7p
	 9fJdOe9Cf2p6GREvYd5Jko1zgL4eBzPlq/Qk5ag8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20231215003818epcas1p3a5a7e40fd23cd0e8544cbe5299f540e2~g2lCK4Lrm1238312383epcas1p32;
	Fri, 15 Dec 2023 00:38:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.250]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Srr160fjtz4x9QB; Fri, 15 Dec
	2023 00:38:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.52.09739.9FF9B756; Fri, 15 Dec 2023 09:38:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231215003817epcas1p21127357982772ebe0e84b86f20115186~g2lBKmio10420204202epcas1p29;
	Fri, 15 Dec 2023 00:38:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231215003817epsmtrp28f83b67b849d79d1faf42f44a0a81b1e~g2lBJsW-A3262332623epsmtrp2o;
	Fri, 15 Dec 2023 00:38:17 +0000 (GMT)
X-AuditID: b6c32a37-487afa800000260b-10-657b9ff990b8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.7F.07368.9FF9B756; Fri, 15 Dec 2023 09:38:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231215003817epsmtip1de03178a9f04a44053f1d2574f24ab6a~g2lA6fCjv0592405924epsmtip1D;
	Fri, 15 Dec 2023 00:38:17 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
	quic_asutoshd@quicinc.com, dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com, ChanWoo Lee <cw9316.lee@samsung.com>, Manivannan
	Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3] scsi: ufs: qcom: Return ufs_qcom_clk_scale_*() errors in
 ufs_qcom_clk_scale_notify()
Date: Fri, 15 Dec 2023 09:38:12 +0900
Message-Id: <20231215003812.29650-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmnu7P+dWpBldmWlmce/ybxeL9tGOM
	Fts6bCxmnGpjtdh37SS7xcTzP9ksfv1dz26x6MY2Josdz8+wW3RM3s5iMXH/WXaLy7vmsFl0
	X9/BZnHgwypGi7stnawWy4//Y7JY2DGXxaLpzz4WByGPTas62TzuXNvD5jFh0QFGj49Pb7F4
	TNxT5/F+31U2j74tqxg9Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
	V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgVqBX
	nJhbXJqXrpeXWmJlaGBgZApUmJCdMWXCScaCnzwVH7p7WBsYv3N1MXJySAiYSHw/tIUdxBYS
	2MEosWwnZxcjF5D9iVFix8Q/7BDON0aJt63P2GA67vYeZYZI7GWUOPv6FxuE84VR4s2Jb0xd
	jBwcbAJaErePeYPERQS2MElcmTePGaSbWeAYo8T7D4kgtrBAlsTzH12sIDaLgKrEhrv7wDbw
	ClhL7O+cyAixTV7iz/0eZoi4oMTJmU9YIObISzRvnQ12hYTADg6J2Wu3skI0uEh8XNnGDGEL
	S7w6DvGchICUxOd3e9kgGpoZJRa+OQ7VPYFR4svH21DP2Us0tzazgbzALKApsX6XPsQ2Pol3
	X3tYQcISArwSHW1CENUqEnO6zrHBzP944zHUDR4Sby/tY4YEaqzE2/bjzBMY5WYh+WEWkh9m
	ISxbwMi8ilEstaA4Nz212LDAGB6Vyfm5mxjBaVjLfAfjtLcf9A4xMnEwHmKU4GBWEuE9uaM8
	VYg3JbGyKrUoP76oNCe1+BCjKTBUJzJLiSbnAzNBXkm8oYmlgYmZkYmFsaWxmZI475krZalC
	AumJJanZqakFqUUwfUwcnFINTKzCDp5p7z5Eml5fqzd9B8N8t/tP7t215eg9dMZ8f4NWefsm
	P64Uu+MyN5dLBlvIBv2PsQgt/Lv3k43mWdHvRqtYHmyWmXZzdbpWRuzWslN+Da4sN33P9q7a
	sa9eleHZQrGSm0vdEuesNPZl3vVkApvy0fDMj4Eqf9a8Prx5QUFX/Kpgbm0+Cw99qeiQR/d+
	68mEypdOmtq9PonlqVW8a/2D0wrPZhxa0fx6D0/hJ83A9PcV0Yov5q3dHvh0/8Q09wX2+pG9
	MRdlPvyRfL9jY0N854Jf+3rY938qMzj2Qd5tzu05u0Tfb4nfkaT15k60w7ujWV7tnaHuOQ0r
	U9mtll7oPNXH/HeVVnzqCgmFg0osxRmJhlrMRcWJAAcX8zVMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO7P+dWpBn82Slice/ybxeL9tGOM
	Fts6bCxmnGpjtdh37SS7xcTzP9ksfv1dz26x6MY2Josdz8+wW3RM3s5iMXH/WXaLy7vmsFl0
	X9/BZnHgwypGi7stnawWy4//Y7JY2DGXxaLpzz4WByGPTas62TzuXNvD5jFh0QFGj49Pb7F4
	TNxT5/F+31U2j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4MqYMuEkY8FPnooP3T2sDYzfuboY
	OTkkBEwk7vYeZe5i5OIQEtjNKNH/6jwrREJKYvf+82xdjBxAtrDE4cPFEDWfGCUWfdnHAhJn
	E9CSuH3MGyQuInCISWLxk3WsIA6zwBlGiQVT25hBBgkLZEgsOXOXBcRmEVCV2HB3HxuIzStg
	LbG/cyIjxDJ5iT/3e5gh4oISJ2c+AatnBoo3b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc5MN
	CwzzUsv1ihNzi0vz0vWS83M3MYLjRUtjB+O9+f/0DjEycTAeYpTgYFYS4T25ozxViDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBiZVh+1NUpuSo9ZL8S/Z
	yHvmwxeTnlIlv/k1y+fF+D5QcEmLinHmeu/MJ7ckaOrF0sW3XrOFbOES3LCddYelZGdytsCz
	+n2SLwTShUN2SYQdSN9ygyk2eGu/TYxVecKlkB1rl3Qt8jBwseQ5FDYxRETFe/6UXHardxVd
	57Yr35VUZSy2PTR1m+C7hAX/L6Xanig2OXiii6HuRqraSp30uomp00+8P7lEh+XolEwH3W15
	IsVNkz2krKrvM3Ey2mtGt5VIGoia8MXP0c7MvmnVHsHXkMw+Ly1te/Y15h9pYVe5q64pLAmx
	uKx3yso9tlUz9Zrb3tLGF9e7OaK9HO1ZRDXfXV/GLDK3rFxlwm0lluKMREMt5qLiRAAa+GcI
	BgMAAA==
X-CMS-MailID: 20231215003817epcas1p21127357982772ebe0e84b86f20115186
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231215003817epcas1p21127357982772ebe0e84b86f20115186
References: <CGME20231215003817epcas1p21127357982772ebe0e84b86f20115186@epcas1p2.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

In commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
the error handling was accidentally changed, resulting in the error of
ufs_qcom_clk_scale_*() calls not being returned.

This is the case I checked.
* ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;

Let's make sure those errors are properly returned.

Fixes: 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
* v2->v3: Change title and description
  v2 :
     https://patchwork.kernel.org/project/linux-scsi/patch/20231214021401.26474-1-cw9316.lee@samsung.com/

* v1->v2: Remove things already in progress
  v1 :
     https://patchwork.kernel.org/project/linux-scsi/patch/20231213022500.9011-1-cw9316.lee@samsung.com/
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


