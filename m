Return-Path: <linux-kernel+bounces-87555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61A86D5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AF288413
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6226143754;
	Thu, 29 Feb 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kzPXwjK1"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184014373A;
	Thu, 29 Feb 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240594; cv=none; b=Pq2FBAZyY+s0XsGgrnFsNwjIqHRVTe50OOEmyZrWrvhiEsC2G+TET0eZV1XU8whCSx+SH5VOAqDBmQqq27Dn2XEsbwULY7cbe8BvFzcCpLlFJmaBomEnzE3MSZwv05U9JxRlFEW1rwd9m2pDVjxBriE1hJFCP33Uc90OxBs2Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240594; c=relaxed/simple;
	bh=VTjWIjnaot8bvp8Uz7YSb+Wu+VwzB7BvnAiwu0uiHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aA5Kx72eCTQTlcfN85Ih+XhIu4XF4ziOO3F3Zx1Tun8tw96TIREO2CLLU2ZHPTvqDXf+FHPFlKHsHC+dYAz1pm48C3JNfsBcJ8j0yZBgUibj9Cc0+EWKyRPK2ruKLwpnFxIlWWYx9HbrqDopnnj8ljt5aKIXMwhqUVwjy3Jkrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kzPXwjK1; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TFBuaH010561;
	Thu, 29 Feb 2024 20:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pps0720;
 bh=bTL4DOSmyNxQGe0QwLYqgTCiTE3h293KECpT2Cd+njk=;
 b=kzPXwjK1SZsCC4A2UXBWK91e9uFF/hCuTPi/3IZkSdWrHbLVAxL10mh32LdEw+Qf5/ik
 at81CsioejMhAKCSvyosSXQTrD63rc1D1WG3QZE84heShZI+kdUW4LvQ0dzZE4esF0OQ
 /GLydvzxR5es2XSb3ehAa2Sd4tkM+ZqWsYOjmbT1nfxPMjNPWoDTqxkvuPohvhABOSFU
 e1sc33lrbdKqeMAkVfZzwza1x2KLjLatL3e6oHtFcInLnKCYtXEyqtvWrOqwpzmj/fb/
 qthu2c9EMSRUd+FI9oRgFnlP/q2d3V9q4YlabwIFqRkVDvEs4B8R3/II53iogipiTrde 7w== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3wjvbxb4w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:07:30 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9BB85130F8;
	Thu, 29 Feb 2024 20:07:29 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id A83CB8005F1;
	Thu, 29 Feb 2024 20:07:26 +0000 (UTC)
Date: Thu, 29 Feb 2024 14:07:24 -0600
From: Dimitri Sivanich <sivanich@hpe.com>
To: Dimitri Sivanich <sivanich@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <ZeDj/LK56borSxO4@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: kaKI-Rt3ddMThGjjOtXFFOFMzOETu6v1
X-Proofpoint-ORIG-GUID: kaKI-Rt3ddMThGjjOtXFFOFMzOETu6v1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=995 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290155

The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
vectors on the boot cpu.  On large systems with high DMAR counts this
results in vector exhaustion, and most of the vectors are not initially
allocated socket local.

Instead, have a cpu on each node do the vector allocation for the DMARs on
that node.  The boot cpu still does the allocation for its node during its
boot sequence.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
---
 drivers/iommu/intel/dmar.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..41ef72ba7509 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2108,8 +2108,12 @@ int __init enable_drhd_fault_handling(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
+		int ret;
 
+		if (iommu->node != cpu_to_node(smp_processor_id()))
+			continue;
+
+		ret = dmar_set_interrupt(iommu);
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
 			       (unsigned long long)drhd->reg_base_addr, ret);
@@ -2192,6 +2196,34 @@ static int __init dmar_free_unused_resources(void)
 
 late_initcall(dmar_free_unused_resources);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+static void __init irq_remap_enable_fault_handling_thr(struct work_struct *work)
+{
+	irq_remap_enable_fault_handling();
+}
+
+static int __init assign_dmar_vectors(void)
+{
+	struct work_struct irq_remap_work;
+	int nid;
+
+	INIT_WORK(&irq_remap_work, irq_remap_enable_fault_handling_thr);
+	cpus_read_lock();
+	for_each_online_node(nid) {
+		/* Boot cpu dmar vectors are assigned before the rest */
+		if (nid == cpu_to_node(get_boot_cpu_id()))
+			continue;
+		schedule_work_on(cpumask_first(cpumask_of_node(nid)),
+				 &irq_remap_work);
+		flush_work(&irq_remap_work);
+	}
+	cpus_read_unlock();
+	return 0;
+}
+
+arch_initcall(assign_dmar_vectors);
+#endif /* CONFIG_X86_LOCAL_APIC */
+
 /*
  * DMAR Hotplug Support
  * For more details, please refer to Intel(R) Virtualization Technology
-- 
2.35.3


