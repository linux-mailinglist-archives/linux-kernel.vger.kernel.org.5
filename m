Return-Path: <linux-kernel+bounces-108411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3254880A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437571F22F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8BE11721;
	Wed, 20 Mar 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgkFZL45"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5551170B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906162; cv=fail; b=qf2nc8zBfXOtNCpHGOhMCwq/7ZbxgzIYETHphfmQac4QUiIg/dpe8W7aj8xTKpuqIIdf9zV0T3RmCwneFagQkn7A/Ck/68fLeSc1Q18y3++qbfrBA8MUzOr5awWIDv09lKGnFiKc6nyfZjxFOKrEbrLpQajUXtibe7gbt7COflI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906162; c=relaxed/simple;
	bh=oM/pgPZR4S8yCDTBf+9oVAxpSEtdqEP+xBNi+LVGQlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liC7TDdt3yyZM0zevgXWfud4wYcIU5PaavIJTBJWGjasES+UpnZPW2sE00cAmL4CQ2TfMEpJTL+lh2+HFePeIC4w1wcdtQ8s2SsUItpIwSP68QU8wotAnw0FBIlyyzrG2PBF9IEHEj8jQl2ZD28lpd+JIVWU//4L0qKCmJv/YXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgkFZL45; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710906160; x=1742442160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oM/pgPZR4S8yCDTBf+9oVAxpSEtdqEP+xBNi+LVGQlY=;
  b=bgkFZL452CrjRwHR9gWu/kxaH8/lQ0rGCMSoAy1b1az6qnkXcWjkCAp7
   sbIz6FWxGHLcaSOHwLiO5h6CDnKuP4xyh+ShJXh/ESGdu2l307wfRy+O1
   pr7/dahDUSh1mwVvZLK2w455COUBZJIvUuCLL2sPkS/leZfsBlpcG/yUq
   albxFQJibOXUbm17uYNhMndmPHL38blnDdR3Nzz5uvNas8UIxJs4nFbQY
   ymzSHxH6tJSrEDu1BZoTJuunnJV/RrgefjzeNijZ18U0hfNlHsZQLRUYw
   Afqxv6IT73d4xm5HNHBUv2QnDcw2DKEW2a8ifbq3hGlFUZtal1iXu039b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16547624"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="16547624"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 20:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14676652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 20:42:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 20:42:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 20:42:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 20:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRNdY71/PPF3eZV1gq7h64B/rV5oerxgwpOSNVZ1nZppirJjUKY0iK3dsb+ofLo2CSBQf4t5Sef02BDvk8ETabKlw1ftE8nQdnbAcgpHk/PjMtDDf3cZIVmhwjQqENqpmAk+PqFzgJ34r0jrWTAjctKBNZd/qwJ6HjCRSC6x6WSSjoMnt91zZHREUHnTPOlIlP7Isny2/w9pObmxqaykkvHkv/LSEH7ionSaUMKR8DkmzsYmmmZ2pj6/Mn7SS+syBERB2IIipY1jvZ0dLjwL0GGhF5Za8AKsPBJdLWp9E4TxdknPfRoyow6dYCj95h7Vr3BEb7sCO5+wCGl4EleqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM/pgPZR4S8yCDTBf+9oVAxpSEtdqEP+xBNi+LVGQlY=;
 b=iQiG0I7624rB0xO1Hk0IKxKaCYhaUhwwqxZaOJ8gbCsASrKd860ZJUxb4vgKqLHF1i7ap7iBgDIUHSfjfNzcagWODR9lZLFo4vvK4TvkOIw24InqcL5aClrY7gdO4Lzt+SpQcamRkiWt5bzWJusy5BYaDtMbDrRAP5BdtYTV+gLBBQyx1NAqruV8ixQmhf5+dHvPDV/shCngLBlu4V9GuhWNX21cGUf7xpmVMRYAOx1zAODWEcGkOrx+iZdOXFVhQ18O9GtpFuAr7TA2oDAyD1sLQ+VmAX2bFM1sXvBg5GuNazNC44i1uGnQ7vE02jh4z/vxNGqTwHnJ+503czG5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 03:42:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 03:42:30 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/coco: Update comment of CC_ATTR_GUEST_MEM_ENCRYPT to
 include TDX guest
Thread-Topic: [PATCH] x86/coco: Update comment of CC_ATTR_GUEST_MEM_ENCRYPT to
 include TDX guest
Thread-Index: AQHaekWyMqZIqx9SSUOir7EVtvp/tLE/xNKAgAA35QA=
Date: Wed, 20 Mar 2024 03:42:30 +0000
Message-ID: <f44a41c56473b603f5ec90b6e7c751a253dab720.camel@intel.com>
References: <20240319213729.81708-1-kai.huang@intel.com>
	 <yeccimxym65c7c7pwwwyvednydhj54dbrcpa6nqobc27kud32u@rgivuknucjus>
