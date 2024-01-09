Return-Path: <linux-kernel+bounces-20267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25564827CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF8D1C23238
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9014430;
	Tue,  9 Jan 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKmWPORq"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655C33D3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704765267; x=1736301267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CdHqfDxcPFIeOtTUu9eEalHjqGfDLamEQKSW2vyjcLI=;
  b=iKmWPORqMmbpiKvZZEfhX55Hot3jAGILyZDg8+nUJoaSFMu+mylJe9ik
   Qv0f+MnNYTbPRdoxrNsld29rhORQ/a/wW97DcFpogUQw/t6HUDJ76s8Ne
   uwV1HbY1x8kc/EIjSun0+cLWSmMZu2vwM33OfmPDuatspX/eZ64Jzbvvg
   klqHV/s8qlDvgWGT4riXTSEc2urfPn44meBjzUozDI5NeMBuJfpbIVSC7
   2BS4TxKaZ8vMjF2k4quauB9e3gdW3nmfbqgeHMdfIJqJgL13/4K0jekV+
   W2u+YrpZKVj5LmU9cTCaALEYsMKTMdsgoMXhaj5mGpvMmZZfzDJvJVY/i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397762489"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="397762489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="851998110"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="851998110"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 17:54:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:54:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:54:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 17:54:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 17:54:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt1nnHdWm9njn6siDUQ+H18wr0Y108jPxDj5v5LrieRuC+I15gQTETHJyrPkedlR46mJU7SSfa2Hd/uBfCFhw1yh7A79vjCkIPDHU4yYYDTCN+Nvn+wzPtgDLuIg16x2gx32SS1Vw9UyMT7MvYUBx4OXYOu78Ns/RaKkKy8kn00r/Mvfu34+evpTt4mJDUrG2dp8nFlqzEeVjdw6AOQ4cwqgM1lv5YS36DSuAh2PhzOVQTbXCo5f1FLUhPQlOdVUDsUhXBfUKQgcMFJTDq0lDHglRzSA8dM/ufrjThILBxkjIoEyRgk/HbCRJNQuZNxIrPfsIz+KylMGUffFoRilug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdHqfDxcPFIeOtTUu9eEalHjqGfDLamEQKSW2vyjcLI=;
 b=l1Xrq8QbN26OqEqLEhg5PKLtwFaME848KFOXu2xSgaefkoI8xMhtmnfa0JR4SrFB2LtxEcCT5gPH78PdYISDwAz0Xvuvj9YOnMpZlx1d6JT4nzGgIoWfdywrZv/pW87lYAKjapE+iyLS49W7roZKi56/cFa8izajNxbw22uORY+mcyBs5KkZgGEvE660ZbW65iu0fPVuYA29BgDw4TXKecdZEDhDb2wLSs9cVRWZEH228MErmIw4bCIlHIDzAtcf1Y/WKvdfZEkrCmOhrdy5PSNq1fKzq58pDdJv4jumao8IbgApQVj/89cGaPvoYTEeEA9jTEDipJXegdSfqdZUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 01:54:17 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:54:17 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHaQjyCF3Nt+9p0tkSkWmDSuvApOLDQAJIAgAAWM4CAAKJBgA==
Date: Tue, 9 Jan 2024 01:54:17 +0000
Message-ID: <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
	 <20230807135028.381851690@linutronix.de>
	 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
	 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
