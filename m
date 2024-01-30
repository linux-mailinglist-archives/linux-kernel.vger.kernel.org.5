Return-Path: <linux-kernel+bounces-44127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0320841D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E8E28E42C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694757881;
	Tue, 30 Jan 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn30xCrW"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AE60DCA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602781; cv=fail; b=agpPXhk6sOMqGfiJ6Bc0mQM7FG0VY5kIwWMLyJWXfgkuQbfET5xgQa6MJIUS+iVz73x0Dnq4g4Xig1hq8anlOlQA9A/0D01NBQQnqdeOUsN8PQwMMMHzG8lQ+ooMtwBI3kMM9bolEMljy4pT6VVXGmRKURcnc6kk0fIvawzAz3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602781; c=relaxed/simple;
	bh=yzqO0PADbf9G/ECcKjiHFaehLTJKSKdI7gtMY3xzMe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mP3EqgXerll2HuPKoPTZ5iAf3dVCN5T8FygRcPaiDnHjiSBdRFIeJIrVP2A24HHmGfSW3JOnldxgo1zrlmoYCbORcP3M7vVDr9cFlyRm2cSyfFGzdMEZp8k0pq3fjvK6hrXdSE7BZOgM4skQ1R7TfJjU4dDXbQ820YFODAMw6Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn30xCrW; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706602779; x=1738138779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yzqO0PADbf9G/ECcKjiHFaehLTJKSKdI7gtMY3xzMe8=;
  b=Nn30xCrWcl+3XHPUXFpeZomEJjYZRa4+CrHAd51qegq7LKExBhC3SlYA
   nAaA0gGwwOZKU5WrnUz+9/5Z9MfCgSSP0OWwGjUGmS52td4em9EQ20eXx
   FcnmlhUq/smLHtNlBJE0iRnVxaA7DowN2CHzWQ84VmYh1POV8fGgxmmUt
   u/Bf77dU+TFSGF1T9cD8d8+Wl9uShxEBzgBVF6mlMyPb703qBZgBi22Wt
   rd3/MI+l/iYestihGVp4haORjRCwZdzBtw4KBE16xBKE3dwlGSX1FkLTg
   SIJnTTMWvas3yVktXbrc+CGeMa3wqWs0v6hsyLsCyp0bfJjde5tvperk+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434377403"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="434377403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36422208"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 00:19:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 00:19:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 00:19:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 00:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YajHxoOHpq66N6VymktNX4H5X3T5msxs+kafstYUCFqP24LWg8Os0oSeyLvSz3TQOF/DJ9yZmsUnitvjJ3RhJV4kkREupzzYddX7fhWhGI6ROyclwztwyiyK9Bpr6P3AIXy4PWhCCl1BhUPssy6/xBGV8xDDj248FEwOwQJS2EtqO0Un99IncLb3KxNrTWBOrw6xIBzOaBTIhOhTUBjRkOJLDNEHPUZWpxPQU4SOVIM8JVNs07fc3FNigs/PoxFyZN6k8Mq7lhGnyC8DThgBABBUVeKeb4mRe6koYUJXnTbRpD38h0HbS184765SsBosYQf5oomLlQZROhE6ikWbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzqO0PADbf9G/ECcKjiHFaehLTJKSKdI7gtMY3xzMe8=;
 b=Enhlj9hGsxUDn3CsgmZOqR1/8QvKdZDCniQ/8Jjb4rrJ/1pLkg6afXHjHVs79TzSGi21NEpOxKcFi9fRJcLP/pRmYDUsjYeYiEwprdPbp0H/NhC+QmwY35qilj7xLgvAcjrQ5jDvnrUr+SpOVe4bv114MavmSRAplxxWpkQMpbzxSsZwVMmx0jP+CI2Pck/OP5gjmLWWloM6ejpx3qnrWrrkvSLDZIUkLbjOL+S8BCO/OAbg6wh71WOMrRaLCLfxKEnB2xiB9yOgrw4yX5kOEAJo6Ok6giz1mS/oHq13mclKiCZrQzbPbkaAFItR8AqXE0uDzLgYiiaSL98UIPvX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB7803.namprd11.prod.outlook.com (2603:10b6:8:f5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 08:19:34 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:19:34 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Randomness on confidential computing platforms
Thread-Topic: [RFC] Randomness on confidential computing platforms
Thread-Index: AQHaUF3eVzWxkihyOEqZjVbKjj5n1LDxAB+AgAADQICAACVkAIAAGUYAgAAKs4CAAAf/AIAADM4AgAAUrwCAAI5hQA==
Date: Tue, 30 Jan 2024 08:19:33 +0000
Message-ID: <DM8PR11MB5750A91026123C7766EB3B0BE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
 <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
 <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com>
 <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c>
 <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>
 <v6maadzwtke3z5ejp2mavsnm4mvmjbu7demvldzpobqeva74rx@r6y5fwxsyoep>
 <b3f48f9c-c1c0-47b5-b55a-d9cd63d86951@intel.com>
 <5861735E-8DE0-42D4-B7CE-E69F129CA7C8@zytor.com>
In-Reply-To: <5861735E-8DE0-42D4-B7CE-E69F129CA7C8@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB7803:EE_
x-ms-office365-filtering-correlation-id: 105f531c-8faa-4d70-e572-08dc216c30e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fTU9w+6KThlvYt2qUIeYLH+Dad8HE4GaF1DmnIs9KaOmNVeDcIaqPbTGnOXWrApXkOpxpjcO0MDbBUAiO1E6O1fDqFDAyltIcqGOn9uoZRzTLzyPx3P3BfhXuEFi7YOXt08CgDGN37K7ZwMxcZHvDvbyN4y5QSSbexkWNGUKXVvUeQnec85U50wsfPDScA2OQBltjCkCODwZE4P08NhjYNqURQ5s2Bt4+eu3OM3mCDwch0/UopqZKKqaeFVh6jLP+4y15msxevr5pMejuIlhim++tE7tn45yBU4MdmN6jJl/tTk4NfwyGTrJL4zxGE2O5KYr7Fka3BIBxwA+nd3OCPBcJqndRjBgCfmm6gHzThr/E3cnCtVA0tQ24y+FyTiJ7U5wElwzLXlnNA8Kn1DrC7A0bLXWhZhXpvvaPT6NapwoD8QAgABpVBh9tgX4rpbNkjyxemKwuGvb5TlwF13oBLl9pfwe1qpXE2WuzE8ckAlzrWow5rUwRFL2o2RYSpiawztwJdK/9yFktWDxlAxtpAtDq5kKKHp7sH92cH9OSF9JIIj8n1ysbWI2go6Nd0U8tUo9JjXUEtfDpoT/hYrYk1+C5zvtiZaJsUssIZKJxHJab51xTEkIHCvMXtvSclru
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(55016003)(83380400001)(6506007)(7696005)(86362001)(38070700009)(33656002)(82960400001)(5660300002)(4326008)(8936002)(41300700001)(71200400001)(122000001)(38100700002)(52536014)(316002)(110136005)(8676002)(66556008)(66946007)(54906003)(66446008)(64756008)(9686003)(66476007)(7416002)(2906002)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3NiOFc5Ym9ndVFCNityOTViUW1oYy93L2JSNWJKR3lrOEdWaDBUbGRBUmt1?=
 =?utf-8?B?TVZJUVF2L1RsdjlhZTgxNDU1b21TbnpHU0picmVZSGRmYWhCWFdvd1FrV2lK?=
 =?utf-8?B?c1JlNW4zM29KNnRSQUJMQmVVL1dML2srVWU4N3phUkJMdXdNczZ5WEV5aEFa?=
 =?utf-8?B?aW5RYWwydWt2Mmp3cE45Nzk4VzdJQ2RyNlVRZ3lSclJGdVRITWRDMkI3Z0xE?=
 =?utf-8?B?NmNHTFBsL3RiSWVWR3hYTmE2VmpsT05GcHFreEI0aEc5MW9CME16bm5UdkRi?=
 =?utf-8?B?RkhqcDV3Z3B6ZzBHdUh4WkQ1eUwzL2ZCVTBJanNRMVdhbUtCOWdrd0xDUG5J?=
 =?utf-8?B?NFdwMnE1VUd6YXNRdjJUcXZ2V05oUzVMcWN5dW9Ud0laSkpsVHJtVnhaV0l0?=
 =?utf-8?B?RmdpYXAwcnpwbEc0Z0ZWdXdLd2syWERXb2lTMmFMMWtrT2h5cCtUVWZtbVZ3?=
 =?utf-8?B?UXB6b3E1azJ4d2NEd1FUUTdrOGYwZlYrWTc1RkxPaVNiOVhPMVhDR044c2hG?=
 =?utf-8?B?cFFkL2x3c1E0SUlWdjZTSmlXY3Y4UFk0ZXgrOFllc3NjSGZ2cThKSG5hNDJw?=
 =?utf-8?B?Z2ZsYUk2aldId2IvVUFwcDlWY0RrTjYyWDFTNnZLK0FIbHkyZUZSUjVsbjBu?=
 =?utf-8?B?UzRsd000cXFTZUc5L0QvV2QwSHJBbFhmaXEvQVFoK1NEcWNjdGJ3aEpTRGJK?=
 =?utf-8?B?VVdFYU1kanBwYnRMcS94a29FdlFhajVhYVBYeG5lU0g4RUZ4QzJMV3BIRWNH?=
 =?utf-8?B?akQ2M1hHKzNVZUFCMnVhVTVCMEIyQWhtMmFUQjFXbDZrc1U0UTUva2NPRDc3?=
 =?utf-8?B?TDN5YzlHVHVNNXlpWHRSR0FMYm1taHFhL1JjVnVjZXE0TXYyOHVBVk5Da2xC?=
 =?utf-8?B?WVJ6NjJUTTBCU3MyY0lCVVpRSEFuK3IvWHQwUE5LUThWRjhJYlR3N2t1N2JV?=
 =?utf-8?B?cWo3UThvN1F2S0VoVGdMWHNQREo3Z0xGMjVsTDIxRnBxMVl3cURGWFpqYUxF?=
 =?utf-8?B?ZWRDekJZc1k2YUU1MkNsWlB6QkxnZk94clRFVUhUd3lGdkJvcmt5RTZzRlRr?=
 =?utf-8?B?MDBXOEJTQWxmaHBWTElVZ1dwVVRpVGREU2VGSDZGUWlpbHd5akF6VDdyMXRZ?=
 =?utf-8?B?Rnh5U2JablRhZEtnSWQ3MDNvdElNemE4bEFxZ1Zuc3V4Q2FqTmF6cGt3Z1BZ?=
 =?utf-8?B?RHg3RVdjNmNBV2dGWTJNd3dnWTZzN3Iwa0JXRnFlbktmRVhvMlBTMVdvMUlE?=
 =?utf-8?B?R3JWYlg3TnB0Q2tTUEE1ZWZKK0VLN2RHdC9ySVBsdHoybnNkSlpsdTlFNmgz?=
 =?utf-8?B?ckkvR1ZxS3cvMXJkNCtWeGFEUlo3TERBSmNsRTcyQk4wcHVVd1U2aEhuQy9a?=
 =?utf-8?B?Z2VNNzF1Z2ViMzhLRDloNiszVGN1VkU1aWxFTzRvNHoyTU1xNlJPTWNScnpE?=
 =?utf-8?B?OWRPVDlvTDBPc09QMGpLMDJXdWVFN2EwVmlMYXFpUHhyVC94MjRUMGlGUE55?=
 =?utf-8?B?cHR6N0oxREVnYjY1eUVsaHBMb2R3eGdHRTRCdHBrQ0Q4TElXbjVLYUdvNWFo?=
 =?utf-8?B?QWdLRWY5Z2xnTXJxczJibzhPcmVFNC9wejlGOVViei9DZmxYNTlkOHFGcFpW?=
 =?utf-8?B?ODZvMVFRTXQwdTVkeTE4Q3lzdWxIV0N1Z0FEbDdIem80ZFp2SG83cERrNklF?=
 =?utf-8?B?LzBCRTc1NDluaHdoWHlsMnBGQ2pYekpUTGdRZEJ4MTFOM1NuNXBGMEFkRjR1?=
 =?utf-8?B?VGhnZU04dzlvc3p3YmZiTktJWnBzZ1psdzd3NklOVkZRQStxNmFKQ1hCYkNW?=
 =?utf-8?B?cThQS0NMcTFldW82bVhLWnkyZ2tUSlBNUWJJVllrb2ZCMzMwdmhLVGtkKzBu?=
 =?utf-8?B?QnN5bWVLNmd6dCtFVnF6RVp2eHlHSm5OWmJEbVpFNkgwWVIwNHBMSXliRktT?=
 =?utf-8?B?dG5zN1ZqSG14S2x3dWlKUEFiKzlJYXc0M3QvczhJczFQdDZOTThLNUJxNlVH?=
 =?utf-8?B?UUpMV0c3RTJWOEg3Y1pESEZFR0pONDFMZ1ZFRGlma3VQT0tWZk1wVXBYWkVz?=
 =?utf-8?B?QjZYWit4b3NFUlBOdkV5RmJiajZQak9oV2xjdVdhN0kzRHB4anNRUHZjYS95?=
 =?utf-8?Q?xQp2liVgWI/MZW43rXSL3DwPu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 105f531c-8faa-4d70-e572-08dc216c30e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:19:33.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/x9Y2GQ6dGRCtxDLTmm1/p0Dybi91T1mOdrc7K+R55dvCZSIvsl6yLRw1j/yTho7n+pzHkysuDTZ8FxkcG9y6fIyJ9oPj2h1qWWuH+xE2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7803
X-OriginatorOrg: intel.com

DQo+IE9uIEphbnVhcnkgMjksIDIwMjQgMjoxODo1MCBQTSBQU1QsIERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+T24gMS8yOS8yNCAxMzozMywgS2lyaWxs
IEEuIFNodXRlbW92IHdyb3RlOg0KPiA+Pj4gTGV0J3MgYXNzdW1lIGJ1Z2d5IHVzZXJzcGFjZSBl
eGlzdHMuICBJcyB0aGF0IHVzZXJzcGFjZSAqdW5pcXVlbHkqDQo+ID4+PiBleHBvc2VkIHRvIGEg
bmF1Z2h0eSBWTU0gb3IgaXMgdGhhdCBWTU0ganVzdCBhZGRlZCB0byB0aGUgbGlzdCBvZiB0aGlu
Z3MNCj4gPj4+IHRoYXQgY2FuIGF0dGFjayBidWdneSB1c2Vyc3BhY2U/DQo+ID4+IFRoaXMgaXMg
Z29vZCBxdWVzdGlvbi4NCj4gPj4NCj4gPj4gVk1NIGhhcyBjb250cm9sIG92ZXIgd2hlbiBhIFZD
UFUgZ2V0cyBzY2hlZHVsZWQgYW5kIG9uIHdoYXQgQ1BVIHdoaWNoDQo+ID4+IGdpdmVzIGl0IHRp
Z2h0ZXIgY29udHJvbCBvdmVyIHRoZSB0YXJnZXQgd29ya2xvYWQuIEl0IGNhbiBtYWtlIGENCj4g
Pj4gZGlmZmVyZW5jZSBpZiB0aGVyZSdzIHNtYWxsIHdpbmRvdyBmb3IgYW4gYXR0YWNrIGJlZm9y
ZSBSRFJBTkQgaXMNCj4gPj4gZnVuY3Rpb25hbCBhZ2Fpbi4NCj4gPg0KPiA+VGhpcyBpcyBhbGwg
YSBiaXQgdG9vIHRoZW9yZXRpY2FsIGZvciBteSB0YXN0ZS4gIEknbSBmaW5lIHdpdGggZG9pbmcN
Cj4gPnNvbWUgZ2VuZXJpYyBtaXRpZ2F0aW9uIChXQVJOX09OX09OQ0UoaGFyZHdhcmVfaXNfZXho
YXVzdGVkKSksIGJ1dCB3ZSdyZQ0KPiA+dGFsa2luZyBhYm91dCBhIHRoZW9yZXRpY2FsIGF0dGFj
ayB3aXRoIHRoZW9yZXRpY2FsIGJ1Z2d5IHNvZnR3YXJlIHdoZW4NCj4gPmluIGEgdGhlb3JldGlj
YWxseSB1bnJlYWNoYWJsZSBoYXJkd2FyZSBzdGF0ZS4NCj4gPg0KPiA+VW50aWwgaXQncyBjbGVh
cmx5IG11Y2ggbW9yZSBwcmFjdGljYWwsIHdlIGhhdmUgbXVjaCBiaWdnZXIgcHJvYmxlbXMgdG8N
Cj4gPndvcnJ5IGFib3V0Lg0KPiANCj4gQWdhaW4sIGRvIHdlIGV2ZW4gaGF2ZSBhIHByb2JsZW0g
d2l0aCB0aGUgImhvbGQgdGhlIGJvb3QgdW50aWwgd2UgaGF2ZQ0KPiBlbnRyb3B5Im9wdGlvbj8N
Cg0KWWVzLCB3ZSBkbyBoYXZlIGEgcHJvYmxlbS4gWW91IGNhbm5vdCBidWlsZCBhIHNlY3VyZSBy
YW5kb20gbnVtYmVyIGdlbmVyYXRvcg0KaW4gYSBzaXR1YXRpb24gd2hlbiBhdHRhY2tlciBjb250
cm9scy9vYnNlcnZlcyBhbGwgeW91ciBlbnRyb3B5IHNvdXJjZXMuIA0KTGludXggUk5HIGhhcyBt
YW55IGVudHJvcHkgc291cmNlcyAoUkRSQU5EL1JEU0VFRCBpcyBqdXN0IG9uZSBvZiB0aGVtKSwg
YW5kDQphcyBzb29uIGFzIHdlIGhhdmUgYXQgbGVhc3Qgc29tZSBwcm9wZXIgZW50cm9weSBpbnB1
dCwgeW91IGFyZSBvayAoSSBhbSBncmVhdGx5IA0Kb3ZlcnNpbXBsaWZ5aW5nIHRoZSBSTkcgdGhl
b3J5IG5vdykuIA0KV2hhdCBjaGFuZ2VzIHdpdGggY29uZmlkZW50aWFsIGNvbXB1dGluZyBpcyB0
aGF0IHRoZSBlbnRyb3B5IHNvdXJjZXMgbGlrZQ0KaW50ZXJydXB0cyBvciB0aW1pbmctYmFzZWQg
aW5mb3JtYXRpb24gY2FuIGJlIHZpZXdlZCBhcyB1bmRlciBhdHRhY2tlciBjb250cm9sDQovb2Jz
ZXJ2YW5jZS4gQnV0IHRoaXMgaXMgKm5vdCogaG93IExpbnV4IFJORyB2aWV3cyBpdCBieSBpdHMg
dGhyZWF0IG1vZGVsLg0KU28sIExpbnV4IFJORyB3aWxsIGJvb3QgYW5kIHJ1biBqdXN0IGZpbmUg
aW4gYSBjb25maWRlbnRpYWwgZ3Vlc3QgaW4gc2l0dWF0aW9ucyB3aGVuDQpSRFJBTkQvUkRTRUVE
IGFsd2F5cyBmYWlscyAoaXQgd2lsbCB1c2Ugb3RoZXIgZW50cm9weSBzb3VyY2UgbGlrZSBpbnRl
cnJ1cHRzL3RpbWluZyBpbmZvKSwNCmJ1dCB0aGUgcXVhbGl0eSBvZiBpdHMgb3V0cHV0IGJlY29t
ZXMgcXVlc3Rpb25hYmxlIGFzc3VtaW5nIGhvc3QvVk1NIGlzIG91dCBvZiBUQ0IuIA0KDQpJIGhv
cGUgd2UgY2FuIGdldCBhbiBvcGluaW9uIG9uIHRoaXMgZnJvbSBtYWludGFpbmVycyBvZiBMaW51
eCBSTkcuDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLiAgIA0KDQo=

