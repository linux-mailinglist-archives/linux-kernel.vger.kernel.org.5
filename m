Return-Path: <linux-kernel+bounces-47729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEC8451E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1555D1C233C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FA1586EA;
	Thu,  1 Feb 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sk4oj3RW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D83FE0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772383; cv=fail; b=Z7tMNdWWs5SokEKloi3l/rxthzE0BMA344/toLAN5lo3Vj+Wb7AEGVTVtNF4UD+r5RtyHWBWsTubk5IbqqR0pT+BfPQ46kHGP0SMQKrT4MgnW9ojRtJ1t88Eg8oqvuCI6jjwLCs4OnSbPfj50gUOZSjnzAeHOMHDPFwL9WezSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772383; c=relaxed/simple;
	bh=sOXWjRLTKK1EXSAwkoynaisJUtE5M1+br0iR326P994=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTK/9ASHzWtZ3lhDPZkpA8xvBzEYHF2SWl8XMQ85BMsUqTtR9pce0Zv5g7c7mv0UNFIZ+TByWXQ8G82cSD/SIUFrxBnSV8e7/FJk4qCkCXIRP5DetNALBuKqxtGPbWkzoCaJHzCRK7kzcE7EPpKMLheu51eAqsNbRIrN3UkgxBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sk4oj3RW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706772381; x=1738308381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sOXWjRLTKK1EXSAwkoynaisJUtE5M1+br0iR326P994=;
  b=Sk4oj3RWF9LWP2/Z1h1z/fEhpJKjvmzEo2MPrc93hJfhNarnX20ZoIXY
   Fb2BqD0+NNQgk0ujleeBVyQhVYPpnm9aX4eBtFwIAInBg2moPYKegXQJs
   Ip+GHPKLqObDdAqE3xm/cZO1H6FOnLFolgf4jx/L6gxaK+l2oV/UEkPSy
   Mumti7GFTOWwkoHWawTOEbobf6IhXo6hptIJCXYPC29m/ZwqXnzDdVs5z
   p8Eh8BsEpBQwLXxquwDXTXHqCwqjkIDHSI4MCkTtq7UUC1ofSNpX7BZsv
   dp8RBBMmg6+6ZPDpfBDUeiRqiAm5xPAS+uiIzdb+de1aBR2HVouG32qno
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2765205"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="2765205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 23:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961846536"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961846536"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 23:26:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 23:26:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 23:26:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 23:26:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 23:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW1dGRTivSn6Jfw7wUEqwcEH2Ce6HPor91x4R7GeL8skgXnCgFOnZB83tR4lhu4wo7D7TXkxOFpc7EG+AotbEBeAs89nJTIgOZfcVw2Vbqe6p6YavAjVcAMY8KVS7Af1DKfW6O24Hosy8XQB7jmaD4VMsmK7qSGXMH6uLLWO5gxe7KMrNpIZLF/Ln3+s9/LuTY/v8O7Wp6tENrXVW384BVGZPXAHKhH275zKv2WFfaMzjcRtYkca+u4KtAPH6/a3qrQn8I0R8z/GygsvyAO8sRh0zDvqXJDTUQrYQVFi0S8vLSELn8BZWlBoaVcvURJilv5gG9jK3/Cdf/uQ1yGeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOXWjRLTKK1EXSAwkoynaisJUtE5M1+br0iR326P994=;
 b=CIcwrMowA4gpWkOF90jotISfJCVd1SLcp7c4ZJKn3aSqJgKmOVzuYK2ctn4sMB1NWYRCuBlRLuTsszNsoTLUMxz5Q/MJ6iJvU4Ls+JbNXoss0qSTDJkqUM5NWm8ohk1yo4rEx9Wi3tYMfEJ16z1Qn9u8qMwPg70jd1bUR6M8fCj6linzubv/1VRUPx0FpBIhLREvgxYZUtiJxRGmfW3Q7fxF+CU04Pc6uGDMtlSTmf833tmSMqC3w9sKyHWd8HGrgcGYpeciLbC5Jcvu2LOO15hdXh1oDRN4SzQdGwEYvrGDA/zo5A7cPM2190qVZ6iEIE299HnI6hrq77vmdRnl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Thu, 1 Feb 2024 07:26:15 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 07:26:15 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Dr. Greg" <greg@enjellic.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Daniel P. Berrang??" <berrange@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson
	<seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Thread-Topic: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED
 fails
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVCAAEjrgIAABNyAgAAErYCAAOk00IAAVWCAgAB9iQCAALLSQA==
Date: Thu, 1 Feb 2024 07:26:15 +0000
Message-ID: <DM8PR11MB5750FDC379F54F8591246DF0E7432@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
 <20240131203531.GA12035@wind.enjellic.com>
