Return-Path: <linux-kernel+bounces-59307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40F84F510
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3601C23694
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE8C31759;
	Fri,  9 Feb 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfpvRoTd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C1286AF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480670; cv=none; b=G/pvZ1+V9ZvVKDkigezWXcXLGs2JcKKISVzZk+ae2Et+ef+d3xGnT0qszLwP1dWEMEgitRHn4a09u/EH6yHht5g2YxAPNDSduAVCLm5u3vQPOwovcMHDbOd1ugHddclNx4oHJZPEScY0ognzUYLIN+QNrOIeOd5S5tUjiZV5lnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480670; c=relaxed/simple;
	bh=atP9nv+MGvE39dRptK4hR3mGbhmbsAAJvomQQDYlAF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mobJzDlKPwlACQTpUTQAiEVpayR63Q+AaA5bej4Q6DhHdh9chYMjk0KgDAUPXW5DSXzwPL0OQHm0vsoOYjjZ4oOY7KAgN+A/yBSdNsLmO3LsHDQJjGgqeRaMBRv1T0XP8u7bD47RNCTRW93zv4FaGq42J6PFtXsnMBHqRFvHa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RfpvRoTd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194xG2U013736;
	Fri, 9 Feb 2024 12:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=t15kCmhkTCQwnVv0g0xmHlVcnU7G0kxiC5XlL5Wt3is=;
 b=RfpvRoTdvtsMZQBQtXgaThF2Hm17EtGsKrqr3wdYo2lP3nYdjzhH+orDpEBBmDxy/fxA
 zGzg4Efg8ZnWSnyJQpHvy2am8JKucostfKNO3E2KOraoBMSKcfsemsEEBSGb/fph8N78
 rtQJeabMfSUm7GGNyNN5pIY+1F+iqxIvgBSlqk3ZE7rxyIpEuaWnCnJBtfAfzw/r/RmJ
 wyWtIrBoyxyLaU4YxMv6KYVnJr6YqSZMFBBBxm0uDN0fvb5xbE7AoP5LtrW/LA8kEpj7
 7vFVMv1f5654KizJNkGstSG6FovtyqQirBFEQcbsA7AH+CBLXa4hKmpe8zO7jpK321xp Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd7a2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 12:10:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419AcOmC038386;
	Fri, 9 Feb 2024 12:10:52 GMT
Received: from localhost.localdomain (dhcp-10-191-128-116.vpn.oracle.com [10.191.128.116])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bxbvp30-1;
	Fri, 09 Feb 2024 12:10:51 +0000
From: Imran Khan <imran.f.khan@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] connector/cn_proc: make comm length as TASK_COMM_LEN.
Date: Fri,  9 Feb 2024 23:10:46 +1100
Message-Id: <20240209121046.1192739-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_09,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=997 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090088
X-Proofpoint-GUID: C7v74ijMVDLO7V_fagI9JMp8oDG3-h7m
X-Proofpoint-ORIG-GUID: C7v74ijMVDLO7V_fagI9JMp8oDG3-h7m

Since comm_proc_event::comm contains a task_struct::comm,
make its size same as TASK_COMM_LEN and avoid magic number
in buffer size.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 include/uapi/linux/cn_proc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index f2afb7cc4926..fd876c9b284f 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -136,7 +136,7 @@ struct proc_event {
 		struct comm_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
-			char           comm[16];
+			char           comm[TASK_COMM_LEN];
 		} comm;
 
 		struct coredump_proc_event {
-- 
2.34.1


