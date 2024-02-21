Return-Path: <linux-kernel+bounces-74275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AB85D1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4852876F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBC3B295;
	Wed, 21 Feb 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdTrGBx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACA3B287
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502352; cv=fail; b=NKlq28N5mFl4U4JSX3ou+O7Edmv8fh+MVDxpDgFLJ42KIHdKU8amXy9V5b2w+zhOrhY5U1E7npqy+rrNJREz1lF1blW5cCj0wCTXyeq2H7T7YKzLQlMy8RBJ7mlfTV+0PgLhHrd60CkpPnvtA5M+17YOmGM/pJ8gf5y1QGe5cpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502352; c=relaxed/simple;
	bh=ywleXiIQZ6NF1En/lkSouL636P8b75wox8KWwrL5YtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XkEmC1BsZtq0pCuslZr8Mx2jKlSy25JEZWO99y0tLfB89rhtKxJRAoz9e8pa+fYYpRTPGkasgNGbkO6TdbA+7L+Nb5whhXvOrQuXEtAYLgTja8oRZRKMLbsNwf3igdDo0p3aSzyakWAJgTRm8ZhaJ45/JEWa7ZZ76Jdi195MKWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdTrGBx8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708502350; x=1740038350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywleXiIQZ6NF1En/lkSouL636P8b75wox8KWwrL5YtU=;
  b=VdTrGBx8bn1d+bMdIt7zjknt+HRuRSW96pIFHs8v4TRnoze6/m0h6F5W
   3U+4edDgCM50rujrjSlwFs2m++QQQicMjMypt1Q5etsz2HJs50ei9/0Pz
   DHVLZVaGII5todABIO9x/eE7OhhFaT9S4Ob7QtQDeYQf5PiKT7LcdOXm+
   qqVxFeaZ1KJuZOIwuItVzPwh8xxly5myPdd4dbMov/XUWmhPFkyDDE96z
   wV33R/TbILg+UjwGh6SP5G17fkSDC4mmi9A7WaXJsQ1kf6T0oo4D3igCq
   AbIeRYcBmwD0zDlSkRdQZOGt8quGEXvJd1uCKurHW4LBePi9z/1ktlK4g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2534260"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2534260"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5019718"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:59:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:59:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:59:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMOJvinj5fwEP5Zqwp+4Uxrkyuqn9R8quz+voxdu+mOAp+o2Y1yL9fxCOTAKV7poxzJhMTtNlAmCLB7/9xZdtv7rtuyruR/eYpFIzV04etxImuo7HzpR/BOaL/pDkKDpEpdWy4ukCdcy21ae+QSDMQ1SNoOUiX8feeTglIBUsy9gzFiyIpBYp+4sqR7GyqtGTtLJ93+uM6PBHZCbnqDSRgp5RtJ0CEsAE5aWM3ALHH5O37bbqcqJThMyKd/L8vLEf0/Ej5lFMH1pLnyU2GPvskKe0/lb97RQAZ93Xcd3RduzQA25a4R+dsqa6nGS4kqzM2pTpiJX5jLQoGHu8Q+JKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUifzW8XAW0I7/KJquzdqkDN6e76033obJd2jgL7hWQ=;
 b=LbGtDlx7AWRkRDdgpiBcujHpVs2NwK60v8zkzfAC5gwttcA5HTh4jsvphIPd6JlwB/0SL6Z0fpfwxZUTsR3C6pnbsEzal4CyF7VsxgcI9sc5fJmTltI1/5hFuQgDABaWCr9wveOQ7WYkhXsn4s38ZhwFwoIor1pBoJvlm4dayjtcEEaNYbzO5HDixkf7eEJNTIrDl/bfvOR7I0TIf9UNFNYK3ff983btMkpojfEXQ1RcneOFiEWEW368g4EQF2kDVoI2ELfsxHbknyDp4H9vlqbCKjyR+s+lGvFWfD0LhFLPxXeIW5/EfZy58IqljEdxj5uJhH1RvlIpQHONzpA5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 07:59:07 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:59:06 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Thread-Topic: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Thread-Index: AQHaZI3Wtb0WdVGjR0SZSXyMH/XcCLEUanmw
