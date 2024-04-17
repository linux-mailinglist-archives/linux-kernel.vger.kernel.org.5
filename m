Return-Path: <linux-kernel+bounces-148769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64A8A8726
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03951F22405
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF213BC18;
	Wed, 17 Apr 2024 15:13:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE31422DF;
	Wed, 17 Apr 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366782; cv=none; b=ixd8hU7/YLOuz9m9nHXTn/o3SwaOYRQDGurq2CEXeaK8dWdaFdz7j1/f29vwAjlFVWjVStoRJRxAg+i5txIp8ZibKCj67XsXJRQdHz99NLAmi3a0StEZEGWm0ktHwyTzFsKTCfNZLmUFJRoPE0oBx5hXVJkxR85h4Nb4YtLpNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366782; c=relaxed/simple;
	bh=BeDNJBDbd5gDvNAksWz9QTioMUv2ML9Z12n2HjGKv1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxDwHucQVpHouhQYbHHLzrt99/KuqR8NRNN5McgAM7U2Cd30LkDNbT3/JoKwy714Cijya1E6zKxl8G21yEpaU2fEfAlXoXGqqNCN3VRHnAQ4RXtdf7u3Yl0Zpf00RXDkYGqCcHMtq41qx4l1Xqd4RRym6KO0jyrHGFB4QoY2QYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKPVn2X6Wz6H6tJ;
	Wed, 17 Apr 2024 23:10:57 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
	by mail.maildlp.com (Postfix) with ESMTPS id A17CF140B54;
	Wed, 17 Apr 2024 23:12:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:12:57 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 16:12:57 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: RE: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Thread-Topic: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Thread-Index: AQHajVULCff80FKHW06RtKfJgVx61rFsllJQ
