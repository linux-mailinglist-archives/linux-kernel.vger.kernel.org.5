Return-Path: <linux-kernel+bounces-111673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B6886F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E561C226E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8E4D108;
	Fri, 22 Mar 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cKiOBsy4"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB147F7A;
	Fri, 22 Mar 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119878; cv=none; b=Tzu4dD3Y1W69AyjxRp230khF9s/NtCtU7xaM3JQEGz816Yn9G7HiB13y9QcZGd5hyGlsOsz098xEXiUQlnM0u9QR2Ra5Q9NZ3Gzb6J6hPxSAB/RrkptgtQk0Lykumd8YYwTDIiWw0R7e52mRKQd/DINXYY/ME9BR8WG5mKOBXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119878; c=relaxed/simple;
	bh=pMw41LK2md1lsVOBw+1WHPfP+SWaN25vqSCRAp+WiEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fveeW+ua+Ugm2wI7fvf2uvI3syJ7rYrQqV48w+fs5X/Q2fofdoStOqhP6GAlPrm20a8E9iDU9Ydbk2Wz8rBC7i2Sbaesam1ENTW3tBCFHSW5WZ13Pf9QRFsGLq5xIUD8RgTjg+lax9wBttGkzEtPLAPLYSUhVMMdT/t4gF5+2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cKiOBsy4; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42MAIIRi009939;
	Fri, 22 Mar 2024 15:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=R+DjamXJ2Os+RkrubU6SEUzUiFfgGVeCbQ1FHdoKBsk=;
 b=cKiOBsy4/LBLdMHPMfIVL+Nij1OMzO7VrCUlP0/3KptUPK+WhIpJTHCDpxD3+NmNuxng
 0oMMGKZL+eFRe3UXaP0rUIRhgE7JNWms17P1u+9q0zJwRHW2FWxRBETJSYjiFdOOmCQk
 tOLLxxHrBIC7lKPHfMIuHcJTsbgLeHpZCEiN6oHM9gUxa0Cd2EV0PI/1DSqQW7mwzcCt
 2IxYpyY3gXrjgJsr3Uxylh7dz8NED+8H97eUO9VdhdKJC22A06Ad/atVMj86kv+ha7hM
 dJanaDa9EMs2MA5FypKvjzBAXmNGq8jc84ONhdFapu7uedk9D+xtiT2AlAA7PxqpJ3SZ 1A== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x0wyey3tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 15:03:30 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 6B0E0804DC5;
	Fri, 22 Mar 2024 15:03:27 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id AE82E800EF5;
	Fri, 22 Mar 2024 15:03:20 +0000 (UTC)
Date: Fri, 22 Mar 2024 10:03:16 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: Re: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Message-ID: <Zf2dtAczygAAa2vg@hpe.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
 <MW5PR11MB58815A2B9929D89F5B32371989312@MW5PR11MB5881.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB58815A2B9929D89F5B32371989312@MW5PR11MB5881.namprd11.prod.outlook.com>
X-Proofpoint-GUID: O9BFYHYfEBnF7POTx4qlHaBYnB6uevQ_
X-Proofpoint-ORIG-GUID: O9BFYHYfEBnF7POTx4qlHaBYnB6uevQ_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220107

Hi Tina,

