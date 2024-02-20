Return-Path: <linux-kernel+bounces-72235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45CC85B108
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A721F2124C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11558135;
	Tue, 20 Feb 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLps7jPo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A458101
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397863; cv=fail; b=bS5sM5zZEIV2iGTOhm4W7ROCSWsuBNWPG09ITh5mPpbh3r2eS9i+3qFcoiQ9EvPuGFY1uEKUrZvdM8bQoCnnvK8UF32JYFb7afl3S9ooJbg0kmfX2Lw/Tnfk7DdNDoqb3kLbpoTOdustVHWeixeojaVuNWhHkp56+M0wIEnu9vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397863; c=relaxed/simple;
	bh=k5+L0Q7FlJ+tmK7GksjO3XZROao3xGsByG9IWTeSd6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxjsnFA+aIeXOkkxsVrKaklHJsTTbsfMSQFdJKXtW09U7t2UBjIGCI0eWzTxoT3aMGux643BcgnbmOddPsT2NbYeLVt2vIa9/hen/o2GhaRjCe0BZLCIzp2/Q/3QpHFuCLvoNw4UMkPwvKdWe5KNkn3m7dh9IapcmxRehcqiv6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLps7jPo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708397862; x=1739933862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k5+L0Q7FlJ+tmK7GksjO3XZROao3xGsByG9IWTeSd6E=;
  b=PLps7jPo5pc4rn32NpTq/QghXttAIAdY/kgbQYt6n3dU9eYx0+Zy9CTQ
   AJeLftCjYBHY1B+peC7zqgbRDyqvu+CelZPxgNjjFwe0i1npYmnfeiCIW
   X3ocqj2GbAXByq1WldBDDHx85FJI5Nj90+ebhBikkjFT8mbLFw1JUegEw
   4zCN72wFmrP99jEqIFF4v3p5KawU9+mOoX426jvFx9CE8eQ+f1Wv3L/g5
   hiOJ615ivfHd+LAia7erKa6jKq1US71fh9PdTtf502Qa/ndUc0uXEpp1U
   YSxwReDLE395ZelFjrL/V8asvjOaursNK3mg/nXTiy1z6VV1wEQ9SJzGb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2619637"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2619637"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 18:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4940791"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 18:57:39 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 18:57:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 18:57:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 18:57:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 18:57:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJcD/BoJYo2koV+tKW9VUX93nYoFvpBJTUNCsnttWI+DBp+E5tCIOMLzwkPu09q6VUpTC0nAUNi8DlEfp4Yc/SKtv8ti6zYcqkEgjvSe6rWAI6jh0CjObcH+mBagTS9/DkDaZNxzUrJecCc2EVk5Iwutna3HnB2UxJoLrK4OoXUnb1wqYZ2g0Ql8UU7NQWYxtQS07pYsMrCfrwxruKMcqemXkjDzQ8vRpykp9hpDszZwfnb6ZVwDPACnHHldkvlp4lUmb6UG+PeImumXsm+KLtuHBWWIny4GDZeCYdFzNDVbBJvLuYaH6gnHm/cNWArNcdabMQts/uofLWvnJtXhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5+L0Q7FlJ+tmK7GksjO3XZROao3xGsByG9IWTeSd6E=;
 b=TRzejd2ufadl6hpsZy1zTvgG0RGHqxgiUt6SjjBcgfwj/kSnhpWYk+Sf9InHmGkg+ZN3g6xmaui5vvI1mgvVUlhBR0MsS/3o5jzpPMs2h318JdgnHC3lbcRhvcxI91ysBkuH+Wsf5WrAsO5RjQzriD7AV4/ovMkpLJeL7ldD/tWeOArdrioi0KCESQB8P+TvyspmsrFpDxAvcSU9NpldRbDrTNKkxBD94o1G90jvOduEU3tu2QRPksrgndpfDDYXEc85CnUIfu0dApenuuv/oST5dmw/hLeue5Nbw54RTt14OX8aLdMb/apRc6VRWacN0DRrPryj/VjuKTDjRnqBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 02:57:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 02:57:35 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Thread-Topic: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Thread-Index: AQHaVDdfcLjlgK8/xEqQPfvtDlVukLER9XiAgAA6hICAAA0QAIAAGziAgABQZQA=
