Return-Path: <linux-kernel+bounces-25212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9682CA72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1646284FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD2168C2;
	Sat, 13 Jan 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHlQ0bR/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427E187A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705131344; x=1736667344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Mxppk6sWZAJ/gGbQek+8RC2MGz+C/GqXHsA21FYThc8=;
  b=kHlQ0bR/OyhOg+CEi/maNIFxzxB57sdpJYR6iVPxN1rkXmh4FluIx+jz
   DWzTg0LFd+tlofG5ywG+O+ZLJZz1gtBm8JaiFQB/cqPAWQurHzn6MewRf
   8mNzxT0WZ7xe/YaMNZqQDhMKGwH0PWO4kmH7Fps+Hmfa5kbo3BtmbYj8E
   HnSb9PaLKsEQJ383C47voyWco2ZDJAbR7yM4jA0L6riLL8jMZj6Jr1Pkq
   xUOxCDFn3DQNbz/s60qZ0lkf+ZjtTpVy5suBFvWdJo6lF9ibL2oX2NYff
   WOUW2tpFnuge6QoDdKjBdL37PAAjo5AnTITeqdnY0pd5dmLozb0U9IPmA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="485525657"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="485525657"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 23:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="817318454"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="817318454"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 23:35:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 23:35:39 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 23:35:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 23:35:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 23:35:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2K16AZP8fUpZGNSQ54Vsq+i0RicOxlPExXg54io6gOzQOR6wTeN3ze1pHfmEwHs2ErcodScpCXBoswIkDBMFvnSYP/YZGh1rygPuE3onzQPOj68+pawmSCa6L/JUmSSfefhp9uRIAqkrSW3p45nK9d5Tr0R7o/ra8any0CRDKDmYCX1I1THRf4aA2FgkpyA1eEAVNtARjrzmRyzIdJpycMOAkRrzOdJRmjZodB3Q9XorQXWlX1FXMBKrqXrW5ZhnMIYIrDRLuJuQzuNKAaojI3EwXBsdXjHvVjmQj21CIjQp4RLXMvV2xfRklpEc+bUl84IjVkR+seozCtWLMvqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxppk6sWZAJ/gGbQek+8RC2MGz+C/GqXHsA21FYThc8=;
 b=RMjVELJwn8FzAbpq5RoMJeP8MmTmACWg9Bs3l9takQ6rCF5dkll44kgxt5RhW+SmCg6m9zIEN9L0AoHHLIgKVTjL0k/YnWiOvpnvKrKzn73MB3NFKH5U54/LdO7UsNXf5gH+eYSNi+bSqpG6KcYiW8HqUZaPO3p46mmb6hiclO7doVdarS1AXEj9aMqCr/+/AbEx07A9jfCtWIW18M8Zo27eE7Gr8r+5O1W/MkvagOFj2cBaNgCnTdWo9oOz1iyiCVCzlgmKqOTRgmWLIfLwY59V7bXjrLFOTcNEU8ogMVvxznhJ2ryIrPmB7BpOVbL23eIw6HJi/ieLXd+j3ZnVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sat, 13 Jan
 2024 07:35:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 07:35:33 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Brown, Len"
	<len.brown@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
	<ray.huang@amd.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Sivanich, Dimitri" <dimitri.sivanich@hpe.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"andy@infradead.org" <andy@infradead.org>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Topic: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
Thread-Index: AQHaQjyCF3Nt+9p0tkSkWmDSuvApOLDQAJIAgAAWM4CAAKJBgIACYq8AgAAPKoCAAsAEgIAAa8UAgAELC4A=
Date: Sat, 13 Jan 2024 07:35:33 +0000
Message-ID: <365568d9441d74516d0bfb802018ee0943b1b94b.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
	 <20230807135028.381851690@linutronix.de>
	 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
	 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
	 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
	 <87frz5jmnl.ffs@tglx> <87a5pdjk54.ffs@tglx>
	 <dbad0f6f9dee5851aa21ffae9e8877cf23645af5.camel@intel.com>
	 <87edemimrj.ffs@tglx>
