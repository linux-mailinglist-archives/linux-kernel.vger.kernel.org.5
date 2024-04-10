Return-Path: <linux-kernel+bounces-139548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274278A0439
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0136283DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAC405E6;
	Wed, 10 Apr 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaXMTh5U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B1C132
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792948; cv=fail; b=BCw6Fgza8wEDaTFTqjdaM3ze3iLQcEqDIffp66IoaluxnyhB8QUiSDs15lX6eNSG2xMUwFzu0I7WIYOmG2Hi3fr2bZ48jFu5eDI6cUydYssn025eXrowfwD05qeQsh98g/6QtAi7fKX21c0niCWBx5/2Cexfm6vIMta2V59G1Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792948; c=relaxed/simple;
	bh=yXly10r0nUNWUS/Z+As9O/1RWJyRqxavbG1X2uoJI3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pde6+PRKLmeOWeMxiIITim+fOoHmrywlxKt9UpeK9HcJGncFND40nnfl9zEFxa/kSDD3NDUvKCNcxN44sPmkO23M7bX2Nl+lrpJK82HFq85Ji52HbIj/0dMHjRrXAR5x2LaMk5ddUTIfo01vucRXtNw9SYGxjX/toX2u5TRIlvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaXMTh5U; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712792947; x=1744328947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yXly10r0nUNWUS/Z+As9O/1RWJyRqxavbG1X2uoJI3Q=;
  b=gaXMTh5U19ApkqFBLtOunRuSHl8jYblPt0L3S6fqjm7acosfGVVGWEHz
   YTx7bBAQwCGJxESPa82QevAk4rd7EvvqWImiL10BHCrE4LYTy8k5ymasw
   EyjkczhOG1l4/B36FTwMRZHFujgatOcG6YbLhAp8tmgg5xbCRAWCdrx9n
   TmXg82gkjuGVcxGDm9DtCElYJOr6UpWYLufKxGG8BdN2oCuSO1rsSdXkI
   boSRjGvqFs9Ze8d7J0xLjA7W6v7JttW5WsxTJBSNthcabkC2jlLUDKIT+
   XzURdKpUQ7MVaX/fBMCfchMoeB4nz4HoBQtkos3zFVsiodH1G/n3j4f9J
   w==;
X-CSE-ConnectionGUID: E3eLnDxATt+e1TRoVrWOyw==
X-CSE-MsgGUID: 16Oe6Hd9QXCtsqZAwx+xWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19336973"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19336973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:49:07 -0700
X-CSE-ConnectionGUID: wHvg6/AgQtC3eAwtxFj9GA==
X-CSE-MsgGUID: YEh3WqsoSc2MZrhOP/hdYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21319565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 16:49:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 16:49:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 16:49:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 16:49:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHCvHyw5rD7l4zIYTCd+WZ6+90vMx+aTe5TGl1z6+vq11XyQ0q5aTrp1KOi4055KpMlJRzJuHdzkKMXjrbOGym94Ijh5fzDlakp1VI22ifbHFiopmhMaXEg2IKWshEHOudFEu4gvVDhVOKkgfaJZicwEqVhriaCXi01q6egivJZUvyBGnSRPrqf2DgTo+eQypH3/bqYqAPislBbuX4wQEBiaTCMIKTEoOwGKsl6PATD3vP8o3Y8VlSvdbaBIuV5sgNYC2za29KGBoVr4CX2jYwd3unseumSFcHmUh0QFtd/OaCJ094t3EWx/6LhI+n4AqrUSJifXFuQhu3Rm+dsUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19QM9DHlZ0FliyoICRu0wU0T56/S647YvKXT4zoQ8ts=;
 b=RF54JT/osQrOYoUV65jpwBqymMyTjzLRtpL/GKOQpcuJ3EgFAZZpKtDMhx7iOVlmmTw04rVI3imCx91QjMokKyzrCOOOs0zTaYEwIZGhTMVFaWN/hpu2g/asOaUtF/KG/ykWEgBb2beL8n07lHcUAnIFja53Dfd2VInIZy+W53EpBgpcWGXgHpMM3qtYzZjRcsJNZbUxgk8Thtb89Sd2LeIBr4J/BPWe5ezCN5XtsYG+Ss9YW98NJNW2zzAuVHLJzJXttcqHQqMff5Prr8EUv7ioLPkNMGqprHWTdQ13Kkm2ChxKWVsbNHwbORzNST7SZPkEfwM2I4DX4HV6Kw1SKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 23:49:01 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 23:49:01 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Topic: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Index: AQHaiPoE+7Nf+/opPEuKjHtgvnvXxLFfjZQAgAKh7bA=
