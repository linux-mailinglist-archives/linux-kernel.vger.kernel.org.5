Return-Path: <linux-kernel+bounces-64811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062185431B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CAB21354
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE985111A0;
	Wed, 14 Feb 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0Wz4afo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FF125A3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893660; cv=fail; b=V6E1n11Xipho+bvrvZvAYPAIXaWvHoN4qKJKxQIdiJPn9U1MZTX2W6zgLJwQjGbqJMX1m0AFM4Nd1yo2M7epblg87PmOMAtJ0zfhMI69cZbZAe63JVXrxz1LKkOB5qHmZnH1JSSISdjvHJmlynJadkshhCYc1AFsya/sHkFuvWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893660; c=relaxed/simple;
	bh=SUXoMtO/pgninGROSSrQt70MdJjwX/EvMTnTo0h2E0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gwT7Cmv/sdDCCy0z0WGBWctxRGW3HkeBOHkYXOhha3HZ8WiWq9Vx8VnyekChm5ZCn0hTybe2/1ckZ6KF88MzTVL2tzIRE9RLc/9iwWIVUfm9iiCbw8p+IQv090BbND6chlObu1yErro4uSgBz8wuPflDiAZU5QEpSNAnJn+BzR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0Wz4afo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707893658; x=1739429658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SUXoMtO/pgninGROSSrQt70MdJjwX/EvMTnTo0h2E0g=;
  b=P0Wz4afo40o4rnn8FzC7+LILqrs9Zi2wNUTXllNSRiRcL3WRtXA6ahOb
   8ihh9xFk7nfS1mxvozMOr8K6ByzN1uUVkLhJw+1Z9flir4i3izcpzZxAg
   XRlPnzfIaYgz3Xm/6/n8k0DhNkz5y0xWXAi4pmZ3d1b/kBjvSZ5PKKed6
   ToPFfyEwQLjiPrGkdnm/Yr5wdWhk0xiByi+/CcFrMVzsEDNzGJWvYkMex
   PZwrO4O+dnsCJUTgArv0IntBvHoseBskzcNwoFIugn0Ozs6H2Gf+lmZbT
   f2eRHVe+uBeQUCcRF+t7VEQ82g5/SxYYr02c74WfCBlyH5bjWP02YVccX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5747998"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5747998"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:54:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7759063"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 22:54:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:54:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:54:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 22:54:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 22:54:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOj4ekJLfRiFCiH4RY98Akg9+/WiNXz8ctYZ/2kq7RtGV7OTquMbCzb/EiD2MucM+oEgZnVAJs9xwbYtpBqqYAJdtDsYj/Xw793RO4uuI5sVROBtL7LQ6FRV1AlTegGqbdJlBt4yp30g6mp9zvMw/NnbIf1KknDZt0z/CHjtcRmPW0OK5jPHqlxtjMKr5uwsbRUAHgWRCmR1wqKThds0g5xqwapzWhb9owkErLpuVhchSlI8pCXpy2TUG7EizY6vs2Z/KpJui2z/rDkcP79nXad+rhsxDWoWwU91uoPVOM3L3kMKINnFg3x3UYZYGy6mqetzHWuYrPphbuPD3+MH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUXoMtO/pgninGROSSrQt70MdJjwX/EvMTnTo0h2E0g=;
 b=R5/hnBLJp/2k/AupZiSUCYuxuXeYRefhdcl/yixxvdSPIi64Imd1i4+1YHa2VBaifkv8pcxpXDIlqqSZGgXjQsalRjsyPkBrY6+xdk/78imzb8kEPK9j6GG2YeAkGqZQml826XohiAKjY5rty3+O8NAlNtXR1lqmIf7Flw3/tKsTEq9EwXUY/150PuRqkh0/BeoomRFF0OfSF3hGqf6GJvDIZ2XLCbaXaeT1HTRBdzoWK2ZX+wVEmPOORcCiCAu0FQklndQBIHdDbOYmYAEyYBwnvEMxXsNf4vlB1HjPbqknay1HfryEIU1/3XKhN91tNJhcEKk3tJEnzcnIO7s+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Wed, 14 Feb 2024 06:54:12 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:54:12 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Theodore Ts'o <tytso@mit.edu>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+AgACNaYCAATcDgIAKEC6AgAPvveCAAI87AIAA+lGAgAEIFICAABvHAIAAPV6AgAAlXtA=
