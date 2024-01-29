Return-Path: <linux-kernel+bounces-42212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AB83FDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B4A284685
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D945BE8;
	Mon, 29 Jan 2024 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYxPttUT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F24596F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508519; cv=fail; b=b2mOwufsC4WHDzE6YXbxvQB9zVBn6cM3Y1h+ERIjkgmxNF97MNi3aWe3XgFOteaHkOP4HhH/EgYGeTl+ySYFkjFa/E9SQcmmcItPu+4lP+cBo/wH407TH9sAmnPHKrzqzWbBA77mgLuyBBWaLj0gClDFipq2pBVHocqf6GA68so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508519; c=relaxed/simple;
	bh=RWNmcHRusTZ2bqzoRBSkCRJfkWwg2PWWfgEZpB3tQeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyhDTk2XlHzy7ciP4bX2b7XyAnMZOC2Pa7FCKcnyAbgF9OzUOVkjWQY6bpaqfwG+Rded4slDxSzJw8x36pEj2ODDj/eNZybIodF795P7MinEWWRtX37xuU/dqThYq0dTjVUdDy0uDe08XkIZapRPjsFks31L8bF4pJJ3kVoDH60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYxPttUT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706508518; x=1738044518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RWNmcHRusTZ2bqzoRBSkCRJfkWwg2PWWfgEZpB3tQeM=;
  b=OYxPttUTGWEECp7K1O83ZqeyV8B4u7g6NCM0OzshCj4oiuXF8iIi69+S
   6bVJfV72j5Zu/9k9KT5ldqwNRN9/h0w35S7rXgSomxCGnGChQHkucwwZ1
   epThMbH4Xg1CZMXReV9ZNc4UaA/gMeOQghjvTH+Ka5Rf6NnLISF4EofBk
   mxiivFqLW97rkISHzyUVdYbB+607/iRuBoS0v2x/WA3DkiXAwGuSUTiXB
   BYW8Do9B1EtaaC3PnW/7jDVAchrQumJ6xL2MeDSSf1+1szwMWfujQPQYt
   FK/4HAZxJeBhqlh/fzyQmcx3NzFIbA5Nwg+ah8C+S1pddhmVHhbTuGgBp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21389988"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="21389988"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="910946320"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="910946320"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 22:08:36 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 22:08:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 22:08:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 22:08:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 22:08:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnWKrKcN4/oyQhkTmfS6BMS3b3RgoEeagT7gK8tMHM2LHVRvkqgYneSiXOQpTh4vgX8eZmdhGQQkPEE3up5Q8NByx9DhWC0XOYz5NH7ihhbh/nmU4RupE3EXKHRvgwp6ii6aBUzFrbh4H/inS87orriJpiLw34rBzUugj8kDZHxi/k23pOz1aZNW+zxjaefhIcigRQ1DUXLqlDKU3hp5UHdhPwZmyH/wjb6KiNyW1fCgMP2FZeVdxwcP3gdtx+j1y0tVgqCXQw+dBW7117WFgXte9wbQV68mU+iiZ74D+wBirxvta5JNW8VDVhzyTc5xkelTB7vyx6yOAaYuQZqvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWNmcHRusTZ2bqzoRBSkCRJfkWwg2PWWfgEZpB3tQeM=;
 b=VTyGbzg+WTISLrDawaCKrgCRXeb8UR7E+UncZZjwnKNqNyLAKTYd5ofjLnZfOf5nm+jgEHs2wQlQ/e1LE+xyGIkWBRSUo/6iftEuR9eCLhMEUQ2GIA1f8ayl59TCAfC6lqfmax8GVTCeu/IL4TjTGOv+pUs0NXTp0LfnAyCekEFnMAkuV8Ljeu3Jme2N4P6cQiXz/CDg04oTU2XDLlQAPPPbIv+ZZjHvBVeH+Csh/1xpAtzcrQjYzsyRcxBbIZuOFsXWGePepjstS33swGr/7yQ4vWCcclTViUgxjzyP9Mf0IsLCW0VdL7E/XHH4lZ9bWwPsqR1kiea1uO8wjXH1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 06:08:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 06:08:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA
