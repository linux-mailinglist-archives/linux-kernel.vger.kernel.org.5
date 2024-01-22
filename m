Return-Path: <linux-kernel+bounces-32537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E5835CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E92E1C21413
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8CC3306B;
	Mon, 22 Jan 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEvg+0C/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECE38F8F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912813; cv=fail; b=ZeMTs2qlUtCbWj+qma5xOTP+Hz0f3ZcnHSWqQlJLuMPjUCrEHGWGFHE/RmudBPRUPjIaMDOGSOdCA+SWC2eOtodhwucZfWtEZOKZ+9cBmjxtL98QtUm8ciFRAyGvkb/L6wqzqsefcVUCWYeERIt35gMc6xC6fEnT6D6iHPGb3JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912813; c=relaxed/simple;
	bh=GQQXGkE7Nns0936Bt72xgLewOTECCng7a+ADS2o+7p4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw0vM6XclAQ7gmSfMr1nMLV3A60+gUv54d4M0prOK2/3AuA0bLg36UYgl28ARXUxFOBnlaiOMsx5UpGkT/qyZy2fWhfchoWWPiGlJqD+v+nke4aAaj8cVmfd6x5mUVic1KfAJlNyZcf8MsbCSg9oG+flcNhYzaLQhArzMEBZr+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEvg+0C/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705912813; x=1737448813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GQQXGkE7Nns0936Bt72xgLewOTECCng7a+ADS2o+7p4=;
  b=XEvg+0C/dR6YuUnidSxRqpnc7BlutTaJXv6+a2sBjJmA4jD40FfkH0Gs
   m18ROoma0p0lqdwIHNOJ5v5ThaEes4THqxjnE1+UmdskVFwB2ze4WXKb9
   YiTzbQ1uUFBWQZHNMl3NUvDXv9sqN9RsZlCLGUkCHUI2UgujR0WUh+dCJ
   rgAP4WIplyQcUQW0X2h73nFKCsLDbs0QIH50nJSugdGVpsHi5iDKovpom
   iOnr0zlcYIy5JU7QlvsEgeI4YGshXedo1Wln99vQy+I027ahQyPCZq/GW
   YTdC+1+FmSEsqXmwN0D2XLDh/gT6QhkOnbza6CVTY+0dJbgmUOZrzDSv2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="19708013"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="19708013"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1222205"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:40:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:40:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:40:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:40:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:40:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7R7HRzDjoJtqSEUrmeJ7KwJGm4weUEJVXU0n2InyWRnQ+7WK7+mcEwytl7Sy1b3vlatYi4ejqYnFki5qczdeBdVJ/xi/ofbkcY+xpnrSoDJx+w9BSMQ6ya3FvX+p2yLcdyk3UcnJmhD451BD622/2U5k1L2NxEaBad/x0gJo09IZw6Lx77kDvW1a93MB/ZY+jpoAQiSu/y06tytH74VdWUB9t3hYBQD9bOU9nkfms4hsfTrNkYMSzARscol8665+DZwEhHkeNKTPSgt8jqsoGV1SJoKi+vIA8kdOWCXh1x3u/+BTwWPV5Ct6eGVt4x2sHzrOmdnzsWLg8uiLSNxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIBZllN8CqWSpcUpL2g1egRT/pYwKDbtEhmtPgQaPEE=;
 b=Q++JDhXhCAbCE5HKjUWClwoRcHL2IdoMOnq7IlyIqM+y+QEgVluZ8bFb40/BNcYXLqQ7xYqbMrGDHnPpa0c2KNw5ZNX7WJp/F0KseCaYl6Yx3NM6ThZzO9tgv3FYNL3rLQ22kOHFewIYerqGItxhjJcoIaVZwIlq34/XnhUdKrulBrgcZyl1tMBgKnZzBJN0Bk/BwujhZqH0A9+kksx1NSOxmDl4AI44rcLu4S+FBsDX1KPtbnx1vBT7svRzfA7+NhkwVbgD7dR6Yc/uPGN+wBAxa2Kb39zz9SHKB86wd7gM2vShijkgaTgLylOZ7vm6ytcA5rFqgas4CDM6IOpalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:39:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:39:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>, "pandoh@google.com"
	<pandoh@google.com>, "loganodell@google.com" <loganodell@google.com>
