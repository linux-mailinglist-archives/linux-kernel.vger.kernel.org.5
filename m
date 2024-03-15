Return-Path: <linux-kernel+bounces-104487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1A87CE98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1FA1F228AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555F381C6;
	Fri, 15 Mar 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoLsUWmA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C0381A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512434; cv=fail; b=hFL6UvlTWZKuIyS1GuY0Hp+2T4mfDtvT3WbpbDiZFM5U1vDibrPUm9l8WIggnO9D/WK0YAbxEA4Q61VHgo6+aB4GEivcYEu2VYV0NhXKy+AEEsq+gQ7UoHUsloRMR5y2i3CrRBrTOeu4Y8QPN7xWnAHooikGlt1j9utQtiE7qcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512434; c=relaxed/simple;
	bh=BLJNMhDXJHwJCHGLi8n9m5zlxfj5Rn8sesoAsnr6JGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYByuiL2njSPbgHPbTIby3jAoHQuRRZo0UckJ3+HcERjxmNxmOzT1qaNC/OWtNhILxb/XIKyvVsJjFpct82Xo/Flqm6G2Ikmv8xINUmARb0YIbw44Pb7/BmdZ8xnBi1ztAYdsjEyZC7GTROvpsE4/SAatONybfKMwmVcusx/Uek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoLsUWmA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710512433; x=1742048433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BLJNMhDXJHwJCHGLi8n9m5zlxfj5Rn8sesoAsnr6JGI=;
  b=eoLsUWmAwFnfpAfFDm+q8UNsh+yc2b5trUDAb14/xt+n2UFAYBYa2nei
   9sWM4qqLomk5RbnHXwEg5sf7PrvdKidPBV5y7F+DKQtJirhwVLM8f9Vcx
   O7K2IIJaYcSnLhVLrEJUD8Ujmq5MDlq1M+WFVIVq4B5/8fLEmkIas9UmC
   rwuqRXCl3uHI4JAfbdO4/M9uFaK+TW+L/F/YC4Afye/p5VEYbu+dinBiY
   IYHqT7TNUFTZ1bi5pLJjqj798ApgN0GPPne+odp65htEkEaUspGIEJJG6
   Egh1r5SgFu/xOh1Gn/jVJKInPH1yEUoQTtb4EY0SsuWGX/d7JJV0jIr65
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5249741"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5249741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 07:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17140553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 07:20:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 07:20:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 07:20:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 07:20:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 07:20:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM3opvLIGiZc1NmKQw6N9caqvHXZevOL5APOEnIUWI3Hy03DFcAMozp6mdl+oyWoRUIyTeRYeKhsaHzNUO/lXaTpnv5lMhiHodo+8KJXiezZMPqpoQJXJ++SMbvzJtHzvpTMGIDwKmVMWuPO7zsMjAZ2F4g0k0+ejlu9GVJmASejWLp7PZbUIsvtYXXIQTF5yE3+n74rg/5369Atkvu+FB3IHuDqzF6kPq9HD6Udzt1UvJI63jAAv3ahxmO7OdwceGBhut9/uEkkOeh8f07KEJE5QaUT1JxPHPcaPJ9bOzV3g996u4nY+gYnHl6mNrlUwAtvKsvgSM9vvZBq7Hm/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLJNMhDXJHwJCHGLi8n9m5zlxfj5Rn8sesoAsnr6JGI=;
 b=QWca/DqiiB11Wq/cHbWM3dEcfEWy2iH26ilJIHomhHGzDnkQuY7f5ascyfhjhK4e8qQUghG17ktKnK6qRs6WF81cveq2tqAMCFx1Q78DJewxtXR0aAa0ZYcuCtXmNvy8RaKKFaP0bjjwb98gu7AYYXZTJzeA5J9zlN4nWSK+AyAm4c/ooj0IqasokA5P0Rxm51zmjliJ8KOlyMIAdtSjS40tFdgRItHC6ZsmpEwIqtB448RU+p3aOTBtgDXB95MoVDWGMS4291N8bMXhKDrdj/DC7ZV3VbA3hrn7+9zyw9V4U3f1yXcgm/8CqB8tt9UD2i2Geqky5aKuC6mV2RV5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 14:20:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.008; Fri, 15 Mar 2024
 14:20:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC: "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Topic: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Index: AQHaduH6Cs7bYZFPJUuH5QAqHlZq5rE42gyA
