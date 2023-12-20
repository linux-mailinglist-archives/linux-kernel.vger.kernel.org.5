Return-Path: <linux-kernel+bounces-6381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5F819818
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E042884A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F1125A2;
	Wed, 20 Dec 2023 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TKo4XbMy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F211C84
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231220052752epoutp02f5e1511a6af45d9c0cac51195cf5f3eb~icwR-fV8F1831818318epoutp02Z
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:27:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231220052752epoutp02f5e1511a6af45d9c0cac51195cf5f3eb~icwR-fV8F1831818318epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703050072;
	bh=Qr6Y/n44TAh60hRyqSdn6ykroR+doAVKJrBLaV/BU3U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TKo4XbMyF3thDWxQ+ID9i8Db9tS7E8S2649tuzV8bdGF00XgFoK9jViCjEMg8h/V6
	 OxZJm1F+f7FnHtCfTw1QnBvdx37MvAF0Qo+9asugI7+q+oYWZb21zTcSYpivJuC4Pd
	 1YMTonVdOS/wFQv/PWm3DQ3OM0PP+gZ9LxQzafso=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20231220052750epcas1p43b047fc01a36edbbd76ad192775eea22~icwQrp6SM1444814448epcas1p4J;
	Wed, 20 Dec 2023 05:27:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.248]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Sw2Bt0vvVz4x9Pr; Wed, 20 Dec
	2023 05:27:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.EC.09739.55B72856; Wed, 20 Dec 2023 14:27:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907~icwPb-Im92245822458epcas1p3a;
	Wed, 20 Dec 2023 05:27:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231220052749epsmtrp2b953272c91a3b32041de0feadc2c5924~icwPaqkOk1019310193epsmtrp2M;
	Wed, 20 Dec 2023 05:27:49 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-84-65827b551e19
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.E7.08755.55B72856; Wed, 20 Dec 2023 14:27:49 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231220052749epsmtip1758180bb7a83894c81a23ec2d805d5ff~icwPHDQ5W0564405644epsmtip1u;
	Wed, 20 Dec 2023 05:27:49 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, peter.wang@mediatek.com,
	chu.stanley@gmail.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
	yang.lee@linux.alibaba.com, beanhuo@micron.com, Arthur.Simchaev@wdc.com,
	ebiggers@google.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com, ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] ufs: mcq: Adding a function for MCQ enable