Date: Wed, 10 Apr 2024 23:49:01 +0000
Message-ID: <MW5PR11MB5881E15977B2987AE32510B289062@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|PH0PR11MB5109:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogPaoqQqese9GIZXvHuwY/TALqRXm/A322CTG/1ktW7QTm3ox1yoYyyokSkpFUj5g0GdnmNtT4umoQ2TSqu4vJI4J8ElflqL8dLq6WokNbbUNDez0khgyfPY6FYiyFk0KAbnm1EQ54+hwpCGbeVoi9pZ7IFSlVjdAldvIwHUD2sIYI35eUCs5+/NKadw0h2ISOVllsx69bde/sww4OYerJwpCAQtzLQJXcaUB7cbTiqZDfM1A7+/nVLPdr/lSncRpMmrXYY2eJIR50p0qevDQNWPRjmXJb/5A0J54Ok2NA73xOPzH96ZU304yGGzsAjrh+/XCkGbWoKeieENf/NtHFtpHzKzCBJspiRtRQM3bw5KJDa1AC3/dN+O9D3PDFpk8Rtz/u6tm2+NGtiUY0ZYrkeUOVAj94g7bfTH5YfvtPGx5cB9PAFYA7x35wg+jc0c145PtZU3UERxc5ARiaCZF0K9nEYvv0P2OeewI65ws0Ntuw2zAGYDf5sZNI64qFSNt5QX5bGllf5k3FGLWQSUoXGq2u0jfmzA/V1elwWjeYW5+fyn3e85kq5RcMvvbAGBkWqynC/kHIQ4W7gODeopEtYXOw7WxkdDh5tu7QzQiDF0ij9YonTEh2jNDjqi58SV2wsLU4n+bWPz87fjDvuf8X0IRHmWb3s8GyGNBS6kEBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cYxmSKQuIK/UIur7e09ITmcn6rbAaUvZQ5LijVvy5y39uwMxBBeQo9X9wc3Z?=
 =?us-ascii?Q?nNjDhmZ5qkYzXWGHmnjOy3Xg+wF2o8E6rA8SMvwK1jp3b5hOBqULVzj8aiyC?=
 =?us-ascii?Q?Zfc3KtWyc/g1Fh11Xf3Q561zHOiC15RiLBMB7kmY43pZvhzgMaWnGgnIQqaR?=
 =?us-ascii?Q?X8KtX9SWdZ36G6ojJ7CuTW0TKaGvY2cFuerqKdwxgBcKsi1yqlE8qgfsbUSB?=
 =?us-ascii?Q?KhwueYnD++ye1G8JzkDnTOkug7l3nZynO+wveXMPPZb3+MwIVQ4nuEXnMkpC?=
 =?us-ascii?Q?CYGRf/eS/2PNRCmi/9JuSedj9sRLfO1xYZpGVjJgQLSAs6ui2AJo+KSfJiam?=
 =?us-ascii?Q?zeurHzZilLtU/AO9eFEw+aUh07+bsZ3MnL1yhhdsMifQBTxc5EL8pAQulYrs?=
 =?us-ascii?Q?nI02JygKv1YH4YIWL3X+FGikozr+ANn87Ga9ceNRUeAkNRW3YKJqqOahXjPI?=
 =?us-ascii?Q?Wg00cWVvD5WFlr5lXnRVVYHYjML/1y4oZ+XHEdlkQ7lC7yuAFjzJVuYbcqBJ?=
 =?us-ascii?Q?zpVpmGvPH43BMUnWJZe2c0NGf2mfCYCmScLTmwVRQaFIjICCzlFsMqocx6hf?=
 =?us-ascii?Q?ODrhaLNfHbGs66gLdgSur8CcNIQhiSbk2m82btmJDlRXe7Zas6GmGUK3+D4W?=
 =?us-ascii?Q?WJv0OHzbmpvYBTnThJUalyxaVa4Rsqxd8z8JP8UVXy4/45vMwH+QBD6RWYG+?=
 =?us-ascii?Q?GYBz7eDK+wnTJXcvB7mJkGKtWeAm93zBTx4I2KTroLjZuMxoNdJSZezPcPjp?=
 =?us-ascii?Q?yqzTdOfGgWBXM/EmBBtuNJc2bBUlzPOCtecw0ucY+erJRLLgxER9ERbjG8PA?=
 =?us-ascii?Q?ibinpPmVyBxcZlmO9qQ+PbIqq0eIRnoO7SjELQrsezXdjUCBJ5vQW8JlemzI?=
 =?us-ascii?Q?helfzN21Ag6pJgkpcIgOfX8TYRqa2lcGTxF5DCgba2+By6t/M39d+WqGFFyJ?=
 =?us-ascii?Q?lgtvvjTreKZZS1F/uZxA4G1xBcSfVMXPsdUxQuMEohaHJ6dP45pTdk9w2OIq?=
 =?us-ascii?Q?97Z04VkLXuz0N05uXcrtj2LjhQsLCXYsyi85uWL0PZU562dzKn36h53XpDRl?=
 =?us-ascii?Q?CrPv09DvHlVAIkrXLe6dKzxmFsGsF46TqPl2ocJLKr3peUxzsMnxTIqnoV5F?=
 =?us-ascii?Q?+ib8PjtarlrRajgj12T6fRhLLSXwnKHs8Athx/UTNFscNM0sX23WFH1V9bq5?=
 =?us-ascii?Q?K7LGilVDB0gOAXRv2/Bh8rfVOuz6I9tK5af08jpTZJhRHoANbHJ4PwmSkIYt?=
 =?us-ascii?Q?URneJTGafhNV+c3CQoCVoKL/tT2g9R3xfq3qct0sDnFYcLn98vrZLpdN5BUd?=
 =?us-ascii?Q?2dw2VeeMmQjkEVOZvGoyeztICsyWLytsBe+gGZZvFf0Nyaf+NSThNv6DKDGk?=
 =?us-ascii?Q?TNRgAJBsoHtRPX74LkTG2IDs51SE9OYVHx9+QgHd/ncpWkde25vV4fsMwehk?=
 =?us-ascii?Q?y7BqPS6dK9jF5eDq+LUTiGoOSPXbImQWiq/aJLJ/uSDGVxaRQcpANBYkIvx6?=
 =?us-ascii?Q?r1zVynqOGLYhPvD0cPrZ7Z9Hjox7eNdA/RNq4bckRil1ZcBzfq22J8z2Cmel?=
 =?us-ascii?Q?Ws/3z7RPuyvX7K1pjgTva1TqFRMmZnJG1r7jt31O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbac058-0e04-4a44-7d76-08dc59b8cc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 23:49:01.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efxf4I7+kByok8EQo8YJ8fhknZxC9fd5HeZJrn5o+GLJYPacV+gfyXM+XBu931yH6POFxKM4QZ4lcGj+n4kk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com

