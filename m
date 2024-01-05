Return-Path: <linux-kernel+bounces-18081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13382588B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AE11F23F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC42E652;
	Fri,  5 Jan 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQ8oIF5V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5F2E3EB;
	Fri,  5 Jan 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405GAUJH015360;
	Fri, 5 Jan 2024 16:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=KTdriLE86+maLYzNTAkNF/rMwcWwOzamLeAdvgeFGlk=;
 b=TQ8oIF5VhKAAHF+q8w51rxwv+IE8k0RuplV5eE4s/yAFjxA4ivUReRYLf3pfiKKQvz+q
 vigFA4v2zsqEHY5SxGB3fKAhD3Ar3WkKzFtys7F5qmbO3CjKrTVLlO+OA2LZt0+zddat
 xvaRx7LvqnV6k8c1egrybs60NdqGershznzp1G381l/53vSwYOSj6Kgbkbj8Drzbeo0p
 aM+Ae12Hvzr9a/uLW2RzExPyrzoqjvxIzazUXFyfzn+remO5NLIbwyE6x0CdzddF+lRx
 DK5URuNfoI23vGhrN08PI4FJQL/aYbwxdi5gagV0WJzOG5lb2FyIOLLdqHO0K2Hztjmw zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ven25g3h5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:44:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405G6NHg009571;
	Fri, 5 Jan 2024 16:40:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve12hxf1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:40:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 405GeGlh009736;
	Fri, 5 Jan 2024 16:40:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ve12hxewn-2;
	Fri, 05 Jan 2024 16:40:20 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
        harshit.m.mogalapalli@oracle.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
Date: Fri,  5 Jan 2024 08:40:00 -0800
Message-ID: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: jLRv-kY0KnD9ryXTYtmDkm-7wTLBVS4z
X-Proofpoint-GUID: jLRv-kY0KnD9ryXTYtmDkm-7wTLBVS4z

Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.

memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)

WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237

Some code commentry, based on my understanding:

544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
/// This is 24 + payload_size

memcpy(&dg_info->msg, dg, dg_size);
	Destination = dg_info->msg ---> this is a 24 byte
					structure(struct vmci_datagram)
	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
	Size = dg_size = 24 + payload_size

{payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.

 35 struct delayed_datagram_info {
 36         struct datagram_entry *entry;
 37         struct work_struct work;
 38         bool in_dg_host_queue;
 39         /* msg and msg_payload must be together. */
 40         struct vmci_datagram msg;
 41         u8 msg_payload[];
 42 };

So those extra bytes of payload are copied into msg_payload[], a run time
warning is seen while fuzzing with Syzkaller.

One possible way to fix the warning is to split the memcpy() into
two parts -- one -- direct assignment of msg and second taking care of payload.

Gustavo quoted:
"Under FORTIFY_SOURCE we should not copy data across multiple members
in a structure."

Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This patch is only tested with the C reproducer, not any testing
specific to driver is done.

v1->v2: ( Suggestions from Gustavo )
        1. Change the commit message false positive --> legitimate
           warning.
        2. Remove unneeded payload_size variable.
        3. Replace first memcpy() with direct assignment.
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index ac6cb0c8d99b..ba379cd6d054 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -234,7 +234,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			dg_info->msg = *dg;
+			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
-- 
2.42.0


