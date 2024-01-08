Return-Path: <linux-kernel+bounces-19591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91D826F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F531F2301C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3BD41232;
	Mon,  8 Jan 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBBBZ/sA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37441215
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704719437; x=1736255437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Lqu2NUjbB7n1oVLskse/vMGRfh9Q0jflyuUPge8/A8=;
  b=PBBBZ/sAg+hnj1kWfKvttI5ooKJALCODKmDSxofZ3prsSlcxmQ27QXye
   YoJ4jCHTyQ4iHh50kHAPn55+aSyK+/YWARsMf6Duo1Ek7Kn4K3OQIaS7A
   DgSRcOADAi+fa1R1UhJdnPIFws5L5KzLdReekyJ4f/Yv+x9HCZWXYW4Vk
   /ITZ3vDXbzSLnv8t2B1lXjlwyDF3t9VAQfuJi5ZUy6uG28iw0LedrHua0
   Aulhezp2oxG0L1+EAieKLkre03wDIJgSRlxM70vhfEF1VFTRQ1SSUywYP
   9qL10MsmWKQMrcoKq9acYCRZoPOJ8a7wjsfBcQnmAnDErX2/HxjDrpP6a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="19375911"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="19375911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="924865691"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="924865691"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 05:10:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:10:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 05:10:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 05:10:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 05:10:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo8aX7ewtwKcBZBJihzRWV5mbO6TCsq5i9t1GHcI9WsD77SGM5BNncsx7yu8FbU0AZgfbbqjaafkbyAA1ESW6QiBAmcjfJaa6Nh+HSaBvLzBEJQdYXpMuUc9jDr2iWLYt6v6l7OpB3UjvdeqeZVsOPXl77qDOJIVHs6Z9AuhUy0SP37D2UIsdh7lW/Pralc0spyCU6o1dqQ0UfRahyj20oLwTXKdTnf3mHlBvIQjE1+1rRLjbK44vw9EFP/3yKTY+LOE4CZDNM6xlO4Cay6pvAh03QDN+k1VCR5+KmJCG44jEdwcc8nKx25V+Jco3vTljLHLI2fZfZXXItVMaTufAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lqu2NUjbB7n1oVLskse/vMGRfh9Q0jflyuUPge8/A8=;
 b=BVhyCYAa3ISog8obMO8vfSwvM6QQfgZrhOsV6vO7ItPGRgTwdFWklmiHpFxOt1ZP1n7jiiPkVEpIh77q+uDLrIOFFxSUWuiQFzQJ7lYRywPCFgfJcscW48Hm6IZOuxB9smeiTrqSvF0OW83OiiGkcMg+Ff+pI8HGOmpyImtRzVp9YiL5XEejlE75O2niKztEw6UIZilimdy8ILel7fzQDnidWIca2xHeyRiMqvblOTg279++2nhKCMXRpiCO1n/KDMsS36SdOTdUl/mF8Wpjin6U34YTFIxSzTlYuxALLxAHERdgCeN0JmuBAtd8BjpVRkluUvKbcC03FsTTx/Nkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:10:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:10:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Thread-Topic: [PATCHv2] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Thread-Index: AQHaQWUoKPVgnANphESk11qO8ra6LLDP5U8A
