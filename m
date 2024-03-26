Return-Path: <linux-kernel+bounces-118808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEE88BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789E23008D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4455E6E;
	Tue, 26 Mar 2024 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDTX30pe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC254BF5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449153; cv=fail; b=XLWwNkJW57LGjnxBeajurfMam/+Fy9BOfIRQoIkeG9HgQtsksYm+fuMbUObSrrGU4WDACzM+bHK0ygAQQqR+tfxC1TOiGtPRfLK1FT3+u9l0c3OA5xIlvCHTJM4w8124Hgb4tnFWTKt3kbULiksmdhLwjyDq6/4YIX8808p/niA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449153; c=relaxed/simple;
	bh=F4BzJNCl6lDbTIiUUgQUCNHR8KK19OFL7QXBPRFxk5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5pJPRocvmMRFjckdWJzY3hP9h1R0Zx/TBLJnAhsCCNzSXdtJKZ5Y7QdMZvhsB7dRA3/qBwRRDcJRrFys/Z1wE76+RbQeNLZ5dFDwoI/VFABH2U4zIzyvh6ZTTfINbzil2D96b0LCyTJ/MekAxWWRPbE5oBcZz24e8LN2gWeqk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDTX30pe; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449152; x=1742985152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F4BzJNCl6lDbTIiUUgQUCNHR8KK19OFL7QXBPRFxk5o=;
  b=eDTX30peT3mvpUG4/1myQeA+afTMVLR/blwmj6XSCPmpzBTEMGeV+0oi
   8pPr6RW7y9EoL47idrAWGAezpC01eq1SQHZ/2hG5FfbSYtS35efO50jn2
   cDuecWSZiufrOkWPpxFV03KmNOEPIxPFtQWUO3IKhBMnbxPp+B1tEVBpf
   DQkNmS9Ayi8ra40kRVPLz9zDqTvsXNkuBB94ygrbrM1urdft941RWQlpU
   oVGIhDozM9pY2Knnz5u4dUkBqCBpGYeZ8PdwNuUhFr6GKY7u7bC5LkoJh
   ElTcXnhtEegpw6Ww9g6ZsxA0DbaGXoCqnXawmxAn2ii0wB2fgffPeUt5U
   w==;
