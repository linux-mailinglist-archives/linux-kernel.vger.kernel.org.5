Return-Path: <linux-kernel+bounces-82817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D9868A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF038B23358
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704854F8F;
	Tue, 27 Feb 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLdlWbE+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666915AF1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019756; cv=fail; b=tzbhT4E8hJIT1NSsPbBED5Rwbb4DU14wQToqlNh8JTNPwOF1vvJhqcEBeM99MrjRXZaYcmGDRBWLSpQ0KbRKeBslvW4HNvla2L91V4sPuNEZXPx6Z8pACEp/HeqYlnLOvhOch7oz+ZrpILO3osPCHG6o8AUivC3eSSMp7S4a9s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019756; c=relaxed/simple;
	bh=pnKhjbW8JDZ0i4YnjhgkhIKME8FeuPzRu5FdLJtRd5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuDoy0zmhuoJxlpkeWLRmHmHWwhN5Lw3OUgamhfb2TpG6saBgskgDEqDbuFRuVeIO3fVFtUyA69nmV3JYRRw7/pOZYIHJ9ehkC8YXqES3lp7zUpxh/LFuz8OtFUnDa7/Ei0bZ2fmtK0XkndNVbrhcINPJ+ANBxnjM3K5ES6zDzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLdlWbE+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709019755; x=1740555755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pnKhjbW8JDZ0i4YnjhgkhIKME8FeuPzRu5FdLJtRd5c=;
  b=DLdlWbE+qkfg8AUZWA3wZk5DkNAVkcK79lBmSanLeopNY6MycNISk5Sp
   Hd9VvJBMUSRnOSz5/7E30h+eMzZ9vDH4/Hxk5s6wp4/eSZd2SiiU5inqi
   1pXDgBPU76wBXM58cQ/JxpsM+UYPQMWawEvcjf7MMh5Q+F4NcpmKFKv7y
   cVoJQoyHUQrn1VXn6vm/9EPgXhm+r9tTz1GQZWVC+I45OZgRM+UlHAn39
   3JdLB1TTdJ+H4cz95CP6B+M009tYw1RJ1KocaC0jOcRwmjWtQYS8GySw/
   a4BI5OLsyMoBdtpLUecAFLSKhc/DRiAFTnkXaTsw0E6Pa/75F0y+uRL6O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3221708"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3221708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44447249"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:42:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:42:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:42:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:42:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue95wLCVC8NeHKAiDXZq4X68EH8CC9/hxIPsUs9i7FZAFLIqCINWJ1eFsE0J4tP9R4AJ/QPOmDNrvwOq/8PzFOZ4H0f3rLmV3RNlHqtZlMsjXq0LkLLgFtgX1779O4Hp4E87V7yAgOyQI0a8wL0WLR+aOV9xtuv4cFWmwaP5nP5ujZxx0NYRMb8vGgrD4pgGz5K4uN7S5To9q/ZQqy80m0H+bfge9vGA8w6RBUrptz48TH5K1yFvdphLla9s+GByZNtaVAte7I5pJeucNcs8zrVAL7KibxW0aeI5e1gyqYzCXZqWAhKkl96GdFyGW/ynpp5qO9Zw52DDZQds4aTjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnKhjbW8JDZ0i4YnjhgkhIKME8FeuPzRu5FdLJtRd5c=;
 b=H+HExPaqkEX7Vb758HZavQDmisdziBGuJ/laye2bWHoCexAAJTSrRSucmuNKF9RwjhGZJVUI64yL3mR28rRTHGV+YaBJ5gV5+OLkwmAhzKDf0uzsms9lhwbGzhpDrW2s5LOMuorrqZ414nxTniDtTh4cmWhMIb7rrlAVga3DSRNJly/R9GExwpJotn7Z3fis+fO32uPRgCoG9Odp655hsYb3oLRr806l0X0kOZRU9hACU2mP2vBNghEGW5m4h0xeVc8amjcqAcG7PzF/p99ctBNBeq69juYFVfpwoSam5LdYEwmsb2du5AdQJfGx+78OlCTF9gXuILQjeLF13s9ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 07:42:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 07:42:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc] iommu/sva: Fix SVA handle sharing in multi device case
