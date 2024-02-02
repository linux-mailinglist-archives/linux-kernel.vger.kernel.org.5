Return-Path: <linux-kernel+bounces-49391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024248469DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B971C25394
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B5E57C;
	Fri,  2 Feb 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUW0vdwe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388917BBE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860579; cv=fail; b=qY+WdXrqA4TSh9l1/6JFMXHCN/GyGhUhrPxFqgHIXjOy9szPk9CRXc4Do7sdt5h54OqxpWLI0CwQzD6N9lwLfJH7O31v9cyNYdW4kZwgDRJRQmMOSaTTOeqlUfg8qUuv0jdmlTRYQuwTMHkavyA7+Rgy1/p5YVrJr61JRwSs0EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860579; c=relaxed/simple;
	bh=jn4uRb6tXOU41a5gAuT1+4+vk7Jkk3U8Q3fMMm3z4T8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ys+UBetefcD3AcJlR/XxWFsU4+J1STR9Uhpo9uBKd2yPG4Xg2k0j3e4ydlaWCUIgog0Iktylnv9nI6iTaPmS/r04s8ndWP+tA3K0nLUbDDQCnaCIZR4wC6+JRkCxdl6p9SP/U9FtuzmGyK5dUu2kwgcO53lLD0qZrEDfkJpYSGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUW0vdwe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706860578; x=1738396578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jn4uRb6tXOU41a5gAuT1+4+vk7Jkk3U8Q3fMMm3z4T8=;
  b=eUW0vdweL//yqMyCPzsS6N3VbZpypT3CSZlZl0bM/biHKoK7lGepxlcF
   JPUvvGKPRXaOI5R0aZy+SZMkXOKD2mp7ZGtw26Wd69U99IdCcvapsncke
   W0dQQdZEzPAV5m3iTVzamHyyYT5t3VapllnqNL7GbmhY/I806j9828FZi
   qDHT/mU73N5Wam95xPxkkLZefHL8z9PjZD4HI1qIffajQlKMa+ATE6Hlp
   7VH1exnO65Qscx1OOvN+mHrrkI9Py0+NFhGwcHz49WjIM1eKdwndQ/v0h
   +83VMqim1/fi02+1HHqqe5h8I4byv73+cNB/QAvKWVi5vwy8D5zXNtRSw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10718299"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10718299"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 23:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="72878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 23:56:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:56:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:56:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 23:56:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 23:56:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdLJaTHhtEI1nu1njeF2+sG2jFRlTU4gwLpSdTWE8/xSJrsTPUxcM5PVC+7rSMdPYXIADxPFVBj+GdXfhoqidUIy0I4ejEIs8H88rovd0E5taUZNKswfV/bIGzYKLwXl8qpfWAenseBv8hS9+6GIbOoxyXSDoiBtNDNDg7pR3hskygqMdBUKiTW+Wu2tcnP9+cCb6aka+rg1EpvlRSLfa3AtnRdSj2ZACVnWKhZsYrNL4NNoVT67FflSq2Y+2N9b1EeyOYOYr8pVvon2gS7+aSlxVNpyd3mRSf1cEjfEAhgGKnpIRAwZ4x8f1kFg4TEfaAvyVitF/TURof1nl+xWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn4uRb6tXOU41a5gAuT1+4+vk7Jkk3U8Q3fMMm3z4T8=;
 b=hp4u/wYZaiLfaO2ouZ9LrAmiGfjcmi4JS4KGjeRKDiidqMYQ0hix8fap4CEIvvMBO3eglllpH0GaT29Cw9hnCzXk1V6FdImFLylyrjcIHGxeVeN/IgeVLA7cjsYtNnSQsqEKkn3NeB5p6YN/KyA0dUaMkejGTv/2wb9hldVAho8nsF68zqXffN/wPN85dJRSl0DqLWIZgHRfeD0tLwngzdXO63Yz8VJbNtDNzr+G1k8mWIBQcQFvk2TQWRJgoG+FDWr8kj8UdVmKo8SMVSppqVEn0Okmyno1v1wvqm5mnQDB2EJUSYc2HSF0odEeYYzQPBTiW9WAkxJS8hOQqb95xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 07:56:07 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:56:07 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Dr. Greg" <greg@enjellic.com>, "Daniel P. Berrang??"
	<berrange@redhat.com>