X-CSE-ConnectionGUID: Noip+6fYSmmggvJ9gNpImg==
X-CSE-MsgGUID: RMNUVNwZQKyriCfP3yVLOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6703772"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6703772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20605899"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:32:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:32:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:32:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:32:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX2dqyBX5nIrd3UgkGNM3aT3mWiamktNRGW6dLe9ztNJpYgh3qI0Obee0a82roE/FGo9oUMvHQlIOmQXASkQwKWD/av+4xrfKdAMdkd+snlN5tDRREJVNbqg5ShmqmrrdTQbDEQp5vqksKmMrr+5P1anc8U7QsJuVMDBtHpVabFNCVVJA3MO5toTUzEOFOI0BtBQq9d8Y8fXdrhDZf1kjtj6bpWmrXocEusjXD+iOnls+h0lnON7llQaw2YTVqEHmNz75+T2oe/RkeMdMm1sj0dYkr7v0Rv5wJhAZj5r8xGxjGYSv/bG49XrjuYfK+gHojr3+higgCo71eS4Ey+c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4BzJNCl6lDbTIiUUgQUCNHR8KK19OFL7QXBPRFxk5o=;
 b=bYZ4UvBWQg15NGTkbY4KacnaEycDxPAAbpPzn39LggEDg8rreUwGRu9ODNPhjqsaWUnbylEW3Qp8KnNFK4qzNhnPsTboL7P6FB8fRKFz92mPue6PTODLVaGD1J3IivnXtkE/JtKSRCp2Y/6Ks6V+jGQxfHY4eqS/78R6bUChGXwvP+2h5JVqsm4rjgik+HeDob0tv8Sq2pum8ORGuJzyOddGZFpltDwIlgmZ1cIZhCKcTh61PMwXhFWU3/NR0q4JEsMD4IBTKVcde7ZYxlx8cgPgfN2yZrSHtBr+rlVv/TtcaiCVw0zAiICYgcXqlO136KddTQGLstQQbXySWzL23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:32:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:32:11 +0000
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
Subject: Re: [PATCHv9 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is
 parsed
Thread-Topic: [PATCHv9 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT
 is parsed
Thread-Index: AQHafqDjblKdq2s7JkOzh/IXxCQbELFJ1HMA
Date: Tue, 26 Mar 2024 10:32:11 +0000
Message-ID: <48ca0ef4f3208cebe8ab816b24ab8665ce96d457.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
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
x-microsoft-antispam-message-info: vydTtcU7heMVjerQP+ldOww5fTC2elfB8F7SB0hvJwbBNXA+d9mP4MpqyWCPulp2pJ4l4x6fIKpTSAOxKhaFq7jqB/SY+qM3ZiimzQQt53Q4YVirVoXPfSlOZsRiPzM9MquUlMsV5LFq4Wfz2vYjiKTxWSVS+mHoEUd0NeNCya+lKn+6MOzbVx0O8/7D35I/4YQbj7v8NaltipWWNf2NXLXAu//3CVm9b8E1F6+wuevkscHOOG1Bmu8swQkA4cCMv2PCwV8nUz/V8uS86dIhq/Cck557YB/Y4DYXIcWA+ey9kesRHrt04e8xLvd473Mr+Y6mKX/WVCybaPTbxqsN4JaOZe1C5mkdWpnKCOduR7PKGA2uNorNHAtneEI/c2VoudNFGpKw2nAM1Kq8IAueDilHjlks0Jc0i5gDVadKs1Q8k8a3GX2D9BMVJqecEQeQ/RkUJ0ydrb3nJtmvzcbihX95b9CVSQN8bFjmIoSlbqE9bHn9fAP351QLAsZzTrXUkxGK4DAEbCYwWS87MAwRSuNL7DWx1Fy/s12EUcCmhaE6V5cbI28fhxB5ugvnhsB8wGeP7hzdJOaWDBPNa3kBk3TxXgkdRRL9xAmgMKLAoZhASc1RgdjYAkH9bO8Nf4i9odMFOVpbFPfVXOKvwAxIXrfJV9leBhp39IZMTleVhv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry9QNlNDZS9PM2M3RkV1Tk16WjBCcnV4MEZMWEJISFlHREFSWEkxb0ltb1Rp?=
 =?utf-8?B?b21teGRkaDNnZi9ra3RVNU05ZTIvQ3JiaktmSjdhcGJHTFB5R21ISENnM2dX?=
 =?utf-8?B?MkxTdEh0M3FNRHhhMjdobHR1cGMyYkZCL1dHenVFeWRFMjBEd3BqeHJpczNR?=
 =?utf-8?B?bjhzUUg0M0JrVUZCUWk2WldjQThEVy84VlNVRldqZjhQY2VTQThYVVlsTlRH?=
 =?utf-8?B?S1hQT1cyeWJlVjVyZDBiQXpWNlRLRzFCNGp5eWE3QzZrQkRhYUhDWnNnZGtP?=
 =?utf-8?B?YTVGcDdqVGhISHl3dk5xRVNGTTNGL2xpZUJaUWs2cjdYcGNhMVdCa1daS3Vs?=
 =?utf-8?B?aFcyL2l1cnNLekRtSXFlV094K2xpTjZLTjFCb3NGS0UyMXByS3VVRlA1L3FN?=
 =?utf-8?B?TEFFdFVhWm0rUThhNHdsa1RmTXptQllhV29KMU5wcFdXdFIzMmVLVG9YSWFs?=
 =?utf-8?B?THdkcWpCRGV4NU8rVDU0b0JKbXpzek03bVpnWWdGcEtlUDJCeXFpNENCQ1dS?=
 =?utf-8?B?TGtjR2ZuWnhTRy9EeXRqUDBSNXFRYjZqaU85SFp1OGZ3dWVxME9NeEh2OG9S?=
 =?utf-8?B?L2ZNMkV2Zy9BUEJaZWtwMDQ3c0pRL1hGbUt0dFB0V05ySFV1elZhbUhPeFhz?=
 =?utf-8?B?eFk3UEd0blFERE1nT2dMeFBNYVJLRzkxSUQ0R2Zua2lSMjhqdGY1c09renQr?=
 =?utf-8?B?MUpDUm5jRnBzMWh2QzhwR1VxVWhRY0NrUm14ODJqSGF3MVNGNmExWldMbG0r?=
 =?utf-8?B?djFIL1FINjI2cVU1dHhRNCs0UjAzMm9QWEhLc284eVBmbWpON2dpYm1tc1c5?=
 =?utf-8?B?dmZpbmZiUHNKRXk4MXRhWm9LTTVPcWJ5Y2JDUC8yUXhnNDNiVDJDMHF5Sitq?=
 =?utf-8?B?L3ppZEVNcm8zZWtGa3J4RlkrSWY5dk5zNEEwT0dCS3ZzSkIxOFkyK28rZUdo?=
 =?utf-8?B?ZTRxbEc3bXFuZjFKUXhnSDdPcUkwSGRrQ0gvaXBOS3U3Z29IaS8yU3B4dGc2?=
 =?utf-8?B?WGN3bW0xTmMwb2hDdEdsaFNEcGcvREdRNG5OZEhIc09MRDVqYjFzTlFmSFFT?=
 =?utf-8?B?b0U2WGhlL3RSb0pqWXQ0ZHhQUFBQdzE3dVBmNVVUWXZkVnU3cHlvdkdRYUpN?=
 =?utf-8?B?NkRSQko5aEttaVdVQVd4UDdCOXNqVndSWnJHUEZmNnI0c2oyRE5td1JUem16?=
 =?utf-8?B?Y01wa2tPd3duOWNHVG9pR2Q4aTFoaWkyRERQQTROSXk0R2x5bFE3aDlYaHVq?=
 =?utf-8?B?a0hGV1kwMGFMTXlscWR1VU1TMDNyN0NYaC9rRzV4OWhOQmg0eVBGZm5ZTHYw?=
 =?utf-8?B?UmMvQXFLYWlPQ1R4am8yZE9PcTRjVHhReGZqQVZOMGJDemRFYVdKTUFLSTJE?=
 =?utf-8?B?eXluOE1FbGttamJpdWliNFFmOVhwQ1dxb1VNRkNPSFdtZ0ZERHNPck55UnV0?=
 =?utf-8?B?WWkrM3IvVVAzc2VLcXpEU3VHZklGOVVrMTB5bUVyUzFicnJWa1RSVzVDeUdM?=
 =?utf-8?B?VU5yU1FTbUwrME5xRHNQY3lIb1MybWtiZ1ZNTTYzcHZkTkhjaVkrejYvUlll?=
 =?utf-8?B?dFRlbWFQVnRuYmo1Z2dsTzd0czBmeWZrWEtyUGlUU2tzdE9DRnR1QXZTRmxL?=
 =?utf-8?B?Sk1PRlI1UjZlWldWMmh4ZVROMG82TEJxbkZxYXBlaFpzTHpVWEh3TEhWY3N2?=
 =?utf-8?B?b0luUnkzaFdTa2xnSlR4T2Q2QTg0OVpGWGx6UUFpbWpvMXlHUmJIekpJR2JT?=
 =?utf-8?B?R01obHE1YlM4Y3ZUUS8wTVFRc2U4ZVBzeHViSkxkdjkyWXIxOVZ6NDhtTG11?=
 =?utf-8?B?czNIM2hLY3NELy9DWmZDbm4zWmdlRUhydnBxcldBU3pjM0VwZ09zNHFScEo1?=
 =?utf-8?B?Q3pKczR4bHhDa0cyY1FHVGUrbjdpZ1FIT3I0WGhMSVg4c0IvdERXd2JRY0pz?=
 =?utf-8?B?Z0RFYUNUaFBtVUJrRTd4bEh6SHBTem5mUllIREJ0VGlSdGx2WXBVd0c0TDZv?=
 =?utf-8?B?V0hQRW1WZzh6a0FFcWF4MXA5M0NYMTdCaGZSU0lZNThMSzZ6YlJodHlaV3dV?=
 =?utf-8?B?VTFvS1FSRzFPTm5SODF5bEw0WG40dW9HL3k1eUdwUHJKWWVEWEJ1V1UydnlE?=
 =?utf-8?B?V2UvK2F5emlLSndZMG83MUN4bWlBblZncGU0L0xnWXRDbFhIVUZqTkRWbC9i?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB8A93C56C0D404F9A7CEBF8FFBFE4D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69499e44-62d2-4fa5-9983-08dc4d7ffee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:32:11.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxxAteAUIU8WAu2CYas1CP88UiIigHBuO+TpNOKdDJgSK5uS+TWkNw5ZKxReAB+S9/IA0uOdkA8BVrtgaltgHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjM5ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFdoZW4gTUFEVCBpcyBwYXJzZWQsIHByaW50IE1VTFRJUFJPQ19XQUtFVVAgaW5mb3Jt
YXRpb246DQo+IA0KPiBBQ1BJOiBNUCBXYWtldXAgKHZlcnNpb25bMV0sIG1haWxib3hbMHg3ZmZm
ZDAwMF0sIHJlc2V0WzB4N2ZmZmUwNjhdKQ0KPiANCj4gVGhpcyBkZWJ1ZyBpbmZvcm1hdGlvbiB3
aWxsIGJlIHZlcnkgaGVscGZ1bCBkdXJpbmcgYnJpbmcgdXAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+
IFJldmlld2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0K

