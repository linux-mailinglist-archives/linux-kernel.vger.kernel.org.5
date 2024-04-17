Return-Path: <linux-kernel+bounces-148093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0388A7DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D2A1F22B20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CB73199;
	Wed, 17 Apr 2024 08:01:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312D7440B;
	Wed, 17 Apr 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340879; cv=none; b=UImmh0+/WEWYA+HSpwxQEU1pJlTFfZR3exf0uHLmK9UFo+LlXnp+0BOPFMsXJEaDe4RrcoWe4qD6hFRdTpoUs2sMWSEnWz3/YeL1dxHejf/yZizRvMfHWxWW3gxvBsEXjJ2clxFAHUBO+WLE1+Ghhut2NfE5v427DPaKi32xf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340879; c=relaxed/simple;
	bh=qicRup+tfgdLLdNGsmaZDoT9WfxzPx2jr6Pc+cXvLD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E132OLHSPZl2FvAY+bGtmheuuOB1sZCOR9766QKO1AqGtLZYhkM4UG6eIkgTWa/rGnMyd3SqrwvM8vYeUpbTbqFZagMVCBR5w+qDeqk6gITE0f8wKGrYOMY3ySjDiK0V748gfAij+CKVKYCpz2hSPpv5+V5RCktpRKEsfbeNrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKCwb6D6Tz6HJLh;
	Wed, 17 Apr 2024 15:59:11 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
	by mail.maildlp.com (Postfix) with ESMTPS id 24C4A140A08;
	Wed, 17 Apr 2024 16:01:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 09:01:10 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 09:01:10 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Thread-Topic: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Thread-Index: AQHajVTpda5PtrGZ80+YonTPgO6cRrFphU4AgAKXr6A=
Date: Wed, 17 Apr 2024 08:01:10 +0000
Message-ID: <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <20240415171426.GF3637727@nvidia.com>
In-Reply-To: <20240415171426.GF3637727@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, April 15, 2024 6:14 PM
> To: Nicolin Chen <nicolinc@nvidia.com>
> Cc: will@kernel.org; robin.murphy@arm.com; joro@8bytes.org;
> thierry.reding@gmail.com; vdumpa@nvidia.com; jonathanh@nvidia.com;
> linux-kernel@vger.kernel.org; iommu@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; linux-tegra@vger.kernel.org; Jerry Snitselaar
> <jsnitsel@redhat.com>
> Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
>=20
> On Fri, Apr 12, 2024 at 08:43:48PM -0700, Nicolin Chen wrote:
>=20
> > The user-space support is to provide uAPIs (via IOMMUFD) for hypervisor=
s
> > in user space to passthrough VCMDQs to VMs, allowing these VMs to
> access
> > the VCMDQs directly without trappings, i.e. no VM Exits. This gives hug=
e
> > performance improvements: 70% to 90% reductions of TLB invalidation
> time
> > were measured by various DMA unmap tests running in a guest OS,
> compared
> > to a nested SMMU CMDQ (with trappings).
>=20
> So everyone is on the same page, this is the primary point of this
> series. The huge speed up of in-VM performance is necessary for the
> workloads this chip is expected to be running. This series is unique
> from all the rest because it runs inside a VM, often in the from of a
> distro release.
>=20
> It doesn't need the other series or it's own part 2 as it entirely
> stands alone on bare metal hardware or on top of commercial VM cloud
> instances runing who-knows-what in their hypervisors.
>=20
> The other parts are substantially about enabling qemu and the open
> ecosystem to have fully functional vSMMU3 virtualization.

Hi,

We do have plans to revive the SMMUv3 ECMDQ series posted a while back[0]
and looking at this series, I am just wondering whether it makes sense to h=
ave
a similar one with ECMDQ as well?  I see that the NVIDIA VCMDQ has a specia=
l bit=20
to restrict the commands that can be issued from user space. If we end up a=
ssigning
a ECMDQ to user space, is there any potential risk in doing so?=20

SMMUV3 spec does say,
"Arm expects that the Non-secure Stream table, Command queue, Event queue a=
nd
PRI queue are controlled by the most privileged Non-secure system software.=
 "

Not clear to me what are the major concerns here and maybe we can come up w=
ith=20
something to address that in kernel.

Please let me know if you have any thoughts on this.

Thanks,
Shameer
[0] https://lore.kernel.org/lkml/20230809131303.1355-1-thunder.leizhen@huaw=
eicloud.com/