Date: Tue, 20 Feb 2024 02:57:35 +0000
Message-ID: <1b38a2a9a7cf2068d7e0a5154111147ba58dc99d.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
	 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
	 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
	 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
	 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
In-Reply-To: <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7411:EE_
x-ms-office365-filtering-correlation-id: a067978c-b7db-46f7-7c68-08dc31bfb0f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CK7+4Hw1u8zWG+qJ/OYbho/O0WPMx87FTwplOZT5NCBocFsEKZ1enBATgcaqHrHHYy7cTAhbXunSMRIkehyssSsO2q/bJCQBcDXsQ5VClQOeB9uKYXjT/aB0SJmDMQPppjfceuhqniLN5Dzzz7mKrzyBOwr9wzptZ8QE2ayZVGxPqrHvRl7y/1SkBLocTyZDl5ivGrb4T1ZD4bIXmucOS0ceNsedrydXlD0K5AB+NDgk7jR/COqT2kgYZTWHrJTpRaLw4WRMywgF5c0Ri7l4aBRv47XVSQ9UmbVyXHEeE2fEWMydQMI8vjVKZ+hXMcXXu4UA/RfwriZglQCPVvfyXt1iBzt0E/bwCbXK+XegrQ0kuZaxcVua+/G7GPkplOvqAllYAje/m7o3feBDioaFo3IXe1RsqNYYrC04ufbHRHeA94JEQpkQ1Kv+SFN+JEdtpbLk6kGkxYM0wDOhXaN5PLe/8Ifr85y0lB+LuYil/mFohTrAAWkljR153xICL2ORmv8juQgsAGp7PMkMDXBTU8b9s74OwrEr12HucGso9X7lUoa16HOc2oKJc9+KOQ13lh1f5AXlWwSTndPqw/IXtsLZ2E/loeA2gughh3nFAO7Uv+6D2n17jkyNL1KrYeV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk1LcW8vSWs3NE5jcVZ1OHN3cVp1b3RnVmJLNXlZU2p0UnV3TjFkOGRtR3Fl?=
 =?utf-8?B?NSs1MS9oN1VueUF3NklmaHQzRHFRZFgxa2xZazNZeTV1OXdrQnMzSW5XbU1l?=
 =?utf-8?B?RGFnUVRuM0NFdGRQdnVyR2NWNzhpdUNkeEg0ckx3em1VN0lBbXVHbjFJSzhM?=
 =?utf-8?B?QWRDcUN0ZFJERFBUa0pCanZMRllJY2QwRFhIWUNnWExZNHozQjlTSlJRMUtD?=
 =?utf-8?B?Wm1MM1J2d0tsL3JrQjJFcUFMNDVOSU56Y2JDdEl1SHNMSWZoTHV5ZWhBUXJa?=
 =?utf-8?B?bzVzckxudjFyU3lRdmlNTERwWVFhRUxUNWd3U2QzMFpVbUIyT0lLUW9ISWtZ?=
 =?utf-8?B?UGZkeEVsdlpiY0pMQjZUVmY5ak5oTWlGN000R3UzRkxiYlNYeTFMRXJleEI2?=
 =?utf-8?B?Zitzb0tyOVdiSGhlNnZuWkxTbEMzWUsrR3o0bkI1UVVxcmNvL2JST1JkYmtq?=
 =?utf-8?B?L0RzTGNuM1F6QkovV3pCWG1sUTNQTmNjbGIxUmRkQ1ZPS21UVVVQMFdnTXhr?=
 =?utf-8?B?S1RCc2xDVmFWOHA1MFJNT1lqWm1PU0diRUlJdnJ1OEhiQTViWFVHeFFNYUZs?=
 =?utf-8?B?Vk1UcEtGZFduK0JuOTN4SUJTbUNDSzZhcDRxTkxvQk5EcTFmMzlSN0xpTHFq?=
 =?utf-8?B?M3RRYXdUZHA0aDRvUVQ3SkJqVU85N3pLeVAzai9LTk5XY09EOTQrT2xpRDJG?=
 =?utf-8?B?RjFYVFUyNHJQVmNZSjlpWXpsYnZhcHhrVmVycmN6aWQ5RzVIcmZvWlU2UFE4?=
 =?utf-8?B?b2ZSMFVKWDZNWnJCeFp6cFM0MDlnQ3V3UTJtVlY2aXpVTXFnaUlMd21CYkJk?=
 =?utf-8?B?SmUza1dIR3FtYXUrVGIwcXdHVk94RndsVVl2S3NqUzFtcmtUQXJTejlYS3hV?=
 =?utf-8?B?RDNXRG5wMXZxTEJzVUpxeWZnWlE5K3BxbzBiMUFOUTNsZURWOGhnWjRFQlIv?=
 =?utf-8?B?eVFXV3M2MU9aMStGcTdvRVJnSFlCcVdGUlNuNjZaYTZOQngvM28wMHAvWVl4?=
 =?utf-8?B?dkk1ajVNTzE3UWt3UWhpMTVSdEhtRzQrZ3ZwVnZSUlQ0N3BKNU9mdVhVaW9O?=
 =?utf-8?B?czFkTnFOclZubVBNQlAyTW9jL0lwdlhTQWRBT2Fud1owTFphYkhDaENCWnN5?=
 =?utf-8?B?ajQzT29vSjVzZHByRGhPdXNTZXBabjErd1NCdlQwYzNYRnZoMFFpSVNOMlcr?=
 =?utf-8?B?Q3hBbVc5TUdaWnEyaVNDUSs4d3BXY0JWUTVQR0d2eFZDYUxVRXRsTEhiTWhE?=
 =?utf-8?B?a1Bta0wrNHRheVVSWEVTRHNDTGU1M3FTb0F4aUR5cXAvcGVDYnZxUHNNSHY3?=
 =?utf-8?B?VzhZeC8zRktGZHV3dzlNcXBWcVIxWktLUlhieFd6dHRsUFZxeUhEL1pzeE9N?=
 =?utf-8?B?cS9XcnZsUkxFSFBidklCY0E3UkZ3L2pwOVFxWTlVTGQzTDVpaHhEQlpoMGdO?=
 =?utf-8?B?UUs5VUYzUmlNMEovSzAvZDRXVDMzSTFzRXdRMWVxSTN4SFNRaFZEZHpWT3M3?=
 =?utf-8?B?cmE4NVN0ZG9TQjhBd3pSL1N0VzZoWVQra0JDTENlTHB0b09YdDZRTDdhQklC?=
 =?utf-8?B?UUlwb3N4NVR5blhvMEpXYzdyeDU4SFFoZmNpQWlYdlBXQk5NZTlGTHFlRWxP?=
 =?utf-8?B?TklDQTkxWGRMNGJjbW9INVQxTUJUbGU4cU1peWM0bkpJZmRyM0lvaFJLNUdI?=
 =?utf-8?B?VlNIcVVaeTc1Q3FuMm1mdi93YW9pUEI4VStRNFgzRGhSeVBrWW50VXFiSG9p?=
 =?utf-8?B?R3NvQWc3cG1Wc2VKK3dWYjZFMDJLNzA3MWVUVXYvcUZjVE5XSksvRFJZWHd6?=
 =?utf-8?B?eFZEeTh2cWgwUmwvc3BtaHZBS0dwZDJPaWZoYmI2ZGhhN2RKUHlBV1dpNmZP?=
 =?utf-8?B?Z3d1cW9zTGl1RExpUU84OEEwL0h2cGc3cXNRazYzUnREV2U0eU13VlFvWUV2?=
 =?utf-8?B?Ym9FMzdBekhabGdSeGtlWlV2TDNSZHJxd0lCUjhkNkRYQS96eGZ3NVVBV0lp?=
 =?utf-8?B?ZXp0dlNiVnc2NWZmYVB6YlY1ZVU3RGRNMzg3N2xsaElvY25zcTJlQTMrK3dq?=
 =?utf-8?B?cDBXTHhHYTNRMkhCem95YklXWTVrb2RBc3QrUDBpMFlaVjZSa29zVEV0d2Zy?=
 =?utf-8?B?bkRFOUgvZG4rUlJ5ZFFtN0xzRnE1UENKc2VMWHNpcFAwUk9xTS93M1N3anE0?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6FC12D75135D041BED6115BA99AC243@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a067978c-b7db-46f7-7c68-08dc31bfb0f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 02:57:35.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZaf3LVUAVhaNUwq/fs4EYzS3m8RgeoZboTgZe4JA5PQAl/A+RI/AAZft7Q+yFkGOPNir7DtgCIrniZWQSYaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAyLTE5IGF0IDE2OjA5IC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IE9uIDIvMTkvMjQgMTQ6MzIsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbiBNb24sIEZl