Thread-Topic: [PATCH rc] iommu/sva: Fix SVA handle sharing in multi device
 case
Thread-Index: AQHaaUj/t510BYnJKUKVLX4qK/IL6bEdzl1A
Date: Tue, 27 Feb 2024 07:42:30 +0000
Message-ID: <BN9PR11MB52765A4BB76A0C75C68744B18C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240227064821.128-1-zhangfei.gao@linaro.org>
In-Reply-To: <20240227064821.128-1-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4616:EE_
x-ms-office365-filtering-correlation-id: 34968722-ed30-4cd4-46cc-08dc3767a75f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inDTX4WNVJIO81Uh0BZtLEy8NRj2iPR8ERUsCiXVCbEXtKezW6NROUj6fFfiXBTQtfoNHy9PuhOtFVtgO1BqLZ9zPuD4S9zIO9ipEvYIQHYJDiTSYZTIQEGpi8OZflXREBjhBebeCxIq8G1ugnsoUdbPdSah3FVBnk7SovdUCrLOvzMle1jrnkbsloz8ZZqEMynwfC8t8dz7WpKnKkJk6nOyqgjrRLQzY+KEg5ZVzXKP1TWluyVYNZx6nHgIoq1WcCsnozotw8At8tGAdztwHQixGTXbxtXF1iHNOM6/Zni2oiqEh/HqksRE1hLOfbSVxLSFwKnrqL54pReXKZ15rll0AbLd75krCLXMtIfspnULDVm4D5I4wNFlqSRF0pRbfYpYo4PE8RorOh4lFLBh/IE+fqs14Sjmc0/2Y1RPv2cPLbWq1MuS8mfVUAUw5+trpwdnF980PwlYJNBziJFzpt+Li7qbOn1sYyaXKf/Vlf0i+q7mqDLXsDvtVcx/S5DR1rPLJTQBnioU5M2IFKz7ON8Ny1pEpom16px8rUq7v/esxuQI0CmefCpgtI3+YByBZ5GRhiFcK2MtyR8hGkYVuWUSKPjY7RmGDvWk8udFVz2Dp8Ffeb82gS5cMWcfbBCsmt7hJKjQY6bumy+2F3ZmJcTxzX5nlOdrRYd1fRgCp19vC4n9GLwXmFsp7ktK7AC8Dq3B0jrzDTpQ+8oq1oGtRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdCWr6jR1GCyIJg5g0TtT05kbwDSAUW+hHYmu/4hx3pWB+qvL1pzoF19jJ5S?=
 =?us-ascii?Q?35rE+Ky6hDAJNVWRAckhSvZb4RC/0KHa4ktSudETQ598Fy5U6E/o6G/F94iZ?=
 =?us-ascii?Q?OE9BjcUwE2gGM/OYicjdjKNNMPsAXa0teTg/byG0flzSdTDp8vmUJxs7YV38?=
 =?us-ascii?Q?SpBYquIvY5KvNGnFMMm/EtMrKQt8RTh/DpZAPSHF9cY+r4XUe6haDQcefwe9?=
 =?us-ascii?Q?GDVEuntuwB+CODf1jdVNEy2JUY07SH5/uzpxOJ37gINw6r3Z/if6l+taPSEf?=
 =?us-ascii?Q?OJ9FCpSUxJNbiZ3IcQkb4E5lH6f5cl3omZ88ZVbdFEuR+7MulCkmomc+xIWN?=
 =?us-ascii?Q?ZSWFf7LrfombPiNmv5Dm5voh/+fMfA/dOjvy92W7OLMUm/aprXiK1IwftYMY?=
 =?us-ascii?Q?iyDgwuaOQ2X9+QHNdrMCS1Ps/+0QoJXDVMbXaePpAgS8SsG++niukaUvu+DW?=
 =?us-ascii?Q?d04nY8/tb95Lq/2nIK2Be/CWfbMYx327aIwdfQ0xqMTN27kKNyREUnDBRFt1?=
 =?us-ascii?Q?HWuUASlM3hqOuf7i5SDTC1cRucAYzk3b0wsmhmYPCSkzwr4rwRlDdlyBRjg+?=
 =?us-ascii?Q?QNAvY9hLI5pcQR7Oyu9lt1+FoKis6NrUQgFb54qONxb4tojzERUgzP1kQiUP?=
 =?us-ascii?Q?vO/Gvi7cRbhOMLXtVOzLMG2YJ56bUi7Ko2Xg/BqTjz0vTArV5y17bEEIBwOb?=
 =?us-ascii?Q?6t5O6O79BWmTNq9AXdMsOk9XOJF/bXNoBgKA/Rq8U6Hob+Zyv0tYK7gRWiPn?=
 =?us-ascii?Q?ex3JlBpp3Wzt7HH50reBQ3uH+61YUps+yo/rB+0+Vr3F0AMrRkO1BpZtp7LQ?=
 =?us-ascii?Q?p+QPDcAGxaxAV1aghxZg/naUBYaW64RxqGGNbla6Ztu7g7vwqI86+9EVfRZk?=
 =?us-ascii?Q?Q78xvhhJBh5vPbl1o2dPoGvHszdIb8hwBBgYRjQYPWSX2jXPhQSkW7j5CC9Y?=
 =?us-ascii?Q?/5E9vx3NZQSiHigZ/j6do/YzIzh75UYrU3PxsX/rmbVyv9KvEUVisDjQR1c0?=
 =?us-ascii?Q?xKYeGt90pOS4kvalnKUhy/XH15K5cy6EenL9LTW0Vg5+AY55dKdES7ah9xHH?=
 =?us-ascii?Q?L8/yY0F2UkO/bHjIwAqKtXYwrNA7aAWCXwbWP7cwei7JxzO5z5szt3IVDGOl?=
 =?us-ascii?Q?62uocwQAyW/4MPCwchp/Cjgjp9hPKk0PiNG+7SG57XVzUGwDHUBRsxFGIgAP?=
 =?us-ascii?Q?SHDVoIVGWsR5X9JvheuljwDoXTeyRcBlgDIQRA7kMZWKcdKShmxsCw1Fljei?=
 =?us-ascii?Q?RntCnvl2TJmT7EB1E3oOKI39WOIrHyAu5ytIWaMNfYl86YESbkiZsVdXy9YN?=
 =?us-ascii?Q?LPiXQBlCARF+KKs5+3j+ybLi7BPQWLpBreIAPAJoBtDemTuXi/MyTUIsaQLb?=
 =?us-ascii?Q?qnbPi+7clKE8N63gTifOequvEvYWNF8291ADd9Mu99T66pt377BXhTpH6xAz?=
 =?us-ascii?Q?mfWMKHIy4VcHiXQ+ir+xCE1zMxpqnbTw0/Oyn2nz3+Uv/melsl39ZPQ6+exD?=
 =?us-ascii?Q?qgKI6Ts0qQtbJOEcEncv+yPI1DxSODBjXwDFIpRrg8VCddARKMZqRasA/jPF?=
 =?us-ascii?Q?qH5hb38lEfPtPB6wF4sMd8eOaV388w7QS0ZRJPEw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34968722-ed30-4cd4-46cc-08dc3767a75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 07:42:30.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8zBGR0z/x9jWenzGmeRSoUXsYQ0Ar5UEfPqsfk4y/uWjTMeKBRHIMfgILz1l12U6/mvIdXCGs2ms0isz7BZiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Sent: Tuesday, February 27, 2024 2:48 PM
>=20
> iommu_sva_bind_device will directly goto out in multi-device
> case when found existing domain, ignoring list_add handle,
> which causes the handle to fail to be shared.
>=20
> Fixes: 65d4418c5002 ("iommu/sva: Restore SVA handle sharing")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