Thread-Index: AQHaUO0r4vtzMl6r2kquUbnxX0Qw4bDwT8uAgAAApaA=
Date: Mon, 29 Jan 2024 06:08:33 +0000
Message-ID: <BN9PR11MB5276D63FAC442A415018ACB58C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240127064512.16744-1-baolu.lu@linux.intel.com>
 <Zbc_mdOYxMIxWAdd@infradead.org>
In-Reply-To: <Zbc_mdOYxMIxWAdd@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7965:EE_
x-ms-office365-filtering-correlation-id: 1747f2af-5fe4-44ca-e8fa-08dc2090b94d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pnkLJiapHBtPnwRE01b1AStPqthk2HUIiLdAqL6ZfHGMSvhd20mWbXGuywO6kcTv84eEg+EzRvFETwLzKXJvxoyGF+wi8k7FITcclmgwnk1xSg9Yk5W/wck2PfGA2h1ag3PSIbaBQO7UxpVOElcHXlxdbu6fO+chHPRGmB4FII+ypHQ7jpwtIjoojTQKX67zn7oc6mkVS6v5abx/w4Yu+cZ2Lsik2K69/AlmAlWXMjbUM5jIqMa8A00JJ22vFsf4sVcBn99QX9g0nT4JBXFfcv3qz8dnGU0SZX0VdvHk5j/7UwniFQ9djl8mUjDs8B6ft9YndXmIxYcze0xgg/nU3x9+3promXvTCDEF4di9YHbh5/MAF61wyI5LbiuJEncYXDwcKyWixwscYmTSVwynK6SkxFGF/mkusLvajQAfP0yMoZ/lJKF9sVfghdqGOpPx/byzFqW8YPZESdXYL09vcHwcwl1RTPT9Z9gDCoWqE70X9H4tgNNO4aqppnykwQNp6m4Aa/JucNTaiVyU1ltIkBFFuz0X0BPvEqr3JUNveAxmrgBCUEPGAogtZFg+Y8w8H6E8rfDu7H+Sj32BHFQIhZHxnm7P5QcRLqGnB8br3d6LeULaw7MiWDpMGc184sX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(83380400001)(7696005)(6506007)(33656002)(86362001)(38070700009)(82960400001)(5660300002)(52536014)(41300700001)(4326008)(8676002)(8936002)(9686003)(38100700002)(122000001)(76116006)(66946007)(66556008)(110136005)(66476007)(66446008)(64756008)(54906003)(71200400001)(2906002)(4744005)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUipMt6KeO2Zr7SBB4WrVyz6k4oAwZbdV9xHwggXocIGWG8/+qIlcKEUGlv/?=
 =?us-ascii?Q?s8QK7Gwp7b7f/3ea9Irf3dHhROgo8uSLTbQ7QUmKUbD5aDUV9oI4NLJ0pec2?=
 =?us-ascii?Q?c+8yWdD49+SSQ8p7yL6eRxlfEne2+QwLAlVLtqf1XVcp75xd6wvyIXR6BWJp?=
 =?us-ascii?Q?AJgsjPPYi7k35+bAF6/nR9JeMUbf5b50yR7G1GWMXyPkXx3ww6YAGfRlbBlw?=
 =?us-ascii?Q?r9GgkGdwgenlw5wIFM6loOZXNOzNYe2DtOcWDlqVKOYYxuK+1kplY2JLMiTk?=
 =?us-ascii?Q?wVqcMqhJvz70D1LIxtJUlzZ6QnNy86BTL8fN6EZTumVFTCex1p5JybvAikzZ?=
 =?us-ascii?Q?3HMbYbwmYw5b2/j9MdmGqVB4KmrXM7ykqmL2R5vXgkXlY6EJ+Ksj9kHN2zfY?=
 =?us-ascii?Q?tsoqrKWak84U5Ie6z6mQqKsT8kVlStyf+Le0fjJfV4AEqi80LdK1kWRChtIl?=
 =?us-ascii?Q?iBcu6YQOOOOVzVfpbYS2BbvjLNp8xfkAgJleL6VY72XYVLnu3TNkMTXyHBIJ?=
 =?us-ascii?Q?V4qjQdLJ2EjLNgWJzEdvsT4pilZ9+wttRf0Fv0Hup6ZreX4WYqF0TJahjVe7?=
 =?us-ascii?Q?amaQ6GIi9SE1sjLmkkl3g1HcUv7yk110l9jKVIA975Cq9uUpi4gz00E7Mod1?=
 =?us-ascii?Q?bHcTpByXZsXqkiyi4IuLc8NtR/I7pMrvrilKgYBL8aswqs2zUxvOL2CkOwjT?=
 =?us-ascii?Q?K0vvdQD7CXSXfMXmZOk9lMqePvMwgBzVCg9uDoBYnh1+syjZ7GmFr66mMxwX?=
 =?us-ascii?Q?m4BFPdP2NDsmhWRpjV2H+bwZpqOaGoJIgP7SBuaEhXu/x5AZO1OLqdFlNEW7?=
 =?us-ascii?Q?NyvolnEsojd8lZ7Zymq3cErVofCfkI8A/8ct8MZOX/uMbInY7alndNkFh8dS?=
 =?us-ascii?Q?Z/TitXokGawA1On82tOovLbxtY+i2KHNDUCyJwMryh7oT2AiRr3erztQ/r8v?=
 =?us-ascii?Q?b/CAdmSFgcJ1q0/l4ODu+Kfx1/X/PMmjMxHAHoD3aB7fCb5J18T+s1z4YQSe?=
 =?us-ascii?Q?WYLFy4sRLg4XPB4Irm9Yqf2dwvwhvj/LQFRiC8XJ1VuVMKESUED+tqv+OAaP?=
 =?us-ascii?Q?S9Fcztx37M++mbnatUV1H+nB1yLceza5ew2nH4k6zClYvabWusIBQzF7zYvv?=
 =?us-ascii?Q?iDxbdWt4O1h7D+HrY6xO4OM8NrVzIe1XQmbqat7Ui1DA+Dy0b6kD+JMBW+NS?=
 =?us-ascii?Q?kvIH59Nnq05jKRGdWTHmsQTJBgzm5ihV8J5HhVWLpx8Wr9hOLXl47uNmzUPi?=
 =?us-ascii?Q?g1lQD0hCSV6K0QalrzJELlqnsW+pgUDDt3TehUwhu+oxPO51ifvDn9ifw/1/?=
 =?us-ascii?Q?1XIGjYesfns4AWao6Rvj98CMeOufaV6QfOK95aXJlkao1aEB7opDjC70fJd6?=
 =?us-ascii?Q?cvNV2sg2BkIF0svOe/gmU6ouF269vnQ862i3mn9cYVfLCdmPU/grT5JGM6wX?=
 =?us-ascii?Q?zj8S/wqTglSB7yEdg7c9cScqq8OOZMYNXEqAXVWwqsMIorB6Y/ectrsgqkqT?=
 =?us-ascii?Q?fBZJrCxqOVMz8/prFav8YsDnD/KtDTtC4X4krlWHwXlnxDYdWer+rec0aACC?=
 =?us-ascii?Q?1Govx+Wx+x7p0dMGPmhm4UNiK9FS32OqGqWpJjzY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1747f2af-5fe4-44ca-e8fa-08dc2090b94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 06:08:33.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q75+5K5znpHN7RfSe1cpVaZDkrIEHYaEvLB8ix1ZkNZRVazJn9js07ZAUWyzYBuWWJ41ebAu7hxsm167LhvD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-OriginatorOrg: intel.com

> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, January 29, 2024 2:03 PM
>=20
> On Sat, Jan 27, 2024 at 02:45:12PM +0800, Lu Baolu wrote:
> > Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA
> option for
> > broken graphics drivers") was introduced 24 years ago as a temporary
> > workaround for graphics drivers that used physical addresses for DMA an=
d
> > avoided DMA APIs. This workaround was disabled by default.
> >
> > As 24 years have passed, it is expected that graphics driver developers
> > have migrated their drivers to use kernel DMA APIs. Therefore, this
> > workaround is no longer required and could been removed.
>=20
> How about you Cc the intel graphics maintainers and get a confirmation?
>=20

in the worst case there is still "igfx_off" option available to achieve the
same effect.

there is really no good reason to keep this config option so long while it
was intended to be removed in 2.6.32.

but yes the Intel graphics maintainers should be CCed.