YiAxOSwgMjAyNCBhdCAwMTo0NTozN1BNIC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+ID4g
PiBUaGlzIGNoYW5nZSB3b24ndCByZXR1cm4gdGhlIGNvcnJlY3QgYW5zd2VyLiBUaGUgY2hlY2sg
bmVlZHMgdG8gcmVtYWluDQo+ID4gPiBhZ2FpbnN0IHRoZSBzZXZfc3RhdHVzIHZhbHVlLg0KPiA+
IA0KPiA+IEZlZWwgZnJlZSB0byBleHBsYWluIGJlY2F1c2UgdGhpcyBwYXRjaCBpcyBjb25mdXNp
bmcgbWUuDQo+IA0KPiBJbiB5b3VyIHByZXZpb3VzIGVtYWlsLCB5b3Ugd2FudCB0byBwdXQgdGhl
IENDX0FUVFJfSE9TVF9NRU1fSU5DT0hFUkVOVCANCj4gY2FzZSBzdGF0ZW1lbnQgd2l0aCB0aGUg
Q0NfQVRUUl9NRU1fRU5DUllQVCBjYXNlIHdoaWNoIGlzIHJldHVybmluZyANCj4gc21lX21lX21h
c2suIFRoYXQgd2lsbCBiZSB6ZXJvL2ZhbHNlIGlmIFNNRSBpcyBub3QgYWN0aXZlLCBza2lwcGlu
ZyB0aGUgDQo+IFdCSU5WRC4gQnV0LCBpbiByZWFsaXR5IHlvdSBzdGlsbCBuZWVkIHRvIHBlcmZv
cm0gdGhlIFdCSU5WRCBpbiBjYXNlIHRoZSANCj4ga2V4ZWMgdGFyZ2V0IGlzIGRvaW5nIG1lbV9l
bmNyeXB0PW9uLg0KPiANCj4gVGhhdCdzIHdoeSB0aGUgJyEoc2V2X3N0YXR1cyAmIE1TUl9BTUQ2
NF9TRVZfRU5BQkxFRCknIHdvcmtzIGhlcmUuIA0KPiBCYXNpY2FsbHksIGlmIHlvdSBhcmUgYmFy
ZS1tZXRhbCwgaXQgd2lsbCByZXR1cm4gdHJ1ZS4gQW5kIGl0IHdpbGwgb25seSANCj4gcmV0dXJu
IHRydWUgZm9yIG1hY2hpbmVzIHRoYXQgc3VwcG9ydCBTTUUgYW5kIGhhdmUgdGhlIA0KPiBNU1Jf
QU1ENjRfU1lTQ0ZHX01FTV9FTkNSWVBUIGJpdCBzZXQgaW4gU1lTX0NGRyBNU1IgYmVjYXVzZSBv
ZiB3aGVyZSB0aGUgDQo+ICdjY192ZW5kb3IgPSBDQ19WRU5ET1JfQU1EJyBhc3NpZ25tZW50IGlz
LsKgDQo+IA0KDQpbLi4uXQ0KDQo+IEhvd2V2ZXIsIGlmIHlvdSBtb3ZlIHRoZSANCj4gJ2NjX3Zl
bmRvciA9IENDX1ZFTkRPUl9BTUQnIHRvIGJlZm9yZSB0aGUgaWYgc3RhdGVtZW50LCB0aGVuIHlv
dSB3aWxsIGhhdmUgDQo+IHRoZSBXQklOVkQgY2FsbGVkIGZvciBhbnkgbWFjaGluZSB0aGF0IHN1
cHBvcnRzIFNNRSwgZXZlbiBpZiBTTUUgaXMgbm90IA0KPiBwb3NzaWJsZSBiZWNhdXNlIHRoZSBw
cm9wZXIgYml0IGluIHRoZSBTWVNfQ0ZHIE1TUiBoYXNuJ3QgYmVlbiBzZXQuDQoNCkhpIFRvbSwN
Cg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nLiAgSG93ZXZlciBpdCBzZWVtcyB0byBtZSB0aGF0IHRo
aXMgaXMgdGhlIGJlaGF2aW91ciBpbiB0aGUNCmN1cnJlbnQgdXBzdHJlYW0gY29kZS4gIFRoZSBz
dG9wX3RoaXNfY3B1KCkgY2hlY2tzIENQVUlEIGRpcmVjdGx5IHcvbyBjaGVja2luZw0KdGhlIFNZ
U19DRkcgTVNSOg0KDQogICAgICAgIGlmIChjLT5leHRlbmRlZF9jcHVpZF9sZXZlbCA+PSAweDgw
MDAwMDFmICYmwqANCgkJCShjcHVpZF9lYXgoMHg4MDAwMDAxZikgJiBCSVQoMCkpKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICBuYXRp
dmVfd2JpbnZkKCk7IMKgDQoNCkkgYmVsaWV2ZSB0aGUgQklUKDApIGluIENQVUlELCB3aGljaCBp
cyAiU2VjdXJlIE1lbW9yeSBFbmNyeXB0aW9uIFN1cHBvcnQiLCB3aWxsDQphbHdheXMgYmUgdHJ1
ZSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIE1TUl9BTUQ2NF9TWVNDRkdfTUVNX0VOQ1JZUFQg
aXMgc2V0IGluDQpTWVNfQ0ZHIE1TUj8NCg0KSWYgc28sIElJVUMgbW92aW5nIHRoZSAnY2NfdmVu
ZG9yID0gQ0NfVkVORE9SX0FNRCcgdG8gdGhlIHBsYWNlIHJpZ2h0IGJlZm9yZSB0aGUNCmlmIHN0
YXRlbWVudCBhcyBzdWdnZXN0ZWQgYnkgQm9yaXMgc2VlbXMganVzdCBmb2xsb3dzIHRoZSBjdXJy
ZW50IGJlaGF2aW91ciBpbg0KdGhlIHVwc3RyZWFtIGNvZGUuDQoNCk9mIGNvdXJzZSB3ZSBuZWVk
IHRvIGFsd2F5cyByZXR1cm4gdHJ1ZSBmb3IgQ0NfQVRUUl9IT1NUX01FTV9JTkNPSEVSRU5UIGJ1
dCBub3QNCnF1ZXJ5aW5nIHNtZV9tZV9tYXNrLg0KDQo+IA0KPiBJIGtub3cgd2hhdCBJJ20gdHJ5
aW5nIHRvIHNheSwgbGV0IG1lIGtub3cgaWYgaXQgaXMgbWFraW5nIHNlbnNlLi4uDQo+IA0KPiA+
IA0KPiA+ID4gPiBTbyB5b3UgY2FuJ3QgcHV0IGl0IGJlZm9yZSB0aGUgaWYgLSBqdXN0IHNsYXAg
aXQgaW4gYm90aCBicmFuY2hlcy4gR2VleiENCj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGF0IHdp
bGwgc3RpbGwgd29yayBiZWNhdXNlIHNtZV9tZV9tYXNrIGFuZCBzZXZfc3RhdHVzIHdpbGwgYm90
aCBiZQ0KPiA+ID4gMCBvbiBiYXJlLW1ldGFsIGlmICdtc3IgJiBNU1JfQU1ENjRfU1lTQ0ZHX01F
TV9FTkNSWVBUJyBkb2Vzbid0IGV2YWx1YXRlIHRvDQo+ID4gPiB0cnVlLiBIb3dldmVyLCB0aGF0
IHdpbGwgY2F1c2UgYW55IHBsYXRmb3JtIHRoYXQgaGFzbid0IGVuYWJsZWQgbWVtb3J5DQo+ID4g
PiBlbmNyeXB0aW9uIChzZWUgU1lTX0NGRyBNU1IpLCB0byBhbHNvIHBlcmZvcm0gdGhlIFdCSU5W
RC4NCj4gPiANCj4gPiBJZiBpdCBrZWVwcyB0aGUgY29kZSBzaW1wbGVyIEkgZG9uJ3QgbWluZC4g
VGhhdCdzIHNvIG5vdCBhIGZhc3QgcGF0aC4NCj4gPiANCj4gPiA+IFRoYXQgd29uJ3Qgd29yaywg
YmVjYXVzZSB0aGUgY3VycmVudCBzeXN0ZW0gbWF5IG5vdCBoYXZlIFNNRSBhY3RpdmUuIFRoZQ0K
PiA+ID4gY2FzZXMgdGhhdCBuZWVkcyB0byBiZSBjYXVnaHQgYXJlIGtleGVjJ2luZyBmcm9tIGEg
bWVtX2VuY3J5cHQ9b2ZmIHRvIGENCj4gPiA+IG1lbV9lbmNyeXB0PW9uIG9yIGZyb20gYSBtZW1f
ZW5jcnlwdD1vbiB0byBhIG1lbV9lbmNyeXB0PW9mZi4NCj4gPiANCj4gPiBBbmQgSSdtIHNheWlu
Zywgd2Ugc2hvdWxkIGtlZXAgaXQgc2ltcGxlIGFuZCBzaW1wbHkgV0JJTlZEIG9uIFNNRQ0KPiA+
IGNhcGFibGUgbWFjaGluZXMsIHJlZ2FyZGxlc3Mgb2YgdGhlIGVuY3J5cHRpb24gc2V0dGluZy4N
Cj4gDQo+IEluIHRoYXQgY2FzZSwgQ0NfQVRUUl9IT1NUX01FTV9JTkNPSEVSRU5UIG5lZWRzIHRv
IGJlIHNlcGFyYXRlIGZyb20gDQo+IENDX0FUVFJfTUVNX0VOQ1JZUFQgYXMgdGhlIG9yaWdpbmFs
IHBhdGNoIGhhcyBpdC4gVGhlIGNvbW1lbnQgbWlnaHQgbWFrZSANCj4gbW9yZSBzZW5zZSBhczoN
Cj4gDQo+IAkgKiBDQ19BVFRSX0hPU1RfTUVNX0lOQ09IRVJFTlQgcmVwcmVzZW50cyB3aGV0aGVy
IFNNRSBpcyBwb3NzaWJsZQ0KPiAJICogb24gdGhlIHBsYXRmb3JtLCByZWdhcmRsZXNzIG9mIHdo
ZXRoZXIgbWVtX2VuY3J5cHQ9b24gaGFzIGJlZW4NCj4gCSAqIHVzZWQgdG8gbWFrZSBTTUUgYWN0
aXZlLg0KPiANCj4gVGhhbmtzLA0KPiBUb20NCg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLiAgVGhh
bmtzIQ0KDQoNCg==

