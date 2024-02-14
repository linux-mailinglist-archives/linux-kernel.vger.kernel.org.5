Return-Path: <linux-kernel+bounces-65781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2D8551C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DD51F28535
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21912AAE9;
	Wed, 14 Feb 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BxqTUWGh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BF128831
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934214; cv=none; b=bAelq194DxN4bFWYzKZZT7OF97tgcLj2LGrO8t7ZofiTWXUCJaqIkxMiB7uqwuAPtb/Ait37oN+ImT/ljGhQ85wT3/QcgnbecIMJRra7sVVPyhOdv9nKQUSrTSs0IcZGnmIJCNqnJ249ThDgADWfh1v/z10tztkFKKwwTa+aaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934214; c=relaxed/simple;
	bh=ksBctz/dgPXDbByBp8te9y7TkU9g1V8SEPw3LYJBR9A=;
	h=Subject:From:To:Cc:Date:Message-ID:Content-Type:MIME-Version; b=ekM9Yk7JhKFh2P1QdaTQqTyVA8r6iIxD2KfrieCIE6KroNkpEGTyUuBfA3ISzPR68UfwkRNUkN/ll5JdovzFFR66gZFZPFAB6NuX3v24M7sVtulClzm1uuYN8nImndGR0UYj2TJw/n4w/Gq/fZ4dTBwI/dWkKWjSuh4rQIWW2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BxqTUWGh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHkDgg016535;
	Wed, 14 Feb 2024 18:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=0MNYMA6KLlVTYGcvolZmqodIbFxalz9bJACvWswK3C4=;
 b=BxqTUWGhZFAFbjyPC7aeP0dPjZJNqcClY5j53rHLqn53n53kUjHPIMVyZkOCrUlUbaZd
 VPtlUS/IPd1S1Jn5pQYJz7rXaH+OO7J2mF/U6ebPKR5A3VXprztSP5OEcglBup2Mob0L
 hxjM5OdxAmFjcpVTq0mNvOtSPtj0U6vz+az3qUD9iBJzhXNjq05bDLfu0tX492+mlMg5
 D0FYAKlWH6FHi0qH5VqI1MkLqbmDKbFSNak2JsxH/mYUdASjifQyDT942U2W6d1ZXF6Q
 iePDOU6azqZJWqbbFS2ZAP+RYMkUeYnNYKJRM94Wb3+8gAiw46SWq5RgjUOgP2bFjimh nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w91x3s73g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:09:35 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EHkGOW016939;
	Wed, 14 Feb 2024 18:09:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w91x3s72r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:09:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EG867l004297;
	Wed, 14 Feb 2024 18:09:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0fqfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:09:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EI9Sam3801784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:09:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 390422004B;
	Wed, 14 Feb 2024 18:09:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7792B20040;
	Wed, 14 Feb 2024 18:09:25 +0000 (GMT)
Received: from ltcd48-lp2.aus.stglabs.ibm.com (unknown [9.3.101.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 18:09:25 +0000 (GMT)
Subject: [PATCH v2] powerpc/iommu: Fix the iommu group reference leak during
 platform domain attach
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, jgg@ziepe.ca, jroedel@suse.de,
        tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
        gregkh@linuxfoundation.org, sbhat@linux.ibm.com,
        gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
        venkat88@linux.vnet.ibm.com
Date: Wed, 14 Feb 2024 12:09:24 -0600
Message-ID: <170793401503.7491.9431631474642074097.stgit@linux.ibm.com>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uKSBjRdBPic4mU_8n_1yN31m-92kmjP8
X-Proofpoint-ORIG-GUID: R82hzjgUCCuYFy8M9RyhMOEcsUjR9CnV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=269 spamscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140142

The function spapr_tce_platform_iommu_attach_dev() is missing to call
iommu_group_put() when the domain is already set. This refcount leak
shows up with BUG_ON() during DLPAR remove operation as,

  KernelBug: Kernel bug in state 'None': kernel BUG at arch/powerpc/platforms/pseries/iommu.c:100!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
  <snip>
  Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
  NIP:  c0000000000ff4d4 LR: c0000000000ff4cc CTR: 0000000000000000
  REGS: c0000013aed5f840 TRAP: 0700   Tainted: G          I         (6.8.0-rc3-autotest-g99bd3cb0d12e)
  MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44002402  XER: 20040000
  CFAR: c000000000a0d170 IRQMASK: 0
  GPR00: c0000000000ff4cc c0000013aed5fae0 c000000001512700 c0000013aa362138
  GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000119c8afd0
  GPR08: 0000000000000000 c000001284442b00 0000000000000001 0000000000001003
  GPR12: 0000000300000000 c0000018ffff2f00 0000000000000000 0000000000000000
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR24: c0000013aed5fc40 0000000000000002 0000000000000000 c000000002757d90
  GPR28: c0000000000ff440 c000000002757cb8 c00000183799c1a0 c0000013aa362b00
  NIP [c0000000000ff4d4] iommu_reconfig_notifier+0x94/0x200
  LR [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200
  Call Trace:
  [c0000013aed5fae0] [c0000000000ff4cc] iommu_reconfig_notifier+0x8c/0x200 (unreliable)
  [c0000013aed5fb10] [c0000000001a27b0] notifier_call_chain+0xb8/0x19c
  [c0000013aed5fb70] [c0000000001a2a78] blocking_notifier_call_chain+0x64/0x98
  [c0000013aed5fbb0] [c000000000c4a898] of_reconfig_notify+0x44/0xdc
  [c0000013aed5fc20] [c000000000c4add4] of_detach_node+0x78/0xb0
  [c0000013aed5fc70] [c0000000000f96a8] ofdt_write.part.0+0x86c/0xbb8
  [c0000013aed5fce0] [c00000000069b4bc] proc_reg_write+0xf4/0x150
  [c0000013aed5fd10] [c0000000005bfeb4] vfs_write+0xf8/0x488
  [c0000013aed5fdc0] [c0000000005c0570] ksys_write+0x84/0x140
  [c0000013aed5fe10] [c000000000033358] system_call_exception+0x138/0x330
  [c0000013aed5fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
  --- interrupt: 3000 at 0x20000433acb4
  <snip>
  ---[ end trace 0000000000000000 ]---

The patch makes the iommu_group_get() call only when using it there by
avoiding the leak.

Fixes: a8ca9fc9134c ("powerpc/iommu: Do not do platform domain attach atctions after probe")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Closes: https://lore.kernel.org/all/274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
Changelog:
v1: https://lore.kernel.org/all/170784021983.6249.10039296655906636112.stgit@linux.ibm.com/
 - Minor refactor to call the iommu_group_get() only if required.
 - Updated the title, description and signature(Closes/Reported-by).

 arch/powerpc/kernel/iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d71eac3b2887..37fae3bd89c6 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1285,13 +1285,14 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
 				    struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_group *grp = iommu_group_get(dev);
 	struct iommu_table_group *table_group;
+	struct iommu_group *grp;

 	/* At first attach the ownership is already set */
 	if (!domain)
 		return 0;

+	grp = iommu_group_get(dev);
 	table_group = iommu_group_get_iommudata(grp);
 	/*
 	 * The domain being set to PLATFORM from earlier



