Return-Path: <linux-kernel+bounces-5461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75839818AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DAC1F222CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C9120DE3;
	Tue, 19 Dec 2023 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlczGLQw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696220DC4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9wuhv017135;
	Tue, 19 Dec 2023 15:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=7NuuEtCagypjfe1xtc4mlaQysed4lhnQXPrzUeLCbiE=;
 b=OlczGLQwnNuot5L8T2BLKhFGkcOuWfvmwsZrjpY0iNulSNEp25TfcgnS/kvTVkOrmHEr
 lv+/pMfXjnEIW4ooY8eEgGZIoR4UHmKZuwiqtjKrgqTWx9GtucX+QUSXwWp183gH6k4C
 2onrW5wCjMOspWus4QaCcz8g7+gIIXMpOEJ1TAydyXz3TX/vwDZLnFBYR+FsVUeyEAQL
 haX84pt94Pf511Iq3v+qZgFeCmSa9hxoJbBHwtl549UkXQ/Mz3toRPukRRNNmXW8B6to
 OeIhbAKab527mSXIdbr4NK+vp6HjYR6rZpIoD5CMCMDLd933kaaloewBzQy4gpe1Rt/B rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p465px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDuAKW028981;
	Tue, 19 Dec 2023 15:12:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w7p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdV008899;
	Tue, 19 Dec 2023 15:12:26 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-6;
	Tue, 19 Dec 2023 15:12:25 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 5/5] x86: add DB flag to 32-bit percpu GDT entry
Date: Tue, 19 Dec 2023 16:12:00 +0100
Message-Id: <20231219151200.2878271-6-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219151200.2878271-1-vegard.nossum@oracle.com>
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190113
X-Proofpoint-GUID: 5IeiefAD5OtgnnxlBoEVhp68y83iybXq
X-Proofpoint-ORIG-GUID: 5IeiefAD5OtgnnxlBoEVhp68y83iybXq

The D/B size flag for the 32-bit percpu GDT entry was not set.

The Intel manual (vol 3, section 3.4.5) only specifies the meaning of
this flag for three cases:

1) code segments used for %cs -- doesn't apply here
2) stack segments used for %ss -- doesn't apply
3) expand-down data segments -- but we don't have the expand-down flag
   set, so it also doesn't apply here

The flag likely doesn't do anything here, although the manual does also
say: "This flag should always be set to 1 for 32-bit code and data
segments [...]" so we should probably do it anyway.

Link: https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/kernel/setup_percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index f2583de97a64..b30d6e180df7 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,7 +106,7 @@ void __init pcpu_populate_pte(unsigned long addr)
 static inline void setup_percpu_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32 & ~_DESC_DB,
+	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32,
 					      per_cpu_offset(cpu), 0xFFFFF);
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);
-- 
2.34.1


