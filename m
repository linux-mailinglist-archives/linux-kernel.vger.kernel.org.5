Return-Path: <linux-kernel+bounces-92510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CE872161
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BD71C22042
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7786636;
	Tue,  5 Mar 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEjRDV66"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1C85C61
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648527; cv=fail; b=luMiiX5jUi4+E3Z2XqB3gFrYXfk1dPubz7UKxtEuZeu3abH0kP8JgJDaTg09eqQaUc9WHNC8LaVvDHTolYBCvnzfagTmu4R76Y16b/KXdJcMSfgXIihOcYViJRMmTTDt8/5MMuTYvaaReNewZ4By4IGNsOBl7fHTpyYaRseVxsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648527; c=relaxed/simple;
	bh=CUTPhdoORarIYgxpris/3FNMU/CDSRnLUpbxAVvWTeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j3Wf+NPfToW3DGKaqIqll4M016h+K/YmzBmFoTVBRYT6XkAnV8u6fkVCTqf7d+/X6PpKr1RfjA2umj0PPR18BRWp6ZJO229LwPEVgkwtl89Bau5b54mvJGxbA2tkQOeQeEP9yVPD1CtCWoIe5e6Q+xzw1/gpjXmd+9z1XycRc8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEjRDV66; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709648525; x=1741184525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CUTPhdoORarIYgxpris/3FNMU/CDSRnLUpbxAVvWTeo=;
  b=XEjRDV66Q5LblDwMsuink41xuaE3+HBVUkQt3SasleWNnIuI5ko+3bCl
   6+GGwcJ1ccPndA2O+4AE/uCYQKfPPRypfqcl1x4MEXYJSVPWKCnocyovy
   ad4lvllOJjcnQkG4nP61Hcfw4/1SVPgOFa3k1KCZNC4ZhBO5QDICI5c/K
   U6XbxzVfMBM+PODyvC+Tei7f0ufG2p6Z78ANb2qK9LhJTtLVit7vO8dIE
   ttt4NL0DvAYJ0orwzWaBPhpK1kfjPn2VIC7vx+p0TyNsp4M8QSvcZGvDD
   m1v+35/F4DUwmhm+KV9exSxR5OnQ5hGr5GcCihyeChcR+49UnGTK0sKX0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4784585"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4784585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13974193"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 06:22:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:22:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:22:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:22:01 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 06:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AebNpDp0tQ8l+pD+JGmFvowdR0ZiMTR8K2NuMrj4WVVa6ORtweiO9S0mo75iZPf9k4pQez+gz/+hFMv1Pp1JDJL2o0t1qQ/li+QAaBGvgGEgk/zuiVntqRJcefBAFDshxVgwhODoJDpb+VGpgj7w6VWDzbr5rUhCdhel6LuVuRF8XpVg6HmXPs4haB5BLXXTNulduIP3X+OlOfNo9cA6k9JNcHcvcNVG+LhtTYTx5+KXOkOTGPldxBDQ8Y8BV1t6DcVvqqU7IarZ+gGoTS2MCJJ8c1f8mJumpXnoKYGDyheCAsFrMjaJ3zhm7jhAbscHc+q+MUgsM/n8toUlp8e5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUTPhdoORarIYgxpris/3FNMU/CDSRnLUpbxAVvWTeo=;
 b=TAA4sVWCCTFSqZ9QZnitVIn6enI2XxRapTSdpWypJISGIJZbfIlhnlP5Ym94DfUdWLrRhr8dnFTZAAdixhiGI6SUmkwJsvSK+VDI2NCINnBWpXX/vmFjIjlWEAw0kDZY4+YovVjuhgy0pYhmnKFQcFB1u6UPLZjt+NWsLGPu3Kd2YtHbH32i7lbjXS23zSuIKPkw/Qx7njHnKj3rYMuOS70nGplXbhMzXU4LkPvbAHtbfVH8pwiTV+0mnlLWi/9gliCA1xi/GnTxoD2wOAXYyISBx8ffs12K9vQ23som9x4vbq7hl0tcf4IrtaS7v5+nXk/oy8pw1Zj79KlkjIoxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 14:21:45 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:21:45 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHaamc6S3UimQVv90Kct5lCKqBGwbEf+/WAgAAOAYCAAojygIAFGOOAgACeWICAAPHyAA==
