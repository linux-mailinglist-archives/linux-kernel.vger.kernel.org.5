Return-Path: <linux-kernel+bounces-74190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E857585D0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DA01C227D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02F3A292;
	Wed, 21 Feb 2024 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7CooUI5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4753A1D3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499373; cv=fail; b=oRn8VH6mkij87zDOzvF3iYtmTEJgP0Fu1gbZMocJGtyRLmDOauTZ4SVWFraWW6AF7uyh9ILP3Ju1JSl8dGbDDmYshnkSF83YKOzQDwchzLTqQXHpBVAsCUD0bxtyBAwqypLe3hxzoXDt/qtQ8PcDYvpcgUKhcJg6glBDhc/jph0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499373; c=relaxed/simple;
	bh=cFchp/XLA40DbS/kmr+s1j9r+qk+xKAMihPVWZxEZvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tHpyhVyKwdZymu6BUfTHz0Q34NilTqrUsIQGF230oUl+Gu0Ujz7N5NTgRqVoN6qbFxma8QRyHWNg+Hpg3jUEVpCpjqH+OVTt+akY5Ug4mwLxDzdvtYV2ynDNBkxU4it1zOv0ilG4UALVpPJbujpcjcBr9wqfKOzKtoLYaU4WTgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7CooUI5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708499372; x=1740035372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cFchp/XLA40DbS/kmr+s1j9r+qk+xKAMihPVWZxEZvU=;
  b=Y7CooUI5fRjSREZapZZCQffJDWL+js+ojtoiwBR6PJt5iqyZd046/BuG
   ABttJw2Pcz9G8UR7WD63ILp2NqjuhrZ8WzVoyOUe7k/681eAyn2vow46E
   pQy2Zk0TsykXYq1dZpAPQXaGWofxZ0WJ5d16wO0UafoeWNfeoM0FMpFEn
   v/EaMELSEAFT66cqyAOq+kkxPikv5CRkN2+rnQT64lDm9z9LRyYei3yD+
   EnPRnGIFjPxymkHAKEQeMcqMqUtpfV/n8HvT535PC5FtYn7e1O5wiW3tQ
   4PzyR7kGmPuBbJRRajssV/W13MyG3yJoF+3dU5o6NnGiZ0WCmjc+aos29
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2781522"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2781522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5188864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:09:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:09:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:09:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:09:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY35VmDHLKnQCvL54r95Vn9xuBP8Ojl0IOwDRJhVpN8d2N5FOxgfL5jSWn20t4RgNZ4NQ2Uih4nUihTH6Wd4DrUZb5RRSbFCvVbVgyfu/XdqMmjg6vX9v1+AOU2FT/tP9QN4cg/3mdBYYKJSw+EXfTZ4p/QBYKUt4guSEx/GUcMIPZqwNe8LUQ6IlWRpvaGLHwUIa6Z41Ha+Xcdf9ILLPTIpf+r24JdENFSdzz9QXQC1Qjp8C44xJ/ygLsSAXM9VdcDUNJiYZW9owqVuxIe/oIS0Lkgy5H/UIm8IS17kjPdZBR+VzTdRYCpi5Mh9nqfAPoy5X1r6tgHeU1awA8zeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKUD2xYZ/U8PLMevpkdJGWeuYjurLaivh+U1F7QRl9k=;
 b=BcC3OcCkA3smxQpZ8cAVGu2xNmaLt6lURd/zLpV82IZdPM5VG8wpHnOSsZMaf5zV/YyVuE851klk3pq+FOhSYfqut1iapghlOr8B/jtuA4hvZwhTF2XCz6I+6nbWlnEZmaPyaGPIFftBe9cQZdCrn9afJOU2UZy9ejIeneDnUr4NqS/Lu3EEXBQif6v0sL/YYCkzbWZP+J5c8UHOsJty2BBZmF8qktGOJauc/kswy1Mf8+UwZ2AIuKIoxV1Uep2gs6FxOrVfCdEGndiMMvuNAH4w/ePdgRO4hVhmNq5nNO4UvfbnzxUFtqfusDqHJyQofexlrFHf4o5ouMlfkbYhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 21 Feb
 2024 07:09:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:09:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Thread-Topic: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Thread-Index: AQHaZI3ars2WxaUdb0ObfriZ3G40C7EUX32A