Date: Wed, 20 Dec 2023 14:27:37 +0900
Message-Id: <20231220052737.19857-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0yTVxzN7dd+LczCZ5F5h4isQaMkPMrzFmSaScyXYAjGPclcrfQbJZS2
	6YM4NOIorxZ0YHgogkPGQ8CAA4GC41USeYyQAcLYoNsAmY7J0yIBFdZS2Pzv3JNzfifnd/Nj
	YRwt04kVI1VRCqlQwsVt6Y1dRzw8Pr6YRHlffchHf95uxNFQJUTa7HIG+nttBEedk1o6yltc
	w5BpsB1DN/pSGahttJeJBquTGWj9TS0TlYw10pD+aT8T1U2PMtBwSyGOhjWDAGX8osdRx2IV
	QBXdGzSUlOyLGpZfMdCccZOO7qQX0dH10fs4yn3WzURJr9voqKzhV4Dmv+kCx53J4cdhpN5Y
	CsjmAiOTLK5Tk3VVWpxsnuSTWSUdgKwvTSSTe9vp5GptOk4uzfxGJ7N/vExee1AFyBd1LmRa
	RwYtwj4y9qiYEooohSsljZKJYqTRIdywM4ITAv8Ab54Hj48Cua5SYRwVwg09FeFxMkZiXg3X
	NV4oUZupCKFSyfX64KhCplZRrmKZUhXCpeQiiTxA7qkUxinV0mhPKaUK4nl7+/ibhedixSua
	VZrc6HKhqecv+hWw8Z4O2LAg4QeNsyM0HbBlcQg9gGVaE7A+lgGsbC3HLSoO8RLA2wXSHcdC
	Td+2qBXA1aJCzCoyAZhSa68DLBZOuMPxR2EWzR7iGR3OlN/disAIHYDrnTq6xeBABMM37d/T
	LJhOHIQr3WlbmG3m89sXMGvaAfj6j0zMyu+GvTefbHkxM69puIVZhkKiwgbqUidoVkMoTGtL
	3sYOcLb7AdOKneCL+VbcatAAeOd597Y7C0DT0jhuVR2DmhQNbumAEUdgbYuXNc0Ozq9kMiw0
	JNgwPZVjVbvBQt0AvjN/aWyaYcUk7E3NZ1q3chZW5yYxs4BLwVsdCt7qUPB/WDHAqsC7lFwZ
	F00peXLf/74yShZXB7Zuwj1QD/LmFj0NgMYCBgBZGHcPO7QkkeKwRcKvEyiFTKBQSyilAfib
	t5qNOTlGycxHJVUJeH58b78AHz/ky/cN4O5l9z+OpzhEtFBFxVKUnFLs+GgsG6crtN6OfXlS
	588HDk9Wls+m/tz1w8ajcLef5ocP9Y063Z087hDS8tWpd+YCdZpXE6LIJ8XVWTdHk8+Fzl7m
	q3js+bCpfMfY4Pozh9ci46f8gkob7vffy28W1QuCOEP7Bec/C9s1tfvbrvSmrvfTEk0TIzfG
	v1jYZTfgbNx8mZLyD/LhiR2DDySUDfTHfxm+uXcsRzBjb79cBOMCqi8lKBhuGTPO9ySH5In7
	DOsLgs3TXsqi3KHN5wdbFcK8E+ebppNsn/pfMnUGaXOu3ioC+opr4/iFD5kfRdmdzBYbstiT
	hkw+/G784um8/TU9nxxLqSGWHg6e7SlT9pRU5I/xNJpPfw/PwdRculIs5LljCqXwX4Nj8KOc
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTcRiH+Z/bjpJ6nJbHmZaTqIzMUcFfFM2IPN2jiCAEm3rykm5rx+Uq
	1FLJnGVT0kzLbGqXdWU1LxlOZ7gcQpm3UizNS0lp3paUl3JJ0LeH5/nB++ElUb4RE5AxkgRW
	LhHHCQlbrKJB6LH+0JlU1vd23lLYW1xBwLf3aJiZcxuHwz/bCVjfl4nB/LGfKJxqMaCwwHwe
	h7UdTTzYcj8dh7/mHvOg5l0FAqs+N/Ogrr8Dh63PrxOwNa0FwKzOKgLWjWkBvGOaR2Bq+kao
	n5jB4UjPbwzeunADg7kdTwiY98XEg6mztRgs178HcPRcA9iynGlt28VU9ZQBprqwh8eU6BSM
	TptJMNV9foxaUweYp2UpTHqTAWOmH18gmPHBLozJeZHMZD/TAmZS58Fk1GUh+x2O2AZEsnEx
	J1n5hsCjttGWtGlE1uOhrHw1hJ0F864qYEPS1Cb6+yMzUAFbkk/VALrvygBYDAK6xvCaUAFy
	gZ3ohgZucTMB6IyhXNzqCcqb7m7cZZ07U6k4na5aad2glBrQpW0jqDU4Uf70nKEUsTJGraIt
	poy/bLfgrxq+o4u3VtCzHy+ii96Rbro2gFkZXfBp+iJUDewL/0uF/6USgGiBKyvj4qPiOZFM
	JGETfThxPKeQRPlESON14O+bvddWgUrtmI8RICQwAppEhc522zQpLN8uUnzqNCuXhskVcSxn
	BG4kJnSxc/lyKZJPRYkT2OMsK2Pl/ypC2gjOIrWHHKXuSVd+rPWv0AJvweiyvOADumzn2Jo9
	uEtQvvvhp/NZ4+ssBbxXjdMnZr6+S1w2+GHYMOpVKRjLPna36LyR/Zw1rg6wfAoLDGvb9+Zy
	zEC5WXytN+5gpq/UNDW4ekv7w91BV9t3Lxk/KjOvjyi4lZA84Rj9e2Oox8CJlpydaYaQ016a
	+871ZTcpy8u5fvscSdGm0NySdlOXllSGrHnhOVyvDA0O1+/106v8bfghOPJxxmG7ot9pZPOq
	i90mh9kniFn6zXcuqXLdiKdIwxSfynf1e7B1h050vC5stWdjcPhBt8mZ5s7kWOU+pWJqMkUV
	q552cy+u/1Auc6/W53JCjIsWi7xROSf+A+8PLCFVAwAA
X-CMS-MailID: 20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907
References: <CGME20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907@epcas1p3.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

The REG_UFS_MEM_CFG register is too general(broad)
and it is difficult to know the meaning of only values of 0x1 and 0x2.
So far, comments were required.

Therefore, I have added new functions and defines
to improve code readability/reusability.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/ufs/core/ufs-mcq.c      | 10 +++++++++-
 drivers/ufs/core/ufshcd.c       |  5 +----
 drivers/ufs/host/ufs-mediatek.c |  4 +---
 include/ufs/ufshcd.h            |  1 +
 include/ufs/ufshci.h            |  4 ++++
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 0787456c2b89..a34ef3aac540 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -394,11 +394,19 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
 
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
 {
-	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | ESI_ENABLE,
 		      REG_UFS_MEM_CFG);
 }
 EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
 
+void ufshcd_mcq_enable(struct ufs_hba *hba)
+{
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | MCQ_MODE_SELECT,
+		      REG_UFS_MEM_CFG);
+	hba->mcq_enabled = true;
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable);
+
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
 {
 	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ae9936fc6ffb..8195e01e7a3f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8723,10 +8723,7 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
 	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
 	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
 
-	/* Select MCQ mode */
-	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
-		      REG_UFS_MEM_CFG);
-	hba->mcq_enabled = true;
+	ufshcd_mcq_enable(hba);
 
 	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
 		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index fc61790d289b..1048add66419 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1219,9 +1219,7 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
 		ufs_mtk_config_mcq(hba, false);
 		ufshcd_mcq_make_queues_operational(hba);
 		ufshcd_mcq_config_mac(hba, hba->nutrs);
-		/* Enable MCQ mode */
-		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
-			      REG_UFS_MEM_CFG);
+		ufshcd_mcq_enable(hba);
 	}
 
 	if (err)
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index d862c8ddce03..a96c45fa4b4b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1257,6 +1257,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+void ufshcd_mcq_enable(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
 int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index d5accacae6bc..e669fad11fd4 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -282,6 +282,10 @@ enum {
 /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
 #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
 
+/* REG_UFS_MEM_CFG - Global Config Registers 300h */
+#define MCQ_MODE_SELECT 	0x1
+#define ESI_ENABLE		0x2
+
 /* CQISy - CQ y Interrupt Status Register  */
 #define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
 
-- 
2.29.0