Date: Wed, 14 Feb 2024 06:54:12 +0000
Message-ID: <DM8PR11MB5750E113F893369A5F61D4DCE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu> <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
 <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240213231341.GB394352@mit.edu>
 <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240214043245.GC394352@mit.edu>
In-Reply-To: <20240214043245.GC394352@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM6PR11MB4659:EE_
x-ms-office365-filtering-correlation-id: 4b4bcad9-d67f-4fcf-5454-08dc2d29c042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RyXSE28BEbqyhVvtB6XmZHRtHaFx1eJEPIWDR4+gb4H7pXND/yA+4BAQsVP+Q5icMorHpzOvv44uwbwcJ19SBxD6Jke/JMJcsKYtTfslIGENUTFYFaBc/q8Iqwh8UB/kaKnC/ZIDkUfLV9esC+ubdcedj0tlW5VdBkkkizkoo8KeetJcEaMlGrGOn0/tyJ0GE7zInLcSd0Psmsl35EO+ZEXP6csAXp6t9DmugpcAz1b1cbPBG+RBoyms8VPJKinyGVUxeWJBx9Z5+0H49FTeghQ4EDgtKwvpQ1SPQ+U+8dPPwjC34x8PE0yyPzAcu1cmw3DRNDm75vrh1NtyHTEYQijy+s/JQppVybC6YWdmlEQ6eTIMnamLc69Fzd5thg7hhgnTl5pwIovROf1auofup7uSOqzptBrTKQLQArB7YldGoEwdYgTkflc9nZS3cInnhePzUBDD+CMAe6LLhUKJ33zki58xiWtPumMzukOXs7v0/vnscP/yAuU7t0vPEYoOw3RBOhNJYJohcU3fiGloA+30+Pfdi+Bxq8mdJkv+eSWWbniBKGGfo5rBuCBMLeBO7I8wJgF3BRlyhYcXXEGfkr7ZLnVduu4IcrkdY+iDXP+DHk4V+RWsoMk21iNuz2n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(33656002)(55016003)(5660300002)(8936002)(66476007)(64756008)(8676002)(66946007)(52536014)(66556008)(4326008)(76116006)(4744005)(7416002)(66446008)(2906002)(9686003)(6506007)(7696005)(478600001)(82960400001)(38100700002)(26005)(122000001)(316002)(54906003)(41300700001)(38070700009)(110136005)(71200400001)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW9abWl6MVAvbXo2SzBwZElaMCtXSUd6dERpSzFISVpjZ2w1bXozRTlzNTU0?=
 =?utf-8?B?WERHeHFub3FCdnhZQzRaYlJNNnRzN1FidFZBSm5uSkVRY09kaUovOTAwSXR2?=
 =?utf-8?B?NU9VcmVKdnN3c1ZMTmFPemVpV2tXUS9Tb3ltaGhFYmNzU3U3cm8yakF1djkr?=
 =?utf-8?B?VE5sbVRsS2kyb1hXTm01Z3lLK1p1VVNPSTg1NEkyRFo4dTBUZTB5aEp0eFN4?=
 =?utf-8?B?czBvWmtkNHA4Vk9Sd3BOamVBNFR6Zm5ORE9sWTZCQytiVFNqSk91S25NMjVi?=
 =?utf-8?B?VHBkbTI1ZkNpc2dhSVdvNVdPM2NGTTRpZFluWmlkdk80bXplQlJqWDM0TVN2?=
 =?utf-8?B?S0gyK3lIZmZXKzUwUVB0VEdqZThZWE9XZXdLeGFYcDlUMkVqbDNvTUV0UElO?=
 =?utf-8?B?R01IbnNkRFRZN3JPcHcvbnA2aDBNVHFJa3V6Y2RFbTc3NWh6Q0ZvSlRCRFFX?=
 =?utf-8?B?amp4VG55YU8zeGkwZ1pja2dWamhJcDc0NWd6bTQ4ajd2eWNOcmJ4V01jLzFV?=
 =?utf-8?B?UjFnMVJQclBoSUwwbUgwa1pRTWtINHJKaElEd05xamlvYjM2UVJSODcxZWpX?=
 =?utf-8?B?Smg3MWpuSnA1TlhUeE5CNXhjbFlIdi8zUnRQbm1uc0RTVDlzS2VCQ0xBeFBM?=
 =?utf-8?B?bDREVDZMMGpMMlBaWXFiSS9kZExwMExQSitIWTNuT2VsMUFpWnZ4bHZ1ZXFn?=
 =?utf-8?B?YVh5ZWtxblp4S3VCVEJPcHFOWklVMFpqdE4zL0xTNk9DWlB1TmtkUEZvaSsr?=
 =?utf-8?B?b1dNb1RiR1ZLQXQrdm53STB0aFRzOGM1aTd4UVcvY3lsNGNlUGNtYUFRWGxk?=
 =?utf-8?B?SFhqUlNweHVRdTNJMURoQWZ1dUdyOHlCNWt6dU5CRjZ5Y0RSbWZBS3VMZWQ2?=
 =?utf-8?B?NWRYSTM4Nmw0eHhRS1cvdXE3b1ArVWIveGh2Y2c2cVhxVWl1WFNHQmlGNHhk?=
 =?utf-8?B?S3pTUEhVODFpYmcrcFIwRDRNYm4rVk9iUzZBZVZFdVRROXo3LzFBNjYzdURi?=
 =?utf-8?B?NjI2TCtyUHVOK0dpdlFVTmlTR28vcjgwa0ovYTlBS0lyMHZxNUlWMXVQdEty?=
 =?utf-8?B?aGNPZVduUXczYTlnc1hHeWp5aWpiV3kzb3BXZXlTRUY0YnliWGtqV2p4b1RZ?=
 =?utf-8?B?YlVsUlNTVTIxb1ZVd25qcUJGNXNRd3RqQ0QxK2V1bEtPblVVeUNENFA2eng2?=
 =?utf-8?B?QzlBMGE3dktsaCtlZXJyL3pjM0J0cGJJQmg2TGJ1NFhXL1p3aWFubFNGZzhq?=
 =?utf-8?B?eFZteUJPZzQwQjhjVDllRXp4ZE1LOW1uTW5ycEhOeDYzTnV2aFZ6a0kwYlpk?=
 =?utf-8?B?eEo5d1RhTjZXNmI3RFZKbytwSjh0Q25ZUjhXM3FMd3BuVWRYNnZqMWFTYXFH?=
 =?utf-8?B?WnhGQWhiN05uZVJkTFpPMXZWeTFJZXJBcTNNTDBPYmRwWk4vVGNBUVYyOEpD?=
 =?utf-8?B?bmFIdXpoVGo1ZGxLSTM0VUFTd3Y0M1c5RjVjL0FmditLRXJWUGJJVTh4dWVY?=
 =?utf-8?B?UmszNmM2YmpMbWVQdnIyVVYyT2M1eHZRcHRxMU84bzJJWGtJTXhoZ3BDL0F4?=
 =?utf-8?B?ZnRxcHljazhzSXY4YXJZby8wMktEdzNOd2dDY2FhbzMvaktkSmZoZkowYVhR?=
 =?utf-8?B?WDJNY2NROEx1QnJRN2RHRWl1SmF0cUUxTEExZ0VLbVNtb2lSS09ONlhBclR3?=
 =?utf-8?B?RkFKRWdCSEtmNm5tMjNwUXYzbEVONHE1WDAxcEZCMXM1RWFibU1KZFN4b2Iz?=
 =?utf-8?B?VjJyMStSREI3SlBkZUR0UUVUSnBDYjRKWVNFb0dEZUZ2aVY2MXJTWVdVV3A5?=
 =?utf-8?B?Yy8rckhkUzVIdnZvM0VoVnV2V05wdWF1K3lZYXFZUWJDSE15YUZHdzhEbEhG?=
 =?utf-8?B?YzdndHNXcHNHeEdFbjdQcDI4UkJXTUVhVkRHV3loS0pLbUMzWGtuc2VmTXlN?=
 =?utf-8?B?ZlFNeGNLOHQ3VmltQldPTitOMzc0V2FRdUpVTnV2RGNXTDZKMk4vTXNNb2ZM?=
 =?utf-8?B?emg1ZFB1bTB3Qk1mQnV0eVYzZW02bndrSlRmRUJuaTJFYzBFZjVOdXZlbERB?=
 =?utf-8?B?VlZGTnhnOXpmcWdzU2lweXluRHZ3NTBIZDdDckpRN0hGR09TQzc1M2ViQ05h?=
 =?utf-8?Q?8G3O3JFoI88g67BOpzjA5q1UQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4bcad9-d67f-4fcf-5454-08dc2d29c042
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 06:54:12.1961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2sO6glLhIKaXf+/c+moCDzLGiBiamlEXRWdcslDZey4bWSqh0ryKWacrOesT2e126VcdG/QohGIaFNdpj/xdejrxcg6/kJQmBJdb5Dwm+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-OriginatorOrg: intel.com

