Return-Path: <linux-kernel+bounces-118806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9488BF90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E05DB28AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E5482D7;
	Tue, 26 Mar 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZAKDEu3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF785647
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449079; cv=fail; b=U3xJFHeb3qQzaI5iB8ZcRL0i40U6ijGKSk/An+ZTS8neR24geMwqm0s9XZqhI8vmv7KgHo+Fq53CsMjp4IMD4DKwUaZyDvRUV0FrWJuWjpBDYmmuNLCJhWLtq8618Nt++0BMRHAtEG9Whaxny66njZXJuQn4z9XSSZO/2gP3PrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449079; c=relaxed/simple;
	bh=TSXTiVjTn3Fpa0olL6u7vCLAnOh8aQ3QrCsKdv8ovCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpaXxLPfACXyDabYC/rMmhf0dSdpOHvOR4nnXcNGnXSxYCBy89HNx348IAKGasAMoqxCoNWIVp/aV3iilqxymgjMrkRCa2Zk0iVIDP3VIfkT0TtSy2U3ltbMs8PS3sFzn1J95NJ8pwi5v8rJ+B7Crn/mI4Xw60shqfSNszkHJ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZAKDEu3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449078; x=1742985078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TSXTiVjTn3Fpa0olL6u7vCLAnOh8aQ3QrCsKdv8ovCg=;
  b=bZAKDEu3RQghCYWgoqaP0uS0vCM/74i2vtOgkwqQ9VIpg1SR1Oq7BGn2
   XM2heWtHN8yK0Lrs3kxeH1cbVXVmGI8SGS9iqmr8xJQZTPdW/ParJYD3D
   TNId7XrG1m0OcJxMPaEXTdA5qoGar6Ds8wviEIx41Jqv5MxkdzcD8edeJ
   RF93rPKjbQ0+kOIxuAVdNbGs362uPwtXH5igI2AdFxCxfQc+O7r5iomXe
   jwjih0hFhB1zo+YxC3Qy+pQy8jqJOqjx4JJwtNpR8naFXky1+yPjwaYhJ
   wlHcc6+gPDLX9l+L45L3fBf6YqmD5258ed+GSObxi6A2lWcrjRE9dhW+H
   A==;
X-CSE-ConnectionGUID: Bd2az+O7QIONM9VXTqDfAg==
X-CSE-MsgGUID: VDjQtdC0QK+syz0F6L3oqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6356048"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6356048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15893977"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:31:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:31:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtrepTemrTwVCtK/wgqQBLJ/YH537VWCCqUlmWoc9WYEpcCWyA4McHn8qNdwS6od+5dwMJ2FV3FSr7IyJXY1ue5jPVrqnTHwNQSKnWWdecmHdB4QhVGRAHgwudkhYhyRj6mplx9dTT0/Kl7xhfKQZTCbswpF4WKcQcbEYsWj6ysfERJYlnVsLGbJ/JI+GB1I8h10oeKQyMBEwEBz/DLivV0sep3K0UT6SSJVfdDLLUA1g784i+Wrr25ndohrDe7JqSHzlD6ARkCJJ5TScDFopUzO+fDGQy7RXgOO6mDawuSPOwTPB6h+bL9dxylCe3lDOIJoViBaFBwAQRYxgJp82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSXTiVjTn3Fpa0olL6u7vCLAnOh8aQ3QrCsKdv8ovCg=;
 b=RhsvGnkgvzS1y2FAyDmlE/ag/SpnVyRVRzlfcvRLJQM2EC1rc215VehVdioHv+Gt7GLatB5AdSC18CRWu+zOR232tqZceS59gbiihYt/l3eN3jN3YD0aXSYgyc4r5uD80CoXAYuqVwa35aIPYtan1oCrKgIhUYJSr4O0mcgkQsARojKebQ5U7U34VXl3RTnrnA3zfFBall2NbYBMOtYttFfDpbsfh1xjvl2+g8N2Trn2a9khj1cDonpZoNUt/yXJYIEZdnD5B5e36JqgzHNL4idJoqt8n/TwqIU8cMmSvCgaqDEY1EP89DXi3BuWNWHpy+03WSGdn0v0n04dLOIp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:31:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:31:14 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv9 10/17] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv9 10/17] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHafqDi8hrQKUdIqk6I9OvheiGwgrFJ1DAA