Date: Wed, 21 Feb 2024 07:59:06 +0000
Message-ID: <MW5PR11MB5881E20A89840306C977F3FA89572@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240221061832.430-1-zhangfei.gao@linaro.org>
In-Reply-To: <20240221061832.430-1-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: a70eb863-f1c0-49fb-a0d6-08dc32b2fa93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvyxgTrDrs9cOyyt0vX4EmbF1kRfAGUUdNyTqwTqgo3yxu9C/y5PSKvkke1Wra0PN1Brk9oPsK5+bsKtRVkCsbHWDueGJHh5nMdOX9sesjWGKS0iHnzZjHRaDEh8Am2HBP/Q1kCLxLPRA8dBPpvUO4yRJRnNnoIw4VIzbwBJtdDAuLhD+aSm5MP73HSYeMlR9Gd81ZobnuYxs3DxJWjGE8lCw7z9T1IpE6gRR6dTHkWoiqdhz8RQR7Eta6CMfPUamMrXFNpmKFTvoF5GBxGdaJRuMS3/alN8XwrIQRa9Kprm8EUgJoooA/5CMZ1yV/E0i96Dpyp02mUQBg9kcvNi6IHhKO0pxNRQDhs5clcGykVq9s64U5DVKXdfTkMt3cOj7aftqWHC2Od8sv7DGph5ikD4VLwb1AH1UAZHLMxG9G6hV5OFLF+B5e4JDLTKzKf3SwhbtFKVQAr/O0tCszLMRdjh/YmFnr4P7QL/J9wr966zdrPjCCsqm4/QKphCh6p4hYQAofAUD0iIXnHFTLTXdKCbg5tnntf74R3U+8XSbQPEQB2KRlsBa/iWPRtrMZqt2amf+VoRwvMgSxz4yMk6WbaugfGz3FpHFKrBd6XObsaBh/VHqwusNCLjWKU817tJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oh1lwck0TdLgHj5+f13gbPcruBEgflIMZ3Z1kTTn7Cew4cs+9OJiTJGybNvN?=
 =?us-ascii?Q?2pQEqmufCmRB7COOD7j2UpvpAxSxnephCqc5ZnaJdepib0VzoL1+Dq6spWL8?=
 =?us-ascii?Q?JrjIK/CTpApi/P5s7NqAh+YmnEI6x/C4eC+G7qb95PaGhpNjosvQRD5shnB0?=
 =?us-ascii?Q?ampBPlKh0NEXi2F6ipVxhFFfXVGloXSTYvg4vfC6ayAJ7JDW0yp7yDmziVZK?=
 =?us-ascii?Q?8l+LALvbO7n6Am6d/H5j1j7z+w6ost9oDxr7mIApBWJzgQTtS8LBGKVEiuNi?=
 =?us-ascii?Q?CmwakIAZnnXkbKinhUzaB0wTYZVH58+SxGl1585fI5wJd7lALem0OCjxFCdT?=
 =?us-ascii?Q?5W2uvQENUCPHEeZM8I+IHL+g5YqRRXg49agLbBQCQMCG6D9tgqeypSSKbKT4?=
 =?us-ascii?Q?FplR2RtdnzEb4FXoZhS0N6G8VuRHxYL9JbNfeyeg6WX2CdnQj92DLrQB9gwE?=
 =?us-ascii?Q?kr4Ge4goK2aoi9wb0Gg2WvqqKrUPid8Woxqp3TAoboUVqtMyKHcMiwQ8BXZT?=
 =?us-ascii?Q?qr8p/Z4GtugwZ30tk2w+SQLq1S3Te0rDrCa62RdXJ0o/Trg4kXEs7LbNdqOi?=
 =?us-ascii?Q?KqnQwUxI5ijqMlIlbsCR+shiM5MOSjoOvUgTdqPC3YxUZWzQ4s5hqoxm6xkt?=
 =?us-ascii?Q?PVt5wqfv+rSmxjWLAfl3nQmf1wj1VSlres0X2aTTwcHUZ5Llm6oIW4ppUpeL?=
 =?us-ascii?Q?vk6PMOQqYZbGheMS9tmZMyRiaq0710up843dbbGdEV9BtwPjwbzwogQy260I?=
 =?us-ascii?Q?gj8lDftU1ww3aFWVnuB8KPXY0+K0xWo4wfavLKAqorXAIctNPHRWOCAbxXVY?=
 =?us-ascii?Q?tsTEq/rM7rjXWABNhPybbA5Jx/1W++S38kUZX9mPq2O/7um+Zw8t6umLZNB5?=
 =?us-ascii?Q?ElPMoZ0Gbrpw2TnrDIbpDKeMDcxm9Xx9mL1q7fgcxFcGxTXOt+QYyL4GefuN?=
 =?us-ascii?Q?JvyNC4nViQO2P0aR36glPwPAXZXnJcLqJ02ZL+FxAkoBEEP2aS5kX+H5G6NK?=
 =?us-ascii?Q?nqd9aq47iKKdfhi8DCZBnPJT4onlscMx8NLbjCv//SU9okHv2lIFYpZdO1Qg?=
 =?us-ascii?Q?CfcvjdyeCgSMcj6verNV3vJR9IIE9jzLcB2SdC83e7WnAdlbeDpT/i618adh?=
 =?us-ascii?Q?YH7OnIqh6GJ50y9k+8sxhs0ywZhB7ft6ZfKrw6PCDfl62VKV7068wyaGdwLW?=
 =?us-ascii?Q?tGb32SiMgMYxDalScaJf/D3Scfstxqu7KQLjDVQzI8uNjWK/Y00mi8v1KLBX?=
 =?us-ascii?Q?K6TM6K32V/23LblNPmrwNpAbXB1L00roNi4IeRmnH0e0uDJSJ1MS0dY7LeVT?=
 =?us-ascii?Q?mnFMeBll9ZKSCrh3xp3xfWOskxQx6HeyuAOFRkpB+IP7oM4TypTfPzvrqKQj?=
 =?us-ascii?Q?2wy4gaY4XCwifw5f9rQ8xc/xCVGcoIDSfMfVx7VpA6CPke7ZvWHLC0y0m+Zc?=
 =?us-ascii?Q?XGhdePK2rj2BudHVvbSZwS7dJL5t5LiU0GYpexOwyIR+fx4hvHtKcg/RTVGi?=
 =?us-ascii?Q?jAK24f0ZGnd92FtiyTs0OsjxSeZQJyB4Vn8m9sSDwgJO8LQYwopHkGzoOJ96?=
 =?us-ascii?Q?QCZNKMd9ACuRg793gk0m/GfwsqisYvcV7e3Nra0T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70eb863-f1c0-49fb-a0d6-08dc32b2fa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:59:06.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65zDTLnPWPFAk8gKm9strl3AX1AZ8hEzg6V5qI3UYNhO05eDCAzYF6TZaN2RFEbuBz5GTVxxd+W6IlAORNYoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

