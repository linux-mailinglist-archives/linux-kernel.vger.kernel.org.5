Return-Path: <linux-kernel+bounces-13867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587928213CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778541C20BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866A3FEC;
	Mon,  1 Jan 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oh7rrX92"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2733C28;
	Mon,  1 Jan 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4015K1mf024521;
	Mon, 1 Jan 2024 13:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=sWE8iLC8lQnGrkSUfaQxhl7Q+roRwXRIvpOVMo+x0us=;
 b=oh7rrX92Hyzbuw8n6gJsQU9rRtH+fM/4jL5xXqWMs5kbQfngIpoCJvF8IIeJyIlzygLW
 /4qf9rsxioZU2EPGWYm1gw1O84IxL2sE2IBeWQozOs9LNrs5Sn+vgs3JjmI6MEzaSE9B
 1FM5eLTwouJnss71GANUFqHuZWVoVDs/CyiLDnDiat/uSFK9NvWn/ohFsjKLIpArO+sy
 eEX94JNElwc1UcQOjIqBTsnxKy3I/2+I9Bbmq01EkEUjj38DOJZZrAmFUZ9km/N2qZEX
 dnwuu6Zi3zVkZdz6UdhNjOTWNt0lRLrxx/q56EWHVOgVjIwLJ7cSzymErY5j8BPfVpnG rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d1swt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 13:08:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 401C47FD012962;
	Mon, 1 Jan 2024 13:08:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9nbtct2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jan 2024 13:08:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 401D8Y8V032534;
	Mon, 1 Jan 2024 13:08:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3va9nbtcsa-1;
	Mon, 01 Jan 2024 13:08:33 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: linux-hardening@vger.kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
        harshit.m.mogalapalli@oracle.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: [RFC PATCH] VMCI: Silence memcpy() run-time false positive warning
Date: Mon,  1 Jan 2024 05:08:28 -0800
Message-ID: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-01-01_06,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401010106
X-Proofpoint-GUID: 2YvmTSpATis-NlN9V21Xe4_8cqzf_oaP
X-Proofpoint-ORIG-GUID: 2YvmTSpATis-NlN9V21Xe4_8cqzf_oaP

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

So those extra bytes of payload are copied into msg_payload[], so there
is no bug, but a run time warning is seen while fuzzing with Syzkaller.

One possible way to silence the warning is to split the memcpy() into
two parts -- one -- copying the msg and second taking care of payload.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This patch is only tested with the C reproducer, not any testing
specific to driver is done.
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index f50d22882476..b43661590f56 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -216,6 +216,7 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 		if (dst_entry->run_delayed ||
 		    dg->src.context == VMCI_HOST_CONTEXT_ID) {
 			struct delayed_datagram_info *dg_info;
+			size_t payload_size = dg_size - VMCI_DG_HEADERSIZE;
 
 			if (atomic_add_return(1, &delayed_dg_host_queue_size)
 			    == VMCI_MAX_DELAYED_DG_HOST_QUEUE_SIZE) {
@@ -234,7 +235,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
+			memcpy(&dg_info->msg_payload, dg + 1, payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
-- 
2.42.0


