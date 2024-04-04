Return-Path: <linux-kernel+bounces-131335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CBD898669
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F7E1F21EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB385929;
	Thu,  4 Apr 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEpghrOk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355B84FC8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231370; cv=none; b=BRWYdbetWGRp3iFh/o95CpqADz+RfnkNDmZIKEC6AtzKJMN5rAd0WSQu7E7965zZMyILRIkIDpCZOLh+OElcj0qjmBFtmBEkDVxHdYGMfJ0uL6RnTrUXD//b0MON/2DaEmbXZDrWZVbyV2fXDFst4cdIO6rCtuoVuIkp7Z/bFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231370; c=relaxed/simple;
	bh=g4YqzOPIIY7GCoTlR7pyNYsta0tplaKPoxknIl7epoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1yxz6NMW5NXzwH1rlgYaWsF9RILFjgaH6JNGMaOIahrldgL8Na7qVz0KOcEZoFuChk9BrtX9oAfHXYZmtFt+T6DJbWUcEwnh07W0+BYNw/VDAfnxqnXJxxNXzq3DLUDngO3ds3yCdyg2znUmEvj4YJT8ZZuKzGwvnaoRiukvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEpghrOk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434BkTWI027412;
	Thu, 4 Apr 2024 11:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QwktDtoU33IoPMUJCZeU4oKjhACE8zM2zneIXMzb6mQ=;
 b=aEpghrOkhmpko1vDijvkpaO/j2mkaiDngvEWNdHFZCZ3w6kVkowh8Ytzzq32n5Cgv/mr
 N4fgXI33g6P/N2I0snCoXVXHAArxlOr8bPUK/plhH4NORAersRgpJIuGz6GgaEC3eZNz
 IxxSwsncRApFgR0IQwU8TTzzrxQaMp0GWnBmOdru7Qr6e87/lXfMjgjA5xIdcnWRUJ3p
 jXO9HJcEJBPXM4NYZvBBcFh7NyMLNy5ERSOd6pXg7bmHycIxsVsY0QClBNXoh3gqhP4/
 mditm/C7rtxJJDF+HUmzkXPK2pUkLnlpkFxs2yUt4h9DZZT/t50j99Hv5RLxsjsl7Xib 8w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9ubf01bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:49:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434ADXAI007713;
	Thu, 4 Apr 2024 11:49:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwkvnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 11:49:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434BnIGX31654596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 11:49:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA91920040;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D10742004D;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 11:49:17 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 1/1] /dev/port: don't compile file operations without CONFIG_DEVPORT
Date: Thu,  4 Apr 2024 13:49:17 +0200
Message-Id: <20240404114917.3627747-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404114917.3627747-1-schnelle@linux.ibm.com>
References: <20240404114917.3627747-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eUUhJCAK7QU925cUjgYqOKW6JlKuR98F
X-Proofpoint-ORIG-GUID: eUUhJCAK7QU925cUjgYqOKW6JlKuR98F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040081

In the future inb() and friends will not be available when compiling
with CONFIG_HAS_IOPORT=n so we must only try to access them here if
CONFIG_DEVPORT is set which depends on HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
and may be merged via subsystem specific trees at your earliest
convenience.

 drivers/char/mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 3c6670cf905f..7904e2bb6427 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -383,6 +383,7 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+#ifdef CONFIG_DEVPORT
 static ssize_t read_port(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -424,6 +425,7 @@ static ssize_t write_port(struct file *file, const char __user *buf,
 	*ppos = i;
 	return tmp-buf;
 }
+#endif
 
 static ssize_t read_null(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
@@ -653,12 +655,14 @@ static const struct file_operations null_fops = {
 	.uring_cmd	= uring_cmd_null,
 };
 
-static const struct file_operations __maybe_unused port_fops = {
+#ifdef CONFIG_DEVPORT
+static const struct file_operations port_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_port,
 	.write		= write_port,
 	.open		= open_port,
 };
+#endif
 
 static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
-- 
2.40.1