Hi,

> -----Original Message-----
> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Tuesday, April 9, 2024 3:30 PM
> To: Lu Baolu <baolu.lu@linux.intel.com>; iommu@lists.linux.dev
> Cc: Liu, Yi L <yi.l.liu@intel.com>; Joerg Roedel <joro@8bytes.org>; Will
> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before
> devtlb flush
>=20
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Sunday, April 7, 2024 10:43 PM
> >
> > The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> > implementation caches not-present or erroneous translation-structure
> > entries except the first-stage translation. The caching mode is
> > unrelated to the device TLB , therefore there is no need to check it
> > before a device TLB invalidation operation.
> >
> > Before the scalable mode is introduced, caching mode is treated as an
> > indication that the driver is running in a VM guest. This is just a
> > software contract as shadow page table is the only way to implement a
> > virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
> > the scalable mode is introduced, this doesn't stand for anymore, as
> > caching mode is not relevant for the first-stage translation. A
> > virtual IOMMU implementation is free to support first-stage
> > translation only with caching mode cleared.
>=20
> I didn't get the connection to the scalable mode.
>=20
> if required we can still use caching mode to imply running as a guest.
> Just need to make sure its implementation conforming to the VT-d spec.
>=20
> >
> > Remove the caching mode check before device TLB invalidation to ensure
> > compatibility with the scalable mode use cases.
> >
> > Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
> > default")
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 493b6a600394..681789b1258d 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
> > intel_iommu *iommu,
> >  	else
> >  		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
> >
> > -	if (!cap_caching_mode(iommu->cap) && !map)
> > +	if (!map)
> >  		iommu_flush_dev_iotlb(domain, addr, mask);
>=20
> as commented earlier better squash this in patch1.
>=20
> >  }
> >
> > @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct
> > iommu_domain *domain)
> >  			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> >  						 DMA_TLB_DSI_FLUSH);
> >
> > -		if (!cap_caching_mode(iommu->cap))
> > -			iommu_flush_dev_iotlb(dmar_domain, 0,
> > MAX_AGAW_PFN_WIDTH);
> > +		iommu_flush_dev_iotlb(dmar_domain, 0,
> > MAX_AGAW_PFN_WIDTH);
> >  	}
> >
>=20
> I'm hesitating to agree with this change. Strictly speaking it's correct.
> but w/o supporting batch invalidation this implies performance drop on
> viommu due to more VM-exits and there may incur user complaints when
> their VMs upgrade to a newer kernel version.
>=20
> So it'd be better to keep this behavior and fix it together with batch
> invalidation support. Anyway none of the viommu implementations today
> (either shadow or nested translation) relies on the correct devtlb behavi=
or
> from the guest otherwise it's already broken.
How about we split this change into a patch. I'm working on the batch inval=
idation patch-set now and I'm happy to include this code change into the ba=
tch invalidation series.

Regards,
-Tina


