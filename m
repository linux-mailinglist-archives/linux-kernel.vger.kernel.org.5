Return-Path: <linux-kernel+bounces-82655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E88687CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21A11C21A86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D641D698;
	Tue, 27 Feb 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhyCqCst"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717538385;
	Tue, 27 Feb 2024 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004862; cv=fail; b=s1c1fWmR1Y0caCIiEZTmPvqAy9n+8dSUI0zmnUWJbkr2lx4OvHqolnxBE4Svc7IYsFtv/nIDc26lVPHs+I76SqOru2ATn6zc691UcJ62F7z8nPewDpDwMPttjyehZ0Xb4GuWXh1JR22OlEorG5KVh3PNAlIq0gOr6Bb7RHiT8oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004862; c=relaxed/simple;
	bh=LTUYgsk0aE65MJ4jqB4lAzQ26LTVQkuqHW6foD+ZcLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LXjxr2o/MBJo87uNvAKJ5bI2oLn6OFUWm34wc79iFX88Q8OpDEE4xGN5YEXpzgsnJNvV+8BlIGjmS8UD9JfFohENrdvm9YTyS36Cmf4T+9EjHSsPI0MgYhndvtmI44eOzrfwFabF1QSqk0iXeG0IzVPtZeQZQUSYHnQfMgDa/iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhyCqCst; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709004861; x=1740540861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LTUYgsk0aE65MJ4jqB4lAzQ26LTVQkuqHW6foD+ZcLo=;
  b=ZhyCqCstfdG1IZD8KIA3uYf2Mhr0UT+gA/R1ythJM+lq7qtO166gV1Jg
   W5MjKSl3y/GjDF7ABa+joiDV4tWHrFq12AnAYe7zD4Vj0ltggwqSG5A8A
   JB0D3xzEDnO6EM5uND0O3W+fBJvtzxp/V6d+x3lMb90aB66vgQ3sR0eob
   TeZ8dms71DfPZvF6sPgeHDAL3XcT9ugjUE/Br5r+t+Jo6yTj+GH8xwSQP
   +hkRO9rgUx7oNAY90e8p/i1CKtAYY12UAgrn2lI9M4UmyjNA6rymKJMta
   UXRy0gO1cWxQlmq+uj5SKj9ysvuz1VGRouNKmlJz4j0JI2CmiGIK59oU2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13970529"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13970529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11489048"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 19:34:20 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:34:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:34:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:34:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:34:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0aFlx/5MLNn1bLzap+Gz3W6M27sn2OL+yRZtCPpNEHX3csfOIeXN+ZL2OvIjDJYKX5qitpzKQf1ieGcF56gga0HE1Ej5pH3mzmWeBcspsj8kNZ40kI/LOHVPOA3u+ldiVkvxjc1edWgBbmIVSo+6NzwGm/8vAbWNKA5LL77e4FmO/BCSCF5QDWt4ZA678lViKYQyakCpRNNxbvS/7npL1gwuAoNgW8rZUMkSHCuaIEKJ8TgQd0IGo2Txy1YaLJWqN76ZsRvDJ0TxVqm8BOgbpVS4Z5k/UxvjLs5D3b/VRdloxwaz/iRgkInvPfa0nC730pMZTBYNSr321dX+lM3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wM/GOuErGftR5sFv9YdolKc5hwle7DpXnCYqLButIA=;
 b=dkYEJCbZfj4481PPUzzGDRfIXRBZyNwQSf+91XVlvACf7gPz0WvTPBHlb01qifF+4JafrlC5/KByQ1PeIOs/iKjlotqIwuZ9Dk6FHaSTEjzV5b3LoPvvtqvxVRO9QVuDOBwDhxpBhTybz3nL/5jSHOa9SerXwJf2o2AF1IKT5bM4osJGwyhAbkYwO/luPKzOYG1IArsdusT9YYKN3HKferX6SA8Rw/DlMNUHloC/Jn8/9PEi+xnZDC7ueubeY56MTHSGZujdQuaXAhjRCTwW7OL/8ygXh83pHmh9yALT/fCGfqEsOAFv99x5e8bp2YTL+vFz+B24cW95G3GcBJrHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 03:34:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 03:34:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH rc 0/3] iommufd: Fix three bugs found by Syzkaller
