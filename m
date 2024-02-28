Return-Path: <linux-kernel+bounces-85175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD8986B1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779B91F27797
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38731586E9;
	Wed, 28 Feb 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFMHoHV7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB9157E9C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130152; cv=fail; b=Nt9Cyln+7C35GcV4ASBYaCOKOsjDcVsEuLUHPMjoFvJjdKNJSqu0alej06WpaGCiomVl1R5p1ga983zvWoKAaX14AKM8l/jgsoERccAeHnZjd5flrEWfaQm/nILSZNuOyRcKBx+D3XBkB0fVz43Xp6DzignadDFxfmgx1pcaScs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130152; c=relaxed/simple;
	bh=0QpVDRjwcmIgTYsx75xnuKd5iQsBIyQ5DxHTefIm7WE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5bldsaeN68RDLPul5yQB1f7XIrRUrp9aR/pgUz8mPkQ1VBKvzm0lpBj6s9FtPEONZHmtdW9zPrmRpZcsdF/zDVxJTBrZdSIEpDGPZutm/47n0Kx7ARqkP4ECqgJmZgqiXraLkBvA2g3WQhJj3fw7Dk+Jji/9Nuf2frD6VeYRW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFMHoHV7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709130151; x=1740666151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0QpVDRjwcmIgTYsx75xnuKd5iQsBIyQ5DxHTefIm7WE=;
  b=LFMHoHV7K3O+fEQiEEWBn7j2yYGG7WBns0Q8xc/zO218JOIFGY15OXlt
   /dMIapKq3Ew/AKgI8OihkXkzS7NUK0Qs+iVgLliKT5A+f+leneCF24zGa
   8HP9/7p3D4Cw/vyOQV0+HBzW8960+H6dHEBp5A/+qa0zpYTYnbxHPhs7v
   wzXIqnePknTFIJx+Eo8/WbrjPDV1NKHoFdl/kC8J7xyJbAke1Y31BWO9N
   1kQCAkT1veTlSYzGrmAeVbUd4p04aNE/xZlZi/RKh9A37ngK5Jb08dr39
   F6b3fKoRZ5XZ3xPh7KASgbXVX8qYrVz+Pej0s50cmvhMATYgsheviNc0n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3691518"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3691518"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 06:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="30634276"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 06:22:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 06:22:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 06:22:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 06:22:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 06:22:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSX1EB9lD7T0geoI2jun7bRfDR2zr6X06PZ8yvXy3rv8LqQ9tEsl3tZh+5R1Bt6y2RZ9oldNd0XArRxNOQFSez6J56bHHmLnpvW5/Ggn5Q5+AfU2SvNLsI3nOjwf2ryZjW+EYD5Ibaoq50SQeMYpKwo6SA0pYCIMDKnG3sXkvrjaK+/szlLDIjx3IP9dFJ8/YGR+DnbUlfOUYjchsUkjWYNgV6BEblVqeSD/xEUVju2hLApROQRLRm09oCL/6fupF+z+DDp519LnvQPnBcyBHQ6d6Qx280/8WajMzJ1os745Pnl5J29+IE1zBThCGvVe1OEUsVwP95+Ta9WgWeqKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QpVDRjwcmIgTYsx75xnuKd5iQsBIyQ5DxHTefIm7WE=;
 b=GS31W1DXlZFjGHrNbisGyHEUvEiVDeKPiDY4jYM6ammkFZoTOIIhZBKbcDvVjaEninz/r14nW4gK4GwKc5gnepyLshsj0rz5d9To0ojRrYkGFdObdaZTT5H+B1TX0yitYgMeJJJBiIPh7SiPKCdrnNNRTaYek6EsSTrmMjJRICXrDbJnKObXmnPDhi0nFocyITjCwkCOV6ddrHniUjxzSgBDA59G58no2aJ8Cu3Q2Mr2xOGlVN8A0tScF/xj4Mh2rNHWESTd71cvkiF6xyqwXrHptcLJZAJ99btV3ww0NFWQZl60IecNmRAbkJOiyGYYXJnL1nszRoCGmH3ktHwOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Wed, 28 Feb
 2024 14:22:27 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::d5d6:c0cc:baae:1ba6%4]) with mapi id 15.20.7339.022; Wed, 28 Feb 2024
 14:22:27 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang,
 Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC][PATCH 06/34] x86/boot: Use consistent value for
 iomem_resource.end
Thread-Topic: [RFC][PATCH 06/34] x86/boot: Use consistent value for
 iomem_resource.end