In-Reply-To: <20240131203531.GA12035@wind.enjellic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CY8PR11MB7686:EE_
x-ms-office365-filtering-correlation-id: b0898fb7-0b7d-433f-d2d6-08dc22f71315
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijeQaFYhOKA/Uj2RZbBMq5kwMLPJ8bnXio7cY/RySWJLJT6H6DJrWFFx7/G/8Q3FKx9MtDdd4S0MoBE+09OApePrrXRRh0agZ/PFAuION/8pNdqEZyTwCkdqjH9k693jVLmoX7dg6GDnLjJFfwDVpVydt4mW4Qc3pTZg9zZcmoZdbjhPT/F3LK3z0U5VIwSMNMA28BAbfLXEBu3zcv8Gp6WV12NJPfiJg9DWpV1WWHfC5sbUvMYz0PO28RKZJnptXaAkBCctGkRxoJLQ8vfxSv2xWWF5tMqn6t1YfENql73oXEtldIjPqH62rB2j7TRoAZT7oIR1/kfa5kHEdZU2gI+o5Aq1SB5NKXL+WAA22mRPJqXO5dzGAi9saTFZCmapgYN7BHQULa07pmcYJdPWiyEUXY0ppQ764rPxdV3o2IAwAWIHIlMugDNiDH+7iWXsVnb8DedqcPJeJ5+5N5ji0vF25DFc088oLZR4ItUFeFQvjcm9WEzWDgXDOGC8Red+hzWp8Wcq59awMxWpivHvMqPvCJd8s5se4v94dY8VBzO1R0CP3mSlD9kUklmJAdLZwruA1CMlb+qNqIkWZY9omXN3xo3z+LIbk0FsnEF0eHDeURXs910YB0YF3s1bRGyAbm42tOP+S6ULPj2Vv/3ld0Slb1P9PzybP+Mep0q3ms0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(8936002)(52536014)(4326008)(2906002)(8676002)(7416002)(5660300002)(86362001)(110136005)(33656002)(76116006)(66446008)(64756008)(54906003)(66476007)(38070700009)(66556008)(66946007)(9686003)(83380400001)(38100700002)(122000001)(316002)(7696005)(6506007)(82960400001)(71200400001)(478600001)(966005)(26005)(55016003)(569784001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjdjM3hSeVhLZ2JpTWZRN1R5OGFBM0dNUGt5ZlNuYUNiRDBWY2dEdVJMS1lU?=
 =?utf-8?B?Sk1hUTh1RDJNZDdSL1FrRVlVenRJUThkNnNkdHB6SVVyem8ydFF6a0tkdUo2?=
 =?utf-8?B?RVk3MmhLUWZFcXYzSytLMEM4b05rQlFKRUhHSjZIWThXL05MQTZuWEE3M0VX?=
 =?utf-8?B?Ty9nd3Q4N0pCMmRTYnpITmIyNXZBM3YxTzFHTTlBdk52TEFYNGE2SmovM0JI?=
 =?utf-8?B?U2E2eWxUTC9zTlNBS05ycGxZWHhlcVFWbjg4b0RtVlpSRkRrSENKODkrTGdS?=
 =?utf-8?B?UkVrYzZGTk8wdnR5bzR3aWIxUGVNbnNkMGRSZzFwZ3FyQkVGdkxsQkQvaldq?=
 =?utf-8?B?SW4wNzJaS3hZWjdmbTVWMFc2eFlyR05FMlFlS2tlTUV2N3FTSGI4Q0FFbTdi?=
 =?utf-8?B?N3U5MWdML0hrTWZJNUVSWkRyTWcrZmF4ckFXaEpwY05BUDJXLzBnQURwRWtw?=
 =?utf-8?B?bndpeHJMMXJDWjhZbVJPNm1IUlNyenk1RmcydHZOd1pYc1B2ajBmd1lBK3JC?=
 =?utf-8?B?c0dXdmJSeElHc3pqTmZVa1FGMFZFN0dDWkVmQVR0Qzh1S0FKaWxkRlV1OEJI?=
 =?utf-8?B?SkJCTDlnQmR1czk4dXF4QThxMk5RS2dQSDUyZkFRTFYvS1lXa25LemY1MzJP?=
 =?utf-8?B?cnREcmZ4NXd5QXVMT095Zll5anZxMGdnbi9WRk03WjBjNjNPdSttOXJGaUdC?=
 =?utf-8?B?UlNheFd1Qll3WFR4Ri9BLzhwMklkSmI5OXlZTTRQUXFKdElpR2YveHRZOTRo?=
 =?utf-8?B?aHJrb0k2N3I2bmJnVThTNnI2Z0lndldRK2hQME8vRGVyU2x1NE9xTHlUL2Ji?=
 =?utf-8?B?Q2lOVFA5b0dWQUxkRG5sOXYzQ1Q0ZW1la1hwY09UUTFWL2hYRCs4ZUxQZ2dH?=
 =?utf-8?B?b1IzK2VLaU9Vc09PbVhOQjhJMlczKzNsT3NObFgrVzZraTBIbmwwT2VhQk1U?=
 =?utf-8?B?eDFjaW5oeDBQRGpwT1RqTGwwTUVHMmJBTllnTkxEOWNSUjhta05mQTRaV01i?=
 =?utf-8?B?d2NEL2g0UGJXVG1uaFAxWGIzeEZNSnFFblR1WjZvUG05VjEyaFQweDdzL3Y1?=
 =?utf-8?B?WEtJZ1NxZjJsQUpXYUMrL0VOZ0I4WmIyYkZWUnNvUEJDdGF6YVp1bERSNU9B?=
 =?utf-8?B?TEVTNjNuS3p6RWkzUjdnbHRiYmlKVDZ4WlVyK2tyT0ZMOWN2LzhpUUtxeDNz?=
 =?utf-8?B?NVdhaW5ZSytidVMvanRpanFINU8wNkxHTXBqUDBENDU3ZVRjV3FTMWorTXdW?=
 =?utf-8?B?ZjllcUtrWitLQnBNVmNuMS8xWmVaWUJrS3Y3RzZyUnVnUUlXN1V4cXN0R1RJ?=
 =?utf-8?B?a1VOdWhid0FFdFNXRTI5d1lQdGNyK3R6djVPM2tKdzhqeXNXb3kxN0JwN3JE?=
 =?utf-8?B?QjV6R3JLcjlEY2xzUjZ5S3QzWmRQY2NpbDM4U2ptUm93eXZqVFlrQlhZcGly?=
 =?utf-8?B?OXc2OWk5Z04vVHVmckZ0K2laVGJid1FhVUI1ZWlFMm5pVVVhNzFXYnFXd3pJ?=
 =?utf-8?B?UVlhTE5jSVQzMlVOdFVSMDhWMXFhdkorQmtxQnhNdFpKYnF3VDFxbktyRnZC?=
 =?utf-8?B?MmhVWHFYSE03cW1xd0MyTDkrdjAwQUNKK1lJaGt5c1RRRng4UTZRQWh5aENV?=
 =?utf-8?B?ZVNhSUdXVHF3eFNOOGNCbzU5dnJlUWM0QkRzbUpLUkRqdFd5OUNBK2JZckcv?=
 =?utf-8?B?RGJRSW54NXphMzUrKy93TloxcEphejR0ZVRKMUwwUEtxWEUvR1V4Zk9aZFgz?=
 =?utf-8?B?a09QbVRZMTVrR1VzaW9QZjNVR0d1bmEzd0RxbDF2ZHdBR1Jpd0JCdld5T21S?=
 =?utf-8?B?OHJkK3VIYllySTlab0pDNFlsRklFdVpyRHEzQ05mSHVmeW1PZzVHVVMxWWgz?=
 =?utf-8?B?KzlqMEVHemU2RnZDS0dEYm12VVVmUDM3RmtSVHcyVzMyaGZHc093TXd0ZS9u?=
 =?utf-8?B?QUNnQ1Z4ZzZEUHByd2E4R1F2M0RKL2p4RWYxSHZja05TdGVWQll3ZTZHWUo1?=
 =?utf-8?B?Z0VHWktsTkJlZnRRSGk1aHZVZVZOcURWSjBsc1B6eW5rbDVrTkxyOEZoeDB4?=
 =?utf-8?B?VVlkaWhJSHhGY1l6WmgxMlVpZ2hQK2tsS2x1SlcxODIwQWdmYlV6WFpscjNI?=
 =?utf-8?Q?RA4tuQROgBB4AvDGIVnzpsEHw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0898fb7-0b7d-433f-d2d6-08dc22f71315
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 07:26:15.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGXg5T/gcXFA1OXoSdm6JraWM8Jg0sO4JZ0fPnnwmPsobAiUlJYwALUHkwVyiMOsjCz0DpLmriBhEGTC/OwyUh8uvAuYeSka/0bd5TVlS8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

PiBPbiBXZWQsIEphbiAzMSwgMjAyNCBhdCAwMjowNjoxM1BNICswMTAwLCBKYXNvbiBBLiBEb25l
bmZlbGQgd3JvdGU6DQo+IA0KPiBIaSBhZ2FpbiB0byBldmVyeW9uZSwgYmVhdXRpZnVsIGRheSBo
ZXJlIGluIE5vcnRoIERha290YS4NCj4gDQo+ID4gT24gV2VkLCBKYW4gMzEsIDIwMjQgYXQgOTox
Nz8/P0FNIFJlc2hldG92YSwgRWxlbmENCj4gPiA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4g
d3JvdGU6DQo+ID4gPiBUaGlzIG1hdGNoZXMgYm90aCBteSB1bmRlcnN0YW5kaW5nIChJIGRvIGhh
dmUgY3J5cHRvZ3JhcGh5IGJhY2tncm91bmQNCj4gPiA+IGFuZCB1bmRlcnN0YW5kaW5nIGhvdyBj
cnlwdG9ncmFwaGljIFJOR3Mgd29yaykNCj4gPiA+IGFuZCBvZmZpY2lhbCBwdWJsaWMgZG9jcyB0
aGF0IEludGVsIHB1Ymxpc2hlZCBvbiB0aGlzIG1hdHRlci4NCj4gPiA+IEdpdmVuIHRoYXQgdGhl
IHBoeXNpY2FsIGVudHJvcHkgc291cmNlIGlzIGxpbWl0ZWQgYW55aG93LCBhbmQgYnkgZ2l2aW5n
DQo+ID4gPiBlbm91Z2ggcHJlc3N1cmUgb24gdGhlIHdob2xlIGNvbnN0cnVjdGlvbiB5b3Ugc2hv
dWxkIGJlIGFibGUgdG8NCj4gPiA+IG1ha2UgUkRSQU5EIGZhaWwgYmVjYXVzZSBpZiB0aGUgaW50
ZXJtZWRpYXRlIEFFUy1DQkMgTUFDIGV4dHJhY3Rvci8NCj4gPiA+IGNvbmRpdGlvbmVyIGlzIG5v
dCBnZXR0aW5nIGl0cyBtaW4gZW50cm9weSBpbnB1dCByYXRlLCBpdCB3b250DQo+ID4gPiBwcm9k
dWNlIGEgcHJvcGVyIHNlZWQgZm9yIEFFUyBDVFIgRFJCRy4NCj4gPiA+IE9mIGNvdXJzZSBleGFj
dCBkZXRhaWxzL251bWJlcnMgY2FuIHdhcnkgYmV0d2VlbiBkaWZmZXJlbnQgZ2VuZXJhdGlvbnMg
b2YNCj4gPiA+IEludGVsIERSTkcgaW1wbGVtZW50YXRpb24sIGFuZCB0aGUgcGxhdGZvcm1zIHdo
ZXJlIGl0IGlzIHJ1bm5pbmcgb24sDQo+ID4gPiBzbyBiZSBjYXJlZnVsIHRvIHN0aWNraW5nIHRv
IGNvbmNyZXRlIG51bWJlcnMuDQo+IA0KPiA+IEFscmlnaHQsIHNvIFJEUkFORCBpcyBub3QgcmVs
aWFibGUuIFRoZSBxdWVzdGlvbiBmb3IgdXMgbm93IGlzOiBkbw0KPiA+IHdlIHdhbnQgUkRSQU5E
IHVucmVsaWFiaWxpdHkgdG8gdHJhbnNsYXRlIHRvIGFub3RoZXIgZm9ybSBvZg0KPiA+IHVucmVs
aWFiaWxpdHkgZWxzZXdoZXJlLCBlLmcuIERvUy9pbmZpbml0ZWxvb3AvbGF0ZW5jeS9XQVJOX09O
KCk/IE9yDQo+ID4gd291bGQgaXQgYmUgYmV0dGVyIHRvIGRlY2xhcmUgdGhlIGhhcmR3YXJlIHNp
bXBseSBicm9rZW4gYW5kIGFzaw0KPiA+IEludGVsIHRvIGZpeCBpdD8gKEkgZG9uJ3Qga25vdyB0
aGUgYW5zd2VyIHRvIHRoYXQgcXVlc3Rpb24uKQ0KPiANCj4gSSB0aGluayBpdCB3b3VsZCBkZW1v
bnN0cmF0ZSBhIGxhY2sgb2YgYXBwcm9wcmlhdGUgZW5naW5lZXJpbmcNCj4gZGlsaWdlbmNlIG9u
IHRoZSBwYXJ0IG9mIG91ciBjb21tdW5pdHkgdG8gZGVjbGFyZSBSRFJBTkQgJ2J1c3RlZCcgYXQN
Cj4gdGhpcyBwb2ludC4NCj4gDQo+IFdoaWxlIGl0IGFwcGVhcmVzIHRvIGJlIHRyaXZpYWxseSBl
YXN5IHRvIGZvcmNlIFJEU0VFRCBpbnRvIGRlcGxldGlvbiwNCj4gdGhlcmUgZG9lcyBub3Qgc2Vl
bSB0byBiZSBhIHN1Z2dlc3Rpb24sIGF0IGxlYXN0IGluIHRoZSBvcGVuDQo+IGxpdGVyYXR1cmUs
IHRoYXQgdGhpcyBkaXJlY3RseSBvciBlYXNpbHkgdHJhbnNsYXRlcyBpbnRvIHN0YWxsaW5nDQo+
IG91dHB1dCBmcm9tIFJEUkFORCBpbiBhbnkgdHlwZSBvZiByZWxldmFudCBhZHZlcnNhcmlhbCBm
YXNoaW9uLg0KPiANCj4gSWYgdGhpcyB3ZXJlIHRoZSBjYXNlLCBnaXZlbiB3aGF0IENWRSdzIHNl
ZW0gdG8gYmUgd29ydGggb24gYSByZXN1bWUsDQo+IHNvbWVvbmUgd291bGQgaGF2ZSByZW50ZWQg
YSBjbG91ZCBtYWNoaW5lIGFuZCBjb21lIHVwIHdpdGggYSBQT0MNCj4gYWdhaW5zdCBSRFJBTkQg
aW4gYSBtdWx0aS10ZW5hbnQgZW52aXJvbm1lbnQgYW5kIHRoZW4gcHJvbXB0bHkgcHV0IHVwDQo+
IGEgd2ViLXNpdGUgY2FsbGVkICdSYW5kb20gU3RhcnZlJyBvciBzb21ldGhpbmcgZXF1YWxseSBv
bWlub3VzLg0KPiANCj4gVGhpcyBpcyBubyBkb3VidCBzZWNvbmRhcnkgdG8gdGhlIDEwMjJ4IGFt
cGxpY2F0aW9uIGZhY3RvciBpbmhlcmVudCBpbg0KPiB0aGUgJ0J1bGwgTW91bnRhaW4nIGFyY2hp
dGVjdHVyZS4NCj4gDQo+IEknbSBhIGJpdCBzdXJwcmlzZWQgdGhhdCBubyBvbmUgZnJvbSB0aGUg
SW50ZWwgc2lkZSBvZiB0aGlzDQo+IGNvbnZlcnNhdGlvbiBkaWRuJ3QgcGl0Y2ggdGhpcyBvdmVy
IHRoZSB3YWxsIGFzIHNvb24gYXMgdGhpcw0KPiBjb252ZXJzYXRpb24gY2FtZSB1cCwgYnV0IEkg
d291bGQgc3VnZ2VzdCB0aGF0IGV2ZXJ5b25lIGNvbmNlcm5lZA0KPiBhYm91dCB0aGlzIGlzc3Vl
IGdpdmUgdGhlIGZvbGxvd2luZyBhIHRob3JvdWdoIHJlYWQ6DQo+IA0KPiBodHRwczovL3d3dy5p
bnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVyL2FydGljbGVzL2d1aWRlL2ludGVs
LWRpZ2l0YWwtDQo+IHJhbmRvbS1udW1iZXItZ2VuZXJhdG9yLWRybmctc29mdHdhcmUtaW1wbGVt
ZW50YXRpb24tZ3VpZGUuaHRtbA0KPiANCj4gUmVsZXZhbnQgaGlnaGxpZ2h0czoNCj4gDQo+IC0g
QXMgSSBzdWdnZXN0ZWQgaW4gbXkgZWFybGllciBlLW1haWwsIHJhbmRvbSBudW1iZXIgZ2VuZXJh
dGlvbiBpcyBhDQo+ICAgc29ja2V0IGJhc2VkIHJlc291cmNlLCBoZW5jZSBhbiBhZHZlcnNhcmlh
bCBkb21haW4gbGltaXRlZCB0byBvbmx5DQo+ICAgdGhlIGNvcmVzIG9uIGEgY29tbW9uIHNvY2tl
dC4NCj4gDQo+IC0gVGhlcmUgaXMgYSBtYXhpbXVtIHJhbmRvbW5lc3MgdGhyb3VnaHB1dCByYXRl
IG9mIDgwMCBNQi9zIG92ZXIgYWxsDQo+ICAgY29yZXMgc2hhcmluZyBjb21tb24gcmFuZG9tIG51
bWJlciBpbmZyYXN0cnVjdHVyZS4gIFNpbmdsZSB0aHJlYWQNCj4gICB0aHJvdWdocHV0IHJhdGVz
IG9mIDcwLTIwMCBNQi9zIGFyZSBkZW1vbnN0cmF0YWJsZS4NCj4gDQo+IC0gQSBmYWlsdXJlIG9m
IFJEUkFORCBvdmVyIDEwIHJlLXRyaWVzIGlzICdhc3Ryb25vbWljYWxseScgc21hbGwsIHdpdGgN
Cj4gICBubyBkZWZpbml0aW9uIG9mIGFzdHJvbm9taWNhbCBwcm92aWRlZCwgb25lIHdvdWxkIGFz
c3VtZSByZWFsbHkNCj4gICBzbWFsbCwgZ2l2ZW4gdGhleSBhcmUgdXNpbmcgdGhlIHdvcmQgYXN0
cm9ub21pY2FsLg0KDQpBcyBJIHNhaWQsIEkgd2FudCB0byBpbnZlc3RpZ2F0ZSB0aGlzIHByb3Bl
cmx5IGJlZm9yZSBzdGF0aW5nIGFueXRoaW5nLg0KSW4gYSBDb0NvIFZNIHdlIGNhbm5vdCBndWFy
YW50ZWUgdGhhdCBhIHZpY3RpbSBndWVzdCBpcyBhYmxlIHRvIGV4ZWN1dGUNCnRoaXMgMTAgcmUt
dHJ5IGxvb3AgKHRoZXJlIGlzIGFsc28gYSB0aWdodG5lc3MgcmVxdWlyZW1lbnQgbGlzdGVkIGlu
IG9mZmljaWFsIA0KZ3VpZGUgdGhhdCBpcyBub3QgZnVydGhlciBzcGVjaWZpZWQpIHdpdGhvdXQg
aW50ZXJydXB0aW9uIHNpbmNlIGFsbCBndWVzdA0Kc2NoZWR1bGluZyBpcyB1bmRlciB0aGUgaG9z
dCBjb250cm9sLiBBZ2FpbiwgdGhpcyBpcyB0aGUgYW5nbGUgdGhhdCB3YXMgbm90DQpwcmVzZW50
IGJlZm9yZSBhbmQgSSB3YW50IHRvIG1ha2Ugc3VyZSB3ZSBhcmUgcHJvdGVjdGVkIGFnYWluc3Qg
dGhpcyBjYXNlLiANCg0KPiANCj4gPiA+IFRoYXQgc2FpZCwgSSBoYXZlIHRha2VuIGFuIEFSIHRv
IGZvbGxvdyB1cCBpbnRlcm5hbGx5IG9uIHdoYXQgY2FuIGJlIGRvbmUNCj4gPiA+IHRvIGltcHJv
dmUgb3VyIHNpdHVhdGlvbiB3aXRoIFJEUkFORC9SRFNFRUQuDQo+IA0KPiBJIHRoaW5rIEkgY2Fu
IHNhdmUgeW91IHNvbWUgdGltZSBFbGVuYS4NCj4gDQo+ID4gU3BlY2lmeWluZyB0aGlzIGlzIGFu
IGludGVyZXN0aW5nIHF1ZXN0aW9uLiBXaGF0IGV4YWN0bHkgbWlnaHQgb3VyDQo+ID4gcmVxdWly
ZW1lbnRzIGJlIGZvciBhICJub24tYnJva2VuIiBSRFJBTkQ/IEl0IHNlZW1zIGxpa2Ugd2UgaGF2
ZSB0d28NCj4gPiBiYXNpYyBvbmVzOg0KPiA+DQo+ID4gLSBPbmUgVk1YIChvciBob3N0KSBjb250
ZXh0IGNhbid0IERvUyBhbm90aGVyIG9uZS4NCj4gPiAtIFJpbmcgMyBjYW4ndCBEb1MgcmluZyAw
Lg0KPiA+DQo+ID4gSSBkb24ndCBrbm93IHdoZXRoZXIgdGhhdCdkIGJlIGltcGxlbWVudGVkIHdp
dGggY29udGV4dC10aWVkIHJhdGUNCj4gPiBsaW1pdGluZyBvciBtb3JlIHN0YXRlIG9yIHdoYXQu
IEJ1dCBJIHRoaW5rLCBzaG9ydCBvZiBqdXN0IG1ha2luZw0KPiA+IFJEUkFORCBuZXZlciBmYWls
LCB0aGF0J3MgYmFzaWNhbGx5IHdoYXQncyBuZWVkZWQuDQo+IA0KPiBJIHRoaW5rIHdlIHByb2Jh
Ymx5IGhhdmUgdGhhdCwgZm9yIGFsbCBpbnRlbnRzIGFuZCBwdXJwb3NlcywgZ2l2ZW4NCj4gdGhh
dCB3ZSBlbWJyYWNlIHRoZSBmb2xsb3dpbmcgbWV0aG9kb2d5Og0KPiANCj4gLSBVc2UgUkRSQU5E
IGV4Y2x1c2l2ZWx5Lg0KPiANCj4gLSBCZSB3aWxsaW5nIHRvIHRha2UgMTAgc3dpbmdzIGF0IHRo
ZSBwbGF0ZS4NCj4gDQo+IC0gR2l2ZW4gdGhlIHNvbWV3aGF0IGRlbWFuZGluZyByZXF1aXJlbWVu
dHMgZm9yIFREWC9DT0NPLCBmYWlsIGFuZA0KPiAgIGVpdGhlciBkZWFkbG9jayBvciBwYW5pYyBh
ZnRlciAxMCBzd2luZ3Mgc2luY2UgdGhhdCB3b3VsZCBzZWVtIHRvDQo+ICAgc3VnZ2VzdCB0aGUg
aGFyZHdhcmUgaXMgYnJva2VuLCBpZS4gUk1BIHRpbWUuDQoNCkFnYWluLCBteSB3b3JyeSBoZXJl
IHRoYXQgYSBDb0NvIGd1ZXN0IGlzIG5vdCBpbiBjb250cm9sIG9mIGl0cyBvd24gc2NoZWR1bGlu
Zw0KYW5kIHRoaXMgbWlnaHQgbWFrZSBhbiBpbXBhY3Qgb24gdGhlIGFib3ZlIHN0YXRlbWVudCwg
aS5lLiBpdCBtaWdodA0KdGhlb3JldGljYWwgYmUgcG9zc2libGUgdG8gY2F1c2UgdGhpcyB3aXRo
b3V0IHBoeXNpY2FsbHkgYnJva2VuIEhXLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNCj4g
DQo+IEVpdGhlciBkZWFkbG9jayBvciBwYW5pYyB3b3VsZCBiZSBhcHByb3ByaWF0ZS4gIFRoZSBv
YmplY3RpdmUgaW4gdGhlDQo+IENPQ08gZW52aXJvbm1lbnQgaXMgdG8gZ2V0IHRoZSBwZXJzb24g
d2hvIGNsaWNrZWQgb24gdGhlICdFbmFibGUgQXp1cmUNCj4gQ29uZmlkZW50aWFsJyBjaGVja2Jv
eCwgb3IgaXRzIGVxdWl2YWxlbnQsIG9uIHRoZWlyIGNsb3VkIGRhc2hib2FyZCwNCj4gdG8gY2Fs
bCB0aGUgSGVscERlc2sgYW5kIGFzayB0aGVtIHdoeSB0aGVpciBjb25maWRlbnRpYWwgYXBwbGlj
YXRpb24NCj4gd29uJ3QgY29tZSB1cC4NCj4gDQo+IEFmdGVyIHRoZSB1c2VyIGNvbmZpcm1zIHRv
IHRoZSBIZWxwRGVzayB0aGF0IHRoZWlyIGNvbXB1dGVyIGlzIHBsdWdnZWQNCj4gaW4sIHRoZSBw
cm9ibGVtIHdpbGwgZ2V0IGZpeGVkLiAgRWl0aGVyIHRoZSBicm9rZW4gaGFyZHdhcmUgd2lsbCBi
ZQ0KPiBpZGVudGlmaWVkIGFuZCBpZGxlZCBvdXQgb3IgdGhlIG1pZ2h0eSBzd29yZCBvZiB2ZW5n
ZWFuY2Ugd2lsbCBiZQ0KPiBzdW1tb25lZCBkb3duIG9uIHdob2V2ZXIgaGFzIGFsbCBvZiB0aGUg
b3RoZXIgY29yZXMgb24gdGhlIHNvY2tldA0KPiBwZWdnZWQuDQo+IA0KPiBGaW5hbCB0aG91Z2h0
czoNCj4gDQo+IC0gUkRTRUVEIGlzIHByb2JhYmx5IGEgcG9vciB0aGluZyB0byBiZSB1c2luZy4N
Cj4gDQo+IC0gVGhlcmUgbWF5IGJlIGEgcmVhc29uYWJsZSBhcmd1bWVudCB0aGF0IFJEU0VFRCBz
aG91bGRuJ3QgaGF2ZSBiZWVuDQo+ICAgZXhwb3NlZCBhYm92ZSByaW5nIDAsIGJ1dCB0aGF0IHNo
aXAgaGFzIHNhaWxlZC4gIEJyb3duaWUgcG9pbnRzDQo+ICAgbW92aW5nIGZvcndhcmQgZm9yIGFu
IFJEc29tZXRoaW5nIHRoYXQgaXMgcmluZyAwIGFuZCBoYXMgZ3VhcmFudGVlZA0KPiAgIGFjY2Vz
cyB0byBzb21lIGFtb3VudCBvZiBmdW5jdGlvbmFsbHkgcmVhc29uYWJsZSBlbnRyb3B5Lg0KPiAN
Cj4gLSBJbnRlbCBhbmQgQU1EIGFyZSBhbHJlYWR5IGRvaW5nIGEgbG90IG9mICdzcGVjaWFsJyBz
dHVmZiB3aXRoIHRoZWlyDQo+ICAgQ09DTyBoYXJkd2FyZSBpbiBvcmRlciB0byBkZWZ5IHRoZSBs
b25nIHN0YW5kaW5nIGFkYWdlIG9mOiAnWW91DQo+ICAgY2FuJ3QgaGF2ZSBzZWN1cml0eSB3aXRo
b3V0IHBoeXNpY2FsIHNlY3VyaXR5Jy4gIEFjY2VzcyB0byBwZXIgY29yZSB0aGVybWFsDQo+ICAg
bm9pc2UsIGFzIEkgc3VnZ2VzdGVkLCBpcyBwcm9iYWJseSBhIGJpZyBsaWZ0IGJ1dCBjbGV2ZXIg
ZW5naW5lZXJzIGNhbg0KPiAgIHByb2JhYmx5IGNvb2sgdXAgc29tZSB0eXBlIG9mIGZhaXJuZXNz
IGRvY3RyaW5lIGZvciByYW5kb21uZXNzIGluDQo+ICAgVERYIG9yIFNFVl9TTlAsIGdpdmVuIHRo
ZSBwYXJ0aWN1bGFyIGltcG9ydGFuY2Ugb2YgaW5zdHJ1Y3Rpb24gYmFzZWQNCj4gICByYW5kb21u
ZXNzIGluIENPQ08uDQo+IA0KPiAtIFBlcmZlY3Rpb24gaXMgdGhlIGVuZW15IG9mIGdvb2QuDQo+
IA0KPiA+IEphc29uDQo+IA0KPiBIYXZlIGEgZ29vZCBkYXkuDQo+IA0KPiBBcyBhbHdheXMsDQo+
IERyLiBHcmVnDQo+IA0KPiBUaGUgUXVpeG90ZSBQcm9qZWN0IC0gRmxhaWxpbmcgYXQgdGhlIFRy
YXZhaWxzIG9mIEN5YmVyc2VjdXJpdHkNCj4gICAgICAgICAgICAgICBodHRwczovL2dpdGh1Yi5j
b20vUXVpeG90ZS1Qcm9qZWN0DQo=