In-Reply-To: <yeccimxym65c7c7pwwwyvednydhj54dbrcpa6nqobc27kud32u@rgivuknucjus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH8PR11MB6610:EE_
x-ms-office365-filtering-correlation-id: 2bd95d67-95ce-45d0-74b7-08dc488fc55b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Flf+dWQbl8LYea0+YgXoo5Mkir+4KbLF8WW+ViqATiADURrdf4zPZ5bzNzAL+F7Y0vgTUXO9vj4XYWxgMeHc0uicCrdcYfRRUTb79uuaAswlbGNuT98SXLYzyMNe6lWz7zsktKYMO1bZhSyzSYURz0Km9fXeag4LnR1NO9BM+tO1XqRsDGs5a7VEi/M+Lxcuxmqsjxy4x5oALER8rUE3qN63a6p/503V1ZxJjtDfR+ThXYVhgSRZTmHmNF1KS2J4AgYYtIXkA05IQIiKlqTAkMR+aTN5MklfpUBO5zYi+pa5/wOmSyq1ZTCs5FvuSNyV14LcuC0g/AZLUaF/bhL8S9bSRsbxKNaFtQXzPL7iAQ7lKej3bXr/ACQwSvj6bzUvjJzDy3X54RjDezcydVgfdbFQ58J3N9eWcsmtpw5NJcu37nqZoiW33aN7zikYpg+Xzvk36udSLTdknl23fowqAWq25q5KA4UZmzH3QwQFL2bvB2WwoX2ZimK5ZmnMVno7ug0Cwj2iK0+VeQFwC1uB8HPlkkbq5GgEiPef0wtND+NetZ4lFM3WEN010cH3fRc4W3vppNfTQxqbQLv3CLVQnT/9SiXEDNS8fjzpRk5c9FJMyZuIgeu+pjkHGQIKnQXeVavLVawUzM0MMiKe1B76BZ8hiED4tyDAGFKAHmOHmJa6rTahhlWcu5+Y5xJbIx/xcvsayRTKueQYkvrRVLfBVwVrhsszxc0CSIGWov9+87s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk90RVRBcHFXVnVsV2k3TjhNUC9MSjlzS05zbGE4cjYwVFkwSmF1TjVmNWJi?=
 =?utf-8?B?MEVzZGpSMlN1aEh4dWpJMGxkRmgzWHJpUjdPeU1oQTI2a2lFOE9rc3BaY1cy?=
 =?utf-8?B?THNLNjBpbHR6WmFrY2lMV1dTcW1zNXRyeDIrY3JOMTh6RndiRjJjMjNtNWNO?=
 =?utf-8?B?THlpWXZKUmpMd0Z4endpY2YxV3JERDF3bFliMEhLYUlPOEZncytwSGVqSkRQ?=
 =?utf-8?B?UmRyZ1Z3S1loclUxT3VGQUtzOXNYM1M3NWE3SW40TDByRDZVUCt1a3lLKzJ3?=
 =?utf-8?B?aTRGODZzRER4ZStQNTRuK21DOENQQ005M1dNQnplMGhXTW9uY21kbFpTTmNE?=
 =?utf-8?B?RUxYVjhscnJUNDJ0QmswbjRTSXp0OWN1OTFTMFNqY2QyL2hSQXpSekxBVTB5?=
 =?utf-8?B?OFVkZlI0dE5jTHRHY2NUR1hNaTMzQWR0azArNzNDTE5FdTEzNWFONkF0YnFt?=
 =?utf-8?B?Wlg3dk5Xc0dIMnAzSTNuZXRsRWhHakFZbjBjTWJPUG5Ya1lVV2Y2aFBUSXJv?=
 =?utf-8?B?Y1JEOXQ5QVZNaUhMMDhlM0d0L0VId0pnd1Rqc3FOZVRyY05jNm0rL1RzL3pq?=
 =?utf-8?B?clVZeE94K0VrbUc5WmFCSlcwMjYwaEpPaC9HMWk0dWRjYm4wS21Cdk5xamJJ?=
 =?utf-8?B?MWhxdEZkaGJSUGJMRys4eU1kaDBIY054UUdtbnR1bmtOQS9LUVgycjdHQ3J3?=
 =?utf-8?B?a1RBWlp4dDVodmozNXprVTQ2UmhxQm10UlNrVEQ3U244R3JPWFJWcDFrZHZq?=
 =?utf-8?B?TVFSWEVNUDJXc0xBUW1UVXVvMTFNWGMraldtUFFYby9VQlhEbU4zVVd1OGJ6?=
 =?utf-8?B?MEhESlczRW5IQ2IxdWVramRaaGpQSkNiOGgxM3NrYzVjZ2hZSVRiSDBoVXRj?=
 =?utf-8?B?Z093UkFadlR2RnEvajVwdFgydi8zLzFZdGwvQmcvZzRUYnpLTFczbzkyNU4r?=
 =?utf-8?B?WE5aSm8xTXltU0t5Y044em1sSkpwRGdNK2VJRUlhbUxsbUFjRjlVWFVQelpQ?=
 =?utf-8?B?ZEFUQ0dmbzFRS1g4RWtZS3FTRi9mMU1vMTBGL2REeUVrSm5PVk5BY2V5T0lQ?=
 =?utf-8?B?ZHVGNWJGNE90My94eXJjMkRiSWlKY0t5OS92cjZQWTdrNHVwejhITXlNMDRD?=
 =?utf-8?B?VkVWUWs2L2F2VzBucEt1ZHNvZmFCWGYreUltUjRnU3BYc0NyK1JCSG9rTjFp?=
 =?utf-8?B?ZTRnR2ZJNVRGeDNUOEhxdU1TQ2RyN0VTNDg3c2ZsMExlZzA4ODRCZG5Mc0lN?=
 =?utf-8?B?WVZBSHpiak0zQVZtWUJCTitURzMvUHQ3bnQ4SHI0RlNtSUVuamhxKytKOUFU?=
 =?utf-8?B?VWVSMkdYQ3lhUjlvSHdJZWtkYlpha001UE9TTUtJRzBPUmVBNDlOMFR0ZzJz?=
 =?utf-8?B?alRqMnp3RCtnOTAzYWduRmhHME5GSVhnS0VjR2dSZkJKVTdCNjB2NXdwdDNq?=
 =?utf-8?B?YkVaTUdTREtKZ1ExZ3VmQ1R4NHV3ZlE3ZmxYRkZLQlVFRVJiNHY1dCsxZzFr?=
 =?utf-8?B?NGFlRndoaEV3U29IazVLSlhxcVk4NGZXTStaQXMyUUJRck1wSDA4M1Mrckhu?=
 =?utf-8?B?d3ZlbTNDNzFuVEdpUkVObUVRY1NQU1lSc2pLUGhIQU5nNW5idUw1Nk84dFpa?=
 =?utf-8?B?bnhrOXdJVEg3KzZpZ1ZvODExZEVwd3g1ZzUrTTQzb0lnd3I5bkFDOGZqOGpU?=
 =?utf-8?B?WEowSE9FYkQ1b1JwajFBYzVmeEwreVhzeGVQR1NNdXRrUE5PQUR3dkpCRERO?=
 =?utf-8?B?aXZhYzFaVE1sd1dLSDJ1TXVOaWVYTFQzREpZa1NWblFJRmR0Y0dGc0p1UHh2?=
 =?utf-8?B?cEJnSzVVckUrVzVHcHBKeWxaVGQ5VWlOWGVlT0dQYVA0ZjNIZ2h5a2dDMnFu?=
 =?utf-8?B?azlyczhQT25UL3JHcUlzWVk2QUowdUhkeXlKRnRxcWI2cXpuUTJtZER1d2w4?=
 =?utf-8?B?MmFhTUdicDZ5ZnZYQXRLVy9tdmtRRnh4b3VxWmVwZDM1bG1MQ0JGVWVlTFo1?=
 =?utf-8?B?U0MyOVMwNDJxY0pqMVpIWVZoL1ZKbTZOWEk2YzVmd1cvY1ArWlNmMTJoRTA5?=
 =?utf-8?B?ejBlcmdmQ1hEUFNockhHT3N0MnF1NHhjWHB3R1pUSTZsZVZ2bWhqMnhYeEFP?=
 =?utf-8?B?ZDVBenFNNVpXZklIaW0yZnR5b0dyeFlGeWxyeDBObVM4VkU2Zmd4TVQ2ZlpG?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <696F4A607DF3F247BB2E479BA27E7C4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd95d67-95ce-45d0-74b7-08dc488fc55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 03:42:30.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imUZ9DV87vmwVNTtvRcre75JPgCsUAV6tOjGa/M+oFlL8AylKfEisVHBp59YmYSsanAnHH3iRxCiAfxP7zNGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDAyOjIyICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgTWFyIDE5LCAyMDI0IGF0IDA5OjM3OjI5UE0gKzAwMDAsIEthaSBIdWFu