Thread-Topic: [PATCH rc 0/3] iommufd: Fix three bugs found by Syzkaller
Thread-Index: AQHaZdV8g+XNcunpKkezRrlyZ7gcfLEdj3Nw
Date: Tue, 27 Feb 2024 03:34:11 +0000
Message-ID: <BN9PR11MB5276D622986E55465C3977CB8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1708636627.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1708636627.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6069:EE_
x-ms-office365-filtering-correlation-id: 0ddbe47d-663e-4d25-66b1-08dc3744f6e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9U/Ctp+pWNUQTf1g2+qlJ8d61u8/q6FgSdLEnyPyKAI7taMl8Z4LVEm2B4SREE+EqMPHvraWhoLV6dDn2ah5+vP/PssTBVetegRSvXSIHbFP0ad2CcsQ/hWZOdmirm7PJLDp+lrfzdq2ju88g28QddzQTsdRsZMuEhyWXnDb8tzMyVEU0Za9aB49YCsdUxOA6b7sDHZadBhIAgEIqomWkfbb8iq+NMj/vkXx12gAg+dexzYsbUQ9UZ7DPpYPxsgUQnOeV3MhpofcyKDFyDedgCovyUyHRcZ8xRxk8+INGV+xDFgY8WAM0ZnR64aH3kj6bmiIcAjzvEH8Jgz9JcCxmzjPC9kkJQSHAPHhgb5WHznHaSAyrTpVsw/10SobzCZfar9XPeXE+bKGqcrDZ/Hu0Fh/kzhxTqWoBW9Ys02+VDJx9/we0JgCsScFt6WXBxbS9TrQZ/pbtVX/mhFN0al2E9mseI63R5zBBPN2ud3U+eRDn57JqAJew6uWfVL98g64aaUu03XoOn3OIKvCf9Ds6P5VHhOc0VsWVfcZv6YqlCscHegjErPb7xukdnLjJ3AZ3w5OAk57MQt+8zVLKPQ1BrVw6JCFLD4vAx9caImmkTUCH+906zZkIKA+7Hyj+73G05Dsh/qWw5NunfxveMdozHNpC3Gu+bV9/aVLQEJqBzH7ctZM/ca24uutu63+WnlSPg8SOzwubCYtYjqZbDM7ciji62PN/65FjeNbTTH1XY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?My1iFKcoAWC3AWyl7HCCVm/9X3BwvmkYyNNoQAmy9wBSdDfU5ijQTqtDeyqi?=
 =?us-ascii?Q?QwKIweN9fN6sp4QR8XchKUoRQTPsMPPkiOIC+CLYy+j7gruljLZc1peCwcY+?=
 =?us-ascii?Q?s8ELe9uohqG+CuQbpGaFGtbJfxZxeok7EJEJGk4Ft/Ajr14lc5go4TTCw8OV?=
 =?us-ascii?Q?6Koa+GGandbudLM2vE5zzYqq4XiV6IQWnGIve3evQ7mKLh90pa2/StxyNCqx?=
 =?us-ascii?Q?KyRcjQOK6beHCdLQZyl+g0AI5Ba5aheA9PiXjtdE2l1rwzH3rKiBZexl0v0/?=
 =?us-ascii?Q?uJysG7Qt/UmTb4xfzcGDIyiXAk0oefO4GHMplR3PvWbfZYHgiN9uOViwoElJ?=
 =?us-ascii?Q?vjvq8Z0sK1fhA13dIVotai4OAkDtlZX7QOtapCq3KWKOC1KWVX7Z/dOIefgJ?=
 =?us-ascii?Q?aLHrLQOMCCXt3V8Z0MGwA5jVnACya/6GiUrU7Xxtld53AQZrqyny0ZvqsNqO?=
 =?us-ascii?Q?WZbv11jXv7OoGj/S/UQVZ3SKGMpPqhnFxtoLYbLtRGpCitdIcpCP73w+cWCe?=
 =?us-ascii?Q?T1dq3fzMLkC0veyDWVZjCofHF3bwqyERgwxQdhDGFCaBKlJzUI4n2nNfiqNQ?=
 =?us-ascii?Q?VHqkl3nuk09aqLt58ZGIghH/lTaUpwFC9BwtJXfxWWoDqBPIWxoj0aFLRgqr?=
 =?us-ascii?Q?+6khbStUK/g1nsTlRmmxW8NB4r1o+Z9A10j2Hu+j197JZMC4oyr9R1ekwYBN?=
 =?us-ascii?Q?xlbc3dVR181rw/HdM2tumySQdAwH/puk/poQvTKsjwb3Lz5Mr9De5CxV/VS1?=
 =?us-ascii?Q?EMo/mkIAlu8tuiKFU4g9DzWqcREiB7OlhrSS7ZjxgcdNEnJn9m8bhCbR2lcN?=
 =?us-ascii?Q?ArHCiVg3zOO8AKNtwTx6GkE29wNpk1l4p4CUat9GEmUx1l3ArxmZHOeUpGVf?=
 =?us-ascii?Q?gZZu7oRXQ+hT/SLEzR3qpN+0BF6wc4STRbZGQcqvIDVsfdXkWOyrqF6wEMtX?=
 =?us-ascii?Q?rtoRSwytcx+iYsgNLY8TDGEl/JyNeGSWjTGOmW1gfA+6EE9dyTYvBnYChUC2?=
 =?us-ascii?Q?GgLCvPU1O2iK8ShsiZEp6PmlPrjSRKM8/slvQcxwOVM06QjQX3TdjrYq31hv?=
 =?us-ascii?Q?6TMpu5p8BS/Op7oRiXGKWKfiAOI7nP8zLH4ATogFQh4Vubp0xQoP6nYEsUu/?=
 =?us-ascii?Q?M8Cbxn+E5DYoxQV48eoOVYsiHoOf/ywrTAufT7fl6KUAScfiIRVQ/69GWLUf?=
 =?us-ascii?Q?m/nev7QpDzntAW+Y7vD81GHmkbYDfVR5pvqdLjmTfzwTzYLvQve1+QMkaZiY?=
 =?us-ascii?Q?jYOel6AY/0c3Bb/70cuyoau9n5q1QTbilbl5geUBdmTegwo/eWmaBPv8S3uj?=
 =?us-ascii?Q?ghqtBDsRvz1QN7p8eRJXqlwVZEvbCdwl3ijV3lNPu9RUCPkktg6FCmgnqLmB?=
 =?us-ascii?Q?Jc5VYnycXo+Miw0NuLOaIF2C33sO0YYaPG+acbwBKVOx9vGNDlj/9YufCwNX?=
 =?us-ascii?Q?Xl1I/GscwmD2N1kN8RpAPr6qK4zs/b367ODn2CVyiy9y14rXaOQbqwWV9Pha?=
 =?us-ascii?Q?h/mCkJs4HZ7eKh3fuPHRTdPhJqg2/L29wiHM/fkDdBuRlBCPUB1Ih4wilrns?=
 =?us-ascii?Q?ci6KCdu1pCM5M6tgWygLlSf593FvyT5Pk3ld1yQD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddbe47d-663e-4d25-66b1-08dc3744f6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 03:34:11.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54jp9W/zxKdxXchqoyDHVJvyGY+JQEL1xSHSBuQxUMXPDe+lUNDke2C96TR4mNLzNYNRBBdYQt4ereipEEPnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, February 23, 2024 5:24 AM
>=20
> Jason has been running Syzkaller that found three bugs.

could you remove "Jason has been running" from all three patches?
Just say that Syzkaller found a bug.

>=20
> Fix them properly.
>=20
> Nicolin Chen (3):
>   iommufd: Fix iopt_access_list_id overwrite bug
>   iommufd/selftest: Fix mock_dev_num bug
>   iommufd: Fix protection fault in iommufd_test_syz_conv_iova
>=20
>  drivers/iommu/iommufd/io_pagetable.c |  9 ++++---
>  drivers/iommu/iommufd/selftest.c     | 40 +++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 13 deletions(-)
>=20

otherwise all look good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