Hi,

> -----Original Message-----
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Sent: Wednesday, February 21, 2024 2:19 PM
> To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; jean-
> philippe <jean-philippe@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
> baolu.lu@linux.intel.com; Zhang, Tina <tina.zhang@intel.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Zhangfei Gao
> <zhangfei.gao@linaro.org>
> Subject: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
>=20
> The accelerator dev can provide multi-queue and bind to the same domain i=
n
> multi-thread for better performance, and domain refcount takes care of it=
.
>=20
> 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> removes the possibility, so fix it
>=20
> Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/iommu/iommu-sva.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c index
> c3fc9201d0be..a95c8f3a5407 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> device *dev, struct mm_struct *mm
>  	/* Search for an existing domain. */
>  	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> {
>  		ret =3D iommu_attach_device_pasid(domain, dev, iommu_mm-
> >pasid);
> -		if (!ret) {
> +		if (!ret || ret =3D=3D -EBUSY) {
If rebinding is allowed, how could IOMMU core know if this invocation is in=
tended (like the multi-thread case mentioned in the commit message) or is m=
istakenly invoked?

Thanks,
-Tina

>  			domain->users++;
>  			goto out;
>  		}
> @@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva
> *handle)
>  	struct device *dev =3D handle->dev;
>=20
>  	mutex_lock(&iommu_sva_lock);
> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>  	if (--domain->users =3D=3D 0) {
> +		iommu_detach_device_pasid(domain, dev, iommu_mm-
> >pasid);
>  		list_del(&domain->next);
>  		iommu_domain_free(domain);
>  	}
> --
> 2.34.1