Date: Wed, 21 Feb 2024 07:09:24 +0000
Message-ID: <BN9PR11MB52763F2A7B45747622C9B17D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240221061832.430-1-zhangfei.gao@linaro.org>
In-Reply-To: <20240221061832.430-1-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7618:EE_
x-ms-office365-filtering-correlation-id: ea638d2c-b577-42a3-d108-08dc32ac0901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTbO55kS4ndKngMIob++EdF+qUVmUU03Pd0UJCA5dSbsMUHf3DIbjIkfnNiiOr8EqxscOVXWogzA5G6i/cIz2aOcam2mJfWGhiO1/uLFPoBLaoShrixW50EEMK6bE2YkJ5//7XoJ3GZl4ZY+H9OnEnR8aJ6u0YkwdH5HWIjsXjYnXIRBzidMXwaECxq+z0iCiqOrKgJy0ayUFi3/+RoFYRe4vhmuOD4tTzA7uIk2wu8ViRODxjcGa0QxAujMgIPAbzb8dpFUMkQpXB0NgPl/vEWrRSRpglq/dmRxcnGZRfnUZ7aE6T9ox1PWVcfU4ZhHCOk5L6EiDHIcnKw3XlsVl806ysioSkeiPBF614VkfobHw2NKcLh2SscXiqq9BLqRSAexqHBACzWKb00RLlc4jvVXoGZMOGtA2xRj8CZAnwY50TxkJKkLiCIYUusY3TYiGL8R3ARzzLCjjAHMHIVNtyZExU/h3IPrQ2LJu5Dh/epI2VvXesftBokazbIB+yMSbwTUjuNej3oQ9QbK4qn2jd4UTymz9dDuAnT57MQJY3a7ItdnjVNEbOG3fON40tICQzJxq//rDUQuTH/NBx15WoxWv878iaYttD8bsM79iM9J8d4QyM81OI4TvP5ehHy2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UGSq3KDjqROum/e2u1TKMjdPh6/pkESm7yLlQi4DyL62EU5q6627l+Vpv3Of?=
 =?us-ascii?Q?LjxScFjL2grzJWwCEVFyDnS1uk41UZPV69NjbRqz1bzTUb9CoZom/tmhWk4C?=
 =?us-ascii?Q?TQN3nhE4Le11JLhl0djQMD8kwB2f/wr8dzjDZVeXCbXPSH4dJNfIjYcqJ/VP?=
 =?us-ascii?Q?gXKKeX/6/nO4MFBcIte1zQTCwNjIhfQmNS9MdqedohuSCnqUpX6iMHYpIm2d?=
 =?us-ascii?Q?xJyrN+O6KjseCtcmhdrl/J3omzj9/c5iwXX0nd7pCVquUMDa6II9MqgPIm2I?=
 =?us-ascii?Q?z/q1FJN6ECG7nT2R6/Yag5WFAiNctBrjVKSJ1UWXvlFVpfLBeku98AfFrjE1?=
 =?us-ascii?Q?j8BeqVUF9ii1tA2Q8pqTGB4g39vaIvxkkFMJoYSnXflxFZIME3wFOi3AbAjP?=
 =?us-ascii?Q?Yx+SxtTDfS1fNiYyRKsY7e1huoUxQx2VnSfI972Ub28aydzv6yabSUPkv/Nl?=
 =?us-ascii?Q?vFWhfw6DPlJ9aE7KkLCtW6fDvmVl3HQGp6M3hZl8xih0bkS0635t5aD/rMog?=
 =?us-ascii?Q?hf5l+x+ASUVccUqCDmcAXAeMBRRotyKecdRGkeYbeCIn/1o3W9jPkqZZVnUZ?=
 =?us-ascii?Q?mPZbyA6fsg9sLFBWI9n6sU7yD08ycGMLk59kl+eqCsSuiCI5VZYwsBwRgpwR?=
 =?us-ascii?Q?Wgc3UW2orlVYkUcOjbLzEmcTO3UZ0D4H9ItXo58ENYriFTXjgEiUOLK4Wh+0?=
 =?us-ascii?Q?IyRLznQ2wHrXpcQwVq1WTqXEyTGyt3pQ07iIygtQISTpMg1+64X3gUQnkNy0?=
 =?us-ascii?Q?+MlX/80f8SzbO03L+lvWH0Z9GQAFrFAsykFxIpzF0xjVuFW8Ze24qSmxVbr1?=
 =?us-ascii?Q?g/0SeMsaJoNeRV5XrQNLHwqXlZ4pZSG9H3oYzJezbP7NxN7xDMlOHcqWePu+?=
 =?us-ascii?Q?zWFQYd5pVGLu++5dRRHPm58nLjpDYopfooMctN1lB9w5Njdi17TPsVkxxIlY?=
 =?us-ascii?Q?PcbZyqLZaX/aRXNEaslSeUgl/WwIiGidlYGoczPuupn8aSVQNe18qqEgvQdl?=
 =?us-ascii?Q?hfIh51a7P1LXbUJduiRagYnkAKqvxDsmSGPzuZC7U1fo5krBzf+pNnHYa+bx?=
 =?us-ascii?Q?5p+4+OXHO+92dtd7o0ouzSA8As8Exjq2Bsvga+cBMPz4RQEGd1JflfHEZbik?=
 =?us-ascii?Q?3zM7asTJxH8V1IZH2PIwAVNffwbyP+J+B3LRQKMd/oEMuVHT55drdVBrlfA0?=
 =?us-ascii?Q?/kUZXwRRCyagwn66hGgSRB1AL1JFfDyE6kCPp2YozB8yuQz+Bamdp+DG5Iyu?=
 =?us-ascii?Q?PtD7OmrhP/PbOBSmmFj+ISm2wk+qCXKSPAonYPntO4EPUHqrqL6B+3a23L1v?=
 =?us-ascii?Q?D5gqzhhjKi4T6LwfQg51yHdhA1/1cPfzpYnZx+1FyUcbtpWximlVe49Avv9T?=
 =?us-ascii?Q?ewAF3AkOkdmYiik0vveYVDXjzFW8rakThNcZQp0/K/sRQY+xZMLZHhwQR58S?=
 =?us-ascii?Q?NE53kjYfNXHQ81FJrkjTOb4yVDVtK8MaA6Ue96X+iUbabbhIppzXxTd5rQjB?=
 =?us-ascii?Q?HXrNisvIxHgdjOD4yDRvdOKLNZL+h+rCwI64UTkJafHkzM6j6cxtBwAHt0yn?=
 =?us-ascii?Q?7bBPvRm0dLlvoHWyUh2N3q7L081VPuJ0Kyqu3NGo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea638d2c-b577-42a3-d108-08dc32ac0901
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:09:24.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7KWig2NOJHHiWqEF94goXmKiKMdil5/bWMWhPqYGZh5OZp6xAfIH8p/hFliEBKx5DgesFyuSQ4pMDrT1JDySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
X-OriginatorOrg: intel.com

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Sent: Wednesday, February 21, 2024 2:19 PM
>=20
> The accelerator dev can provide multi-queue and bind to
> the same domain in multi-thread for better performance,
> and domain refcount takes care of it.
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
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c3fc9201d0be..a95c8f3a5407 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> device *dev, struct mm_struct *mm
>  	/* Search for an existing domain. */
>  	list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> next) {
>  		ret =3D iommu_attach_device_pasid(domain, dev, iommu_mm-
> >pasid);
> -		if (!ret) {
> +		if (!ret || ret =3D=3D -EBUSY) {
>  			domain->users++;
>  			goto out;

-EBUSY is not a right indicator for reuse.

It may simply indicate that the pasid has been used for other purposes
e.g. attached to a domain different from what the caller expects here.