Date: Tue, 5 Mar 2024 14:21:45 +0000
Message-ID: <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
	 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
	 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
	 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
	 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
	 <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
In-Reply-To: <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SN7PR11MB6875:EE_
x-ms-office365-filtering-correlation-id: a3bc9456-5951-40b7-448e-08dc3d1f9645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yor++FCJTXguCe9hnUEgLK7iEGadtcfP+auc1mrUNRvhsGRq2Ovi07cQHUe/DQcNlcPOMPjyxF1p+LiCsZKf19aZj/dNLpeQ4ZmVYwUuJMPrV0XKHYY5CFK4TBW3ksFuf2qW65o5yj1dV08jTQz0v+XeQevTOvtaxpbjplq4N/q07vAcwW6pDtdJdsjpFQKf3SBSGsgvUpR8Pd47aZcL5MavgNfLtNEAEnBAjHuTPqDSx88M6TeeJYtx2JX4ehOqUGS6QWQVQPzkAd8dLvFrl4DHZdyeth6OHImTWzJC6DOgyv4B3zoJqEjm4gr5RqePj/Q2Y//iNAnW+3mPBDtu8k4VWL+wCV94Kf+vXQaKfVpWRPcy+1Ta1VJ57LkrW51ytzD+wJG2mN0NexrcbqrteoRI1rpswYx8rIaFaTBOQHklqKtNcAQ1fQuU4X+lQWNXj2xqqrE6b8zM5FY2oh2/Et4kC6Bg8hsKOIvcUz0kDdPyc442sC8tbKXBaB1+EUy5riAiSqgRULEkure8xlViRTzPhDFgpRrXYO0D2eiCyFOvOKPGRWxK6Zw+KR0iyKDqT/4Z6DNHGClvhHK8K1Ah5kITxMVgWSkdUJHI5frzmHo5B9d4QEOKSi13Aq2JVoSPdy2p55Z2FSApZzSxAd0cJa6ye8x2sZ5pxXtu/gYpZmo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjdkRDUyMWFDZ1c2WGVKbjNDRkRXKzh2RXliRXJ6OW1qSHY5Sm5uU0MrS0o1?=
 =?utf-8?B?dkRpeEdTZUdQQjBTZDVkU2xFZTMreDlnWHdJZGtNSVBmemJobDI1a1Y1QTQ1?=
 =?utf-8?B?SnlwajZ4bXRqZjdXNE53azhTb3Y2ZGNhMWxwZ0J4Q2lwamJEdldFakpFakds?=
 =?utf-8?B?NTRreVplMXY2TXlUaUJYaVRGWnNVU3NPRXcxUktyRUVHbGsycEtTMVI2VFpK?=
 =?utf-8?B?Wk45TWdacXpIMG4yaEF0ZUNqK3ZJVDZhblFTNjdwelRYbEVndXBvU29BY2Rk?=
 =?utf-8?B?OG96WHZrZDJNY2FldDhEWTZCZ0xUSmkxSjJCK3pUU3dJempZZTZXOGlKVzJW?=
 =?utf-8?B?MTE3VkJNMUNra09GK3JkanliM3dheFQwSUNKVERHeWlUZjVMbUJpcGpXVVlN?=
 =?utf-8?B?eUtNQjFMYU53ejhtNWx3SXp0SGRrZWowNUYrREdQRWkzaCs3czdneWFCeTdp?=
 =?utf-8?B?aFVDbkFrTmhxSE1iNmtIRVExWXBWQkVIMGFOZ2ZERXYxK1NDZ3NvN0VRZDNN?=
 =?utf-8?B?MytIZDdKZVhjQ2FtYWthei9XdHVoWmVzcjZVQ0FjZ0dyanRmc0txK3NEeHgy?=
 =?utf-8?B?WnBROFUzSXB1ay9xTGpwbDlsb21WeVArd2VXMDk1R1dIa3NlK0pxb3FscVlR?=
 =?utf-8?B?QmdrNXVXV0FpY3pBMHNobVZpTG04eDlVMWJQZndxVHlhcUVlNG1JcjlrYlRE?=
 =?utf-8?B?Skw5KzdiMkdDendhcXJFRVVKbFU0bXI0QkJiVzgxeWVMYVEyQnRmMEN2SkNS?=
 =?utf-8?B?dVFiKzFMTmdudlkzYmhsanhBNmZqc1JPVng4b1ZDb1k5bWZkSERxc3R4NDFR?=
 =?utf-8?B?YUNMbEZCb2dsTEZaSlhLdWpKZWVlSmJnYzJTKzZQcE1FRlU2QlRTczRLTmZ1?=
 =?utf-8?B?NVlwRnN1cEU0YjZyT0d6UU9BNGFTNGxaOTlZZzRzV3JDKzdvTHBBNCtQQTNj?=
 =?utf-8?B?clZNaFJKQjl0ZkV6Q3FiWnBzUnB5QVFDVG9rRGE0YjlaMTZTNjI2a2QyM3d2?=
 =?utf-8?B?WGxNa2w4TU5mTGNrMHFTM3ZKZEVKZDlWaWhPRGlCeGlFeWNxcXZOQTdTMTRP?=
 =?utf-8?B?U2Jld0xQY2wzRmdRb09oQzAycXZpTnB5azZYQlNNRkpPQllKWHRqZnBnNklX?=
 =?utf-8?B?TGJMSm83Um9SZm4zdzRHQ0N3bnhRRXRYYjVFNDBuU0Z6WEdYMm9QVEZWZ3l1?=
 =?utf-8?B?UUVXOCs4MU1xTGF1enFjVEE1blE0LzR5Zk1ESW5pNDN4c0VoSVdFSWk2a1l2?=
 =?utf-8?B?MXdUNmdvZzgzSlhrVFF2QWNYMSs5NXM0clBLWWd5Z0dqd2hWRWNlL2t5UHV0?=
 =?utf-8?B?dXNHbmU2K0svTEdFYlIraWdNeXFCWGNKeXhaNHZXcmZqWUphckVEOENIdXVY?=
 =?utf-8?B?VWJLS1hveU93eWM2QnlHMVY0NHh3UXhhLzgxeHBXaVQ1aFd1K29LUkFjQ2I2?=
 =?utf-8?B?ZmRRb29Qd2Z1c2NPUE1DTkFhbkdvV0Y0Q0V5b1BJYVVyRnhzM1BEaUFuMW9U?=
 =?utf-8?B?d1dwRVVmMlByb2R4VkJMKzBsaDhVVmIvY3J4MFM2eEJEZFpPbmNhUkhLZ1hv?=
 =?utf-8?B?VkhPbjBYbGcwdUxJWWNsR2ZYTStkZFllUUY5T0JhdWh3QmVKdnlPMUpMWWlK?=
 =?utf-8?B?dUdSTTc5NXdINWN5dEYyNVBEYldmY09qZDA3dmwxWEp0ZDhjT3ZsQVRLMUJQ?=
 =?utf-8?B?bmxGc2VTMktxcFB6U3ZrVmlNNDFGT0JFRTZvL2tXWXNqOXpxQ05GVUdnQWdU?=
 =?utf-8?B?cTNLMW9hcC9kTWVpZEVrelZFRTdNZXo2Q2ZjTEExdlBmMkRndXZIOW5PRUNx?=
 =?utf-8?B?aTM0V2MrdTZGMUU0aVR4Y3hSaW12K3k0ZVZYN3pwY3dBVTZOUCtLUjgyeTBK?=
 =?utf-8?B?akkvSDJ6ckF4Z3ZpRHMwUkJDT1YrM2F3TXg3S0RReW5wbTdhWXdkb3phaG5O?=
 =?utf-8?B?aWpxYTVhUExTSkFSc3dBNldUczMzZFpjaDJxSlZGaDBCWEFwdkdpZ3pXNHNy?=
 =?utf-8?B?YjlqQWFyZTRidHE3QkYyTUdXMFBtV1EzbjZoYXdrejU2Q1VnVGdpVzFnbjdD?=
 =?utf-8?B?eE5EM1N6aWVXTWVMWWhQMFZVbVhqRWh0TGNmdi9JTzNDenFOelFzYkJScXk5?=
 =?utf-8?B?YisxRi8zU3NoMTUzTkx3UmZvQTkvQytVekd2dzhjT0RpbjRYWWFibXNEeEdu?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214E8EC954AC5446B1B2607095313CB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc9456-5951-40b7-448e-08dc3d1f9645
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:21:45.4004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nI7rbbHjjNIMY7C/ZGuQAk76gBylDCyUOo+twF5o3PEhQa++AUHfS5gdFV5o4420JbqVDO7W334Ligyg0JzFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDE3OjU1IC0wNjAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDA0LCAyMDI0IGF0IDAyOjI5OjAzUE0gKzAwMDAsIEpvc2UgU291emEg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDI0LTAzLTAxIGF0IDA5OjM4ICswMTAwLCBKb2hhbm5lcyBC
ZXJnIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIwMjQtMDItMjggYXQgMTc6NTYgKzAwMDAsIFNv
dXphLCBKb3NlIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJbiBteSBvcGluaW9u
LCB0aGUgdGltZW91dCBzaG91bGQgZGVwZW5kIG9uIHRoZSB0eXBlIG9mIGRldmljZSBkcml2ZXIu
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEluIHRoZSBjYXNlIG9mIHNlcnZlci1jbGFzcyBF
dGhlcm5ldCBjYXJkcywgd2hlcmUgY29ycG9yYXRlIHVzZXJzIGF1dG9tYXRlIG1vc3QgdGFza3Ms
IGZpdmUgbWludXRlcyBtaWdodCBldmVuIGJlIGNvbnNpZGVyZWQgZXhjZXNzaXZlLg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBGb3Igb3VyIGNhc2UsIEdQVXMsIHVzZXJzIG1pZ2h0IGV4cGVy
aWVuY2UgbWlub3IgZ2xpdGNoZXMgYW5kIG9ubHkgc2VhcmNoIGZvciB3aGF0IGhhcHBlbmVkIGFm
dGVyIGZpbmlzaGluZyB0aGVpciBjdXJyZW50IHRhc2sgKHdyaXRpbmcgYW4gZW1haWwsDQo+ID4g
PiA+ID4gPiBlbmRpbmcgYSBnYW1pbmcgbWF0Y2gsIHdhdGNoaW5nIGEgWW91VHViZSB2aWRlbywg
ZXRjLikuDQo+ID4gPiA+ID4gPiBJZiB0aGV5IGxhbmQgb24gaHR0cHM6Ly9kcm0ucGFnZXMuZnJl
ZWRlc2t0b3Aub3JnL2ludGVsLWRvY3MvaG93LXRvLWZpbGUtaTkxNS1idWdzLmh0bWwgb3IgdGhl
IGZ1dHVyZSBYZSB2ZXJzaW9uIG9mIHRoYXQgcGFnZSwgZm9sbG93aW5nIHRoZQ0KPiA+ID4gPiA+
ID4gaW5zdHJ1Y3Rpb25zIGFsb25lIG1heSB0YWtlIGluZXhwZXJpZW5jZWQgTGludXggdXNlcnMg
bW9yZSB0aGFuIGZpdmUgbWludXRlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQncyBhbGwgbm90
IHdyb25nLCBidXQgSSBkb24ndCBzZWUgd2h5IHlvdSB3b3VsZG4ndCBhdXRvbWF0ZSB0aGlzDQo+
ID4gPiA+IGV2ZW4gb24gZW5kIHVzZXIgbWFjaGluZXM/IEkgZmVlbCB5b3UncmUgYm94aW5nIHRo
ZSBwcm9ibGVtIGluIGJ5DQo+ID4gPiA+IHdhbnRpbmcgdG8gc29sdmUgaXQgZW50aXJlbHkgaW4g
dGhlIGtlcm5lbD8NCj4gPiANCj4gPiBUaGUgb3RoZXIgcGFydCBvZiB0aGUgc3RhY2sgdGhhdCB3
ZSBwcm92aWRlIGFyZSB0aGUgbGlicmFyaWVzIGltcGxlbWVudGluZyBWdWxrYW4gYW5kIE9wZW5H
TCBBUElzLCBJIGRvbid0IHRoaW5rIHdlIGNvdWxkIHNoaXAgc2NyaXB0cyB0aGF0IG5lZWRzDQo+
ID4gZWxldmF0ZWQgcHJpdmlsZWdlcyB0byByZWFkIGFuZCBzdG9yZSBjb3JlZHVtcC4NCj4gDQo+
IGl0J3Mgc3RpbGwgYSB2ZXJ5IHZhbGlkIHBvaW50IHRob3VnaC4gV2h5IGFyZSB3ZSBkb2luZyB0
aGlzIG9ubHkgb24NCj4ga2VybmVsIHNpZGUgb3IgbWVzYSBzaWRlIHJhdGhlciB0aGFuIGRvaW5n
IGl0IGluIHRoZSBwcm9wZXIgcGxhY2U/ICBBcw0KPiBKb2hhbm5lcyBzYWlkLCB0aGlzIGNvdWxk
IHZlcnkgd2VsbCBiZSBhdXRvbWF0ZWQgdmlhIHVkZXYgcnVsZXMuDQo+IERpc3Ryb3MgYXV0b21h
dGUgZ2V0dGluZyB0aGUgY29yZWR1bXAgYWxyZWFkeSB3aXRoIHN5c3RlbWQtY29yZWR1bXAgYW5k
DQo+IHRoZSBsaWtlLiAgV2h5IHdvdWxkbid0IHdlIGRvIGl0IHNpbWlsYXJseSBmb3IgR1BVPyAg
SGFuZGxpbmcgdGhpcyBhdA0KPiB0aGUgcHJvcGVyIHBsYWNlIHlvdSBsZWF2ZSB0aGUgcG9saWN5
IHRoZXJlIGZvciAiaG93IGxvbmcgdG8gcmV0YWluIHRoZQ0KPiBsb2ciLCAibWF4aW11bSBzaXpl
IiwgInJvdGF0aW9uIiwgZXRjLi4uLiBvdXRzaWRlIG9mIHRoZSBrZXJuZWwuDQoNCldoZXJlIGFu
ZCBob3cgd291bGQgdGhpcyB1ZGV2IHJ1bGVzIGJlIGRpc3RyaWJ1dGVkPw0KVGhlcmUgaXMgcG9y
dGFibGUgd2F5IHRvIGRvIHRoYXQgZm9yIGRpc3Ryb3MgdGhhdCBkb24ndCBzaGlwIHdpdGggc3lz
dGVtZD8NCg0KPiANCj4gRm9yIHRoZSBwdXJwb3NlcyBvZiByZXBvcnRpbmcgYSBidWcsIHdvdWxk
bid0IGl0IGJlIGJldHRlciB0byBpbnN0cnVjdA0KPiB1c2VycyB0byBnZXQgdGhlIGxvZyB0aGF0
IHdhcyBzYXZlZCB0byBkaXNrIHNvIHRoZXkgZG9uJ3QgcmlzayBsb3NpbmcNCj4gaXQ/IEkgdmll
dyB0aGUgdGltZW91dCBtb3JlIGFzIGEgInByb3RlY3Rpb24iIGZyb20gdGhlIGtlcm5lbCBzaWRl
IHRvDQo+IG5vdCB3YXN0ZSBtZW1vcnkgaWYgdGhlIGNvbXBsZXRlIHN0YWNrIGlzIG5vdCBpbiBw
bGFjZS4gSXQgc2hvdWRsbid0DQo+IGJlIHZpZXdlZCBhcyBhIHRpbWVvdXQgZm9yIGhvdyBsb25n
IHRoZSAqdXNlciogd2lsbCB0YWtlIHRvIGdldCB0aGUgbG9nDQo+IGFuZCBjcmVhdGUgYnVnIHJl
cG9ydHMuDQo+IA0KPiBMdWNhcyBEZSBNYXJjaGkNCj4gDQo+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gSSBoYXZlIHNldCB0aGUgdGltZW91dCB0byBvbmUgaG91ciBpbiB0aGUgWGUgZHJpdmVy
LCBidXQgdGhpcyBjb3VsZCBpbmNyZWFzZSBpZiB3ZSBzdGFydCByZWNlaXZpbmcgdXNlciBjb21w
bGFpbnRzLg0KPiA+ID4gPiANCj4gPiA+ID4gQXQgYW4gaG91ciBub3csIHBlb3BsZSB3aWxsIHBy
b2JhYmx5IHN0YXJ0IGFyZ3VpbmcgdGhhdCAiaW5kZWZpbml0ZWx5Ig0KPiA+ID4gPiBpcyBhYm91
dCByaWdodD8gQnV0IGF0IHRoYXQgcG9pbnQgeW91J3JlIHByb2JhYmx5IGJhY2sgdG8gcGVyc2lz
dGluZw0KPiA+ID4gPiB0aGVtIG9uIGRpc2sgYW55d2F5PyBPciBtYXliZSBnbGl0Y2hlcyBoYXBw
ZW4gZHVyaW5nIGxvZ291dC9zaHV0ZG93biAuLi4NCj4gPiANCj4gPiBpOTE1IGRyaXZlciBkb24n
dCB1c2UgY29yZWR1bXAgYW5kIGl0IHBlcnNpc3QgdGhlIGVycm9yIGR1bXAgaW4gbWVtb3J5IHVu
dGlsIHVzZXIgZnJlZXMgaXQgb3IgcmVib290IGl0IGFuZCB3ZSBnb3Qgbm8gY29tcGxhaW5zLg0K
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQW55d2F5LCBJIGRvbid0IHdhbnQgdG8gYmxvY2sgdGhp
cyBiZWNhdXNlIEkganVzdCBkb24ndCBjYXJlIGVub3VnaA0KPiA+ID4gPiBhYm91dCBob3cgeW91
IGRvIHRoaW5ncywgYnV0IEkgdGhpbmsgdGhlIGtlcm5lbCBpcyB0aGUgd3JvbmcgcGxhY2UgdG8N
Cj4gPiA+ID4gc29sdmUgdGhpcyBwcm9ibGVtLi4uIFRoZSBpbnRlbnQgaGVyZSB3YXMgdG8gZ2l2
ZSBzb21lIHVzZXJzcGFjZSB0aW1lIHRvDQo+ID4gPiA+IGdyYWIgaXQgKGFuZCB5ZXMgZm9yIHRo
YXQgNSBtaW51dGVzIGlzIGFscmVhZHkgd2F5IHRvbyBsb25nKSwgbm90IHRoZQ0KPiA+ID4gPiB1
c2Vycy4gVGhhdCdzIGFsc28gcGFydCBvZiB0aGUgcmVhc29uIHdlIG9ubHkgaG9sZCBvbiB0byBh
IHNpbmdsZQ0KPiA+ID4gPiBpbnN0YW5jZSwgc2luY2UgSSBkaWRuJ3Qgd2FudCBpdCB0byBrZWVw
IGNvbnN1bWluZyBtb3JlIGFuZCBtb3JlIG1lbW9yeQ0KPiA+ID4gPiBmb3IgaXQgaWYgaGFwcGVu
cyByZXBlYXRlZGx5Lg0KPiA+ID4gPiANCj4gPiANCj4gPiBva2F5IHNvIHdpbGwgbW92ZSBmb3J3
YXJkIHdpdGggb3RoZXIgdmVyc2lvbiBhcHBseWluZyB5b3VyIHN1Z2dlc3Rpb24gdG8gbWFrZSBk
ZXZfY29yZWR1bXBtKCkgc3RhdGljIGlubGluZSBhbmQgbW92ZSB0byB0aGUgaGVhZGVyLg0KPiA+
IA0KPiA+IHRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrDQo+ID4gDQo+ID4gPiA+IGpvaGFubmVz
DQo+ID4gDQoNCg==