IA0KPiBVbHRpbWF0ZWx5LCBpZiBDUFUncyBjYW4gYWN0dWFsbHkgaGF2ZSBhbiBhcmNoaXRlY3Rn
dXJhbCBSTkcgYWxhDQo+IFJEUkFORC9SRFNFRUQgdGhhdCBhY3R1YWxseSBjYW4gZG8gdGhlIHJp
Z2h0IHRoaW5nIGluIHRoZSBmYWNlIG9mDQo+IGVudHJvcHkgZHJhaW5pbmcgYXR0YWNrcywgdGhh
dCBzZWVtcyB0byBiZSBhICoqbXVjaCoqIHNpbXBsZXINCj4gc29sdXRpb24uICANCg0KSSBkb27i
gJl0IHRoaW5rIGFueW9uZSB3b3VsZCBvYmplY3QgdGhhdCB0aGUgcmRyYW5kIGFwcHJvYWNoIHdl
IGFyZQ0KZGlzY3Vzc2luZyBoZXJlIGlzIHNpbXBsZXIuIE15IHBvaW50IChhbmQgYWxzbyBQZXRl
ciBvcmlnaW5hbCBpZGVhKSB3YXMNCnRoYXQgaWYgd2Ugd2FudCB0byBkbyBpdCBjb3JyZWN0bHkg
YW5kIGdlbmVyaWNhbGx5IChhbmQgKm5vdCoganVzdCBhYm91dCANCmNvbmZpZGVudGlhbCBjb21w
dXRpbmcpLCB3ZSBvdWdodCB0byBwcm92aWRlIGEgd2F5IGZvciB1c2VycyB0byBkZWZpbmUNCndo
YXQgZW50cm9weSBzb3VyY2VzIGZvciBMaW51eCBSTkcgdGhleSBhcmUgd2lsbGluZyB0byB0cnVz
dCBvciBub3QuDQpUaGlzIHNob3VsZCBub3QgYmUgYSBwb2xpY3kgZGVjaXNpb24gdGhhdCBrZXJu
ZWwgaGFyZGNvZGVzICh3ZSB0cnkgaGFyZA0KdG8gYXZvaWQgcG9saWNpZXMgaW4ga2VybmVsKSwg
YnV0IGxlZnQgZm9yIHVzZXJzIHRvIGRlY2lkZS9jb25maWd1cmUgYmFzZWQNCm9uIHRoZWlyIHBy
ZWZlcmVuY2VzLCB0cnVzdCBub3Rpb25zLCBmZWFycyBvZiBiYWNrZG9vcmluZywgd2hhdGVsc2Uu
DQpUaGlzIG9mIGNvdXJzZSBoYXMgdGhlIGZsaXAgcGFydCB0aGF0IHNvbWUgdXNlcnMgd2lsbCBn
ZXQgaXQgd3JvbmcsIGJ1dA0KcmVhc29uYWJsZSBzZWN1cmUgZGVmYXVsdHMgY2FuIGJlIHByb3Zp
ZGVkIGFsc28uIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==