Subject: RE: [RFCv2 PATCH 2/7] iommu/amd: Refactor set_dte_entry
Thread-Topic: [RFCv2 PATCH 2/7] iommu/amd: Refactor set_dte_entry
Thread-Index: AQHaROtPd1NH4nYkIUyUFZdUjqnIFrDlkmpA
Date: Mon, 22 Jan 2024 08:39:57 +0000
Message-ID: <BN9PR11MB527677A782FBDF13FBA1E0368C752@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-3-suravee.suthikulpanit@amd.com>
In-Reply-To: <20240112000646.98001-3-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6912:EE_
x-ms-office365-filtering-correlation-id: 6cf5897f-5f80-443d-ec34-08dc1b25b70d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ts9QnL7d+WVFz/ZCAW/1yeh8FrECveng5I7UgD/CoMcqYgQVTFr89txo7gLn28wFBSfUANFH5E0o2XnMMbha5KlykGVRNECWW+t4vtWurgtQTm0OU7Y8ehdIxbbx5MXIRlsT5LcspKa2mnZ5f2PLI6yq0cxqIe6X/d5TLiFNqrq/yy19hC+/ULPR7L0olHAl5faZDez0+j0QoPq4sDC0J3SnwDxFN3DD84q1/cC+vJylxiOURgohzJhkuw+/r2F8bBSLOa7XM5MkJVKwmAfWrTO3ITz6JHUNxytxNTN1/oCBMWJ3YxBY519wfShvakfeJMjikWa8890sP+XykQdXZXEecuLH2Uxkmu4mOAEwReF9KjPsoUdsKkP1oiFEEZQcpFBfXWVCnwjC6awtSLzEnyZiyvD/JP/rrenHzme8fnsY9O9W74caQTh1QP6munQguM2W3o6vuMbdVrr18wGUAm8db4CPSxbBx/b/Vei74c3YyxKsafHoQWQfa4NE2rQDOHaKhYrOwr9i17TMv3LEWcW0sh4DOnlB2B6CEGjHuaI5F7V697uhjsMr+XoHupwunQLz+tGALcfVGRtVC3vpqwnSxvf0bYRiL9EGWSmAvbJfhwDvaseDVGMbzgVzTzQh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(55016003)(6506007)(7696005)(71200400001)(9686003)(26005)(122000001)(86362001)(38070700009)(38100700002)(33656002)(82960400001)(41300700001)(52536014)(5660300002)(7416002)(2906002)(4744005)(8676002)(66476007)(8936002)(66446008)(66556008)(110136005)(64756008)(4326008)(66946007)(316002)(478600001)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z9pcHw/jgvorOdxgH7x4n9pBaCLZmY5f0rPkYNccBfMfU/y9v2fLoIUjXyIp?=
 =?us-ascii?Q?olgQ9QhzNzgvw8YG14Uv4vWmh6UKIrMB1ArkL1Awmkr8ZzvsZBqKxdKuO1Xu?=
 =?us-ascii?Q?zr4tNV65PCMZabfk6KGCkcGyYDEX50YWIGeUvLheTzjZbzyzOdyZAg9zT3Kh?=
 =?us-ascii?Q?W8sT4O+QSvUSFTX6svFTy+aXb1TdQX9ykZRlVuR7vhiEAb7c+JfXDaZeI/gK?=
 =?us-ascii?Q?Y6ZoVb9LUHiS6sqWSYfnIqOvEIG+oY3jrTDsvZSZTAxqfCNLNmjYh5SFTsM+?=
 =?us-ascii?Q?gHc3TnqWGKISjkNsFXuQsq1VToOPydY5GuVIIWw4UKzAK1Q5kCQ5N3pTD4M9?=
 =?us-ascii?Q?d0ZXEQVybwoW2cO3jLsW0hBDLuYp+gwvT0bp50YK08YDeio34pvBc99QauPE?=
 =?us-ascii?Q?/TGbGGOf+OMd26lhysa2nPq5PHfmveVaQZGfOXRXkX7pKiTBdtZlaNVEkYSG?=
 =?us-ascii?Q?WSWbX0U9BrPyyNhjzcjTzjFdZZFvvV3p0KTwBdE/XXzmhsRAfemop6pyWjpi?=
 =?us-ascii?Q?rIkoP9pDwGSQfxr0+lMe2d/NINfK77XXIe5sUCwlhiitICKgGluhrQrXw+4I?=
 =?us-ascii?Q?zMoq6xVVdpJM5FVswMPv3kPI7OOi1SYXevjzvu2efDXhZ+5M1hGQGAPgo3er?=
 =?us-ascii?Q?exRAxswM4LbonX6bfOJKOygUseazNtL9h+5oD+L9KY4LERYUsWpXQXpBY04N?=
 =?us-ascii?Q?x4Wl97PwgGhu4gHbmNr25dyEvZ4JHSqFHX1q5SwYKtWGtoBRFQtxgDPuYnd6?=
 =?us-ascii?Q?znQkuocCyhmH99Hblk52feGF/BFEOAZ2Q1sDb7PQp40SApHhZh5wNVn6l8Nj?=
 =?us-ascii?Q?NmwEtl8jTREAK2+zQCkWHfAAJ+6bvUp20cjBCffQWKy1ppTB/iVzUrfZVu+h?=
 =?us-ascii?Q?kKDZanMdOzs2Xr9pM95sGhmZS8lv8hOaRL3xSZs9S0KBBSiIqC+NuaYO3aF4?=
 =?us-ascii?Q?E3m7e/jmByfQJKFfuSKR0BhY4LC5FUXGF6BBpYPBTiwpEvcI7uhcSl18bOhk?=
 =?us-ascii?Q?IapT9yiV+2jkjjL7D/5DOl+r3Rn+rgSgKfTOWJHOQ67SFA0vmtymeSshWAbw?=
 =?us-ascii?Q?JWeUmzjENx8KbVp72L8Lm4Rv3pcxT9MZjNcdXglhde/6wJLGH757goNBSW/1?=
 =?us-ascii?Q?+9lIXAjAdyTJYJVMu8l3CDX8QYR0ossp+8Lj+C48IEZcZcAgC4RmNSsHu2/h?=
 =?us-ascii?Q?a0BY7sWpjYXY1PH0yuBvXkWFlbnR58n9wrqMvveL1Mr0izhwghlL4WBhdU19?=
 =?us-ascii?Q?rb1JEERzBZ5zTlb7yy33jH7r1UoVswdGurRWicKSBQPD8dHJW8XGMV8rV1OM?=
 =?us-ascii?Q?34OempBBqA8Ct1RYVPM3DSyU8JKGytKRMCoD1QAqw7/mkSlxodcv1tXMIBfJ?=
 =?us-ascii?Q?jysM2mtU+uBLTHL11u2j+wOo1bzRoMZaAZyZWIUupqlVdJgD85m2FL8Of3Qn?=
 =?us-ascii?Q?dV+swCzZfhu9hon6HQvCBBlKwL4ZNNajtezy/GlTwgpgrr58ibxZABGu/mNE?=
 =?us-ascii?Q?JSbIdIgtR/VN6DjUyeegsAI22f4ivXUZi5ZyHMOWRnbDBY6D+CmCG+YyqazZ?=
 =?us-ascii?Q?WwXa0wGJJGP7pM3y1Swv6+nhrHtplCP15zpDFGYI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf5897f-5f80-443d-ec34-08dc1b25b70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:39:57.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70sbPHhutRx3PxEJPYHs8wjal2lLamnXAto1vt6/U2PPwA7h2xI/6E36f8u+iFGRrTSIqtS8lhK2hUrXSW/4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6912
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, January 12, 2024 8:07 AM
>=20
> +
> +	/* Use system default */
> +	tmp =3D amd_iommu_gpt_level;
> +
> +	/* Mask out old values for GuestPagingMode */
> +	target->data[2] &=3D ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
> +	target->data[2] |=3D (tmp << DTE_GPT_LEVEL_SHIFT);

Just directly use amd_iommu_gpt_level here.

btw this sounds like a functional change as the original code only does
this for 5level:

		if (amd_iommu_gpt_level =3D=3D PAGE_MODE_5_LEVEL) {
			dev_table[devid].data[2] |=3D
				((u64)GUEST_PGTABLE_5_LEVEL <<
DTE_GPT_LEVEL_SHIFT);
		}

If it's the desired change then better make it a separate fix.

