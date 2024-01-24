Return-Path: <linux-kernel+bounces-36538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822E83A2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24156B224DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62CA171CE;
	Wed, 24 Jan 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6vAhZUS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E8171C8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706080880; cv=fail; b=CVWAOFRl5u6PC2ZdUVvjeI7K0S9eZEpg9jF2uH1RYB1E2yn4KQs1rADsjPrXp/xiSunANZhUKEqg76Hux4Sr9p3GtY4kQbSAlaa8iTk5h0HgVp1Lum5p+UT/C0h0iM1qr/0ea+929ap7LfJUMJujEPnvSsWum4YM6+2eIWkoRTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706080880; c=relaxed/simple;
	bh=LxBnni7lYX1Eio4BFql/1I0LnJpBF8eYpwPuGbj5aCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwKD+Y48uRt23udJosTmXeMX9IdLquTqKUYcljRHPCOQkONkP+n3G48UU7OPXxOfPFx0wA8twSNwY12oRFv6fp6oIvk+eQEC6sxqBDJVwq6q0o0XVPBn0dKeNMSpeP9K4CuMl1833EBJMpY7pWLHwHmXHVZxa2Z2ULc0Ab96A8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6vAhZUS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706080878; x=1737616878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LxBnni7lYX1Eio4BFql/1I0LnJpBF8eYpwPuGbj5aCw=;
  b=O6vAhZUSVx0UtQ8iTrOjaMIJBeCNXsdjN+eoI/94Lp1ioL3g9xuATXQp
   PTJtc5g2v/n9gBYjDk8VHMHlsWswysZkxMiBK+RbdNf75jB8bm1s7Usbp
   RfCQNC8DjzrX0S5WQ7GzVX/Uwf+abh9orH5Lx0F4692jOyPDP/8DWwc63
   aAlMiwCTrhcJg0KEljFi3pbiHeyegalVqmIyCOjjM9wiNI6gEe/jCtHZs
   5wOql7eia3ix3zKTXf6nDqeFbkq3TKAuo1Uw54F3YMFzm8hPaV+0ko68L
   G1JPnIjUPrGOgEBHjuKgPeH9faNy1n6f72Hgvmbsd53wH1XK5uvgIZ/Dl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1653839"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1653839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 23:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820366673"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820366673"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 23:21:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 23:21:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 23:21:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 23:21:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFSvpNzD+5r+Pnmpn3zT3+WIqE1ng/ptVIhUj4R/6IUxEI6I3xw1nG48P0WNg5RvpvOWzhP15E1fqPuoI/sxD+DPnm/s/+qnJhixmwgAzcswkYp+czjkxN3e6e4LycyerThWsVwrQt0oIaQCdeRiI5PYFt5nvkuEDvRZm/whEdwnnRanBNW4+364EGDdXLPsZVmRQ0dheKMv8VZPM+hjyyHblYZKlD54IXDoN1GIVJq4nvGri3bXE8Pgkn1qcSZZrUzCQJw44s/WaSKqrbPe/vGN+jLAxsABOiWP/DgKZDL99o0HVqWciMXdntna4CaM3hvpSyn6i73Z74uAsZJO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxBnni7lYX1Eio4BFql/1I0LnJpBF8eYpwPuGbj5aCw=;
 b=bd1o4xR/AWACIf8Z2A30jM+Qyf7epeMQiTTjz78zOP28+oxwpQPnbhBWQTXL1vnVlBcWnjsPdPX+3jK1sAD8qv6S2seuhvI3w2A076vYfdfi2gmIsRLW/K4PpcWG9hi7qAIvkgEM/ojhVP9fQckE6IrJAhV+pi2LQ6Ie5H6Yg3lkWmEWO3EDZfyzjuajLu4sTPvrSlSFDFPErhSKg1ZX8iD1C36RoQZ3pvwn36vAaKJgBZjfTJ3Xuh8umkfkXn1ZFIe83KdsPQfi/5+Ri1M9DWHQ/tW92tIVkrzTxZyerpAml3D4GaeqI3lfeU9HDOkA9EiEtksGSqMLNnzlkUVF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 24 Jan 2024 07:21:14 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::89b0:d67c:ea7f:465f]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::89b0:d67c:ea7f:465f%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 07:21:14 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: David Laight <David.Laight@ACULAB.COM>, 'Andrew Jones'
	<ajones@ventanamicro.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "heiko@sntech.de" <heiko@sntech.de>, "Li,
 Haicheng" <haicheng.li@intel.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Topic: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Index: AQHaP65h4Tgp9DgCwEu/ue2vJWxme7DcmyaAgAAk0gCAC9siMA==