Date: Tue, 26 Mar 2024 10:31:14 +0000
Message-ID: <44c129d5088c26cf48dd67046de6a2f2babe9978.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-11-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whwaCGRtIWQw+ba/vLudvm4dPdxKntAj1AxZuLfJT688LhKfDTvU/Uz8pdSW4wPlf/4UDJLn3nrG/BoLAUc3X3Bn6sCdHgjaMCmdNEdXuHhgcSRjUgIomCp6UYmTENzsrVGXwH4l7ZnfPOX+tql6KmmWiN5kGFwVASAxBFUmzmGyUXnR4rwmi4MDBPiOJNLJwX/MBi94L3YugCji8WEsTpsxALUZ0ZMOnwjJpooypiQYC+sGGDNeVi1rPi2EYL/3fDxjf2RpxozpLnCsYv7GBRBVgWb5sV+FmgUdNmvNRhWpbBQV8D97BpebVOp4KWww6XKotg+jqFazKvv0+WXCV8I3nDusenYUCAa7jxnGwzmXMsoVp2R2kZksusHJvuLLIdNjWueZoGF7XzrHhN0PS0pEUTa0LpdFVT06363WKhPaWBBmBvokUVP4qtHO/SEquDRVj0lAqbo5WBXwV2W5Dh2AhziM5poPyQWQmftO2a5M8AhCeqzJdcq8USxblhWYa1VsLkhXUnTUo1NUAVvkNk8CU+bpNi3V2G0KpxcalqccBVD1W1ajUTzdICiL8nWneLxuaR/EBMoSYqNDmIuzd8H8ZFyZp0c+9CRu7ZYif5cQZ7djoPf8lly13TCa6OkVvA4z0qmf1pSR3MgmKPFdbed6UIv/W827S5HZhzLGR2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3cvbkIvR1pQOGN4WHhNOXFTbFJMY2NNYXpEbUdDaTFrMzRNaThDWml0Ykhk?=
 =?utf-8?B?QUxXY0phM1VjZzNCYmh3bVZkcDQ0dkFqV3lQZmd6Ym5jbGdWVTBSZ1VwMjNC?=
 =?utf-8?B?TFBvUzdLMjVNVjI2d1dNUGpEU3NRYmFpN2tKcEpHMnBvUmVHdlpkMWNsUGVZ?=
 =?utf-8?B?MEgxb1ZPVnk1M0JzaHltM3JsSW9UYzNXM0lOczVXZ0gxNVFGa2pvZGJkZEh6?=
 =?utf-8?B?TzAzSGRQenlyUHRuNUpkY2N6UVZqeldtS1VvdWdzNkVVVHFjTktLSlNmV1VZ?=
 =?utf-8?B?KytvMlNVaWFzYTMxZEFYWlc4RWl4aGNLQzBDdHBCWkZINk1JdnVreDBueEVB?=
 =?utf-8?B?NmUxZHNuMFVoUXBISlhqa2JBTUVHczBNUDZKbXN2YmRYYk1aZkthcityNVFw?=
 =?utf-8?B?RndaNGNDbTlTS2R6dmZpRnVtaVFteHRNRm12QU1CWXc0Zm93OVNSQmh0UE1r?=
 =?utf-8?B?RUtOYkZaYTI0UlZKcHBBdVBCUlVpV0tBTXc2bTdzdTlXdThJdFhuUEJEeTd0?=
 =?utf-8?B?NG1wMmlRdzkwQXliNHQ1QlJOYnRVODE5cGU5M1ZEUzczczhTRDE2VWtXOFZH?=
 =?utf-8?B?bnJXRVVmcVdBa3E1MVJvOThFM2VGWjVvbm0rQktOclpYUTFmM2xzakdmQWtT?=
 =?utf-8?B?ZTZ1ajBRSFFnNDNhZllXODZVaHBFenBWS3kvaERzOFZtS0Jmb2k1cjFpYUs3?=
 =?utf-8?B?Nnk1a09ZY2RlRHQ3bGQ0OFZWYnN2RkYrUDJ4L3AyQ2prQzFUTjZvWjNnQisr?=
 =?utf-8?B?T2RhNmxjT2ZKbUlhalRJNE1rTkg3TFpDeE05c2V6ZUx0RzNKekdXVnVHZm0y?=
 =?utf-8?B?dzdHVFgwMXpSQmJzWDRSUXBlSWJXUHp0QVF5V1FRQVhqeitONytkT0lZVlZJ?=
 =?utf-8?B?QVpiSGZtdFI2TTRWd2o0dktNU0FHWStmbDJkQnpvVlpYd09RaUw1c3Y4YXdr?=
 =?utf-8?B?aU5kQURlT1l4UzhxVFVEUjdEUUx1QXNTRzlGNnNkQ2M4TTVsZHBoRFRSUEl5?=
 =?utf-8?B?czAzYkZSQSsxTGR5SHhONWYvUXhOUWhOdU5zY1BoYWs0RGFPWjJtTWZOalRN?=
 =?utf-8?B?VWZaZkpzR2Fqc1JrQ09BS1BOb051V1lSMSs0QWFsRkVlaHJzYWd6QnROQXNI?=
 =?utf-8?B?Q25jUXBEMzRjejg1WXJHblFhb1Y1Y1czclBFT0tOclA2UWF0Z0JiUWNNOTZ1?=
 =?utf-8?B?VVAyMzhtVVBjSElaZnQ3T081OUhPVGpmN0VnanBDdmsvNXJUZEtaUkozbFE0?=
 =?utf-8?B?OUdyVlpNYlIwUFdabnBLZ2ljTENuMEhRRGNRMFJBdnpwTWRCMzViWVNhZWZ0?=
 =?utf-8?B?dVFCcDBhYnhQNFBpU2xrbmplcW1PeE1yV2NwQXBjWStnalNYcTFRM1p0eEFh?=
 =?utf-8?B?WmFRK1Y3L0MzVXRheWt5c1JqRmZ6c29KWVlJWGJFL2xmazhwQzVZZkhFODha?=
 =?utf-8?B?VnBmTXQ0TjVBWFlPbHNuS1VFcEhFYWJXdU5OMDhhREdldEI2RVVUNWQ1aXpi?=
 =?utf-8?B?S0cvR0h2QytHU01hd2VRWEU4WVUrb0NPSjIxRWZSRFR2N1JhT1ZsWjU4ZlZG?=
 =?utf-8?B?NjNRMm8zTGVMMFd0Q3E1cjRzQXFLTWxVeno1K2ptM3pHKzNGR2h1QjRBeG1S?=
 =?utf-8?B?aTlMVHBUeTFMdDVtNVFOSWZKd043RFVoc013S2ZQRWUzNWFUMHVnZGc5cGlT?=
 =?utf-8?B?M0dkSm1yTUViZkZXZlVheDRQUmpjUjZ4YXlnakdXWjBIQ2pjZnFCZ2xBdmNx?=
 =?utf-8?B?WU1JYS8xQXdrNi9pQ3ZTSTM1S05WL3BzRmxoNUdyV0xYN21qS21EcjRCZWhy?=
 =?utf-8?B?WERGankrLzFoUzBENFFOVlJUeHpyNXQ3ZlRiVEc2L0N1b2tVcDlNNmNRL0hR?=
 =?utf-8?B?cEtuNWtUNjg3aDZKUTNNcEExVXJ5UWtCdHZrNWdZc0pyR1Z1UERmWTJ3czNQ?=
 =?utf-8?B?dnFyYzgvRS9DVWU1eis4MDZ6cGE5VEk2YzZNd3F4RTZkSGhRa0RoM2xXd3FE?=
 =?utf-8?B?RE5UbzBYTXdHbmZFWWdpV3M3aVZBZXhDS05XaytZb2tOaEhKUkhCdEZBbWZq?=
 =?utf-8?B?REVFU0x4dElEdDZGYUlXWDRpaTlkUmQrWjRBbEdwR3g0YmxSYkU3S1poUWR5?=
 =?utf-8?B?eEg5c3U3anFlS2FxSWI0YVVNbnlsa1ozYjlLa3c4a20vQkt4cW1LMG1seG9r?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABE85E2A8DEB374BB6B8AF2B310EF1BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233a3bba-bd0a-48bd-f4c9-08dc4d7fdd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:31:14.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Clj1AzUABnWB8D0Ih8CqinJlnAolpx5yBFlWFzeHXY3BqdhZDO3MOMZkC3iMxvZzPAQjsiO7IDxQCjp6SfVukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjM5ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBndWVzdHMgYWxsb2NhdGUgc2hhcmVkIGJ1ZmZlcnMgdG8gcGVyZm9ybSBJL08u