Date: Mon, 8 Jan 2024 13:10:31 +0000
Message-ID: <b69afad98d043ddfb685982c9977105f1b563485.camel@intel.com>
References: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240107122847.27740-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4717:EE_
x-ms-office365-filtering-correlation-id: 59e62922-fc03-4253-d870-08dc104b3162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4cIArdpuUj2T5GnrCvOvlA83UEiP/mJ3/WARkv525l+v6XOzoS3wM5EbeOKMOTonDcWP3Eq3iAG6zoz7nPZd83cg7F33+pQ8+YXXO4sl7bmpX3ByYqeLk2EKwD4lfgMTQHB6W+fDi88jySqPxxaFpedUXD+xZICcn/FKkhGdzynyMBzdMhy8Eb2T6eh3fHX45JsSY+A2yUHnpABqzn2zw/dfWAGvAYujApD4rawv8iqSu0chxjTjLMy94q9o1Ip69NLwjP2A/g7Nz2B0vEx7REDlyOz/FegNVDPKST2fYz6YhSAyOUq1VJQm26jw3SowRez/kHb2JlCN4zJLvbIFzsRAn6phT9WHYsg0XCa78ruFnVzAg8Xu8ZATiuEsb+K8YiCx6g/r+jZ1c8QQzlmnfxsvoDJOHSSxLZJhy+Nce8DSNA3EboSpWnCU4hmPWBN1kFORv43jtpbNK/AWs/2Hq/4Zr4II/omVOGxmljWOl+c2i6hk7+7DCYHU+2/JOnj9SOHqNiWpnRmYwf1mmYVj5+NtxlUDN2RPFFuBNt/rLlLkSPAcAeEQRGLOs3lXA166iNyKJqvSsOejVvMyJUMWS5I/q6xrUPTnBMdN9rfvZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(2616005)(38070700009)(26005)(6486002)(6512007)(6506007)(966005)(478600001)(71200400001)(122000001)(36756003)(86362001)(82960400001)(83380400001)(38100700002)(7416002)(2906002)(8676002)(8936002)(91956017)(66476007)(66946007)(76116006)(316002)(66446008)(64756008)(54906003)(110136005)(5660300002)(4326008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVI1OUIrM3h6Y2w5NFMzaHRhcVF1VFdOR2xEc2ZHQ3NJWTZhbUxGSjJ0SE00?=
 =?utf-8?B?TVZqYlhGeUM2Yld6S0Eza2VQWTVOSDdnUEZFd1ZNSTBlYVMxTlMybEtaRi9z?=
 =?utf-8?B?WVJJNjNDZXVtakRKZGtIamExeVhHQkRZNkF3dnV4bWVHT0JCVkhjd29DSzFI?=
 =?utf-8?B?SlBzMWloRzMzRENwdXdmQWlDQmZST3Q4KzRPS1lmNWE3REMweHhtNzk4RVpv?=
 =?utf-8?B?N2lpQ2FmNXh6L1BOd0w1Yk9abWtqT2Vlc0R1OXl5TGVEMXVSWUtQZlNpMVE5?=
 =?utf-8?B?OGlZcDVYVHdmUVk1cjJFSWcwVjhmMFdhYnFTdEt3Zm1LUkR3Vkk0c0JlYjcy?=
 =?utf-8?B?UzBKakU2QytPeWcyWG5CcVJydDhXTEJUTDEvenpaVlBRVWdycjJUck0ybGVK?=
 =?utf-8?B?MmlvWW9TZzNXWkJHa2pwRXpUVm1BRXVNOHg0TTN4c1pod1dxS1JNU3BIdlRq?=
 =?utf-8?B?ZGNDczV5anVmRGozbDdyRXVaUngrbjBxTzYvV0k3Z3lkbkhvQnVQNnFibE9z?=
 =?utf-8?B?U045U2NRdzdLRUxnWlVIaER2VzM0WXg4K0Q5dnZSYm1uN3hJUHJDSDZkVFJC?=
 =?utf-8?B?cU85eXVmQWRveUZXZE9jMmJmaEdNNmgyWlUyajdLMzRTVTc1OVNsYW15dEhZ?=
 =?utf-8?B?a3NCcE9aQ2llbTI3M3lkYTlGanlUeWJ0NERJSjRQV3BmcjJQMHIySHFUZElM?=
 =?utf-8?B?Y29GQ2x5UUpwZWZzaFlSdFRKWjF0bEhFYkYxR2UyM1hXVFNxYzlWOFVkQ2tH?=
 =?utf-8?B?TGdsc0lLenhncmlMV2wyTWFIalJXVnhJbm5vSDYwUEp6cXNnNzJQd0VLNUhq?=
 =?utf-8?B?dyt0VEo2RjRYS3YvOW13MC8zVEdYTndvaEhMNk5rcGJnZld5d2Y1dW53MWtS?=
 =?utf-8?B?dzNpNy9taGIwRmIxZEUyZDEzYnQ1bzFxZXdlRnFUZVByR2hFZ2o1UEp1d1FT?=
 =?utf-8?B?bUpybFhNdFdBbnpibmVURFNEVDdYZDFOVlZpZlluQ1lXMTV2N2ltbE1TZnZ3?=
 =?utf-8?B?WFlBME1GbGlWWUtZZjlmTDk4ZGFndFJtcm9HSFhEcVJDaEhCK0trTHFYYmxp?=
 =?utf-8?B?bmxMMjd5dGJNZXhYMHB1VUN0c0lwM2dFTHNlYnRUOEQyUHJMaFIyWXo0ZFA3?=
 =?utf-8?B?TVRkWWdTZkdjbzFsYmU4bStOMEFWQWxCbzlqc2hHZ2Y0Um4xRllLSENQNGtH?=
 =?utf-8?B?TWxBNUM0c3FrUS90Z3Vib3pKTGcvQ09haE9rV3FYbEorcklXQzVSWllsdERr?=
 =?utf-8?B?bFppZFJhV01oV1c4eExlSHh0em5vL2crRUx5R1ZJMWU3WW1vdVY4Ym5YSDgx?=
 =?utf-8?B?b0tybzZqSkNublYrRWFBakNlc1hvckR1aDZZSlZnNUNSdHR5L0U0LzBmRFJ1?=
 =?utf-8?B?L3ViOHhWY1ZkV25qUFRhdms1MXVkNWYvYzR2bW42T3BjNDZWTXJUa0ZWMnp6?=
 =?utf-8?B?Ylk5YVpSWUZlSmg4b2pOUExma1JXOE52UzVreU41OTFvZTFmUUg1R2FQTzdk?=
 =?utf-8?B?Q2g2N05ISFFOV3lsbUxyYjFIMHl3ZEVPdU1SdEpsenJyUERzcE1uVWw1Wi9U?=
 =?utf-8?B?Z2hiRE1uUlFSWFd0K0Y2Qzk5QnVNSmo0cDVJWXp6TUVhOVM0YTNFNzNYOGtS?=
 =?utf-8?B?NjNDa0cvRGpVZ2o2YU9VUllJR3RHZEFTSFozaVdCcTZsQWFTaGFSK2pMdldU?=
 =?utf-8?B?Y0U0SXNxMDNMa0gxNTd3azJPbnBaNzQrVUdYeGtSeTZUR1B4RHZ6bk9rUERw?=
 =?utf-8?B?ek4rcm9rNS94VWtkZjNiZkk1ZGFJcmJ1ajBPdGc1K0FhUFllaGtpUUxIb0F3?=
 =?utf-8?B?RGZhY2JoUnpqeXk4K202OVZuc1NmeExmbzcvWkFOd1hEZ0JJUFduWi9vS0JR?=
 =?utf-8?B?YUNMTHo5YWZDaUc5ZlVXNkpSYlkzb2JlM2djNnZZeHVHZ3VSNFlxRTd2cGJj?=
 =?utf-8?B?ZFBuSVVHczdRQ09qdGpUeVB4RktycEZBZXdxQmQ4bXRSRDlla1AzV0d3VStS?=
 =?utf-8?B?Nk9xdWdQSGo3Z29UTmI4dGR3eENOc2ZMTTl6UldCaCtoSmJMSU96dnZ6QXZY?=
 =?utf-8?B?bFdQUHpLUWtzL2I5OW9FYVNGZHh5UVhHNkcwT0tjbEl5OGdqOFI0amRMblMy?=
 =?utf-8?B?WnZ5bVR1MzgyUTF1eDBPcURaTGhVRnkyVjEwTlFGYVBZVU5nNDBmWWlNZXZJ?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77279B293CB50D429E593FF7025935DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e62922-fc03-4253-d870-08dc104b3162
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 13:10:31.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8KYVg0TuiMzISxUeKkJ0XXc8b4kt8bYiBRGSUKBnByiOZcHMC1aYiTxP/HkpvVGGZQZKh/46nb75jV6eCDndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTAxLTA3IGF0IDE1OjI4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSB0cmFtcG9saW5lX3N0YXJ0NjQoKSB2ZWN0b3IgaXMgdXNlZCB3aGVuIGEgc2Vj
b25kYXJ5IENQVSBzdGFydHMgaW4NCj4gNjQtYml0IG1vZGUuIFRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGRpcmVjdGx5IGVudGVycyBjb21wYXRpYmlsaXR5DQo+IG1vZGUuIEl0IGlzIG5lY2Vz
c2FyeSB0byBkaXNhYmxlIHBhZ2luZyBhbmQgcmUtZW5hYmxlIGl0IGluIHRoZSBjb3JyZWN0DQo+
IHBhZ2luZyBtb2RlOiBlaXRoZXIgNC0gb3IgNS1sZXZlbCwgZGVwZW5kaW5nIG9uIHRoZSBjb25m
aWd1cmF0aW9uLg0KPiANCj4gVGhlIFg4NlNbMV0gSVNBIGRvZXMgbm90IHN1cHBvcnQgY29tcGF0
aWJpbGl0eSBtb2RlIGluIHJpbmcgMCwgYW5kDQo+IHBhZ2luZyBjYW5ub3QgYmUgZGlzYWJsZWQu
DQo+IA0KPiBUaGUgdHJhbXBvbGluZV9zdGFydDY0KCkgZnVuY3Rpb24gaXMgcmV3b3JrZWQgdG8g
b25seSBlbnRlciBjb21wYXRpYmlsaXR5DQo+IG1vZGUgaWYgaXQgaXMgbmVjZXNzYXJ5IHRvIGNo
YW5nZSB0aGUgcGFnaW5nIG1vZGUuIElmIHRoZSBDUFUgaXMgYWxyZWFkeQ0KPiBpbiB0aGUgZGVz
aXJlZCBwYWdpbmcgbW9kZSwgaXQgd2lsbCBwcm9jZWVkIGluIGxvbmcgbW9kZS4NCj4gDQo+IFRo
aXMgY2hhbmdlIHdpbGwgYWxsb3cgYSBzZWNvbmRhcnkgQ1BVIHRvIGJvb3Qgb24gYW4gWDg2UyBt
YWNoaW5lIGFzDQo+IGxvbmcgYXMgdGhlIENQVSBpcyBhbHJlYWR5IGluIHRoZSBjb3JyZWN0IHBh
Z2luZyBtb2RlLg0KPiANCj4gSW4gdGhlIGZ1dHVyZSwgdGhlcmUgd2lsbCBiZSBhIG1lY2hhbmlz
bSB0byBzd2l0Y2ggYmV0d2VlbiBwYWdpbmcgbW9kZXMNCj4gd2l0aG91dCBkaXNhYmxpbmcgcGFn
aW5nLg0KPiANCj4gWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9k
ZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL2VudmlzaW9uaW5nLWZ1dHVyZS1zaW1wbGlmaWVk
LWFyY2hpdGVjdHVyZS5odG1sDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVt
b3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbmRp
IEtsZWVuIDxha0BsaW51eC5pbnRlbC5jb20+DQo+IENjOiBTZWFuIENocmlzdG9waGVyc29uIDxz
ZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+IC0tLQ0KPiAgdjI6DQo+ICAgLSBGaXggYnVpbGQgd2l0
aCBHQ0M7DQo+IC0tLQ0KPiAgYXJjaC94ODYvcmVhbG1vZGUvcm0vdHJhbXBvbGluZV82NC5TIHwg
MzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9y
ZWFsbW9kZS9ybS90cmFtcG9saW5lXzY0LlMgYi9hcmNoL3g4Ni9yZWFsbW9kZS9ybS90cmFtcG9s
aW5lXzY0LlMNCj4gaW5kZXggYzlmNzZmYWU5MDJlLi5jMDczNTQ1NDIxODggMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L3JlYWxtb2RlL3JtL3RyYW1wb2xpbmVfNjQuUw0KPiArKysgYi9hcmNoL3g4
Ni9yZWFsbW9kZS9ybS90cmFtcG9saW5lXzY0LlMNCj4gQEAgLTM3LDEzICszNywxNSBAQA0KPiAg
CS50ZXh0DQo+ICAJLmNvZGUxNg0KPiAgDQo+IC0ubWFjcm8gTE9DS19BTkRfTE9BRF9SRUFMTU9E
RV9FU1AgbG9ja19wYT0wDQo+ICsubWFjcm8gTE9DS19BTkRfTE9BRF9SRUFMTU9ERV9FU1AgbG9j
a19wYT0wIGxvY2tfcmlwPTANCj4gIAkvKg0KPiAgCSAqIE1ha2Ugc3VyZSBvbmx5IG9uZSBDUFUg
ZmlkZGxlcyB3aXRoIHRoZSByZWFsbW9kZSBzdGFjaw0KPiAgCSAqLw0KPiAgLkxsb2NrX3JtXEA6
DQo+ICAJLmlmIFxsb2NrX3BhDQo+ICAgICAgICAgIGxvY2sgYnRzbCAgICAgICAkMCwgcGFfdHJf
bG9jaw0KPiArCS5lbHNlaWYgXGxvY2tfcmlwDQo+ICsgICAgICAgIGxvY2sgYnRzbCAgICAgICAk
MCwgdHJfbG9jayglcmlwKQ0KPiAgCS5lbHNlDQo+ICAgICAgICAgIGxvY2sgYnRzbCAgICAgICAk
MCwgdHJfbG9jaw0KPiAgCS5lbmRpZg0KPiBAQCAtMjIwLDYgKzIyMiwzMyBAQCBTWU1fQ09ERV9T
VEFSVCh0cmFtcG9saW5lX3N0YXJ0NjQpDQo+ICAJbGlkdAl0cl9pZHQoJXJpcCkNCj4gIAlsZ2R0
CXRyX2dkdDY0KCVyaXApDQo+ICANCj4gKwkvKiBDaGVjayBpZiBwYWdpbmcgbW9kZSBoYXMgdG8g
YmUgY2hhbmdlZCAqLw0KPiArCW1vdnEJJWNyNCwgJXJheA0KPiArCXhvcnEJdHJfY3I0KCVyaXAp
LCAlcmF4DQo+ICsJYW5kcQkkWDg2X0NSNF9MQTU3LCAlcmF4DQo+ICsJam56CS5MX3N3aXRjaF9w
YWdpbmcNCg0KVGhpcyBzZWVtcyBkZXBlbmRzIG9uIHRoZSBCSU9TIHdpbGwgYWx3YXlzIHVzZSA0
LWxldmVsIHBhZ2luZy4gIENhbiB3ZSBtYWtlIHN1Y2gNCmFzc3VtcHRpb24/DQoNCj4gKw0KPiAr
CS8qIFBhZ2luZyBtb2RlIGlzIGNvcnJlY3QgcHJvY2VlZCBpbiA2NC1iaXQgbW9kZSAqLw0KPiAr
DQo+ICsJTE9DS19BTkRfTE9BRF9SRUFMTU9ERV9FU1AgbG9ja19yaXA9MQ0KPiArDQo+ICsJbW92
dwkkX19LRVJORUxfRFMsICVkeA0KPiArCW1vdmwJJWVkeCwgJXNzDQo+ICsJYWRkbAkkcGFfcmVh
bF9tb2RlX2Jhc2UsICVlc3ANCj4gKwltb3ZsCSVlZHgsICVkcw0KPiArCW1vdmwJJWVkeCwgJWVz
DQo+ICsJbW92bAklZWR4LCAlZnMNCj4gKwltb3ZsCSVlZHgsICVncw0KPiArDQo+ICsJbW92bAkk
cGFfdHJhbXBvbGluZV9wZ2QsICVlYXgNCj4gKwltb3ZxCSVyYXgsICVjcjMNCj4gKw0KPiArCWpt
cHEJKnRyX3N0YXJ0KCVyaXApDQoNCklJVUMgeW91IHdvbid0IGJlIHVzaW5nIF9fS0VSTkVMX0NT
IGluIHRoaXMgY2FzZT8gIE5vdCBzdXJlIHdoZXRoZXIgdGhpcyBtYXR0ZXJzDQp0aG91Z2gsIGJl
Y2F1c2UgdGhlIHNwZWMgc2F5cyBpbiA2NC1iaXQgbW9kZSB0aGUgaGFyZHdhcmUgdHJlYXRzIENT
LERTLEVTLFNTIGFzDQp6ZXJvLg0KDQo+ICsuTF9zd2l0Y2hfcGFnaW5nOg0KPiArCS8qDQo+ICsJ
ICogVG8gc3dpdGNoIGJldHdlZW4gNC0gYW5kIDUtbGV2ZWwgcGFnaW5nIG1vZGVzLCBpdCBpcyBu
ZWNlc3NhcnkNCj4gKwkgKiB0byBkaXNhYmxlIHBhZ2luZy4gVGhpcyBtdXN0IGJlIGRvbmUgaW4g
dGhlIGNvbXBhdGliaWxpdHkgbW9kZS4NCj4gKwkgKi8NCj4gIAlsam1wbAkqdHJfY29tcGF0KCVy
aXApDQo+ICBTWU1fQ09ERV9FTkQodHJhbXBvbGluZV9zdGFydDY0KQ0KPiAgDQoNCg==