CC: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Thread-Topic: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED
 fails
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVCAAEjrgIAABNyAgAAErYCAAOk00IAAVWCAgAB9iQCAAIl7gIAAVdmAgAAUe4CAAKaGAIAAsrXQ
Date: Fri, 2 Feb 2024 07:56:07 +0000
Message-ID: <DM8PR11MB57504206F76D02D5F5D04797E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
 <20240131203531.GA12035@wind.enjellic.com> <20240201044735.GC2356784@mit.edu>
 <20240201095451.GA17612@wind.enjellic.com> <Zbt7mXg9p6IOdcqp@redhat.com>
 <20240201210410.GA24013@wind.enjellic.com>
In-Reply-To: <20240201210410.GA24013@wind.enjellic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA0PR11MB7403:EE_
x-ms-office365-filtering-correlation-id: fe0d9fcf-c181-4b14-9291-08dc23c469c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1T0btgiRpEn7isRDVA8BulhExMt/cszR6Ir1uFc2mKFxZppS5R3YFFO34ktalLihS0PwS3xcShfXWPx1yARTmp2UbzydsffdhwwX6Ud6YXnvSjKVHW3b+rbyNJ0Uf4H/ZPvFXrA6LknGVSw+wuD+QxjJXmDBTdwVEb5a6aCJigsvlSO1yvFXMciy3JbagsBt7p2bs4adyOEIRjtHWr9QKH6UD1lqHj24Os3EbL6m1m7qlfeRaNwonX4LX7fcEOQHDtOB430oe9NtcmRLYpxWelr0XzFCuW5ZlhHlk/xYpYa8qIVRtRybcNYFBCadPN6tYkgCNWr3lDeSvJJdYNoz8971iI327hlWCYbgT2mJpMPZL4eivwGXzaZHLd+wNTBvRPvB7Pbe/BfAnJ9wZna/7VVtDBBV2lFCO+RSYS9uwFV6hTMRODNqVR/NlbsCmWsxyhHulWzStWW0oStDUaCadgU8Henj42tYcBn6B5S20V5TDqKqjV3WNxJygQ+nrb+DgoptX+p9gnVskMK6IineLA+mrO+IsKZYjE6BGZMwf3y0bUNZZ8NfODFNsfX/rA6qdYvp/FtIEX00RC+hAl8QBRRjKFOu/SebFA8bm5TdnCYP9nUkC9v7XGduMiIo3R0ifViyU+J0E2Z+9DRmPf5Wexv/bXgrrZsmAqUSNecBQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230373577357003)(230473577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(83380400001)(82960400001)(33656002)(86362001)(38070700009)(8676002)(5660300002)(122000001)(9686003)(41300700001)(38100700002)(26005)(966005)(66946007)(6506007)(2906002)(316002)(54906003)(7696005)(76116006)(66476007)(66556008)(7416002)(64756008)(478600001)(110136005)(4326008)(8936002)(66446008)(52536014)(71200400001)(569784001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0MyZXhXaTlnVVJ4NDVZS3dzUWVQcDdiaVJxWmhhUmhIVGw4bkNMNWgrSU5U?=
 =?utf-8?B?VmhUN2NkN2M5S1Z6WkszWStzVzdqdE45SmxWcFdMeVdUQ3loVE42b1Q3YkU1?=
 =?utf-8?B?U2JIM2ZhaC8yMjcwYmFUL1h6a3pkK2RlalplWWZuQUpJN2t4K01vb0Y1ODU3?=
 =?utf-8?B?dHN6MFdLRTBuWVJmVnh3QW1hdEZObzlFSXlSV3M4QXJOdXlPaWtuajBodm9p?=
 =?utf-8?B?clFsT3VINFEya0FKSEEvTEgvZkQyVzNnQ0ZWeGpFcGNOY0dUbUZ5V3ZkdlFs?=
 =?utf-8?B?UEhjamh3L09hblZpNFJCT0wrWURSWnltZDg3L2hDOUpiRHBOa0FkWkVNTWpS?=
 =?utf-8?B?WkhKeDBTZ1k4b0UvamZhQW9BRlRkdU9QeStMT0FLbFpvZG1DeTNVU2dMNm80?=
 =?utf-8?B?cmluVWl1RVRZL29ENkNGSVlhbGp0NzdPbm4wZ2hIUktVTE1QRUtPVzJOMXpJ?=
 =?utf-8?B?ekdjb3lHQzloMkM5eWgyeGdOclZ3TzVIOTVEL2ZJNjlFQnY0M0MvNkdtdHVZ?=
 =?utf-8?B?TjFnd2UzQnEvR1V1bXFLWFpiZzhvUFg1Mm5JSkh0NW1Yc0RyRGk3U3FYZHZI?=
 =?utf-8?B?d0Zpemhoc25YY3BnRjNreWhDQmxOS2tTeW5LOCtST1M5YjI4NWJpUWRlZUkv?=
 =?utf-8?B?NHdFcjdRdlNXUDdUTGxnNVlQb2NtUWtPN3Q5d0xHbm5jaGJrZmxna3pzOTRT?=
 =?utf-8?B?OTdkeXRIN1ZLMm5ZdFc1bXlnK3I2eGMxb2ZSN0laLzN3dlcvUEN1VkQ3QWVr?=
 =?utf-8?B?RXdPRExsbU5TcDIzSHgxMWJHRm1FbVFsT2dMbGxJMW45bytjWHB3QkRkaWdl?=
 =?utf-8?B?UWs4UDR0THl1bXg1am5uUnFFRGRDNVNiUHhLUXBQc2czWGp1ZEpXWWx6UkFq?=
 =?utf-8?B?bEpjWTJwRVUvWmduQWFmV2pvcDVoK1UwOXVBcmZWdkx5dVVNeHFYSHBkNGZl?=
 =?utf-8?B?c0drUHpROTIwRC96T1BWTHNRSkwzN0JzYkhUM0dKM1IwOUVUUUxyWDE2THVH?=
 =?utf-8?B?UmJqTVdQbVlwMkY2QnVCMFZ2MXBpQjJUSDZhdk9YaHJmL0ZCUVVkRzJRbU1y?=
 =?utf-8?B?N0duRmFyV1BxdVZmNmxsRTRhVVBBNjhiQitZd0NNbE9nRFhaSjBDc1dqRVky?=
 =?utf-8?B?OEZNaUU5YkV0SnNxMkxPeWJIMVVtWVJaQTFXMEh4Z0FCMitOTTE2Umw3WGIr?=
 =?utf-8?B?NEJ5U0R2R0R0TzFud0ZoQTUxSURGZFZtZkRwZjk3SXlZRkFFRWN5NEVuQjln?=
 =?utf-8?B?c2xsUDdtbmgrZFJCQUxUTVJQWCsvUmZ6VGlkSjQwcHQwa3NNWkFLZ0lhOGhJ?=
 =?utf-8?B?SkVpZkROM21RVUg3eG96NlJNTVpURWNPOTJyNStLaitSWjQ5Y0hVdWF3Rkdl?=
 =?utf-8?B?azFmY29KWUVTSHVwYnU2RTRlaFVGZjdwK1dnTW9pcHYxQk1ZZ1VWbXBjTlpx?=
 =?utf-8?B?Mlp4WDF5SjBucTlsMTBqSzJaYWpYNWNkL2txdU5IMy9EYWlKVVB4d0hOUERi?=
 =?utf-8?B?YVhaOTl1RnRPN3ZqRWRueTZ4WEExTDJMR2l2TXpoRlRwZXhqWnRueXdnRXJ6?=
 =?utf-8?B?VDlXUDdWd1FBSGc5S1plSDZVNkcrSHpINkx2NlpVT2U5RlFBZ1FXRUU2Kzl0?=
 =?utf-8?B?TXhvaWNtcWFoRUhjdXdXamNHSzBTeGR5ZG5KZWVldmNUcE9IdHVDSW9GS3Rs?=
 =?utf-8?B?Vno4d2tWOFFEdEUwTkUxWEdrb2tiTGc0bnhjKzlpalJWRVlocDVidkZGdGdh?=
 =?utf-8?B?bGhsQTRrbHpDdHZSamloaHhHYTFXT2JSQkkzSWlsVFZQS0hWSkhoVkh1ME1D?=
 =?utf-8?B?VkEvalZ4aG9wLzIrM2hGOUlYb1NtaWNnTHErT1dHVm44Z1Z1YzhVd1pYMmwy?=
 =?utf-8?B?Tm1uVG5rRmRzbm1MbFR1NEZHdkdJa3loSWRSbHlxdW5hUW9xaFdySmQ0cldp?=
 =?utf-8?B?cHkxWFNvSmVJaWpUTk4zNTJVanl1a3RlSmRYcHliMkdGNWV4cVJOU3FWMko1?=
 =?utf-8?B?aTd1d2dHQm4rN0pHSnZxa1ZBZ0t1Y1V2bzE0TE5BZHAxcHlHaEpkZk9HVTln?=
 =?utf-8?B?YWp4dUkrbFhiWWNENnFRdWkrZHgwaWRKMk9jYWpkaVVnZVFoUkNsNkowZkNV?=
 =?utf-8?Q?GlKO6JkSmxA0RnuEUhJR864pH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d9fcf-c181-4b14-9291-08dc23c469c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 07:56:07.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viIXuOBehD6u5nPIFLFrcgx2K2N2mSelpLO8wzL3nEeoCC6RwgEBc3XHjVshAs5airPVDtEWUYwPQzEQbnUmPxFfYXyIMPEcQ90+PQ1l3lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
X-OriginatorOrg: intel.com

PiA+ID4gVGhlIGJpZ2dlciBxdWVzdGlvbiwgd2hpY2ggSSB3aWxsIHJlc3BvbmQgdG8gRWxlbmEg
d2l0aCwgaXMgaG93IG11Y2gNCj4gPiA+IHRoaXMgaXNzdWUgY2FsbHMgdGhlIGVudGlyZSBxdWVz
dGlvbiBvZiBjb25maWRlbnRpYWwgY29tcHV0aW5nIGludG8NCj4gPiA+IHF1ZXN0aW9uLg0KPiAN
Cj4gPiBBIGRlbmlhbCBvZiBzZXJ2aWNlIChmcm9tIGEgcGFuaWMgb24gUkRSQU5EIGZhaWwpIGRv
ZXNuJ3QgdW5kZXJtaW5lDQo+ID4gY29uZmlkZW50YWwgY29tcHV0aW5nLiBHdWVzdCBkYXRhIGNv
bmZpZGVudGlhbGl0eSBpcyBtYWludGFpbmVkIGJ5DQo+ID4gcGFuaWNpbmcgb24gUkRSQU5EIGZh
aWx1cmUgYW5kIERvUyBwcm90ZWN0aW9uIGlzbid0IGEgdGhyZWF0IHRoYXQgQ0MNCj4gPiBjbGFp
bXMgdG8gYmUgYWJsZSB0byBtaXRpZ2F0ZSBpbiBnZW5lcmFsLg0KPiANCj4gWWVzLCBpZiB0aGVy
ZSBpcyBhIHByb2JsZW0gd2l0aCBSRFJBTkQgd2UgaGF2ZSBhIENvQ28gc29sdXRpb24sIGZ1bGwN
Cj4gc3RvcC4NCj4gDQo+IFRoZSBpc3N1ZSB0aGF0IEkgd2FzIHJhaXNpbmcgd2l0aCBFbGVuYSBp
cyBtb3JlIGdlbmVyaWMsIHRvIHdpdDoNCj4gDQo+IEhlciBleHByZXNzZWQgY29uY2VybiBpcyB0
aGF0IGEgY29kZSBjb25zdHJ1Y3QgbG9va2luZyBzb21ldGhpbmcgbGlrZSB0aGlzLA0KPiByZHJh
bmQoKSByZXR1cm5pbmcgMCBvbiBzdWNjZXNzOg0KPiANCj4gZm9yIChpPSAwOyBpIDwgOTsgKytp
KQ0KPiAJaWYgKCFyZHJhbmQoJnNlZWQpKQ0KPiAJCWJyZWFrOw0KPiAJc2xlZXAoc29tZSB0aW1l
KTsNCj4gfQ0KPiBpZiAoaSA9PSA5KQ0KPiAJQlVHKCJObyBlbnRyb3B5Iik7DQo+IA0KPiBkb19z
b21ldGhpbmdfd2l0aChzZWVkKTsNCj4gDQo+IENvdWxkIGJlIHN1ZmZpY2llbnRseSBtYW5pcHVs
YXRlZCBieSBhIG1hbGljaW91cyBoeXBlcnZpc29yIGluIGEgVERYDQo+IGVudmlyb25tZW50IHNv
IGFzIHRvIGNvbXByb21pc2UgaXRzIGZ1bmN0aW9uYWxpdHkuDQoNClRoaXMgaXMgbm90IHdoYXQg
SSBoYWQgaW4gbWluZC4gSG93IGRvZXMgdGhlIGFib3ZlIGNhbiBiZSBtYW5pcHVsYXRlZA0KYnkg
YSBtYWxpY2lvdXMgaHlwZXJ2aXNvcj8gSWYgdGhlIGFib3ZlIGNvbnN0cnVjdGlvbiBjYW4gYmUN
CmxvZ2ljYWxseSBtYW5pcHVsYXRlZCB3ZSBoYXZlIG90aGVyIGlzc3VlcyB0aGFuIHJkcmFuZCwg
dGhpcyBpcyBpbW8NCmFscmVhZHkgYSBjb250cm9sIGZsb3cgbWFuaXB1bGF0aW9uIGF0dGFjayB0
aGF0IHlvdSBhcmUgc3RhdGluZyBoZXJlLiANCg0KV2hhdCBhIG1hbGljaW91cyBoeXBlcnZpc29y
IGNhbiAqaW4gdGhlb3J5KiBkbyBpcyB0byBpbnNlcnQgdGhlIGV4ZWN1dGlvbg0KZGVsYXlzIGFu
ZCBtYWtlIHRoZSBhYm92ZSBsb29wIGZhaWwgZXZlbiBpZiB3ZSBhc3N1bWUgdGhhdCB0aGUgcHJv
YmFiaWxpdHkNCm9mIGZhbGxpbmcgdGhlIDEwIHJldHJ5IGxvb3AgaXMgbmVnbGlnaWJsZSBpbiBu
b3JtYWwgY2FzZXMgKGFzc3VtaW5nIHRpZ2h0bmVzcw0Kb3Igb3RoZXIgdGltaW5nIHJlcXVpcmVt
ZW50cykuIEJ1dCBhZ2FpbiwgdGhpcyBpcyB0aGVvcmV0aWNhbCBhdCB0aGlzIHBvaW50Lg0KQnV0
IGlmIHRoZSBTVyByZWZ1c2VzIHRvIHByb2NlZWQgYW5kIHBhbmljcyBpbiBzdWNoIGNhc2VzLCB3
ZSBoYXZlIGEgRG9TDQphcyB3ZSBhbHJlYWR5IGRpc2N1c3NlZC4NCg0KQmVzdCBSZWdhcmRzLA0K
RWxlbmEuDQoNCg0KPiANCj4gSWYgdGhpcyBsZXZlbCBvZiBjb250cm9sIGlzIGluZGVlZCBwb3Nz
aWJsZSwgZ2l2ZW4gdGhlIGxvbmcgaGlzdG9yeSBvZg0KPiB0aW1pbmcgYW5kIHNpZGUtY2hhbm5l
bCBhdHRhY2tzIGFnYWluc3QgY3J5cHRvZ3JhcGh5LCB0aGlzIHdvdWxkIHNlZW0NCj4gdG8gcG9z
ZSBzaWduaWZpY2FudCBxdWVzdGlvbnMgYXMgdG8gd2hldGhlciBvciBub3QgQ29DbyBjYW4gZGVs
aXZlciBvbg0KPiBpdHMgc3RhdGVkIGdvYWxzLg0KPiANCj4gPiBXaXRoIHJlZ2FyZHMsDQo+ID4g
RGFuaWVsDQo+IA0KPiBIYXZlIGEgZ29vZCBldmVuaW5nLg0KPiANCj4gQXMgYWx3YXlzLA0KPiBE
ci4gR3JlZw0KPiANCj4gVGhlIFF1aXhvdGUgUHJvamVjdCAtIEZsYWlsaW5nIGF0IHRoZSBUcmF2
YWlscyBvZiBDeWJlcnNlY3VyaXR5DQo+ICAgICAgICAgICAgICAgaHR0cHM6Ly9naXRodWIuY29t
L1F1aXhvdGUtUHJvamVjdA0K