In-Reply-To: <87y1czkdlg.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB7672:EE_
x-ms-office365-filtering-correlation-id: 70ab59dc-b81c-4051-45e0-08dc10b5e3a4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJKI0dZeCk2IDpllEHvSj/OeBXTbDnDEfSxgCOLa9Owiq7Pg7U8t8Ongd6LHe5r0Xad0Prii3EuucQYhFuYcIIRP+c3Y/cFT3hN8r5QOXIu/cmoBqg/gX6BMIGgMssQDEVdsCfAcEwjOv898SlgbuPQaTBcUnNn6HS9Q8ZvJ3iRGcW91K1ck7Y/vBMVrIL2l917K6AvihIO/GB0kn4t5dfEw+Y98R5M1zpcQz+21kqmveK0I5vySbGSEb24pcBqLdw36boCMcTsWeQqVdHyi1R2epa2QJ2U1ivgtDyD7xB6/S2Z45hcqrEHdJfrytjEtlYKzQ7rmtXB0vzc0zjfTNPkDENVB8NWPp3xoyxg7oHRW9egKSdq7YCR58yZrRSIrpTw9g0yQVo4c779/YwaFU2vyeB4rlz3HxcdW1R9meqO0zYITNAXOW22CLoV9w72lWfJAi8XpWEV2mJufnR/5lKGN86nf/qJqZRucitnVedEiUaxRqNX2Uq4e1DO5rQ9Pohqq7Csd2Nz45VPVw585nlrOlVmYflIMvc69SZq+dEICkGF3ijueqqFqdkRLvYAsDaeZuY4TjXzrSuD+806ImXMpnBCIpVcmAPrSNA38IY5Sxq2fggqHsND0cjW8/s8t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(71200400001)(26005)(83380400001)(36756003)(86362001)(38070700009)(122000001)(7416002)(38100700002)(82960400001)(5660300002)(4326008)(6506007)(6512007)(66556008)(66476007)(76116006)(66446008)(54906003)(110136005)(316002)(66946007)(8936002)(8676002)(91956017)(2906002)(41300700001)(478600001)(2616005)(6486002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlpJOHJCdGNodVB2UDVVTzJFTnZtWHY5cGNqZjl4L3ZjT1dWR0ZWSytONW1m?=
 =?utf-8?B?enVRY2ExNVlkTWVreXkzR1c1MDg2YUVGckVDNTRkc3ZUT3ZwMWtHaFlyK0p2?=
 =?utf-8?B?ckpRYU9xcUhxcmJZTUZma1pmUm1UbWNFbDkvamRWeC9rYWJWeGFSTG1vOWlz?=
 =?utf-8?B?bThiM2ZKMTk1dVhKRVZyN21uOVNoNlROYlBJZVNKbUNHaWNNamNraDlhVEd3?=
 =?utf-8?B?MVZNenp5YzUxUW9Bb2w3NEQ5SFErLzMxSm9IVzdISFAxdWRjVUNNU1A3bXdO?=
 =?utf-8?B?NXV3TWNFN3UyYW5RUXJGZSt2d1pQN3F3OEM3dWRTZ0Q0WTVmZnRHYmNlNjNN?=
 =?utf-8?B?SmlGVHU5eDFHNXVQRjdzYkFpSHlsUlRseFlubHBIa1FtSkMwQzJkckQ1Tnht?=
 =?utf-8?B?WGVWdEh1SFVGKzhESlNzMXdaeGs2bUtRRUxkalVYSFdidGNTazhPOFBIbXBq?=
 =?utf-8?B?cmhZcUk0SmRNS2gvempHSWsvaHBwenJ0OVgyQnJkMis0djJKWnRic2Q5SDlj?=
 =?utf-8?B?ZjlCVWQ2THJlTEhReSsvQzAxVWk0SVVXOUY2c216d2hGS21mM0ZsOUh6SjRu?=
 =?utf-8?B?R3EvSE00dWtrZ3U3bUErcUZBYnRkNmhNdDlLK0wvYnV3YllUeGViV241WmVH?=
 =?utf-8?B?NGJLanp2MkhsZTFGSkdjRlVBOTNvUTlMNHNxUHRmajl4TEthMmI1dUlMS1l6?=
 =?utf-8?B?bFVFTnRPVit6RHVZeG0wUUo3dkQrRVB3M2w1azBOTjRXVHo5NWdQMmNYeVBx?=
 =?utf-8?B?d0VHRjhYRDZ4VFRSaXJjMUZjczY4dEJyazVwTVZXeTBQcGl0UDRpYXo3OXBE?=
 =?utf-8?B?bEsxK3RBS0RnSjZZY2FSSnpnRTNHMVAyVmlaVjVEK3duKzI1RmJDOXp5bFB1?=
 =?utf-8?B?bG4wclAwMkJFOWdWV3FsdWI2MEcyMmQ1dEtpQ0oyWm51R0wvaktGOXAxT09o?=
 =?utf-8?B?ZWxjc0MwUTI2V1V6NmZFOVMxSjJ4NnhaSElOV1BQWEt1YWpqaXdnd0VmTU5n?=
 =?utf-8?B?YytrNTEzT01yVVFMTnVBem4wNUxaeHVSTmltWWk5OEJrdHVMNDYwRmRNQ2RH?=
 =?utf-8?B?T2Y5T1N1MGRMVW1GZ2JpZ3l5T3hnMXJKZ1AxSXVGeHFyRTZ0VFhhY2llUTU2?=
 =?utf-8?B?RFZPVk5JeWIxZVhtMXZLWFAvRXBKTDVRaHNEK2xjK3I2MHoyRHpmMTZNVEF2?=
 =?utf-8?B?VnVKc3VJanBLRmhrcEM2MnA2R0xsbGp5TDlDMUR2Nlk4dnkwSUNYRWt3THY5?=
 =?utf-8?B?RlNMNXZDbWdUa25palN2NWJvUTNGRGY1cjNWNXczNFFGV1h2TDByaTNpQmdT?=
 =?utf-8?B?RGVXaVROc2dYN25uUFJTR2pYMkhPbW9lbWg2M2o5SDh1cXEvL0RiclFxUkdJ?=
 =?utf-8?B?Snh3RlYwcW9HNU1xRjJpREl4Y2hzcStzSm9tTUpZb1BQa1hiMmpzeVgvTU0r?=
 =?utf-8?B?Wi9WOCt0blhMa0h0dlhmckR2aDVwWnJqWEtLN0ZXOFVVSUxxbWluSWExdXdv?=
 =?utf-8?B?VXVzaGUxTkhjZU4zMzlLS3JtbHhvSFhYak9nTkRrSUlCMmNOYlFJb0dRaStD?=
 =?utf-8?B?MEJlcUVXQVoyRVhscUZISW5sTWJ3TEZrVDZBYjVrOWNTeFplZVg2TFB6eGVy?=
 =?utf-8?B?YksyZEZLNjJzbHBSYUEwSStVRStLOEVBWmdpakFxUnBTcmRCMXB0cVpWa2FP?=
 =?utf-8?B?NlRMYmxOc0NSS0NBOTdwcXVCUEJocDlqNk9PZ2NGN0N0dERYWFZ4RnQwZDlM?=
 =?utf-8?B?YUMzelorQ3BWc09yRlNFaFpTKzhKS1lmRmV2dHNBTWRRWTdoTGRGNXdvU250?=
 =?utf-8?B?RUU2UXNSdXVmYllzTnVTNWVyT2JjWE5TbUZ0SFhlcklWWk5KNFIzTUg3SG1Z?=
 =?utf-8?B?MXhWeTduQ0lZUkg0M0dsVVpzOWVWdjgxeHRHVGJsbE5ZeXNzdDlrekI1VXQ1?=
 =?utf-8?B?a3pWVW9yNUJzTlRHQ3pldFMzTlBKZHFVYTNNZW5vdENHTHJRbTV0ejRvWlB3?=
 =?utf-8?B?OWtDWTR5K011WlZmYjl4cVBDb3h3L1VoQ2lDeEhzVlovd0tmMElzOWpVZ0o1?=
 =?utf-8?B?Mk1VZ2FIWVAyY0NLYTUwQ3ZUblFJbzFnOC85Ti9BemJya0Nna3lqS240ZzA5?=
 =?utf-8?B?SloweWdiMGtMc2tlMnJldDgxZnpiTmVSdFpnWkZaelY2S2NHTGxIVVFSNVdR?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED6D6D99ECF5C34F8E7A54E030D4FF0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ab59dc-b81c-4051-45e0-08dc10b5e3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 01:54:17.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 250gl/7m+JvTum/SkayVwIsKh6W071Y9hA9xAewnSF58TvDvgzh0K4DaNjRm0NGXJFOAFLcsH6IF53ZaxljUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAxLTA4IGF0IDE3OjEzICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIE1vbiwgSmFuIDA4IDIwMjQgYXQgMTU6NTQsIFRob21hcyBHbGVpeG5lciB3cm90ZToN
Cj4gDQo+ID4gT24gTW9uLCBKYW4gMDggMjAyNCBhdCAxNDoxMSwgWmhhbmcsIFJ1aSB3cm90ZToN
Cj4gPiA+ID4gK3N0YXRpYyBfX2luaXQgdm9pZCBjaGVja19mb3Jfa2R1bXBfa2VybmVsKHZvaWQp
DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoHUzMiBic3BfYXBpY2lkOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oCAqIFRoZXJlIGlzIG5vIHJlYWwgZ29vZCB3YXkgdG8gZGV0ZWN0IHdoZXRoZXIgdGhpcyBhDQo+
ID4gPiA+IGtkdW1wKCkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgICoga2VybmVsLCBidXQgZXhj
ZXB0IG9uIHRoZSBWb3lhZ2VyIFNNUCBtb25zdHJvc2l0eQ0KPiA+ID4gPiB3aGljaCBpcw0KPiA+
ID4gPiBub3QNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogbG9uZ2VyIHN1cHBvcnRlZCwgdGhl
IHJlYWwgQlNQIGhhcyBhbHdheXMgdGhlIGxvd2VzdA0KPiA+ID4gPiBudW1iZXJlZA0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqAgKiBBUElDIElELiBJZiBhIGNyYXNoIGhhcHBlbmVkIG9uIGFuIEFQ
LCB3aGljaCB0aGVuDQo+ID4gPiA+IGVuZHMgdXANCj4gPiA+ID4gYXMNCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgICogYm9vdCBDUFUgaW4gdGhlIGtkdW1wKCkga2VybmVsLCB0aGVuIHNlbmRpbmcg
SU5JVCB0bw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcmVhbA0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqAgKiBCU1Agd291bGQgcmVzZXQgdGhlIHdob2xlIHN5c3RlbS4NCj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgICovDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSGksIFRob21hcywNCj4gPiA+IA0KPiA+
ID4gVW5mb3J0dW5hdGVseSB0aGlzIGNhdXNlcyBhIHJlZ3Jlc3Npb24gb24gSW50ZWwgTWV0ZW9y
bGFrZQ0KPiA+ID4gcGxhdGZvcm0sDQo+ID4gPiB3aGVyZSB0aGUgQlNQIEFQSUMgSUQgaXMgTk9U
IHRoZSBsb3dlc3QgbnVtYmVyZWQgQVBJQyBJRA0KPiA+ID4gKGluc3RlYWQsDQo+ID4gPiBDUFUx
MiwgdGhlIGZpcnN0IEVjb3JlIENQVSwgaGFzIEFQSUMgSUQgMCkuDQo+ID4gDQo+ID4gQmFoLiBM
ZXQgbWUgdGhpbmsgYWJvdXQgdGhhdC4NCj4gDQo+IEluIHdoaWNoIG9yZGVyIGFyZSB0aGUgQVBJ
Q3MvQ1BVcyBlbnVtZXJhdGVkIGJ5IEFDUEk/DQoNCg0KVGhpcyBpcyB0aGUgb3JkZXIgaW4gTUFE
VCwNCiQgY2F0IGFwaWMuZHNsICB8IGdyZXAgeDJBcGljDQpbMDMwaCAwMDQ4ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDEwDQpbMDQwaCAwMDY0ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDExDQpbMDUwaCAwMDgwICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDE4DQpbMDYwaCAwMDk2ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDE5DQpbMDcwaCAwMTEyICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDIwDQpbMDgwaCAwMTI4ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDIxDQpbMDkwaCAwMTQ0ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDI4DQpbMEEwaCAwMTYwICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDI5DQpbMEIwaCAwMTc2ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDMwDQpbMEMwaCAwMTkyICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDMxDQpbMEQwaCAwMjA4ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDM4DQpbMEUwaCAwMjI0ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDM5DQpbMEYwaCAwMjQwICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDAwDQpbMTAwaCAwMjU2ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDAyDQpbMTEwaCAwMjcyICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDA0DQpbMTIwaCAwMjg4ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDA2DQpbMTMwaCAwMzA0ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDA4DQpbMTQwaCAwMzIwICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDBBDQpbMTUwaCAwMzM2ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDBDDQpbMTYwaCAwMzUyICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDBFDQpbMTcwaCAwMzY4ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDQwDQpbMTgwaCAwMzg0ICAgNF0gICAgICAg
ICAgUHJvY2Vzc29yIHgyQXBpYyBJRCA6IDAwMDAwMDQyDQoNCmFuZCB0aGlzIGlzIHRoZSBvcmRl
ciBpbiBMaW51eCAoZnJvbSBDUFUwIHRvIENQVU4pDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNh
bCBwcm9jZXNzb3IgPSAweDIwICgzMikNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nl
c3NvciA9IDB4MTAgKDE2KQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0g
MHgxMSAoMTcpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDE4ICgy
NCkNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MTkgKDI1KQ0KICAg
ICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHgyMSAoMzMpDQogICAgICB4MkFQ
SUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDI4ICg0MCkNCiAgICAgIHgyQVBJQyBJRCBv
ZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4MjkgKDQxKQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2lj
YWwgcHJvY2Vzc29yID0gMHgzMCAoNDgpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9j
ZXNzb3IgPSAweDMxICg0OSkNCiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9
IDB4MzggKDU2KQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHgzOSAo
NTcpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDAgKDApDQogICAg
ICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDIgKDIpDQogICAgICB4MkFQSUMg
SUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDQgKDQpDQogICAgICB4MkFQSUMgSUQgb2YgbG9n
aWNhbCBwcm9jZXNzb3IgPSAweDYgKDYpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9j
ZXNzb3IgPSAweDggKDgpDQogICAgICB4MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAw
eGEgKDEwKQ0KICAgICAgeDJBUElDIElEIG9mIGxvZ2ljYWwgcHJvY2Vzc29yID0gMHhjICgxMikN
CiAgICAgIHgyQVBJQyBJRCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4ZSAoMTQpDQogICAgICB4
MkFQSUMgSUQgb2YgbG9naWNhbCBwcm9jZXNzb3IgPSAweDQwICg2NCkNCiAgICAgIHgyQVBJQyBJ
RCBvZiBsb2dpY2FsIHByb2Nlc3NvciA9IDB4NDIgKDY2KQ0KDQp0aGFua3MsDQpydWkNCg==