IEl0IGlzIGRvbmUgYnkNCj4gYWxsb2NhdGluZyBwYWdlcyBub3JtYWxseSBmcm9tIHRoZSBidWRk
eSBhbGxvY2F0b3IgYW5kIGNvbnZlcnRpbmcgdGhlbQ0KPiB0byBzaGFyZWQgd2l0aCBzZXRfbWVt
b3J5X2RlY3J5cHRlZCgpLg0KPiANCj4gVGhlIHNlY29uZCBrZXJuZWwgaGFzIG5vIGlkZWEgd2hh
dCBtZW1vcnkgaXMgY29udmVydGVkIHRoaXMgd2F5LiBJdCBvbmx5DQo+IHNlZXMgRTgyMF9UWVBF
X1JBTS4NCj4gDQo+IEFjY2Vzc2luZyBzaGFyZWQgbWVtb3J5IHZpYSBwcml2YXRlIG1hcHBpbmcg
aXMgZmF0YWwuIEl0IGxlYWRzIHRvDQo+IHVucmVjb3ZlcmFibGUgVEQgZXhpdC4NCj4gDQo+IE9u
IGtleGVjIHdhbGsgZGlyZWN0IG1hcHBpbmcgYW5kIGNvbnZlcnQgYWxsIHNoYXJlZCBtZW1vcnkg
YmFjayB0bw0KPiBwcml2YXRlLiBJdCBtYWtlcyBhbGwgUkFNIHByaXZhdGUgYWdhaW4gYW5kIHNl
Y29uZCBrZXJuZWwgbWF5IHVzZSBpdA0KPiBub3JtYWxseS4NCj4gDQo+IFRoZSBjb252ZXJzaW9u
IG9jY3VycyBpbiB0d28gc3RlcHM6IHN0b3BwaW5nIG5ldyBjb252ZXJzaW9ucyBhbmQNCj4gdW5z
aGFyaW5nIGFsbCBtZW1vcnkuIEluIHRoZSBjYXNlIG9mIG5vcm1hbCBrZXhlYywgdGhlIHN0b3Bw
aW5nIG9mDQo+IGNvbnZlcnNpb25zIHRha2VzIHBsYWNlIHdoaWxlIHNjaGVkdWxpbmcgaXMgc3Rp
bGwgZnVuY3Rpb25pbmcuIFRoaXMNCj4gYWxsb3dzIGZvciB3YWl0aW5nIHVudGlsIGFueSBvbmdv
aW5nIGNvbnZlcnNpb25zIGFyZSBmaW5pc2hlZC4gVGhlDQo+IHNlY29uZCBzdGVwIGlzIGNhcnJp
ZWQgb3V0IHdoZW4gYWxsIENQVXMgZXhjZXB0IG9uZSBhcmUgaW5hY3RpdmUgYW5kDQo+IGludGVy
cnVwdHMgYXJlIGRpc2FibGVkLiBUaGlzIHByZXZlbnRzIGFueSBjb25mbGljdHMgd2l0aCBjb2Rl
IHRoYXQgbWF5DQo+IGFjY2VzcyBzaGFyZWQgbWVtb3J5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBS
ZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
PiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

