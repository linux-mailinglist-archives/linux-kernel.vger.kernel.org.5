Return-Path: <linux-kernel+bounces-77535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D551F8606F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A098287E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA34182AF;
	Thu, 22 Feb 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azfnIp5t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0618032
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644427; cv=fail; b=op60JN2BaV35WRKWaOjX7nTM8GAeJV5bS3tMSJfAMlgRrPvLpPAk4Xm0SzPupA3Fb5CBfJoTgLdEEVpKux/IEUlDJQLaLZ88W16LhqqiNyNAIBQjptaXSSoxbWYh6eeFC8Ht1X+g9DSROY5gj3rswwfKKlDnwdJ4S50BY8FLQjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644427; c=relaxed/simple;
	bh=8BLMjnu6Zii66vsME4JpkHmD82jRypaWR8CndclkOQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJZxloM1gsE+oAGvvNcz7MI8D4yM2aq+rP0yl+8spvD7R+SHIFMAoCOtTDuuGBf6XQJJaKONQWCTF5Cam1hN6Wmz1oPvjXqXKqJ5sB688om+dbqhFEH3DQMcUxuB2pbbxtPPVAjCPKUFSCFRmUkUi64WADWsOL9xN6Q9xj2Y8+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azfnIp5t; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708644426; x=1740180426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8BLMjnu6Zii66vsME4JpkHmD82jRypaWR8CndclkOQE=;
  b=azfnIp5tBMO2E05jwaY/8PUPVUguh1hd7gOyEgNS69Ik0XbFp8geDau5
   wuJHapLZiN6oP44pi4ETVhZNEXtRTnHC5dPF/BV8u/60+jfRQrWWAz3Vl
   jroZqOz3BOL0tWgKNQEWqhPp8HxIWzAMfC4GLVKXsMwO6HX6EH9WPPLRL
   MRFzqwjwWopfRt5pFZhb0iPGBSekCVWMEuMWOg01sVsrplWXp0xoPDdOl
   fAhbiECdTXghnVFKM3YT0HzO9YSpPLIKS+/0o73cADwqUIg7WeF8ZON6e
   YEPwCY4rxvVkYR6V679lXoT4rABDX0kl/SQcDRCaDbrk9VEYPJemGB3/z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28350781"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28350781"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6034797"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 15:27:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 15:27:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 15:27:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 15:27:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe2uUpMivMB+BArduMqXeRz5R2xPzXg4f8nJgB3TyDYXZjaBhJrk1Ff5dlQypiJ53vBwLd6mzuxjtg/Fq480YOPvSV56/ka2lA6y7j0TSjtXVnCon87PCl+H1K1/7ncV9ROWK/0tI1NvqftPw516YbefmgEKzTAtEa9z5iGVcbZjK1n9d2Mhp5OPIeWcx3bWvusN3CRjN7kuyYuk/JVe4m19Du5EjfkQB9HgMjXbH4o1sQ6sPxQTOqO7AwjvuEbFTU2WmDsicZqNHXQfnrakK8k2SwvAY/T1dzf3lifEoKIHYFYagRYcEd1BYRCzdQmf3AgJBpb/hPUPQR2fkHocBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BLMjnu6Zii66vsME4JpkHmD82jRypaWR8CndclkOQE=;
 b=HCzJ17iiw8V1fn7TBdq/DMjV8nPz1zilKJV5VxxONSVBAt8sdAc7UZ9WTSoTOGFXc9WnJUfeEjHOvQk9hBi/9gqKg82y2DzM8HfdSUWVqfPbs2qQ2aBG4aVHrdDx3wn/Alhw16ixT3VgNlKLu4Pjtfv77D6234OJ8EKsTH5/9y/dXKe3WDX0Iw3xu7xL8tBrOiiwd76lp1z5RKsEZASaD+Spgq5A+zVl/cw/9G+JkeieDFEnRCoEhzKKGVZLfIKooXmruOcbsf6xN8pi1slQM13Qxbzoi7tDmH/3XxsM86iwTp+sZqRPp3o9f4yTp/HC2BSNX3ZomSq9UGFI7/UKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6212.namprd11.prod.outlook.com (2603:10b6:930:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Thu, 22 Feb
 2024 23:27:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 23:26:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Borislav Petkov
	<bp@alien8.de>, James Morse <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
Subject: RE: [PATCH v3 0/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v3 0/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHaZcASTXMPymEcC0KprhU+3FduF7EW/3cAgAAAnqA=
Date: Thu, 22 Feb 2024 23:26:59 +0000
Message-ID: <SJ1PR11MB60839AD3BC4DB15BF5B0BBE0FC562@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240222185039.72201-1-tony.luck@intel.com>
 <19d3087a-dc2c-455a-b225-6ac114631f74@intel.com>
In-Reply-To: <19d3087a-dc2c-455a-b225-6ac114631f74@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6212:EE_
x-ms-office365-filtering-correlation-id: 32f5bd7e-4a4e-46be-40a9-08dc33fdc4b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTz+tsRpGd2O26w1VpY2Qir+iCbR7oebU6s9eNsQjIdcTTC/rAPTD8grdKvaJCEvTaOgbleEY9KSsDvqqMEXW+34ANS7l09flRGJ+ylKRBFM7QqwW/MO0HF2n33VZs00Pw3DSYy3JOuuBCC/Rhxu4uQKuyzCCLeSBryPo/jcUl0smzFgZqjOv/uHyb6NwphNgpbUe0N4aPTXga2h313fq458Zkj2kZALY+mEFIng7Vbcx5Ooc5SKrElWWinnXEHUgjkx/aO/mHeDj68RqwSjitHcZVNJPL/x2vMDFK4pJyLpWxZIRo2TJmESU4ygDtHKvjxdRkTU5ws4pabF8TOdLUcS7xWnXNDkATAdnO6mlUJu9YTG/JTN9TGPoGu26KCr+Nh2BfMgdSdjbXqTfzlBkvpAMiJPv9n4WbGydxnJVyTeR1RXIZrcHzj19r5WUtiQTe/fRj0c6jA336xmiTh/3+qMrayBTt3++jY5QFSNwOR12UhzRfu2LM6ZGN0WGXsg8Bm2mdLaIm98TL7T/s2bGzYF4mMQEd0BppIpidgzWyPQq7s2gIQKJ7g+ZHXwzw+OE3Et+pIoQeUxk92kZo1TUoN0RAfZHnmorGJ3uwMLGfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2I1bzJEVGRwZnA2Uk93NUVsTlVxeUdyYitLMmVVc1VJYkJSbWJ0K2RvODlY?=
 =?utf-8?B?WUNVMjdQakZMSTdDc2lmK0F6amFzNmtSYWVsYVZVVXdjUFhzYjdjSThnd2dY?=
 =?utf-8?B?a2Q2ZTRWUk94TGg4UW1GQ1RsMXhCS3U1SUZldjRYOVE1WEpsaHN5Q3B4dlVZ?=
 =?utf-8?B?SFRUbmZtR1lsU3BCVk9wVFNsQlQ2N1NtZ3RLQzBteGxtL1d6aHY4R3N3ZXRj?=
 =?utf-8?B?VHVVeTVwbWk4ZFo3RFlnbTI5SGxPY0dqdVdUbkp2cFFlY1pKOWQ5UWRlZSt4?=
 =?utf-8?B?M0xvWmd0V1UyVDFhR3JmTW9DZDNvUHdZaFRaSjgzazNOY2pLdGMzWng2WEpa?=
 =?utf-8?B?eUYwSVdCQjRIYWxRejEzU0tQRWhQb3ZnSytWT3BTNi9ocUdNVmRIbHFVK0FT?=
 =?utf-8?B?cTZJVnNrUXJzaTNmQWlkSEdocCs5cmlFK3EwdU9NMEZVV3VRLzQrNXE0K1ZP?=
 =?utf-8?B?YXEzUjFUZ2d6aCtyc25CQUVST1VERis5M2NydG9zSjZSa1llZVAwVWVzZXY1?=
 =?utf-8?B?L2JpWk03Q2QxaXZIYlcvRUNkMzJZdG1zaXh4MU5WeVpMaCs3MVNsVms1TjJO?=
 =?utf-8?B?Z2YyYnkxSUJDTmg2aGc3SUdlQ09YL2U5Z0d4WXVFV0VNMWhWUzdqNFNEZkdH?=
 =?utf-8?B?citkOTVoL3ZyUGdMMU5HOEJ4RWVWS2d0L2YrbFhBSy9KMkhtODZhTW9xRGti?=
 =?utf-8?B?emU4M1paTnVxa3RGMmFEa1QvTHBEQ2d5Syt5NXA2YVpRSXNmbVNmWXppK2xN?=
 =?utf-8?B?SVlVT1ppcnlJUGMxQ3llYWN2MzdFcjN1RXUwS3c3RGIwMWhzL0krQXpoTHM5?=
 =?utf-8?B?OEFBbjQ3MndsSjRpdGJoWlM5RW55aTJLbzBLM3RZY2s1bmhxdkRjeS90bCtV?=
 =?utf-8?B?WTd2TVNQSWlIaWxwV252bGhVMU1xRXFqQmVhZ0JtaHRiNGtyV0N3TThpaGRk?=
 =?utf-8?B?K3gva2NyR1E3d2c2RjFaT1Y0c3NqSkJTQ0l4QXljb2UwVVZxNms2bzZoTk1v?=
 =?utf-8?B?RmNUWFBUaDRiWFVxNy9CbG9yT0VLZU9jNGhSbmVPdGs5VnBlN2Jxd3kwSHZO?=
 =?utf-8?B?UFhOdUVIeGhSWEVzblpyYWlHQlBUTk0rejd6di9HRElkSXZ3cUFOTk93VHVX?=
 =?utf-8?B?czhYRldaTHRPbUpaRjIrM2xiNFVwbXFvak85Z2VKcEp1RitGS0s0S2FDbFFy?=
 =?utf-8?B?QU0xbEtaN2NTV0ZaT1Y0a2pBNzJFcjZQeXJBektvSGw5M3NYSCtWTFZRZUFr?=
 =?utf-8?B?Mk1Zck9MaHF4Mm9yb1FHcjZWVmVBQk54eE1wZ0pWS0FOYWE2SXV0SkNQdDhJ?=
 =?utf-8?B?NjJES0U5OVlTV2hmczJDTGMwL29URGo3cFFqSUVqMUhLYjRDR1FlWCtqcUhG?=
 =?utf-8?B?TnBHUmhzbHcwd3hPelpjWWlQalN0dFh2NHh6NmVJTS9iRHVWa0dmNzlVVWRZ?=
 =?utf-8?B?V2k1TGlvTURleGVWUmp3WGw4SHB0b0hoWGJ4cUZiNlUwK0prQlRldVoyTUlv?=
 =?utf-8?B?c0MvOEpCUXpCOTZsY3NsZGNuMkFUQnRFY2NCVm5aamZDNXM4RHZwWWZBNWNN?=
 =?utf-8?B?cUFwT3NZaEFmNndKNzVoR05NWDZzakpLdml6Z1g0OTQxNEtkVjluVDZKYXRv?=
 =?utf-8?B?UTJsZ3lhMGhTTHAyQUhJekZ0TGJ5eVkwWXlRaWd0T0tPN1BWanJBU21kWFV4?=
 =?utf-8?B?bW55c1ZHZjkrSGdYOVVUNnh1UGRHUkJvSlk4bkJEUm5ydFMzUmUxbm5aaThx?=
 =?utf-8?B?SFhMeDJUc1d4S1JYT3hFTDhPMTlGS1NxeE0wTENGWko5OWhVcUgvM0ErSElV?=
 =?utf-8?B?NEIvVDBpMjh5bThxblRKenUzMEpVUjVKc2ZzbTY4NlZqdzY2czdwa0U0Z1RY?=
 =?utf-8?B?NDNUK2hHWnRlZ0FQZTNoN0ZocW1ET1ZURVJ5a0RGZ1JzZzYzMlVaZTdoRkJ6?=
 =?utf-8?B?NnkyMEl6UXNuUzk3aCtnWWJnbFlWclF5OWZtWFJ5WVJOaEMzOEJXRmJqS3NH?=
 =?utf-8?B?MjcyclNEQlUyWURBZ2F5QVNrcGh6R2JJSURlR0FEVWlFcVYweWJLTlRueXlq?=
 =?utf-8?B?dWVJeCszMUNCVWtjdG8yRys0NUtBRk1JUDRWRHVWUVZncVdLM1FuUzZmMC9a?=
 =?utf-8?Q?nG1asaehslHUE7dEheCTJrq7k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f5bd7e-4a4e-46be-40a9-08dc33fdc4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 23:26:59.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkCnS8cG1n/CntbJI3naO0KVSssROUxE7pLvBTCqbYlSGtyS3R9QvavK3abrw9d5gRJ0rtO5ahzgSaRpr2r8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-OriginatorOrg: intel.com

PiBJcyBzZW5kaW5nIG5ldyB2ZXJzaW9ucyBvZiBwYXRjaCBzZXJpZXMgaW4gcmVzcG9uc2UgdG8g
dGhlIHByZXZpb3VzDQo+IHZlcnNpb25zIGEgbmV3IGN1c3RvbT8gSSBhbSBmaW5kaW5nIHRoZSBT
TkMgdGhyZWFkIFsxXSB0byBoYXZlIGJlY29tZQ0KPiBhIG1hemUgYW5kIG5vdyB0aGlzIHRocmVh
ZCBpcyBoZWFkZWQgaW4gdGhlIHNhbWUgZGlyZWN0aW9uLiBNeSB1bmRlcnN0YW5kaW5nDQo+IG9m
IGN1c3RvbSAoc3VwcG9ydGVkIGJ5IFsyXSkgaXMgdG8gc2VuZCBuZXcgdmVyc2lvbnMgYXMgYSBu
ZXcgdGhyZWFkLiANCj4gVGhpcyB0aHJlYWQgZXZlbiBjb21wbGljYXRlcyBpdCBtb3JlIGJ5IG1p
eGluZyB2ZXJzaW9ucyBvZiBkaWZmZXJlbnQNCj4gZmVhdHVyZXMgaW4gdGhlIHNhbWUgZW1haWwg
dGhyZWFkLg0KDQpSZWluZXR0ZSwNCg0KTm90IG5ldyBmb3IgbWUuIEkndmUgYWx3YXlzICh0cmll
ZCkgdG8gbGluayBldmVyeXRoaW5nIHRvZ2V0aGVyLg0KDQpCdXQgdGhhbmtzIGZvciB0aGlzIGxp
bms6DQoNClsyXSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNz
L3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2V4cGxpY2l0LWluLXJlcGx5LXRvLWhlYWRlcnMNCg0K
SSBzZWUgdGhhdCB0aGlzIGlzbid0IGRlc2lyZWQuIEknbGwgc3dpdGNoIG92ZXIgdG8gYWRkaW5n
IGEgTGluazogVVJMIGluIHRoZSBjb3Zlcg0KbGV0dGVyIGdvaW5nIGZvcndhcmQuWzFdDQoNCi1U
b255DQoNClsxXSBJJ20gZ29pbmcgdG8gbmVlZCBhIHY0IGlmIG9ubHkgdG8gcy9TaW1wbHkvU2lt
cGxpZnkvIGluIHRoZSBzdWJqZWN0IG9mIHBhcnQgMiA6LSgNCg==