Thread-Index: AQHaZb806882M9XHJ0yQDRL29GQfQLEeDLKAgAHK3gA=
Date: Wed, 28 Feb 2024 14:22:26 +0000
Message-ID: <90e18fe107fe602cc187a5e6a3523714a09a5880.camel@intel.com>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
	 <20240222183934.033178B5@davehans-spike.ostc.intel.com>
	 <195ad815f14b71c46de94281f0af57027b4e3fff.camel@intel.com>
In-Reply-To: <195ad815f14b71c46de94281f0af57027b4e3fff.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: f544bd02-abff-4c1f-9c82-08dc3868b091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4gHDXIRLK47DaS8tO0nvHjojUn8429sytfEceIM4ToeIYoliZ/46aBA6xSKrX2ZU3DqlGYgz0cnAYEnfnhHmQRe1JP0qTgynEBoIQAFhi7YIUFrrCpr6TVoRFoE2R5nDWLk/qJQYeti6EQjb0KI6noTU53KWrzeiBBttdjRzTA+Uc7JVbYud1XQTdP6Z2ykfXGhpb/wSbox/qCIcWY/pwC8C6Ot19JEWezP24fjGVcYyurDGMhM66ksvA3VTP6LbU3ralCmLUD3gr3if6Uq9N6FOrSnLNNec7gYo8AMB0d/n2Y5Cv5jB4brjcIH05VE7y20Fm+87m/MdqmwKK0griVn03ixt90JEe3a/xshT4HNmLu37yidTEJqh9VoeEHoYE3dn9gPri68r/fnWhSAe791V+OOI7OviRb5Q9jATPNwB7ugVZr5LbyKD8myyGuxW13SCQU9gkHN6V7aSk3E90BBOqYCGJVryVUVTgOGJ8jIUMZh4Z5drwkFaDxotrMcOIRj7zuBvtKanlfWwUAdepBanvTQPL5gQHI0d/2zlfZSXJD8CtzkkPE1ngbh6871EgyZNqHGmOwqBeFO8MCMlwy8PWxYxagZIGHLrN9YJmCNZMTSZObIf7qySIy1u9xf2kj2MYkWF/ehwxCqOfQadE4WTeifsNRcWILrmHIgSTec84WmQhwk1xmsODdH0XPDzhBLS7D0Gbz/nG/g5Ywofg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlNSd2ZwY2hDTC9hVnZjTXUxNkhDNkJVSHZPejQvTmMrRWQwaUtualJxclVv?=
 =?utf-8?B?V3pQTzVPaTJGb0xPa01ramJoU3N1T0haWG5WOXZob2FPK1M5R3BvRzJGL25r?=
 =?utf-8?B?MXNBMnUyLzREbm5scjBrSkFDTndrQTFOWHNJWmpYZkVTK0pWN3JSYlVTbEdX?=
 =?utf-8?B?NHdxZ1lUQml2ckd2SVF1dWJVSlJVa0RoNDJZWmViVVhWeVQ0TmY4TnV4OHJx?=
 =?utf-8?B?ZE5LaUQxRzRudmNZOFlFVmxpdy90QXdiNThxK3o5OWxvd081aGFnc3QyM2lh?=
 =?utf-8?B?THVlN0RiZE5DRFpiQzZ0N25hVTFYdWQvYmF0cEFWZnp2NVdjNndxOVdvU1Nl?=
 =?utf-8?B?UjJEcVlRSXFzbUtqaWkrUENnYUdMNDZuYTEvMzhwZXVUQTBjSnEzNHdQalRq?=
 =?utf-8?B?VXZhTEZacm1lcCtSVFRvUWZ3dTF4NmNSYUJnWEhaNXlzSWdhNlk5N2VZa3hF?=
 =?utf-8?B?a1NFbTMwQzRpVG0vVlJjVVBxM2k0L2xON2VNdTdicFpVeVZqNzgzYUIyOEln?=
 =?utf-8?B?UHFvcjNtSjJRaUJFRTVjc0ZIQ3hZUi9TVk9TcTBvNnJ6NjlBWG8wM0RLcitQ?=
 =?utf-8?B?cEthUXBwZ2ZKVDdJK0YxZmZvajZtUlRsV2Mvd3JtYzJwd3JiblpOcW50bjRY?=
 =?utf-8?B?d1lMTG1WYkZseERzRWEzMFRXNUR3a2JZb2FIS2N6d1hrejdWcC8zcWF0NytV?=
 =?utf-8?B?SkpKNWFIR0s2cktyaXJsTVMyVlVYaWNnTm9WT011WFBnZVNJSE5FbFRXeU4v?=
 =?utf-8?B?MHBkOURKT2plNFlUQjlGL1RkZkRnbXM2TWhBMG04b05VOFp2YVc1VS9MbzNt?=
 =?utf-8?B?b21YVXI3SVN6dlQ5S1AwaXIwYmY4TWFYaldFbXNPeDFWY2lVOEJObFNZTHp1?=
 =?utf-8?B?QVJDdkEvTFJVRnEzZWxSdXBRQlRLYWY1dW5Pa3VnYUtNSkZTeFREMzFJenJR?=
 =?utf-8?B?aUk2MjZ3bmV3MUxSUllxWGlyL000ekZyYVZmY1FiWkRhTnVDMERYNGdicDZU?=
 =?utf-8?B?K09jcWltSW85K3l3aSs5amtNTEtVNllqeno3bWlrZjc3N3VCS3N1TlorRVNY?=
 =?utf-8?B?b3dQUHc1RCtYWitYY3ZRMFByRHZETTFtZ2tybmVtM0phOEVPUlhCNXJZaWlJ?=
 =?utf-8?B?alJ3bEJFd0I3R1pROE9lUHRneFF0MVUrWlFWNjdDdUpqVCtzYkYrc2lBT0Zk?=
 =?utf-8?B?cUw0Mk1MUC92bEhpazhheWpIYW5PUlAyN1Z5QzMvbFIxdDNlTXdNc2pBVkd4?=
 =?utf-8?B?V29BdUNyYXlNNTgyaHIzNGk2ZURQQzBQaUl3SnFsR284NzJsVVNMQ1lvNlN0?=
 =?utf-8?B?bGYwRGlBM1VSQ3lwWXJ3S3dDZkR4WnhBaUUwbjIrSFJKeG4xQU5wMWlWQ0Nk?=
 =?utf-8?B?ZGVJM3hWaG9XVkFZYmtSSnZKd0Jqc2tJanIxaVFaNWZxU3RTM3M5dlM4MDFH?=
 =?utf-8?B?Q3JRazkxOXNhdTBSWWhsbnovY3EzTE1wRVlPeFY0NWU5QlQ1SFJoUldYbW05?=
 =?utf-8?B?cVhXVTNONERpRVIwMnllT2kwc2dwVTFKOFd3aC9rUTFrOE5lV0JjZzNkR3FB?=
 =?utf-8?B?eGxoZWUwcm1zUmxxdjVvcXpkWUthb255RTBHam16UDdPNzd3NU9ERkNRYnc3?=
 =?utf-8?B?dWhVSG9ZdWhwcVo0UGZielNlYlBOTHY3Uk5sM1RGdXRCR3AyZ1lHMTQ1OSsw?=
 =?utf-8?B?L21nNlB1R3VZQzhNSHM5NjBaRDZHZlh6ZmFnOHFEY2I4aFJiRitzd1c1UkNj?=
 =?utf-8?B?anZhQ0x2dDIzM05URGFEU1RjbVdCQWIwS3FhTDlUa2tlajFHa0hYQ2tZVUZX?=
 =?utf-8?B?WVc0THZYQXpsQm1wSXZVZTc1a1dHUjhQblJrbGxBRmpCSUlpRzcwbHg3eGpK?=
 =?utf-8?B?Nys2UktqRDk4eW5weEp3Y1A4MjlDTjU4SkJSbTZQSVk4UXJmZEdLcFBOZXNM?=
 =?utf-8?B?NXJyTmxOQkpFVC8vd3NQZGVjTElaOXBPZ1RybWpyZ1Npbnh4bmVscmVmZTFv?=
 =?utf-8?B?M1lXYlo2QUhkWnpUTWUyQzEvTU1pSGgrVWFIaEFVSDNDdnAySHBrY2w3VVc0?=
 =?utf-8?B?eE9GRXBDZnRtb0pmbXBwQjJ2WlowRGk5dmRvOFQ0TjhJM3FQMms5RnNmOXB4?=
 =?utf-8?Q?8RHrzTFDxbf2sQK4s9v52PtpJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C013E9A7CCE9834D89015CAD0B4CD993@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f544bd02-abff-4c1f-9c82-08dc3868b091
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 14:22:26.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LPd5RsTxJw4HXDA5tKscbSGZpoWgAeimJq5Qr7TafdBAqJtXRNO4yLb8p8ajLHzkpcdrtFHJkMPtBOY+NWnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTI3IGF0IDEwOjU5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjQtMDItMjIgYXQgMTA6MzkgLTA4MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+
IEZyb206IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gDQo+
ID4gVGhlICdzdHJ1Y3QgY3B1aW5mb194ODYnIHZhbHVlcyAoaW5jbHVkaW5nICdib290X2NwdV9p
bmZvJykgZ2V0DQo+ID4gd3JpdHRlbiBhbmQgb3ZlcndyaXR0ZW4gcmF0aGVyIHJhbmRvbWx5LsKg
IFRoZXkgYXJlIG5vdCBzdGFibGUNCj4gPiBkdXJpbmcgZWFybHkgYm9vdCBhbmQgcmVhZGVycyBl
bmQgdXAgZ2V0dGluZyBhIHJhbmRvbSBtaXNobWFzaA0KPiA+IG9mIGhhcmQtY29kZWQgZGVmYXVs
dHMgb3IgQ1BVSUQtcHJvdmlkZWQgdmFsdWVzIGJhc2VkIG9uIHdoZW4NCj4gPiB0aGUgdmFsdWVz
IGFyZSByZWFkLg0KPiA+IA0KPiA+IGlvbWVtX3Jlc291cmNlLmVuZCBpcyBvbmUgb2YgdGhlc2Ug
dXNlcnMuwqAgQmVjYXVzZSBvZiB3aGVyZSBpdA0KPiA+IGlzIGNhbGxlZCwgaXQgZW5kZWQgdXAg
c2VlaW5nIC54ODZfcGh5c19iaXRzPT1NQVhfUEhZU01FTV9CSVRTDQo+ID4gd2hpY2ggaXMgKG1v
c3RseSkgYSBjb21waWxlLXRpbWUgZGVmYXVsdC7CoCBCdXQNCj4gPiBpb21lbV9yZXNvdXJjZS5l
bmQgaXMgbmV2ZXIgdXBkYXRlZCBpZiB0aGUgcnVudGltZSBDUFVJRA0KPiA+IHg4Nl9waHlzX2Jp
dHMgaXMgbG93ZXIuDQo+ID4gDQo+ID4gU2V0IGlvbWVtX3Jlc291cmNlLmVuZCB0byB0aGUgY29t
cGlsZS10aW1lIHZhbHVlIGV4cGxpY2l0bHkuDQo+ID4gSXQgZG9lcyBub3QgbmVlZCB0byBiZSBw
cmVjaXNlIGFzIHRoaXMgaXMgbW9zdGx5IHRvIGVuc3VyZQ0KPiA+IHRoYXQgaW5zYW5lIHZhbHVl
cyBjYW4ndCBiZSByZXNlcnZlZCBpbiAnaW9tZW1fcmVzb3VyY2UnLg0KPiA+IA0KPiA+IE1ha2Ug
TUFYX1BIWVNNRU1fQklUUyBhdmFpbGFibGUgb3V0c2lkZSBvZiBzcGFyc2VtZW0NCj4gPiBjb25m
aWd1cmF0aW9ucyBieSByZW1vdmluZyB0aGUgI2lmZGVmIENPTkZJR19TUEFSU0VNRU0gaW4gdGhl
DQo+ID4gaGVhZGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gwqBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3NwYXJzZW1lbS5oIHzCoMKgwqAgMyAtLS0NCj4gPiDCoGIvYXJjaC94ODYv
a2VybmVsL3NldHVwLmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMTAgKysrKysrKysrLQ0KPiA+
IMKgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtcHVOIGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jfmlvbWVtX3Jlc291cmNlX2Vu
ZA0KPiA+IGFyY2gveDg2L2tlcm5lbC9zZXR1cC5jDQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVs
L3NldHVwLmN+aW9tZW1fcmVzb3VyY2VfZW5kwqDCoMKgwqDCoMKgwqDCoDIwMjQtMDItMjINCj4g
PiAxMDowODo1MS4wNDg1NTQ5NDggLTA4MDANCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0
dXAuY8KgwqDCoDIwMjQtMDItMjIgMTA6MjE6MDQuNDg1NTMxNDY0IC0wODAwDQo+ID4gQEAgLTUx
LDYgKzUxLDcgQEANCj4gPiDCoCNpbmNsdWRlIDxhc20vcGNpLWRpcmVjdC5oPg0KPiA+IMKgI2lu
Y2x1ZGUgPGFzbS9wcm9tLmg+DQo+ID4gwqAjaW5jbHVkZSA8YXNtL3Byb3RvLmg+DQo+ID4gKyNp
bmNsdWRlIDxhc20vc3BhcnNlbWVtLmg+DQo+ID4gwqAjaW5jbHVkZSA8YXNtL3RoZXJtYWwuaD4N
Cj4gPiDCoCNpbmNsdWRlIDxhc20vdW53aW5kLmg+DQo+ID4gwqAjaW5jbHVkZSA8YXNtL3ZzeXNj
YWxsLmg+DQo+ID4gQEAgLTgxMyw3ICs4MTQsMTQgQEAgdm9pZCBfX2luaXQgc2V0dXBfYXJjaChj
aGFyICoqY21kbGluZV9wKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiDCoMKgwqDCoMKg
wqDCoMKgZWFybHlfcmVzZXJ2ZV9tZW1vcnkoKTsNCj4gPiDCoA0KPiA+IC3CoMKgwqDCoMKgwqDC
oGlvbWVtX3Jlc291cmNlLmVuZCA9ICgxVUxMIDw8IHg4Nl9waHlzX2JpdHMoKSkgLSAxOw0KPiA+
ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogVGhpcyB3YXMgdG9vIGJp
ZyBiZWZvcmUuwqAgSXQgZW5kZWQgdXAgZ2V0dGluZw0KPiA+IE1BWF9QSFlTTUVNX0JJVFMNCj4g
PiArwqDCoMKgwqDCoMKgwqAgKiBldmVuIGlmIC54ODZfcGh5c19iaXRzIHdhcyBldmVudHVhbGx5
IGxvd2VyZWQgYmVsb3cNCj4gPiB0aGF0Lg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIEJ1dCB0aGF0
IHdhcyBldmlkZW50bHkgaGFybWxlc3MsIHNvIGxlYXZlIGl0IHRvbyBiaWcsDQo+ID4gYnV0DQo+
ID4gK8KgwqDCoMKgwqDCoMKgICogc2V0IGl0IGV4cGxpY2l0bHkgdG8gTUFYX1BIWVNNRU1fQklU
UyBpbnN0ZWFkIG9mIHRha2luZw0KPiA+IGENCj4gPiArwqDCoMKgwqDCoMKgwqAgKiB0cmlwIHRo
cm91Z2ggLng4Nl9waHlzX2JpdHMuDQo+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gK8KgwqDC
oMKgwqDCoMKgaW9tZW1fcmVzb3VyY2UuZW5kID0gKDFVTEwgPDwgTUFYX1BIWVNNRU1fQklUUykg
LSAxOw0KPiANCj4gUGFvbG8ncyBwYXRjaHNldCB0byBtb3ZlIE1LVE1FIGtleWlkIGJpdHMgZGV0
ZWN0aW9uIHRvDQo+IGVhcmx5X2NwdV9pbml0KCkgd2FzDQo+IG1lcmdlZCB0byB0aXA6eDg2L3Vy
Z2VudCwgc28gbG9va3MgaXQgd2lsbCBsYW5kIHRvIExpbnVzJ3MgdHJlZQ0KPiBiZWZvcmUgdGhp
cw0KPiBzZXJpZXM6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2VmZjM0ZGYy
LWZkYzEtNGVlMC1iYjhkLTkwZGEzODZiN2NiNkBpbnRlbC5jb20vVC8NCj4gDQo+IFBhcGxvJ3Mg
c2VyaWVzIGFjdHVhbGx5IG1vdmVzIHRoZSByZWR1Y3Rpb24gb2YgeDg2X3BoeXNfYml0cyBiZWZv
cmUNCj4gc2V0dGluZyB0aGUNCj4gaW9tZW1fcmVzb3VyY2UuZW5kIGhlcmUsIHNvIGFmdGVyIHJl
YmFzaW5nIHRoZSBjaGFuZ2Vsb2cvY29tbWVudA0KPiBzZWVtcyBkb24ndA0KPiBhcHBseSBhbnlt
b3JlLg0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIGJlbG93IG9yZGVyIGlzIGFsd2F5
cyB0cnVlLA0Kc2V0dXBfYXJjaCgpDQoJZWFybHlfY3B1X2luaXQoKQ0KCQlnZXRfY3B1X2FkZHJl
c3Nfc2l6ZXMoKQ0KCWlvbWVtX3Jlc291cmNlLmVuZCA9ICgxVUxMIDw8IHg4Nl9waHlzX2JpdHMo
KSkgLSAxOw0Kd2l0aCBvciB3aXRob3V0IHRoZSBhYm92ZSBwYXRjaC4NCg0KPiANCj4gUGVyaGFw
cyB3ZSBjYW4gZ2V0IHJpZCBvZiB0aGlzIHBhdGNoIGFuZCBqdXN0IHNldCBpb21lbV9yZXNvdXJj
ZS5lbmQNCj4gYmFzZWQgb24NCj4geDg2X3BoeXNfYml0cygpPw0KPiANCkFncmVlZC4NCg0KdGhh
bmtzLA0KcnVpDQo=

