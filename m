Return-Path: <linux-kernel+bounces-81168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42B867171
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7DB1C27ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4A57878;
	Mon, 26 Feb 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nm01oJ7+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC94157875
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943448; cv=none; b=cFVPsLKcAl5D/nxUSgOisRGUE746/XCsTPoFm381r+JQ9QpxnkUSckl0bQVLupUmxbZtwgBhzcN5GqfJ+UNUxU1TfxDhFTIC2tsEmuLJq4nGRmWRN+SJRQlHU390+Tuc1eP6TJMJnQ+UIvZzvQ2zgvJ5HL59Y6joT9ZWPMhvViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943448; c=relaxed/simple;
	bh=KYg6mrMNStxiGbbzbxEg/eEQuvcP5cIEzoKaUwm4QiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knJoqLx4qfNY9l5pi3ymi/d/RiNQ3Y1NjhZfF2G6jCEKdv83hwzNxIh8tm/nwlShOUKmLM/uDXDWn18Bx/ROPmoJwLoe/1ixoaTrjG4ci7GtaCI4ng7XR94koMk9NVQrIG6VjVdzLUHv7PaFERU/T6ear2Vk13ctBE621RR2l+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nm01oJ7+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QAUC0k008331;
	Mon, 26 Feb 2024 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dI/mBcNNUD2cSvzFhJrEOpTylU3tUmT5GNPFVYNXGTY=;
 b=nm01oJ7+u6s7ujeOu3sGaGa3EtUV6EIzt68KsPlbMMLJ2Bqk/yGlYZ1atLXq1aP4Uygg
 zkOn2CFMRmRGuGPVud2SkbqfvFtVJDytT3Nrbq0FuseOARiPNeoh67crn77iFAsy5t1t
 FH/W3TCiNo61WlbwVoyHtQUB68sIo5VtIaraFMMSCjoRIrOo9TpCZ5lPBtNBzguBfXs7
 DmEMJ7MjjZHmSlm7aarCb+AlPf5Kfu/NrqwVjqYHSnc8RsUw+XA2A4L+MxCl/QTZoGQH
 ncpWpfXdrPav3/qDaFt4b5W3Yvs0ijJuDG7cK+FsqcFEEMNkNASWJVZoxu1WL3yz6KeL Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgmg2e2r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QAUOJC009669;
	Mon, 26 Feb 2024 10:30:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgmg2e2qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q8lCeU008189;
	Mon, 26 Feb 2024 10:30:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m08qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QAUHO766716076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:30:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A7F920043;
	Mon, 26 Feb 2024 10:30:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A6020040;
	Mon, 26 Feb 2024 10:30:14 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 10:30:14 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>
Subject: [PATCH linux-next v2 1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
Date: Mon, 26 Feb 2024 16:00:08 +0530
Message-ID: <20240226103010.589537-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yzZ7pqNr7dH_VRpsTh9hCqMVno0eizzv
X-Proofpoint-GUID: L4ueQ49CtB466i6VpGELkjM_YWBf-K3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260079

struct crash_mem defined under include/linux/crash_core.h represents
a list of memory ranges. While it is used to represent memory ranges
for kdump kernel, it can also be used for other kind of memory ranges.
In fact, KEXEC_FILE_LOAD syscall in powerpc uses this structure to
represent reserved memory ranges and exclude memory ranges needed to
find the right memory regions to load kexec kernel. So, make the
definition of crash_mem structure available for !CONFIG_CRASH_DUMP
case too.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* No changes in v2.

 include/linux/crash_core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 23270b16e1db..d33352c2e386 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -8,6 +8,12 @@
 
 struct kimage;
 
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[] __counted_by(max_nr_ranges);
+};
+
 #ifdef CONFIG_CRASH_DUMP
 
 int crash_shrink_memory(unsigned long new_size);
@@ -51,12 +57,6 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[] __counted_by(max_nr_ranges);
-};
-
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-- 
2.43.2


