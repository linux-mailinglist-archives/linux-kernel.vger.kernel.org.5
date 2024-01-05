Return-Path: <linux-kernel+bounces-18084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1582589A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C4A1F22BA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC62E852;
	Fri,  5 Jan 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ORqlR1ML"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6531A9D;
	Fri,  5 Jan 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405GAdea015401;
	Fri, 5 Jan 2024 16:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=gUFjJnldcCaXe2pdA55QFTTausQXLS6J9u68Q5ncGio=;
 b=ORqlR1MLCCOIG3+daQXHeCYON933hpPYh1ILuhU9wykDfFhUV1aZvhxhaVDrx1p9D6fM
 2aOJ1h4hYvfz4DAwvprwtZmJ2jHZnGqqsAJOzW4DoqUIeh+ahTsnTlrkWOeQsxEDEBH+
 58mvhVBxMkClJada3G5MCHNPLvif8uekBuHnVPl0uTPPIshFvsyZJcb9swErMvQ/Ilte
 Jdig8AWksgxJW7NYXu360LlrWwbGhya4QPR6ysxkOa6sTgWPydKrGfQx90NCFwTYfdSP
 ljhvsM94B+9YdMumhgqDZV77kleNfrvyRaUUMZXLQyjF1y4Pd1DIhkxNUHPHiMO3Fjn6 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ven25g3h4-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:47:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405G5Uiw009401;
	Fri, 5 Jan 2024 16:40:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve12hxey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:40:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 405GeGlf009736;
	Fri, 5 Jan 2024 16:40:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ve12hxewn-1;
	Fri, 05 Jan 2024 16:40:16 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH v2 1/2] VMCI: Use struct_size() in kmalloc()
Date: Fri,  5 Jan 2024 08:39:59 -0800
Message-ID: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050137
X-Proofpoint-ORIG-GUID: kgrNTprd204Py8fGpk9BJG_QYnC6j41a
X-Proofpoint-GUID: kgrNTprd204Py8fGpk9BJG_QYnC6j41a

Use struct_size() instead of open coding.

Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index f50d22882476..ac6cb0c8d99b 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -224,8 +224,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 				return VMCI_ERROR_NO_MEM;
 			}
 
-			dg_info = kmalloc(sizeof(*dg_info) +
-				    (size_t) dg->payload_size, GFP_ATOMIC);
+			dg_info = kmalloc(struct_size(dg_info, msg_payload, dg->payload_size),
+					  GFP_ATOMIC);
 			if (!dg_info) {
 				atomic_dec(&delayed_dg_host_queue_size);
 				vmci_resource_put(resource);
-- 
2.42.0