ZyB3cm90ZToNCj4gPiBURFggZ3Vlc3QgYWxzbyByZXBvcnRzIENDX0FUVFJfR1VFU1RfU1RBVEVf
RU5DUllQVCBhcyB0cnVlLCBidXQgdGhlDQo+ID4gY29tbWVudCBvZiB0aGlzIGF0dHJpYnV0ZSBk
b2VzIG5vdCByZWZsZWN0IHRoaXMuDQo+ID4gDQo+ID4gVXBkYXRlIHRoZSBjb21tZW50IHRvIHJl
ZmxlY3QgdGhlIGZhY3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS2FpIEh1YW5nIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0KPiANCj4gQWNrZWQtYnk6IEtpcmlpbCBBLiBTaHV0ZW1vdiA8a2ly
aWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCg0KVGhhbmtzLg0KDQo+IA0KPiBBbHRlcm5h
dGl2ZWx5LCB3ZSBjYW4ganVzdCBkcm9wIGFsbCB0aGVzZSAiRXhhbXBsZXMgaW5jbHVkZSAuLi4i
LiBUaGUgc2FtZQ0KPiBpbmZvIGNhbiBlYXNpbHkgY2FuIGJlIGRlcml2ZWQgZnJvbSBjb2RlLg0K
PiANCg0KQm90aCB3b3JrIGZvciBtZS4NCg==