Date: Wed, 17 Apr 2024 15:12:57 +0000
Message-ID: <1d68c21591fa4f8497aea0e6a0afda8b@huawei.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <ee70b82c8268e9a6746486ddcb3e8e7f32f0629f.1712977210.git.nicolinc@nvidia.com>
In-Reply-To: <ee70b82c8268e9a6746486ddcb3e8e7f32f0629f.1712977210.git.nicolinc@nvidia.com>
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 13, 2024 4:44 AM
> To: will@kernel.org; robin.murphy@arm.com
> Cc: joro@8bytes.org; jgg@nvidia.com; thierry.reding@gmail.com;
> vdumpa@nvidia.com; jonathanh@nvidia.com; linux-kernel@vger.kernel.org;
> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> tegra@vger.kernel.org
> Subject: [PATCH v5 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
> VINTF
>=20
> When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
> only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
> add a new helper to scan the input cmds to make sure every single command
> is supported when selecting a queue.
>=20
> Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
> guest kernel driver writing it or not, i.e. the hypervisor running in the
> host OS should wire this bit to zero when trapping a write access to this
> VINTF_CONFIG register from a guest kernel.

Just curious, suppose there is a malicious guest with a compromised kernel=
=20
which bypasses the HYP_OWN bit check and issues other commands, does
the hardware has the capability to detect it and not make the host unstable
in any way?

Thanks,
Shameer

>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  7 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++-
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++++++-
>  3 files changed, 49 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ba7a933c1efb..9af6659ea488 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -352,10 +352,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd,
> struct arm_smmu_cmdq_ent *ent)
>  	return 0;
>  }
>=20
> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct
> arm_smmu_device *smmu)
> +static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct
> arm_smmu_device *smmu,
> +					       u64 *cmds, int n)
>  {
>  	if (smmu->tegra241_cmdqv)
> -		return tegra241_cmdqv_get_cmdq(smmu);
> +		return tegra241_cmdqv_get_cmdq(smmu, cmds, n);
>=20
>  	return &smmu->cmdq;
>  }
> @@ -765,7 +766,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct
> arm_smmu_device *smmu,
>  	u32 prod;
>  	unsigned long flags;
>  	bool owner;
> -	struct arm_smmu_cmdq *cmdq =3D arm_smmu_get_cmdq(smmu);
> +	struct arm_smmu_cmdq *cmdq =3D arm_smmu_get_cmdq(smmu, cmds,
> n);
>  	struct arm_smmu_ll_queue llq, head;
>  	int ret =3D 0;
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 5b8e463c28eb..fdc3d570cf43 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -836,7 +836,8 @@ static inline void
> arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
>  struct tegra241_cmdqv *
>  tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id);
>  int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
> -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct
> arm_smmu_device *smmu);
> +struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct
> arm_smmu_device *smmu,
> +					      u64 *cmds, int n);
>  #else /* CONFIG_TEGRA241_CMDQV */
>  static inline struct tegra241_cmdqv *
>  tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu, int id)
> @@ -850,7 +851,7 @@ static inline int tegra241_cmdqv_device_reset(struct
> arm_smmu_device *smmu)
>  }
>=20
>  static inline struct arm_smmu_cmdq *
> -tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u64 *cmds, int
> n)
>  {
>  	return NULL;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 15683123a4ce..7aeaf810980c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -262,6 +262,7 @@ struct tegra241_vcmdq {
>   * struct tegra241_vintf - Virtual Interface
>   * @idx: Global index in the CMDQV HW
>   * @enabled: Enabled or not
> + * @hyp_own: Owned by hypervisor (in-kernel)
>   * @error: Status error or not
>   * @cmdqv: CMDQV HW pointer
>   * @vcmdqs: List of VCMDQ pointers
> @@ -271,6 +272,7 @@ struct tegra241_vintf {
>  	u16 idx;
>=20
>  	bool enabled;
> +	bool hyp_own;
>  	atomic_t error;	/* Race between interrupts and get_cmdq() */
>=20
>  	struct tegra241_cmdqv *cmdqv;
> @@ -369,7 +371,32 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void
> *devid)
>  	return IRQ_HANDLED;
>  }
>=20
> -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct
> arm_smmu_device *smmu)
> +static bool tegra241_vintf_support_cmds(struct tegra241_vintf *vintf,
> +					u64 *cmds, int n)
> +{
> +	int i;
> +
> +	/* VINTF owned by hypervisor can execute any command */
> +	if (vintf->hyp_own)
> +		return true;
> +
> +	/* Guest-owned VINTF must Check against the list of supported CMDs
> */
> +	for (i =3D 0; i < n; i++) {
> +		switch (FIELD_GET(CMDQ_0_OP, cmds[i *
> CMDQ_ENT_DWORDS])) {
> +		case CMDQ_OP_TLBI_NH_ASID:
> +		case CMDQ_OP_TLBI_NH_VA:
> +		case CMDQ_OP_ATC_INV:
> +			continue;
> +		default:
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct
> arm_smmu_device *smmu,
> +					      u64 *cmds, int n)
>  {
>  	struct tegra241_cmdqv *cmdqv =3D smmu->tegra241_cmdqv;
>  	struct tegra241_vintf *vintf =3D cmdqv->vintfs[0];
> @@ -386,6 +413,10 @@ struct arm_smmu_cmdq
> *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
>  	if (atomic_read(&vintf->error))
>  		return &smmu->cmdq;
>=20
> +	/* Unsupported CMDs go for smmu->cmdq pathway */
> +	if (!tegra241_vintf_support_cmds(vintf, cmds, n))
> +		return &smmu->cmdq;
> +
>  	/*
>  	 * Select a vcmdq to use. Here we use a temporal solution to
>  	 * balance out traffic on cmdq issuing: each cmdq has its own
> @@ -575,6 +606,11 @@ int tegra241_cmdqv_device_reset(struct
> arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>=20
> +	/*
> +	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
> +	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
> +	 * set of supported commands, by following the HW design.
> +	 */
>  	regval =3D FIELD_PREP(VINTF_HYP_OWN, 1);
>  	vintf_writel(regval, CONFIG);
>=20
> @@ -582,6 +618,11 @@ int tegra241_cmdqv_device_reset(struct
> arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>=20
> +	/*
> +	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
> +	 * kernel, so read it back from HW to ensure that reflects in hyp_own
> +	 */
> +	vintf->hyp_own =3D !!(VINTF_HYP_OWN & vintf_readl(CONFIG));
>  	vintf->enabled =3D !!(VINTF_ENABLED & vintf_readl(STATUS));
>  	atomic_set(&vintf->error,
>  		   !!FIELD_GET(VINTF_STATUS, vintf_readl(STATUS)));
> --
> 2.43.0
>=20


