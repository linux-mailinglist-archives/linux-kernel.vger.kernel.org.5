Return-Path: <linux-kernel+bounces-148268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0F8A800F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F81F23B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250C13440B;
	Wed, 17 Apr 2024 09:45:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C70F516;
	Wed, 17 Apr 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347141; cv=none; b=AkQet1goG9s+plP5UCz/AIX+7tk7U+WLvT6YLrOdl846thJVzK65iYKhpkK6h3YFCfjjdpdSfDyt1Bj3r8It7jOH3qrZLZfanV+PCBkj0oIGRw8Hbv50FN09nQ2UYO2stm/shm4fcxg5lyqRrIQy3Ou4uiYSoEQ9T7nuRSIwOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347141; c=relaxed/simple;
	bh=KoJBnnMfkQDjTHJ4VXbOujuvynCUV4+zBSTfLBsA10E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eIKGN3fUrME0g6YYnBiMa6nhnz70xEL68Qd/srauKemeB+MMShZdTgE3WLKidPsNeDD95uCd94WthQVyCDmcFTh3XrIZsHv9xPyUsL7u4ZiZQtiDylbJL9YaeYW4pR/PejSHF9sDLtpjGcJacGCzRY1tis7yUhefpAP77eSiujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKGF43Vrnz6F8c6;
	Wed, 17 Apr 2024 17:43:36 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
	by mail.maildlp.com (Postfix) with ESMTPS id F2387140B63;
	Wed, 17 Apr 2024 17:45:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 10:45:34 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 10:45:34 +0100
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
Thread-Index: AQHajVTpda5PtrGZ80+YonTPgO6cRrFphU4AgAKXr6CAAB7BMA==
Date: Wed, 17 Apr 2024 09:45:34 +0000
Message-ID: <ba3047f946c6475aaf30800f9d3f9afb@huawei.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <20240415171426.GF3637727@nvidia.com>
 <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
In-Reply-To: <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
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
> From: Shameerali Kolothum Thodi
> Sent: Wednesday, April 17, 2024 9:01 AM
> To: 'Jason Gunthorpe' <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com=
>
> Cc: will@kernel.org; robin.murphy@arm.com; joro@8bytes.org;
> thierry.reding@gmail.com; vdumpa@nvidia.com; jonathanh@nvidia.com; linux-
> kernel@vger.kernel.org; iommu@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; linux-tegra@vger.kernel.org; Jerry Snitselaar
> <jsnitsel@redhat.com>
> Subject: RE: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, April 15, 2024 6:14 PM
> > To: Nicolin Chen <nicolinc@nvidia.com>
> > Cc: will@kernel.org; robin.murphy@arm.com; joro@8bytes.org;
> > thierry.reding@gmail.com; vdumpa@nvidia.com; jonathanh@nvidia.com;
> > linux-kernel@vger.kernel.org; iommu@lists.linux.dev; linux-arm-
> > kernel@lists.infradead.org; linux-tegra@vger.kernel.org; Jerry Snitsela=
ar
> > <jsnitsel@redhat.com>
> > Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/=
2)
> >
> > On Fri, Apr 12, 2024 at 08:43:48PM -0700, Nicolin Chen wrote:
> >
> > > The user-space support is to provide uAPIs (via IOMMUFD) for hypervis=
ors
> > > in user space to passthrough VCMDQs to VMs, allowing these VMs to
> > access
> > > the VCMDQs directly without trappings, i.e. no VM Exits. This gives h=
uge
> > > performance improvements: 70% to 90% reductions of TLB invalidation
> > time
> > > were measured by various DMA unmap tests running in a guest OS,
> > compared
> > > to a nested SMMU CMDQ (with trappings).
> >
> > So everyone is on the same page, this is the primary point of this
> > series. The huge speed up of in-VM performance is necessary for the
> > workloads this chip is expected to be running. This series is unique
> > from all the rest because it runs inside a VM, often in the from of a
> > distro release.
> >
> > It doesn't need the other series or it's own part 2 as it entirely
> > stands alone on bare metal hardware or on top of commercial VM cloud
> > instances runing who-knows-what in their hypervisors.
> >
> > The other parts are substantially about enabling qemu and the open
> > ecosystem to have fully functional vSMMU3 virtualization.
>=20
> Hi,
>=20
> We do have plans to revive the SMMUv3 ECMDQ series posted a while back[0]
> and looking at this series, I am just wondering whether it makes sense to=
 have
> a similar one with ECMDQ as well?  I see that the NVIDIA VCMDQ has a spec=
ial
> bit
> to restrict the commands that can be issued from user space. If we end up
> assigning
> a ECMDQ to user space, is there any potential risk in doing so?
>=20
> SMMUV3 spec does say,
> "Arm expects that the Non-secure Stream table, Command queue, Event queue
> and
> PRI queue are controlled by the most privileged Non-secure system softwar=
e. "
>=20
> Not clear to me what are the major concerns here and maybe we can come up
> with
> something to address that in kernel.

Just to add to that. One idea could be like to have a case where when ECMDQ=
s are=20
detected, use that for issuing limited set of cmds(like stage 1 TLBIs) and =
use the
normal cmdq for rest. Since we use stage 1 for both host and for Guest nest=
ed cases
and TLBIs are the bottlenecks in most cases I think this should give perfor=
mance
benefits.

Thanks,
Shameer