Date: Fri, 15 Mar 2024 14:20:19 +0000
Message-ID: <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
In-Reply-To: <20240315140433.1966543-1-hjl.tools@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB8089:EE_
x-ms-office365-filtering-correlation-id: 0cd3ca7f-b42b-4b8b-2c63-08dc44fb0b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYBnX6lS16+QpEzDblkqMhs0oPcYkKp1Z9KZjJ0N6injxvVg5gQf/GDYIsBFKlHftr2OmFX4cO/tEFNSQ71J82W5k/G59RCWE+vMLZMQzq3i7s4GZ8c0MA2gOg8Z8TMgavfLRoP7mA6+CwFS/bN8loXIwW8Q1eMQvjAUsyXc1d9H7vD42YG7wVrT/pExSbHn87FqaL/dGA+frLs/q8XjuMN9ce3evtg5YetiyDrPpYV8yqpqT6elDs30ReAmRH5MHWKoBa2kt+WGYAfgeRpYAmFwmGcqypYxmKPcC4EC2KPqSibOq5n3njC+jaQv/W/df1Lxbdtbwf2wokzC8ITk7NYbuNpOjdJ4VsM5ZcfPx85RUgIrKM+PZICUNglmh7ncCRga3BHZqb3HhKZ9RN6WkeVo2i7M2QVcK3rNsSUhQuxvUKuBB7blClJxicUft9RXS7Xtt6kn60TcQRIhEQSPrvFLy2Bb1mvvaoct4v6l8LL5LuVzHfxIy5vM7ap4flOAGE682SSre+yKxl7Ybudl5Be+W65vWzfxn+qrv9gWlTQOt378RLYeTOpu8RiCRH5wiTUDtMl8Oj7VD5d0wFBE1hxMNJn9n7ja3DprI7STnh3BlsX80hwy7shFdkkKWfiHSLiGtyzBmIhbbe5rqAS8sYxDAcsjKrtNe5yBMA5UA8I+G/WolwEkG5ooFs5OaL5WG0NxWw6FAI+oJ9j5N2u2ab/NYbLajkTpnLAxs5QoKEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RysyOHdLOGU5cXM2ZzFQMkFpQW1WdksxWmtqSDhCb0VMbkVTTmFRemZWSzFP?=
 =?utf-8?B?WUQzNElTM1FzUUE3WTlqcTF3VGoweVVJcnJ3OU5ZN3VPejhHVkQ0WGVzSElQ?=
 =?utf-8?B?VVNSVVhkVnRSenB1NmptbUlRQkl0ZkF6Tit0RDN0Z1QxWFRNQzR2ODZPOGtO?=
 =?utf-8?B?dFdSTHFOdXQ1YlpBZ1pjZTBaRGFTaVlvWGpxNVlibitiZ1V5YnhWNzVzYmp5?=
 =?utf-8?B?UjhIT01MM01SeGpaaTBuZUdrV0VTTVFFaU1xbWxwbmZKb2RmeGpZME0wZk1j?=
 =?utf-8?B?QVFxNTZuMXEzU1hZdXMzeUV1Z2pNK0hCd1J4aG5hM3JneFdDWGRIMHY0QVlh?=
 =?utf-8?B?cmsveGQ3YWZYRUNJaUEvSWNySTJHWVlXWi9EQWExMVBWd2tyK3BmREhRQ0hj?=
 =?utf-8?B?ejV2RGNvRzRHZkh3UVpNMHRsUjhOSllrNkQvTjhaaUhvRWsvcUwrSUkrYUhC?=
 =?utf-8?B?VnUzTFFZUW1HL0NYOUJ0aURCN2NIdkM5YTBUbFJaY0x6MUNCL1NaeW9wTWY4?=
 =?utf-8?B?RXFCR3BWdnVxaG9Tc0NnUXFiNEtuWnorTnJLaXhJTm9ZeFNQN2pUaElsbFl3?=
 =?utf-8?B?anduQVR4U0xMRytTWDZMZkFsTHFpbTNMUXFoeW5BTmVZTjh4RDJFeXYwcFlZ?=
 =?utf-8?B?UnhlOGFxODg1eGZ1cGxMaURRWnNEeGo1ZThkRHNmaU1qMGhpWW5nd1kzWEJa?=
 =?utf-8?B?SDJ2WjFHcHF5NnpVaUdiZEpMVWgvbGFDUlFrcm1Jc1l5RU1IWm0yMGlpZGQ3?=
 =?utf-8?B?dTgvWTI1QnlXZ0I4REdqcGlYbDdWTkdnT0hvVHRKTmJ0dTUwazFtMkpIWG43?=
 =?utf-8?B?aFppcStuRy9sSzdxbFJwNXFMNUphb2JzVGRRRHJsRFllL0FGTy9RU0h3cEJV?=
 =?utf-8?B?SkhodVp4M1g2RzRmT2hjajBYL3hRVXVlSzkyd1VqSVh1dDdwbU9QNVZaSEsr?=
 =?utf-8?B?azFZZVFaeEt6Y0ZBZ2IzQzkvU21NRERPdW8zSlhXUGRTOUxYZDJaSzJiYnhj?=
 =?utf-8?B?YUsxTW42eUFwS041aWREZTYzdlBscHVnd0hpNVl3OTY0bER2N0g5dUVPM1BC?=
 =?utf-8?B?NHdsUFY5YVRtb2VKdmJkWVpCMEJGU0RHME9vTERnY0hTMHNkWHY0TnJZWmsz?=
 =?utf-8?B?d1lYbXdlcFN1MlVLS0xhUkhGanJManJRcjZac0JHaTBBc2UyNE1keC9udm9X?=
 =?utf-8?B?aW9UbFpaWTNzRnYvSWhucmU3MGRGVDc1bjRQenVzS2J0MXFOVDl1RmQ1Zlpx?=
 =?utf-8?B?eWhiaFpDWVFqendXWjdnZ1VzVXl1RzZMMTQ2Y0dURkJtZ0FkY2U0bHFheXNq?=
 =?utf-8?B?UmpldnFDY2tHd3FES3VTNDF6TFlPdWI3YURycU1WdW5MNEpmZHdxTkdlNUFV?=
 =?utf-8?B?OVhnczc0NXpGb2s1K0s2MUJoNmR4M296eGcwRHVqdUFRNEhiU1F3ZSs0VDkw?=
 =?utf-8?B?VWNkbnQ0dE1OajZGREdadzVaRXJaN1BORTJ6VWZwUVI0T2EzYjlmZEZhWHh1?=
 =?utf-8?B?WUVqdjdqUTFnNDIvSEQ0SzNHSTNKSDg5SlBkdjdBQ0k4WmpXOU5saC9QRTBs?=
 =?utf-8?B?M2h5NU55TXlCeFVHQjF6U0orMVBmZ3BBM2cvNDRTdFBycVlNUUJQa2RoS3Jm?=
 =?utf-8?B?SEp6ZWtKSnZ0NndFQy95TDdnTGM1Qy9sVXFDTGk2NDRUTERKdkU2NFVlR2FE?=
 =?utf-8?B?M2J0SFJ5QTc4M2Nya2NGM2hkUnBHNTA4c0ZpWXRFc1lxdU5YSHl4RFhYS2Fn?=
 =?utf-8?B?MUFwN1ozcVV1OG8rVk5QajZYMGhTaFl4QVZyQTQwcitXbXlObmtUWHRWTEdJ?=
 =?utf-8?B?ZjhZQTFmc0FLVXFRTHBVcHV0d1JaM242MUxpaUowTnlPU3dlUTNxQjNyQjd3?=
 =?utf-8?B?L3pjUkpwQ3pDQm9XRUROT2RQSFhCYld2ZHFVYkJTTWNjOXVucmtQeFFMaWg0?=
 =?utf-8?B?VkF1N0lsajBDQldqUVEvOFlHVUptRHpDTE56V0I5K2pIMTJUUm01UkhTNVNW?=
 =?utf-8?B?YllEcmJjdWUweUQ2SzRTb01YOE5zYXljZmpXUWFFamtURDEvODVua0hFTHc4?=
 =?utf-8?B?aFBtaUtsSWtsSjVZUnhPRzg3MkpJcWovM1RrNTFVc1lXTUZiQkZTT3JWbFF2?=
 =?utf-8?B?MFVNV0wvQWs4aTBBc3l3WDk5QXBvSUl2RzB0UTk4N0hLZHFLSVgxc294aVFr?=
 =?utf-8?Q?4sAzVzC//X5Ybwm68ZfioSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48F15F2A97BA684C8C9DABC3D1801A58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd3ca7f-b42b-4b8b-2c63-08dc44fb0b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 14:20:19.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vwL3NghaeDWed6OBb6hXP9PHVAZvQN3/fiX2IPHok4bxKERImxq6eH5Uus021klq3kQydzovEF7jiY3yNCH8RIfYs2N1k3mhNgfCZpFpKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTE1IGF0IDA3OjA0IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiAxLiBB
ZGQgc2hhZG93IHN0YWNrIHN1cHBvcnQgdG8geDMyIHNpZ25hbC4NCj4gMi4gVXNlIHRoZSA2NC1i
aXQgbWFwX3NoYWRvd19zdGFjayBzeXNjYWxsIGZvciB4MzIuDQo+IDMuIFNldCB1cCBzaGFkb3cg
c3RhY2sgZm9yIHgzMi4NCj4gDQo+IFRlc3RlZCB3aXRoIHNoYWRvdyBzdGFjayBlbmFibGVkIHgz
MiBnbGliYyBvbiBJbnRlbCBUaWdlciBMYWtlLg0KPiANCj4gQ2M6IFJpY2sgUCBFZGdlY29tYmUg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiBUZXN0ZWQtYnk6IEguSi4gTHUgPGhqbC50
b29sc0BnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEguSi4gTHUgPGhqbC50b29sc0BnbWFp
bC5jb20+DQoNCkhvdyBtYW55IHBlb3BsZSBkbyB5b3UgdGhpbmsgd2lsbCB1c2UgdGhpcz8NCg0K
SSB3b3VsZCBoYXZlIHRob3VnaHQgaXQgd291bGQgcmVxdWlyZSBtb3JlIGNoYW5nZXMgZm9yIGJh
c2ljIHgzMg0Kb3BlcmF0aW9uLiBXaGF0IHdhcyB0aGUgdGVzdGluZyBleGFjdGx5Pw0K

