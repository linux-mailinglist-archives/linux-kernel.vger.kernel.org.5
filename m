Return-Path: <linux-kernel+bounces-63440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65596852F62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1869E28CF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01916374DB;
	Tue, 13 Feb 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BeY7dFlp"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18F364C1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823936; cv=none; b=Q/FZ3ZkocQfBCBZTclcm3WZxWPjMLrwI5cfoPCUIpkCZVrUZtK5/OuzSHe2txAKBbuOfBW7dl4knZUNeUs76v9u1E/WgjYlO39eouAzwwU/GYPsTfCh1wxVgkuEWoNz0k68zcvdLPUc1/fuYaOyNDta/23fSzdEUwVS3alht5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823936; c=relaxed/simple;
	bh=Aa073cl3kqnphTf8b6BN7oCcURDXbs4boksLOpQndAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKbzZ2J7qruM0WGF7ZT+iU4kSAZ+NeSz+fO9Wn5LOFHl6xRLHbJwyQl8KVHa4mEPySWhdMfBng3y+w5BR++7Q8IG+AVO+jfUlWpXrQHJ6yyHijks2wwCd8n6YIxjK2pgPZZm6ePQEGmlqGjMOIAxpDEBIP50HD4WqLmtENkQwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BeY7dFlp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DB2XCx001458;
	Tue, 13 Feb 2024 11:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H4n7Gti0DQpKf+Lev3b2U1UIu6/NC1ZAUUgGWt0NH4A=;
 b=BeY7dFlpHB6ll/tirYvog5WZor0e08M9RwzIDLCdajD8RcPgPmPBpw8P+Xwt1PMtpkkE
 IRdtCe5jvojDDhkMe5gWU3l071WgfKkkt/FfvJbpvVRrb8TC0fsSi731fwBJXgStszAD
 Xwr9bH5wXcHUhdGtJJPq1w9mXDF3AnQWXHlhzkQyEUYNSTOD+40EpEWKXoS7RSv+Ikin
 +yV5OWIc3r+ew/ShuWEFnhQomJ9X6V6zCf//rSVATxvB0qj3N9TH+ab7Mk35sfNckzg9
 FD01/xh6LXzX7zbtsWEn4MU8X6VdeYo2ZeSrbPuPJPCuzSzvkcmf5960nwaHc+t46GvB VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w876tgk5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DBP74E020242;
	Tue, 13 Feb 2024 11:32:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w876tgk41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9kDhE009728;
	Tue, 13 Feb 2024 11:32:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62phjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DBVvkY31326602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:31:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192002004B;
	Tue, 13 Feb 2024 11:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525FA20040;
	Tue, 13 Feb 2024 11:31:54 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 11:31:54 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH linux-next 1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
Date: Tue, 13 Feb 2024 17:01:47 +0530
Message-ID: <20240213113150.1148276-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113150.1148276-1-hbathini@linux.ibm.com>
References: <20240213113150.1148276-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TVZ2HrHNgGxAqkRWyrbg9EsaotK3-Ut3
X-Proofpoint-GUID: W03R_p21SDHzPOy2M12oBn2E8MCT4U5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130091

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
2.43.0