Date: Wed, 24 Jan 2024 07:21:14 +0000
Message-ID: <DM8PR11MB57515558DE051F2246907FE8B87B2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240105080830.3738117-1-xiao.w.wang@intel.com>
 <20240116-9f09b002afc2337ab5e41e3f@orel>
 <1153d2dd82cf43adb6062627d8d89b27@AcuMS.aculab.com>
In-Reply-To: <1153d2dd82cf43adb6062627d8d89b27@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|IA0PR11MB8303:EE_
x-ms-office365-filtering-correlation-id: 500c5e9f-683b-4ac3-8f98-08dc1cad0c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+ZE2T9Sam30bueEBUp147IMqEUbHiUd1UNkLY1Yo7GZe5cDkG+o41q82bq+Ivwm47mrH3TxZaxEEsKic4nI1ZzGL5spPE87ZUbP0LNPNnLJ5a2paF1FDyI10Y1r56mFmNRvokYRye8YHchkFY4BfRPhSGeAKS9Id3h89liCM/K6EnXHRGERWVRxRuWA3QE4EaRTKNgihklPdfYC6ynA1Sg+7XyF7n2dUnkom2JtxpvmskhHEdN70W1gutd4bLHG6YkxlVVomPpq2mUgjm6Vg1LRNlj2wXmDFIJPRWZehBo2pSVVUWcWVFdib3mvJ8xciTSJYfUi0Yrqb2NsUyovq69EGhkO1Nn/xyewC+GcGbsE/Oj8ceYvX0ZrCV2Yp5Xr2Re9rcVIUbD06/57vpn4Gze2UmgVFQhtJS9AYJRoE3w1g5dJyKXwibWbWVxiAHuYzhflH+kc7X4nOFHFpbvLlkBoSoQPSdom1qhkQVOjZPM4dbDeMxRgSeCN7O6v+id5xCC+SjzLf7l2//VSZ8OpIpxvM6RHdqQ1qLk6MZTv7TYv4EL9TJeWGRom4fhoopy3ApB8B7PabWT+YFHg7nvd7eYRMDBN+kR3PIhlPIy2ELD1AEF6+eYKg8l5qVigKlJ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(55016003)(26005)(4326008)(478600001)(8676002)(8936002)(110136005)(52536014)(5660300002)(66446008)(82960400001)(64756008)(316002)(66476007)(66556008)(54906003)(86362001)(66946007)(38100700002)(2906002)(76116006)(9686003)(53546011)(122000001)(7696005)(6506007)(71200400001)(38070700009)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxlM09kUmROOStvUkV3eW43YWJJUDU5M05WazNjbXlzOEYwZEE5MU1yVmc4?=
 =?utf-8?B?dXBua2FjYzBJNFNrSHU5NnlWMWR1RlpvZDN5MTArRm9iYm5BeEh4ZUtNRjAv?=
 =?utf-8?B?bGl5VGJIOFdROWVOM2dUQWRUMk1LdEtvenc1bHdabEV4VUFuT3EwcGhLWXla?=
 =?utf-8?B?TThyWnliVURKYUhnZVJYQUR4SkhuQnRnVHp0aDVMcnVVYTFyMStlMzVFK0do?=
 =?utf-8?B?RnR1bTZOSkhFNDFsbE1xM1B6Sm1sSmRnQy9zRnNFcVFodmp2Z0hkMlhGTlBW?=
 =?utf-8?B?UnRiaWZqQXVLbE5XZFg0cHU1SXMyU3RmS0I3cmJBM1RucjdUSFFIK1NIYWor?=
 =?utf-8?B?MjBvWDV6ZVkwaHdsQWhjS1Z4cmpPSmxTaWdyVVptRUhrUFNFSjl0dDExNGM3?=
 =?utf-8?B?WGVhM0Y5UzF6VWxyV0p1aFk1LzZxRTNHSEY1dndyRnpIZjQySFhGR3k3TlVx?=
 =?utf-8?B?V0MrMTFlcFh5NWVOTHY2S1MwcmRkdEZDaHZWTGZzSi8wbGlDMVlyL21aSVBV?=
 =?utf-8?B?Qnl4TkhFd09EZStpMEgwWmFLVG9yY0VWVWhvUEVvQVBKRlZzZWFOcEx3MTFP?=
 =?utf-8?B?TDIwbjc2WE5LTmpocGlIYmo0b3R1REcvZndZWWdMOWlSV2IrL2NGNlFRWEND?=
 =?utf-8?B?ekZxNmxZemFCbC9CNnNvSm0xSnUyUkZILzdkOU9TYmR1QVZHUFl2a0xyeWE2?=
 =?utf-8?B?djNIc1RMa2ZuRjFlNEt0czRFUmYxWmhlTDJrTXJWYVlVaXJPY0Zxd0ZGWlUr?=
 =?utf-8?B?eGt0V3pqZnZVcjBFTmU5NVhKUSt0eDA4WHFYREpwNkRodzNzZTZIOXZBNGZJ?=
 =?utf-8?B?NEl5Sm1ONlJPWElkRFpDZVVRRXZzT2RtaFBydm5NcmZVYXFqb0YxNDRCRGtS?=
 =?utf-8?B?b21TMHdCMG8yUlhQV0xHOTZLWUtxS01LNGZ6ekxmNmlZc3p4YmZRYjRNdTlX?=
 =?utf-8?B?QXlhbnVvTXh2Qm5qMEZhVmNqWktWcUs1NCtqWWxaQ04vWmk3RnpVMklQMG9Q?=
 =?utf-8?B?Wko2YWkzaUd2dmhXd3VvMDJaYlNSYUhqTURWWC8xTTRWcEY2QjFLcHNKRnE5?=
 =?utf-8?B?SXA2dDdlbnhIb29ORFNaSzlEOFkvTXQ4M1RFL1pla1l4ZzlzREd2RGZqT0No?=
 =?utf-8?B?Y0E5Zmx0RnIvbVlwdndEMWhETWhUZ2pSRjY1OXlPdWh4MXlEeUVXRDNyV0hu?=
 =?utf-8?B?emRkdE45TWY0bmVvckNqeTF2aGE4Njh5eWllcGprS1c0S3lqaHlLdzhhbVR6?=
 =?utf-8?B?WUxTZ1RNSFAvZmhDaFVVaGFlNU94N0xMM0ZuVGdaenIzaXNRM3lBbGxSNlJv?=
 =?utf-8?B?ekhQTWtCR0NhWUZSRktCR0x3OWJhMk1Db1NUU0JtNHo4eGhKTHFTYllFeDl6?=
 =?utf-8?B?RXNlMVhpNWpWT3dEMTQvbHM2Kzh5ckhuWkJmWWtBaFIxS2tIQ3pWSVY5RWNm?=
 =?utf-8?B?U0hpMXFhYjFJSnZ0ZmtGYkt3ekpOeDl5US9IWHY1VzhtR0NyQVlvc2M2NDBD?=
 =?utf-8?B?dlNWZWxaTUVmei9lcmFnckhhQ1prSmh5QzA2UW9uK0s5R1ZBZU4rdkVLaW5w?=
 =?utf-8?B?dEtvc3QrUlFNYkVScXYybjRWNjJWQmpteUNVS3IycURidVZqNncvSDVXTFRI?=
 =?utf-8?B?bEpjZG9MWEtYTkpxdHphQmRmWk9KZys1S0xnc3B0MjlFR2RXSmtlVWRnUitG?=
 =?utf-8?B?ZEdIYnRsTmsreUFLckY2K3lmamRXTFZDMDBPLy85RlJ6ekRxbjBuY05lZUdH?=
 =?utf-8?B?NzZvd3ZXSGxkcU9QcjZZMkhHd2lYTUpYY1UrOXZ5NlhsRUFVNEpyMlVNWE5k?=
 =?utf-8?B?RTIyUEQxZ25DbENoTURYeTBFSWJjMnluUEtKLzRBWEM0bEVucFNGN1FsZTQ0?=
 =?utf-8?B?NS9ZWG1VSkpCL2lTQVFaS2NpNWNKYkg5ajk5S2I1YXBFZEVmTnJBbHYzNHdS?=
 =?utf-8?B?QWhZdlhOYm5WR3RzSWpPNGM0WkxXc3VnUXh5bDVISEkzSTkvNk04bWREZ0w3?=
 =?utf-8?B?ZU0xNUtVdmp1czRCVGFtR3dxNEJBZkZrUzhrMk04UUlqVFZ1ZXZBM25sZXBP?=
 =?utf-8?B?b3hWRGRxQm03YUZzNlNFQ3FFM284NjNlMGViYS9xZzhMYXhqOE55bEdkcVBQ?=
 =?utf-8?Q?3lzgUCVfu0GI6bD0sgMXsDeaF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c5e9f-683b-4ac3-8f98-08dc1cad0c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 07:21:14.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBMVBqpGFER8L19mHnOZQfXEHyzPwhVwLJkcgv2IeW2rehVR4YZXohv9VSq9d+IpuJCQWD4Yhz+aWj30rlQO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

SGkgRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
TGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51
YXJ5IDE3LCAyMDI0IDE6MTYgQU0NCj4gVG86ICdBbmRyZXcgSm9uZXMnIDxham9uZXNAdmVudGFu
YW1pY3JvLmNvbT47IFdhbmcsIFhpYW8gVw0KPiA8eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiBD
YzogcGF1bC53YWxtc2xleUBzaWZpdmUuY29tOyBwYWxtZXJAZGFiYmVsdC5jb207DQo+IGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdTsgY29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb207IGhlaWtvQHNudGVj
aC5kZTsgTGksDQo+IEhhaWNoZW5nIDxoYWljaGVuZy5saUBpbnRlbC5jb20+OyBsaW51eC1yaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSRTogW1BBVENIXSByaXNjdjogT3B0aW1pemUgY3JjMzIgd2l0aCBaYmMgZXh0
ZW5zaW9uDQo+IA0KPiAuLi4NCj4gPiA+ICtzdGF0aWMgaW5saW5lIHUzMiBfX3B1cmUgY3JjMzJf
bGVfZ2VuZXJpYyh1MzIgY3JjLCB1bnNpZ25lZCBjaGFyIGNvbnN0ICpwLA0KPiA+ID4gKyNpZiAo
QklUU19QRVJfTE9ORyA9PSA2NCkNCj4gPiA+ICsJCQkJCSAgc2l6ZV90IGxlbiwgdTMyIHBvbHks
IHU2NCBwb2x5X3F0LA0KPiA+ID4gKyNlbHNlDQo+ID4gPiArCQkJCQkgIHNpemVfdCBsZW4sIHUz
MiBwb2x5LCB1MzIgcG9seV9xdCwNCj4gPiA+ICsjZW5kaWYNCj4gPg0KPiA+IEhvdyBhYm91dCBj
cmVhdGluZyBhIG5ldyB0eXBlIGZvciBwb2x5X3F0LCBkZWZpbmVkIGFzIHU2NCBmb3IgeGxlbj02
NA0KPiA+IGFuZCB1MzIgZm9yIHhsZW49MzIgdG8gYXZvaWQgdGhlICNpZmRlZj8NCj4gDQo+IHVu
c2lnbmVkIGxvbmcgPw0KDQpZZXMsIGl0J3Mgc2ltcGxlci4gdGhhbmtzLg0KDQo+IA0KPiAuLi4N
Cj4gPiA+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBsZW47IGkrKykgew0KPiA+ID4gKyNpZiAoQklU
U19QRVJfTE9ORyA9PSA2NCkNCj4gPiA+ICsJCXMgPSAodW5zaWduZWQgbG9uZyljcmMgPDwgMzI7
DQo+ID4gPiArCQlzIF49IF9fY3B1X3RvX2JlNjQoKnBfdWwrKyk7DQo+ID4gPiArI2Vsc2UNCj4g
PiA+ICsJCXMgPSBjcmMgXiBfX2NwdV90b19iZTMyKCpwX3VsKyspOw0KPiA+ID4gKyNlbmRpZg0K
PiA+DQo+ID4gQ291bGQgd3JpdGUgdGhlIGFib3ZlIHdpdGhvdXQgI2lmZGVmIHdpdGgNCj4gDQo+
IEhhdmVuJ3QgSSBzZWVuIGEgYnBmIHBhdGNoIHRoYXQgcmF0aGVyIGltcGxpZXMgdGhhdCBieXRl
c3dhcA0KPiBpcyBsaWtlbHkgdG8gYmUgdHJ1bHkgaG9ycmlkPw0KPiANCj4gSSd2ZSBub3QgdHJp
ZWQgdG8gcGFyc2UgdGhlIGNyYyBjb2RlIChhbHRob3VnaCBJIGRvIHVuZGVyc3RhbmQNCj4gaG93
IGl0IHNob3VsZCB3b3JrKS4gQnV0IEknbSBzdXJwcmlzZWQgeW91IG5lZWQgYSBieXRlc3dhcC4N
Cj4gDQo+IEFmdGVyIGFsbCwgdGhlIGNyYyBpcyBiYXNpY2FsbHkgYSBsb25nIGRpdmlzaW9uIG9m
IHRoZSBidWZmZXINCj4gYnkgdGhlIGNyYyBjb25zdGFudC4NCg0KRm9yIHRoZSAqX2JlIG1vZGUs
IHRoZSBBUEkgZXhwZWN0cyB0aGF0IHdpdGhpbiBlYWNoIGJ5dGUgZnJvbSB0aGUgZGF0YQ0Kc3Ry
ZWFtLHRoZSBoaWdoZXIgb3JkZXIgcG9seSBiaXQgc2l0cyBhdCBtb3JlIHNpZ25pZmljYW50IGJp
dCBwb3NpdGlvbiwgYW5kIHdpdGhpbg0KdGhlIHBhcmFtZXRlciAidTMyIGNyYyIsIHRoZSBoaWdo
ZXIgb3JkZXIgcG9seSBiaXQgc2l0cyBhdCBtb3JlIHNpZ25pZmljYW50IGJpdA0KcG9zaXRpb24s
IHJlZ2FyZGxlc3Mgb2YgQ1BVIGVuZGlhbm5lc3MuDQoNCkFmdGVyIHRoZSB1bnNpZ25lZCBsb25n
IGRhdGEgbG9hZGluZyBmcm9tIG1lbW9yeSBpbnRvIGEgcmVnaXN0ZXIsIHRoZQ0KImhpZ2hlciBv
cmRlciBwb2x5IGJpdCBzaXRzIGF0IG1vcmUgc2lnbmlmaWNhbnQgYml0IHBvc2l0aW9uIiBpcyB0
cnVlIGZvciBlYWNoIGJ5dGUsDQpidXQgbm90IGZvciB0aGUgd2hvbGUgcmVnaXN0ZXIgb24gYSBs
aXR0bGUgZW5kaWFuIENQVS4gSW4gb3JkZXIgdG8gZG8gdGhlIFhPUiBpbg0KcyBePSBfX2NwdV90
b19iZTY0KCpwX3VsKyspLCBhbmQgaW4gb3JkZXIgdG8gcnVuIHRoZSBDTE1VTCBpbnNuIGF0IFhM
RU4NCnNjYWxlLCB3ZSBuZWVkIHRvIHJlYXJyYW5nZSB0aGUgd2hvbGUgcmVnaXN0ZXIgYml0cyB0
byBnZXQgdGhlbSByaWdodGx5IG9yZGVyZWQuDQoNCj4gDQo+IFRoZSBDUkMgSSd2ZSBkb25lIHJl
Y2VudGx5IGlzIHRoZSBoZGxjIGNyYy0xNi4NCj4gTXkgbmlvcyB2ZXJzaW9uIChhbHNvIG1pcHMt
bGlrZSkgaGFzOg0KPiANCj4gc3RhdGljIF9faW5saW5lX18gdWludDMyX3QNCj4gY3JjX3N0ZXAo
dWludDMyX3QgY3JjLCB1aW50MzJfdCBieXRlX3ZhbCkNCj4gew0KPiAjaWYgZGVmaW5lZChjcmNf
c3RlcF9jaSkNCj4gICAgIHJldHVybiBjcmNfc3RlcF9jaShieXRlX3ZhbCwgY3JjKTsNCj4gI2Vs
c2UNCj4gICAgIHVpbnQzMl90IHQgPSBjcmMgXiAoYnl0ZV92YWwgJiAweGZmKTsNCj4gICAgIHQg
PSAodCBeIHQgPDwgNCkgJiAweGZmOw0KPiAgICAgcmV0dXJuIGNyYyA+PiA4IF4gdCA8PCA4IF4g
dCA8PCAzIF4gdCA+PiA0Ow0KPiAjZW5kaWYNCj4gfQ0KPiANCj4gSSBub3JtYWxseSB1c2UgYSBj
dXN0b20gaW5zdHJ1Y3Rpb24gZm9yIHRoZSBsb2dpYyAtIG9uZSBjbG9jay4NCj4gQnV0IHRoZSBD
IGNvZGUgaXMgb25seSBhIGNvdXBsZSBvZiBjbG9ja3Mgc2xvd2VyIHRoYXQgdGhlIGJlc3QNCj4g
dGFibGUgbG9va3VwIHZlcnNpb24uDQo+IE9uIGFueXRoaW5nIHBpcGVsaW5lZCBhbmQgbXVsdGkt
aXNzdWUgdGhlIEMgY29kZSBpcyBsaWtlbHkgdG8NCj4gYmUgZmFzdGVyIHRoYW4gYSBsb29rdXAg
dGFibGUhDQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIGNvZGUgcGllY2UsIGJ1dCBpdCBsb29r
cyBvbmx5IHRoZSBsZWFzdCBzaWduaWZpY2FudCBieXRlDQpvZiAidWludDMyX3QgYnl0ZV92YWwi
IGlzIGludm9sdmVkIGluIHRoaXMgY3JjMTYgY2FsY3VsYXRpb24sIEkgZG9uJ3QgdW5kZXJzdGFu
ZA0KaG93IGl0IGNhbiB3b3JrLg0KDQpCUnMsDQpYaWFvDQoNCj4gSSBkb24ndCBrbm93IGlmIGFu
eSBvZiB0aGUgMzJiaXQgY3JjIGNhbiBiZSByZWR1Y2VkIHRoZSBzYW1lIHdheS4NCj4gDQo+IAlE
YXZpZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxDQo+IDFQVCwgVUsNCj4gUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg0K