In-Reply-To: <87edemimrj.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB7552:EE_
x-ms-office365-filtering-correlation-id: bd661ffb-7da3-4327-ec9d-08dc140a39d0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+jwU0MU3oFOAV9vQehQWeQFPZr4SkpD3laN7EKWi4gG8xNh2lIX63pNaWI8qjCrSpoGRGxD2VQyPD8hl7v1aneEbKR8L5sWdwXFS27zYP5HQW/3J1yaskv96vqmu5vFX6tT1hH9wo1/rNljZXcEXyhc9UGxUnnwMFkS5KxVaAy0PBwEAdiRFig2MqjRk4OqxEEU72fslqPDCfDSIJWB7ZPbwJHbMzvW+UOZXCxQwa0cIkIJvk0o3CsbKjFW0YMT9Rm+nj3Sj581xy2kiJPIrvzrEaOPhFDvxkoSLsLKCBH0Lu3LhD/x2gBmvN3VewFsOPzA5mkEyjQ2g2q0F8IeXgLGL6y+EbOsga7ycH4s+O3O6Hp5pO4n3NqYc+E40fRrLkxoII7hAFiIFMeJ8hBxAR/VroY+YI1uRM8Lw6dgi0gJiV45AIOUFMi4+2GAvXgsY5SeOs9CHLEFMx8Hest7rpTXy/tWwH2tYLbgSSY7nBAWGHMWP/lWUHHUzQA7kU0YY/T23aB5VKqWZCQTYrI8t8TR6Yuz2gM/S/At7Hf3TMliKX3sxAvKpKejBl9dOAAzPDR9y/AGd4sSqymdwU07uBx1PiXzgHfhGojopvCVDR16I1DowGl+kulSt/EE26lt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799012)(186009)(451199024)(6512007)(83380400001)(26005)(36756003)(86362001)(38070700009)(38100700002)(82960400001)(6506007)(110136005)(71200400001)(5660300002)(7416002)(4326008)(2616005)(66946007)(66476007)(64756008)(91956017)(66556008)(122000001)(66446008)(8676002)(76116006)(54906003)(8936002)(508600001)(6486002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T015VkZXREF5NjE1R01rMWFWcitnVW9OUU1jRTNEMnBLZFhpUksvbnBsZmdr?=
 =?utf-8?B?Ylp6UCtMN3B2NHJmSjREUlRXTmVhVUl6WlNudEtYNk50SkZEVEVLMndPMG16?=
 =?utf-8?B?TzVQWmJ0QmRXbkJIUEVIbitkL0txNkdZUWRiN0crNFZqM1o2eFJScVdCUUQz?=
 =?utf-8?B?VFpmZGh4OGxrNUg1M0ZSdEtScEsvNkZFdXNaK3dETFlna1hJRER6RGFjcnJm?=
 =?utf-8?B?SDlmWkpKdUgxV0d2a256MUpzS1Z0WjQ1M2dVZnpoVjkvVEFGVjhybmtWejVJ?=
 =?utf-8?B?alZzVnV5bkUza3lnWHFISGxJRVdTNldpZDI1N2JBRFAybWREc1RCZ3JUWDdZ?=
 =?utf-8?B?a3pYSVBKN1ZhZUh4a2JNYWVxMUxReDhERGZtOGxldWxBb0gwckJJSHpSNzcr?=
 =?utf-8?B?Z0FuUUIwZzFrcGY0NkN6WjhTWWdHYXlBekhpVHdpNEZzc2tJcnpQaEZ3UEls?=
 =?utf-8?B?MlFibXl4N0xWQ25RMDByV2M3RWxzdFZ1SG4wUnZ3d1pZVjRvT1k3THhFWko1?=
 =?utf-8?B?aVdXYW9SU1VCQ1Faa08vZ0NkamhoZmszM3Jyb1B5dVAxMWpGK3U0OGJ2Rm9a?=
 =?utf-8?B?TXhlMFozbTdFRlJKVWJlU0JFT2pyTUlWKzdsUkhPRCtGSStFNTdoYTZTdVFa?=
 =?utf-8?B?eDFjSnF6Ry93R1ZRcUpyUzVYMUhUdFVFQTk0RHdGTWFyS0swMnlxMmZuRUM4?=
 =?utf-8?B?NHVmRTluSHgvZk84SXE2dWk2Q0h5QTlxcTlHeDhGQmpwMFEzV25iOTA0UHlr?=
 =?utf-8?B?elgxWVpJanhPRG9SR1RxNGxwOHl4SHFqRW9MZlM3R3ZaY211Z1RzTCswVzhU?=
 =?utf-8?B?N3ZHZUhteGxlWnFrejk1dXRFL3YyNXk1eGFtZmtlR1l0cFFkZjVCUmdPZEN1?=
 =?utf-8?B?Y3pPUnZtOVltYTN3MnBYa0JsNnhGbHcrWXpIb1Z1Y0hwOWhsMWtwRUpwbGRC?=
 =?utf-8?B?bXJqMlI5TlA5TjhTQzVNOTRMUDUvQVdHbFM1RmpTWTVVcDg5bGFmZ2NHbDFF?=
 =?utf-8?B?OGNudFZQNS9LSFFNNGtKd1RRdDRxVFBDZ1hyNk4yNG1uUk1wazdqYWpUbE8v?=
 =?utf-8?B?L21YZDFEeUE2MHp1Q1ZXaVk3ZFk2Mks4TzZuZWNFQVUyUGtuQWJBTHZadXZn?=
 =?utf-8?B?ckFNcmc3Y3BENWVUL0Z1ZFk0MUduSCtCWWhHTjZQcGl1bXZYaE1SbmRrUUFI?=
 =?utf-8?B?ZU53SHRZT2FlcHJ4YUgraWVZbWpCK2w4cldPYlRQVURNRmlnM2F6V2JnSUY0?=
 =?utf-8?B?eGxSZHFLdzVvRVFLLzk5dkk4RmJzdUFjelBwcit2VzU0bWR3NkxJbzF1T2hE?=
 =?utf-8?B?QTBzNWdzUkc3VnpBRDFHb1lOeTZKNFpiR2IrbFg3MFJGTy9ZbHk3MDBlaXRD?=
 =?utf-8?B?S0xPUWtZMnJzT012R3dQbm9FTTh0QzlacDQ1Vm9XOE4wQW92dFFCM1NTTzNC?=
 =?utf-8?B?Q1FqczJOem5UQWhpb0gwazlmNVNlek5WSU1qZHhuRUZVOXNVejFYVis1Tmx1?=
 =?utf-8?B?aUQzZ3VGZzhvc2ZiZEpVb0pOeVdnUmttS05rc3BoT0NPYU81NDY4NjJ0S2ha?=
 =?utf-8?B?aVlkM1pSMkZzaSs2bDk2ODNGL241b3BVcnhpL3NBbXFRQnlmYis1UkV6UE9i?=
 =?utf-8?B?QkZRd0R5YUlCMm5RRUJ3VDE2NnB0NHkrUFF0QlRXUU1pdUdvMTlNNjJLcVpI?=
 =?utf-8?B?ZlY2UnBJQmNrQ2VvanNqYncyT29JSlFFMDJZQTFxbEx2U3dLb2t0V2Q4cnBD?=
 =?utf-8?B?U1J5WlIyWE9qQ2l2Vk1XWGYrenZFZmowNlFremZwdC92a2pKcXZ6NmtBRXpU?=
 =?utf-8?B?K01MWXdaL0hXOXVxZVNCNm11ZHZic1VTbitLdldoaS9ZdUdVODF0VmdNeEM5?=
 =?utf-8?B?SXRia0JSZXpwaXkxQzBIMzlLMXJyYk5pdEFIZi9UdTgrUms2RTV0ZDlIajU4?=
 =?utf-8?B?ZzZpL05aYjZ3VEhQcnVHVVIwL3pMdjlzS0pUZDc1YUFpN1lYRHF5SHlTYkU1?=
 =?utf-8?B?ZHBaU0xsZzlsZkU1dnBmWjFPMm1sdDJGSUJPUE52VHM0SFltT3pyc3BuU3lK?=
 =?utf-8?B?U1lUUUJTejFuaUpkdXU4WnZVRGpnQ0xrMVF3UHNESVliWHpQTm0wTGxrZW11?=
 =?utf-8?Q?kgj8aCfjGUkYAvZyXp7WgnDDM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <700A3BFA4080B74DBAEF722087214939@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd661ffb-7da3-4327-ec9d-08dc140a39d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 07:35:33.1612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: px4thyTiL4cjDID8Yy+Qzx4iEsb7WC5MyQXiicD3VnTEafNHm+PV8Cbi7edmAK2aOfmtm9+GxDurfETdC2Uqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTEyIGF0IDE2OjM5ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIEZyaSwgSmFuIDEyIDIwMjQgYXQgMDk6MTQsIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4g
T24gV2VkLCAyMDI0LTAxLTEwIGF0IDE2OjE0ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEphbiAxMCAyMDI0IGF0IDE1OjE5LCBUaG9tYXMgR2xlaXhuZXIgd3Jv
dGU6DQo+ID4gPiA+ID4gVGhpcyBpcyB0aGUgb3JkZXIgaW4gTUFEVCwNCj4gPiA+ID4gPiAkIGNh
dCBhcGljLmRzbMKgIHwgZ3JlcCB4MkFwaWMNCj4gPiA+ID4gPiBbMDMwaCAwMDQ4wqDCoCA0XcKg
wqDCoMKgwqDCoMKgwqDCoCBQcm9jZXNzb3IgeDJBcGljIElEIDogMDAwMDAwMTANCj4gPiA+ID4g
PiBbMDQwaCAwMDY0wqDCoCA0XcKgwqDCoMKgwqDCoMKgwqDCoCBQcm9jZXNzb3IgeDJBcGljIElE
IDogMDAwMDAwMTENCj4gPiA+IC4uLg0KPiA+ID4gPiA+IGFuZCB0aGlzIGlzIHRoZSBvcmRlciBp
biBMaW51eCAoZnJvbSBDUFUwIHRvIENQVU4pDQo+ID4gPiA+ID4gwqDCoMKgwqDCoCB4MkFQSUMg
SUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDIwICgzMikNCj4gPiA+ID4gPiDCoMKgwqDCoMKg
IHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MTAgKDE2KQ0KPiA+ID4gPiANCj4g
PiA+ID4gV2hhdCBhIG1lc3MuLi4NCj4gPiA+IA0KPiA+ID4gQW5kIGNsZWFybHkgbm90IGFjY29y
ZGluZyB0byB0aGUgc3BlYw0KPiA+ID4gDQo+ID4gPiDCoCAiVGhlIHNlY29uZCBpcyB0aGF0IHBs
YXRmb3JtIGZpcm13YXJlIHNob3VsZCBsaXN0IHRoZSBib290DQo+ID4gPiBwcm9jZXNzb3INCj4g
PiA+IMKgwqAgYXMgdGhlIGZpcnN0IHByb2Nlc3NvciBlbnRyeSBpbiB0aGUgTUFEVC4iDQo+ID4g
PiANCj4gPiA+IE9oIHdlbGwuIFRoZXJlIGFyZSByZWFzb25zIHdoeSB0aGlzIGlzIHdyaXR0ZW4g
dGhlIHdheSBpdCBpcy4NCj4gPiANCj4gPiBUaGlzIGlzIGluZGVlZCBhIHZpb2xhdGlvbiBvZiB0
aGUgQUNQSSBzcGVjIGFuZCB3ZSBzaG91bGQgbW9kaWZ5DQo+ID4gdGhlDQo+ID4gb3JkZXIgaW4g
TUFEVC4gQnV0IHRoaXMgZG9lc24ndCBicmluZyBhbnkgYWN0dWFsIGVmZmVjdCBhcyBMaW51eA0K
PiA+IGFscmVhZHkgaGFuZGxlcyB0aGlzLCByaWdodD8NCj4gDQo+IEl0IGJyaW5ncyB0aGUgZWZm
ZWN0IHRoYXQgd2UgY2FuIGRldGVjdCB3aGVuIHdlIGFyZSBub3QgYm9vdGluZw0KPiAoa2V4ZWMN
Cj4gY2FzZSkgb24gdGhlIGFjdHVhbCBib290IENQVSBiZWNhdXNlIHRoZW4gdGhlIGZpcnN0IGVu
dW1lcmF0ZWQgQVBJQw0KPiBJRA0KPiBpcyBub3QgdGhlIHNhbWUgYXMgdGhlIGJvb3QgQ1BVIEFQ
SUMgSUQuIE5vPw0KDQpSaWdodC4NCkkgd2FzIHRoaW5raW5nIGluIHRoZSB3YXkgdGhpcyBwYXRj
aCBzZXJpZXMgZG9lcywgd2hpY2gganVzdCBjb21wYXJlcw0KdGhlIGJvb3QgQ1BVIEFQSUMgSUQg
YW5kIHRoZSBsb3dlc3QgbnVtYmVyZWQgQVBJQyBJRC4NCg0KPiANCj4gPiBGb3IgdGhlIEJTUCBB
UElDIElEIDB4MjAsIEkgZGlkbid0IGZpbmQgb3V0IGEgc3BlY2lmaWMgcmVhc29uIHdoeQ0KPiA+
IHdlDQo+ID4gaGF2ZSB0byBkbyBpdCBpbiB0aGF0IHdheSwgYnV0IGl0IGlzIHN0aWxsIGxlZ2Fs
Lg0KPiANCj4gTGludXggZG9lcyBub3QgcmVhbGx5IGNhcmUgaW4gd2hpY2ggb3JkZXIgdGhlIEFQ
SUNzIGFyZSBlbnVtZXJhdGVkLg0KPiANCj4gPiBXZSBtYXkgbmVlZCB0byBmaWd1cmUgb3V0IGFu
b3RoZXIgd2F5IHRvIGRpc3Rpbmd1aXNoIHRoZSBrZHVtcA0KPiA+IGtlcm5lbC4NCj4gDQo+IEhh
dmluZyB0aGUgZmlyc3QgZW51bWVyYXRlZCBBUElDIGluIHRoZSBNQURUIGFzIHRoZSBhY3R1YWwg
Ym9vdCBDUFUNCj4gaXMgYQ0KPiBzZW5zaWJsZSBhbmQgZnVuY3Rpb25hbCB3YXkuIEV2ZXJ5dGhp
bmcgZWxzZSBpbmNsdWRpbmcgdGhlIHNpbGx5DQo+IGtleGVjDQo+IGJvb3QgcGFyYW1ldGVyIGlz
IGVycm9yIHByb25lLg0KPiANCj4gSSBhZ3JlZSB0aGF0IE1BRFQgaXMgZXJyb3IgcHJvbmUgdG9v
IGdpdmVuIHRoZSBmYWN0IHRoYXQgbm90IGV2ZW4NCj4gSW50ZWwNCj4gY2FuIGdldCBpdCByaWdo
dC4uLi4NCg0KRm9yIHRoaXMgTVRMLCBJIGNhbiByYWlzZSBhbiBpbnRlcm5hbCB0aWNrZXQgdG8g
Z2V0IGl0IHJpZ2h0Lg0KDQpBcmUgdGhlcmUgcXVpdGUgc29tZSBwbGF0Zm9ybXMgd2l0aCBCU1Ag
bm90IGxpc3RlZCBhcyB0aGUgZmlyc3QgZW50cnkNCmluIE1BRFQ/DQppZiBzbywgd2Ugc3RpbGwg
aGF2ZSB0byBsaXZlIHdpdGggdGhlIGtleGVjIGJvb3QgcGFyYW1ldGVyPyA6KQ0KDQp0aGFua3Ms
DQpydWkNCg==

