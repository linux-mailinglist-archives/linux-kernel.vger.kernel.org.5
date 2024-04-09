Return-Path: <linux-kernel+bounces-136181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78989D0D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D9A281AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736E54BCA;
	Tue,  9 Apr 2024 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QDL9/zEL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65CC548F2;
	Tue,  9 Apr 2024 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632554; cv=none; b=Kc1k8hLZ22B9QJmT2UMbcpfta5767NvQdPTWGxaB2MmHyQ6SNxxNV3XNjqnGvipLOnO/ivk/wL8JeIXACos0RIJRjlT8WleY2JkvYHiVTIySRZ486cwfKEhuuStkYYnxUNUgywCz3u6kHQm8iZBcb5kGPB9GpQcbwyXs46DaL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632554; c=relaxed/simple;
	bh=jrIScl7tEROJREqjIpcHI6bGspQlGAFhvM6VM7rlaV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgV/9bjYBYlXIinBxD37AXh+c86++9Nf8qVW9/r8Q8qekpFDFvVWYxs5nQDxFOqY9nrtiPK7Q48n9ge0FaIv4bPghkqkSXuadBSUoWlxHkdjZ7Ro/qUNZcM6NPEA54ndC5rp0gw2jXo6q6fG/fEVm/7ulg4nisSu+G+H9limZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QDL9/zEL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439386Hr005531;
	Tue, 9 Apr 2024 03:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3hR7/b+Lcmm0h+bCz7ikScFKg0g90gZUtEoSlyOaUGQ=;
 b=QDL9/zELLwJNTA0AlRX0XMVL5usITKhIqI7llCZqCy7N8HGs3rxRV/D0UwmrLLuGzbjM
 yvDYC37VQftNtPjImysV3fWO2/YqdG7hjBeE5aEhfVcM856SZKQSJ0dPtP6pccEaVKIE
 lq9/hxwzsYTliDoyEkFdEN58SBsV978NCM1absBAfDovsIrF7QDk+A5yGdY4wTpdceLj
 9V/9ZgafeMs8F4P7mVfMI641SZ22vli5o/+VNGzL9DhpltKtJMKgkC6XQ//3bYmlk6iV
 p/gVyxDRbS/1KrgswfW5PQCbioAkZt1yzu7b1BpxwI4JcpfAM5W7/m2zTXafHmMwgnT/ tQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcv1gg43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 03:15:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4390vlJA013550;
	Tue, 9 Apr 2024 03:15:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbgqtc1ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 03:15:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4393Ff1F27656924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 03:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E28E2004B;
	Tue,  9 Apr 2024 03:15:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC77F20040;
	Tue,  9 Apr 2024 03:15:40 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 03:15:40 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com.com (unknown [9.36.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 481A76016D;
	Tue,  9 Apr 2024 13:15:37 +1000 (AEST)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc: manoj@linux.ibm.com, ukrishn@linux.ibm.com, fbarrat@linux.ibm.com
Subject: [PATCH 1/2] MAINTAINERS: Make cxlflash obsolete
Date: Tue,  9 Apr 2024 13:10:26 +1000
Message-ID: <20240409031027.41587-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MjqIFWIQGX14MH6cBX1Ov2X8XbAeNIZ5
X-Proofpoint-ORIG-GUID: MjqIFWIQGX14MH6cBX1Ov2X8XbAeNIZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=703 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090018

The cxlflash driver is no longer actively maintained and we intend to
remove it in a future kernel release. Change its status to obsolete.

While we're here, Matthew Ochs no longer works at IBM and is no longer in
a position to access cxlflash hardware, so remove him from the maintainers
list.

Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..34f605498873 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5780,10 +5780,9 @@ F:	include/uapi/misc/cxl.h
 
 CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
 M:	Manoj N. Kumar <manoj@linux.ibm.com>
-M:	Matthew R. Ochs <mrochs@linux.ibm.com>
 M:	Uma Krishnan <ukrishn@linux.ibm.com>
 L:	linux-scsi@vger.kernel.org
-S:	Supported
+S:	Obsolete
 F:	Documentation/arch/powerpc/cxlflash.rst
 F:	drivers/scsi/cxlflash/
 F:	include/uapi/scsi/cxlflash_ioctl.h
-- 
2.44.0