On Fri, Mar 22, 2024 at 04:41:01AM +0000, Zhang, Tina wrote:
> Hi Dimitri,
> 
> 
> > -----Original Message-----
> > From: Dimitri Sivanich <sivanich@hpe.com>
> > Sent: Friday, March 22, 2024 4:51 AM
> > To: Thomas Gleixner <tglx@linutronix.de>; Joerg Roedel <joro@8bytes.org>;
> > Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>; Will Deacon
> > <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; David
> > Woodhouse <dwmw2@infradead.org>; Lu Baolu <baolu.lu@linux.intel.com>;
> > Mark Rutland <mark.rutland@arm.com>; Peter Zijlstra
> > <peterz@infradead.org>; Arnd Bergmann <arnd@arndb.de>; YueHaibing
> > <yuehaibing@huawei.com>; iommu@lists.linux.dev; Dimitri Sivanich
> > <sivanich@hpe.com>
> > Cc: linux-kernel@vger.kernel.org; Steve Wahl <steve.wahl@hpe.com>;
> > Anderson, Russ <russ.anderson@hpe.com>
> > Subject: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
> > 
> > The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> > vectors on the boot cpu.  On large systems with high DMAR counts this
> > results in vector exhaustion, and most of the vectors are not initially allocated
> > socket local.
> > 
> > Instead, have a cpu on each node do the vector allocation for the DMARs on
> > that node.  The boot cpu still does the allocation for its node during its boot
> > sequence.
> > 
> > Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> > ---
> > 
> > v2: per Thomas Gleixner, implement this from a DYN CPU hotplug state,
> > though
> >     this implementation runs in CPUHP_AP_ONLINE_DYN space rather than
> >     CPUHP_BP_PREPARE_DYN space.
> > 
> >  drivers/iommu/amd/amd_iommu.h | 2 +-
> >  drivers/iommu/amd/init.c      | 2 +-
> >  drivers/iommu/intel/dmar.c    | 9 +++++++--
> >  drivers/iommu/irq_remapping.c | 5 ++++-  drivers/iommu/irq_remapping.h |
> > 2 +-
> >  include/linux/dmar.h          | 2 +-
> >  6 files changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/amd_iommu.h
> > b/drivers/iommu/amd/amd_iommu.h index f482aab420f7..410c360e7e24
> > 100644
> > --- a/drivers/iommu/amd/amd_iommu.h
> > +++ b/drivers/iommu/amd/amd_iommu.h
> > @@ -33,7 +33,7 @@ int amd_iommu_prepare(void);  int
> > amd_iommu_enable(void);  void amd_iommu_disable(void);  int
> > amd_iommu_reenable(int mode); -int amd_iommu_enable_faulting(void);
> > +int amd_iommu_enable_faulting(unsigned int cpu);
> >  extern int amd_iommu_guest_ir;
> >  extern enum io_pgtable_fmt amd_iommu_pgtable;  extern int
> > amd_iommu_gpt_level; diff --git a/drivers/iommu/amd/init.c
> > b/drivers/iommu/amd/init.c index e7a44929f0da..4782f690ed97 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -3389,7 +3389,7 @@ int amd_iommu_reenable(int mode)
> >  	return 0;
> >  }
> > 
> > -int __init amd_iommu_enable_faulting(void)
> > +int __init amd_iommu_enable_faulting(unsigned int cpu)
> >  {
> >  	/* We enable MSI later when PCI is initialized */
> >  	return 0;
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c index
> > 36d7427b1202..7644a42f283c 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -2122,7 +2122,7 @@ int dmar_set_interrupt(struct intel_iommu
> > *iommu)
> >  	return ret;
> >  }
> > 
> > -int __init enable_drhd_fault_handling(void)
> > +int enable_drhd_fault_handling(unsigned int cpu)
> >  {
> >  	struct dmar_drhd_unit *drhd;
> >  	struct intel_iommu *iommu;
> > @@ -2132,7 +2132,12 @@ int __init enable_drhd_fault_handling(void)
> >  	 */
> >  	for_each_iommu(iommu, drhd) {
> >  		u32 fault_status;
> > -		int ret = dmar_set_interrupt(iommu);
> > +		int ret;
> > +
> > +		if (iommu->irq || iommu->node != cpu_to_node(cpu))
> > +			continue;
> If iommu->irq is set, current logic will clear any previous faults by accessing DMAR_FSTS_REG. However, the code change in this patch seems missing it.

Yes, the current logic does clear the faults even in the iommu->irq!=0 case,
but enable_drhd_fault_handling is currently only run once by the boot cpu,
prior to startup of the other processors.  So each iommu will, initially at
least, only have its faults cleared once.

With this patch, enable_drhd_fault_handling will still run on the boot cpu
prior to the startup of other processors, but will also run on each AP as it is
brought up (hotplugged).  It will now only operate on the iommus that are on
its own socket, however.  If we add back the fault clearing for the
iommu->irq!=0 case, each iommu on a socket would end up having faults cleared
once for each cpu on the socket (so 120 times for a 60-core socket with HT
enabled).  In addition, this would happen again each time a cpu is hot-plugged
after having been hot-unplugged.

So is there a specific reason why faults would need to be cleared if the
iommu->irq has already been set, since I assume they would've already been
cleared during this boot?

I'm definitely willing to add back the fault clearing for the iommu->irq!=0
case, but am looking for guidance from others like yourself on this.

> 
> The current logic:
> int dmar_set_interrupt(struct intel_iommu *iommu)
> {
>         int irq, ret;
> 
>         /*
>          * Check if the fault interrupt is already initialized.
>          */
>         if (iommu->irq)
>                 return 0;
>         ...
> 
> int __init enable_drhd_fault_handling(void)
> {
> 	...
>         for_each_iommu(iommu, drhd) {
>                 u32 fault_status;
>                 int ret = dmar_set_interrupt(iommu);
> 
>                 if (ret) {
>                         pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
>                                (unsigned long long)drhd->reg_base_addr, ret);
>                         return -1;
>                 }
> 
>                 /*
>                  * Clear any previous faults.
>                  */
>                 dmar_fault(iommu->irq, iommu);
>                 fault_status = readl(iommu->reg + DMAR_FSTS_REG);
>                 writel(fault_status, iommu->reg + DMAR_FSTS_REG);
>         }
> 	...
> 
> Regards,
> 
> -Tina

