Return-Path: <linux-kernel+bounces-73909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5085CD81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806C4284F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BD4694;
	Wed, 21 Feb 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EF1M2K4a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA883207
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479508; cv=fail; b=au3JT5sjolJHY7Icv3gnoGSdV41vVArkNqYwFN2horrtdBp9PMz10MUu/XqH40V5gXGRat7NAXqYgeubs40RtGA4nRr4Y8YYtDrLpx3uHuv0FJUWFF7XdO2PWpngAgx/KmsobJHvpBRIfI7pUr9ewl1wsdE7sLEr5UgZnTe5Qvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479508; c=relaxed/simple;
	bh=Tctjt6MfJSGMOOjzG7lsaI5wyMQGJsoJ+F1JS9g7Occ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFrmmLpmnlOlSOm1uYGJxlj6wfEoOgOFJ4Yo/1PH/flEDYyuHUbbDpiRQp7NSacHU0IPDO4OqHsbdyBSavkz0eVgikGFd6jNLMAwEUbNoQ7U8FzIOBeZXhYEoJTATyRN5G7C1OY/DleZqALRJmt5bN/yWkej8QGAQVUPeyG+4Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EF1M2K4a; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708479507; x=1740015507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tctjt6MfJSGMOOjzG7lsaI5wyMQGJsoJ+F1JS9g7Occ=;
  b=EF1M2K4agsiOf42yHgUbH/MWHRQSnIgaKG73n2yG0eIQYmPl5MtyTKhG
   6QeFvJDp/rVoTWdldaWrjir0K6Ns2OmMRGvYajWEjbfO+8Y5eP6WcZCKk
   05MhR21E8Glu8oudD7dpvIn2eHHWpWkYw9Kr2V2z3RYEuD2QqpubdMX79
   rOCjCx3ZAvePnIaZ5wpXbUxPRr5CF+RBn8urD4a+HUVe9hJoXf6UtamTx
   Su65j81cMn/IpZFJVvy/HusE+TUzGPq9hOqJzN4BfK5ic9IjIN7umahcK
   7UdOczI00CP7Ab7Vnvp1jHCVNWUkrGVGd/KnAl264b75neH/jxm59yZ7c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2770009"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2770009"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 17:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9622900"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 17:38:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 17:38:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 17:38:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 17:38:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 17:38:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP5CtQwALFVlvjSv0m0fIyHMIz1mAOpTlxQceu7ECt1t/z4EMzdkL0qFI6usztcUKZ1mUvcinYNz13rOF25XUyWGUd+vRu7McZRb+RMziFmuNsGocMvH2lgqGCWsmcii536w66nBtowdbJV/LN2BAIdPVkkkh49rLAZIyXEwpRHDR77EleuMLHkJrheQ+zD8wuIJomQbq28LyZKLm84IIpf9/NU9CumkVVoAjx4AtZBATlzaAwOSaoM5mRmVy7o0wLjV8hBLThGnCMfswm9WbrhbF1vmayIRkYlMsz6muTHdqO9KFRfDOHUkZKSQUHoGTtkZvKgsLMVaFDWsQk1yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tctjt6MfJSGMOOjzG7lsaI5wyMQGJsoJ+F1JS9g7Occ=;
 b=aQ3Gqaxf45zSISen0mMKWXwCRBotBqeRQ/tAKufx33eH5hLTScUvO1uh2hcpS6W3m32IkMf6ifvCRNbIpPHhM0RXpH+dUYrOypZv+R502652ksIFEWN8HZuMF/T/v5nRKcmq+3Ari8+avKiTnp7N82WTgQM/9GQLvuD63xo/iEHSEjcxNN9JYPSTyLPKkFSTBiYDoGhJAsc7Uh1gxoxPJObcHRfSyZAF7ubO3DvzpSwdmXhnc5PpSj1t0G6xsvpN60wN240KjVJJOJIDI/rXbN507557tVGofhuBiFRKn79xOKHwvQj7ZtARlBdpQ4F+j3sFDnzzTeJHy70XJMuT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8522.namprd11.prod.outlook.com (2603:10b6:806:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 01:38:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 01:38:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "Gao, Chao" <chao.gao@intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHaVDdfcLjlgK8/xEqQPfvtDlVukLER9XiAgAA6hICAAA0QAIAAGziAgAERXgCAAAWBAIAAWS2AgAAn/oCAADSDAA==
Date: Wed, 21 Feb 2024 01:38:13 +0000
Message-ID: <687d4543ba0c96a54ec1af4dbe5ecb861a9dff03.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
	 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
	 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
	 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
	 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
	 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
	 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
	 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
	 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
In-Reply-To: <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8522:EE_
x-ms-office365-filtering-correlation-id: 6e2e260d-7a29-41ea-f7a6-08dc327dc4ca
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MqVZgbHvVSZX5Of3nOWssLitOVs+bVPcKdbiUQp26e0T/5gEKtmlwMniPoZ/+F8hGxQ1zu0oHigdf5yzAv6dQCrlNxNBr8qZN4k7uh3NkHSYv2JmzZsc6MoBMZMtrzOEjxemClEb4X+7ORRxsFhboHql+Rv7VuIxs5BHMUL+G5u7ZWW/kB4iEmTSyT7ex7E3B4e+pi56shlP+d9jf/nV62QQxakVfV/THXkxUZ9F/6zHmRlJkggg400HOjhSrh5RL+OJF1WXHc+8RF7LPK6SW4SBBhEtrkj+an+R13tfpXgxQg4LHTVk9dsS+EmwbVJwXSSe9qxLjO0IEcoxFJUjKa2AgtacTYQEzQsTTsU146XpW0e8KfiW2B+DkmdboMl22WoeyhpuPLN30eDhQ9zd9gZbWMQDpqHn48ldzoltFeZKkTXWSSbhVL19WBr8wWfI+8BGqRBt69n8MUCb30fDUZrOb+f6PNUC9BbeKs/iFjffErNZ2OMY+CMOANkRTeVBWFOyl0dEwwefMvdxJQmZg8wmyKBxYxB0KQrgW4i5nOWPbvUP0II9yAFimaS9Fxz3zAiFILkF0FO37Hie37G3Hvu5uk0hhslbBpiEiix/62QNVbCGI3sb5ZKZwfQq3AK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRJTkFUNEtMRjhxZmM4VHBTbC80d3dma2FlQ3NCU0RsbElWZjM4OVc5TVM5?=
 =?utf-8?B?NnluV1hSeU16MVUxLzFYeUt5UTZkY3V1OFpsN01mY25sbGNuODFveUR1NEJm?=
 =?utf-8?B?alkzT0VoVGV4WG9uNmNBQTF2QkhaTHNkTnRyTnpFeVNQSk5Xa21va1FVSFlE?=
 =?utf-8?B?bEh5VTNwNVZSTVYrQTlmaTlpd1YxRHhJR2FwdDlJNk1Mcnd2TGtqNEZRWEhI?=
 =?utf-8?B?ZmhrRndwandNbE1VVjFieGRVb3ZPblZyQzRnNzRoc0NMQ3RoOXRWdDZ3T05r?=
 =?utf-8?B?eExZYVNVYXVzZ0FyUkw3d0JGd3pQVjVyM1BIZHNoRjEwV0Ywd2twaVpJdGk0?=
 =?utf-8?B?dmxxQW1CVXlxZnhLOFpPQlpCVXc5TVZJT3lncERpYzluYzh1cFlrbVR5eVg3?=
 =?utf-8?B?cHZFUWR3bFZQTWl4dEZvMXJqVHB1NTUwdUtWZFBGdFRhLzZKM2h0Slhzb3oz?=
 =?utf-8?B?b3FwTHlHajRjUE5lcGs0R2tNN1VTVFBMYkRhMHdMRjB6cHJBRXQ4ekZEMERV?=
 =?utf-8?B?bHliQ2R1aGZpQnlHZnUyMzVMd005SW5oc251cUFBbzZzblBNdHdyM1hwWW9D?=
 =?utf-8?B?OTkyUG9TbDArZlBoenBTdDFPUk1iMXN5Y0IvekYrc3MrMVo3SWlERlJ1aGt1?=
 =?utf-8?B?VXVBeTQyZkNKQlVlSGVjK0hnOWNMOFkyQ1hxOHFHRXFCVUMyZDRJSXgvV3hF?=
 =?utf-8?B?USt2S2c1RzRjOW9VMUZKVWFtOFBoNFRrMnF2dDNXdGJDTWJXeFIwbmJCR0RU?=
 =?utf-8?B?ekZNQ3Y0b01CK0oxcTl0VnQ5OFduZ2NxUUVuSWx0VGs4aVJrNXFXNDJrUnhJ?=
 =?utf-8?B?cnFubGEvQUIrVEd0Qzc3UzFSb3p1YmdRTkxqQkJNT09Xc1FQaXVMOFc2S2NH?=
 =?utf-8?B?ZndCUU5FMDVROHVoQlBlRzVab0tMQ01wdWpQLzcxUmdCaTlVUC9FSWpCamRG?=
 =?utf-8?B?VW9tSTlOcUZDWGhrdml3VUdpQnphUkk5SDU3Z3Z3RUl3b3dVYmYwVkRXdVc1?=
 =?utf-8?B?bU1mTnJHTXVwTzQ1Zi95eGR0M3Zzb3laVkpmMml4bmdWMWJDN1BrbTFsNHNm?=
 =?utf-8?B?Y29uRDh1Ym1GMFBTTEIvby80OXVwbTRQSlREMXJHdGZVVllsellPWDdHTXN5?=
 =?utf-8?B?NldzL21nZVViOVAxeHlhZnVMcGg3K1lPcFRQcmh6RTJ4RFRqdEtGb010dWlC?=
 =?utf-8?B?OUVJdHB5SEI5c05SK0pzNTQ2WVVKVnowaTdKQVdpM0JCeXlPNXhSQ0NiYkdW?=
 =?utf-8?B?UXBqMVQxVFZWaXFpeWlVdkphaDJ2UCtrTVNvZWpGZ3hEUjhBSG5YY3Bmdksw?=
 =?utf-8?B?cEFHWlNXS0xlLzZHWFNPVXF1VjRmeU1ERVoyREhlbnNvZE0xT1NMbFRrMUR1?=
 =?utf-8?B?TXdZVnFTVXBSSTZIMFR6MldyZnFnaXJNVVJ0TXQrZk5kQWlZM3NMallSeW1p?=
 =?utf-8?B?ZmFFUERLTWJPOUpOaUJXMTd2OFdKd0hWc3NybSt0L25OVzBsaUhhaVJXNTNP?=
 =?utf-8?B?NnFBVDI5MFNHbHBEMnBmTzNOeC9EWUNTaWF5WlB4MEZtcGtlNU5lRkRaSVhl?=
 =?utf-8?B?amp2V3JKc09UU0ZpVXZzbEQxdVdUOStmQktpUHQwK1l5ZDd6cGRways0ei9u?=
 =?utf-8?B?V2I4MENmREt1Y1FQbUdCTUxhb2w5VGI0dVV5VW5ndUJiRFpMemovRk4rUGQr?=
 =?utf-8?B?VGdybEhnRTRYbnVoZXg4OU1jd0tVYUFBeEZtM1BRR2dRNENPWHZtay9UTGRu?=
 =?utf-8?B?RGIrV2NheTZCek92VHNnT2kyU2I3SW1zc2F0NmZROTBwRzNPbUwzLzlxZVdS?=
 =?utf-8?B?ZnNvdzRVN3RmUmVXOWNoU2txV3JwRTBLMnJlN0J5czE4VExRakdRMEtzUjkx?=
 =?utf-8?B?elFyMUk4S1krcGJSbVpaVmpKVXhlVXZ5WDc5WDl3dExsM0E0TlBOdzRFdkho?=
 =?utf-8?B?S1ZITkdDTTdnVlJiTGIzRFJPeVUwV053NlZ6Y1hkaW91NG14NW52SGYxSWJ2?=
 =?utf-8?B?Q0ZyVWdMZkJSMjR5b204WG5UT1lyT0lwQWw5Q2ZYRjEwUllPbnNkYm1DUzFM?=
 =?utf-8?B?VUxTUmc3dDF2S2ZtMDYwUmlDWnJVSjFQWVdTeTFjdGlQd01KVm1oUG5aM3ZU?=
 =?utf-8?B?ZG9pOUdaVUpkTjBTOEJxRzNrLzIweWZIakNaWHQzVG5kR2tLeGFubkU4RzZO?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0447F36CB25B584DB611F3F0994438E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2e260d-7a29-41ea-f7a6-08dc327dc4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 01:38:13.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rYO/BWVTcViWY6nm2Nk2f31iUZ8Uo1A/U8mwCStL9A6GgLdKPfTHmrevhkUB8Tc7LPKVM0NX1wk4xRDdn0A5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8522
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE2OjMwIC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+
IE9uIDIvMjAvMjQgMTQ6MDcsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI0LTAy
LTIwIGF0IDA4OjQ3IC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+ID4gPiBPbiAyLzIwLzI0
IDA4OjI4LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgRmViIDE5LCAy
MDI0IGF0IDA0OjA5OjQ3UE0gLTA2MDAsIFRvbSBMZW5kYWNreSB3cm90ZToNCj4gPiA+ID4gPiBU
aGF0J3Mgd2h5IHRoZSAnIShzZXZfc3RhdHVzICYgTVNSX0FNRDY0X1NFVl9FTkFCTEVEKScgd29y
a3MgaGVyZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgd291bGQndmUgbmV2ZXIgZmlndXJlZCB0aGF0
IG91dCBqdXN0IGZyb20gc3RhcmluZyBhdCB0aGUgdGVzdC4gOi1cDQo+ID4gPiA+IA0KPiA+ID4g
PiA+IEJhc2ljYWxseSwgaWYgeW91IGFyZSBiYXJlLW1ldGFsLCBpdCB3aWxsIHJldHVybiB0cnVl
LiBBbmQgaXQgd2lsbCBvbmx5DQo+ID4gPiA+ID4gcmV0dXJuIHRydWUgZm9yIG1hY2hpbmVzIHRo
YXQgc3VwcG9ydCBTTUUgYW5kIGhhdmUgdGhlDQo+ID4gPiA+ID4gTVNSX0FNRDY0X1NZU0NGR19N
RU1fRU5DUllQVCBiaXQgc2V0IGluIFNZU19DRkcgTVNSIGJlY2F1c2Ugb2Ygd2hlcmUgdGhlDQo+
ID4gPiA+ID4gJ2NjX3ZlbmRvciA9IENDX1ZFTkRPUl9BTUQnIGFzc2lnbm1lbnQgaXMuIEhvd2V2
ZXIsIGlmIHlvdSBtb3ZlIHRoZQ0KPiA+ID4gPiA+ICdjY192ZW5kb3IgPSBDQ19WRU5ET1JfQU1E
JyB0byBiZWZvcmUgdGhlIGlmIHN0YXRlbWVudCwgdGhlbiB5b3Ugd2lsbCBoYXZlDQo+ID4gPiA+
ID4gdGhlIFdCSU5WRCBjYWxsZWQgZm9yIGFueSBtYWNoaW5lIHRoYXQgc3VwcG9ydHMgU01FLCBl
dmVuIGlmIFNNRSBpcyBub3QNCj4gPiA+ID4gPiBwb3NzaWJsZSBiZWNhdXNlIHRoZSBwcm9wZXIg
Yml0IGluIHRoZSBTWVNfQ0ZHIE1TUiBoYXNuJ3QgYmVlbiBzZXQuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gSSBrbm93IHdoYXQgSSdtIHRyeWluZyB0byBzYXksIGxldCBtZSBrbm93IGlmIGl0IGlz
IG1ha2luZyBzZW5zZS4uLg0KPiA+ID4gPiANCj4gPiA+ID4gWWFoLCB0aGFua3MgZm9yIHRha2lu
ZyB0aGUgdGltZSB0byBleHBsYWluLg0KPiA+ID4gPiANCj4gPiA+ID4gSGVyZSdzIGFuIGV2ZW4g
bW9yZSByYWRpY2FsIGlkZWE6DQo+ID4gPiA+IA0KPiA+ID4gPiBXaHkgbm90IGRvIFdCSU5WRCAq
dW5jb25kaXRpb25hbGx5KiBvbiB0aGUgQ1BVIGRvd24gcGF0aD8NCj4gPiA+ID4gDQo+ID4gPiA+
IC0gaXQgaXMgdGhlIG9wcG9zaXRlIG9mIGEgZmFzdCBwYXRoLCBpLmUuLCBubyBvbmUgY2FyZXMN
Cj4gPiA+ID4gDQo+ID4gPiA+IC0gaXQnbGwgdGFrZSBjYXJlIG9mIGV2ZXJ5IHBvc3NpYmxlIGNv
bmZpZ3VyYXRpb24gd2l0aG91dCB1Z2x5IGxvZ2ljDQo+ID4gPiA+IA0KPiA+ID4gPiAtIGl0IHdv
dWxkbid0IGh1cnQgdG8gaGF2ZSB0aGUgY2FjaGVzIG5pY2UgYW5kIGNvaGVyZW50IGJlZm9yZSBn
b2luZw0KPiA+ID4gPiAgICAgZG93bg0KPiA+ID4gPiANCj4gPiA+ID4gSG1tbS4NCj4gPiA+IA0K
PiA+ID4gVGhhdCdzIHdoYXQgSSBpbml0aWFsbHkgZGlkLCBidXQgZXJyb3JzIHdlcmUgcmVwb3J0
ZWQsIHNlZSBjb21taXQ6DQo+ID4gPiAgICAgZjIzZDc0ZjZjNjZjICgieDg2L21tOiBSZXdvcmsg
d2JpbnZkLCBobHQgb3BlcmF0aW9uIGluIHN0b3BfdGhpc19jcHUoKSIpDQo+ID4gDQo+ID4gVGhp
cyBjaGFuZ2Vsb2cgb25seSBtZW50aW9ucyAiU29tZSBpc3N1ZXMiLiAgRG8geW91IGtub3cgZXhh
Y3RseSB3aGF0IGtpbmQNCj4gPiBpc3N1ZXMgZGlkIHlvdSBzZWU/ICBBcmUgdGhlc2UgaXNzdWVz
IG9ubHkgYXBwZWFyZWQgb24gU01FIGVuYWJsZWQgc3lzdGVtIG9yDQo+ID4gb3RoZXIgbm9uLVNN
RS1jYXBhYmxlIHN5c3RlbXMgdG9vPw0KPiANCj4gSSBiZWxpZXZlIHRoZSBpc3N1ZXMgd2VyZSB0
aGF0IGRpZmZlcmVudCBJbnRlbCBzeXN0ZW1zIHdvdWxkIGhhbmcgb3IgcmVzZXQgDQo+IGFuZCBp
dCB3YXMgYmlzZWN0ZWQgdG8gdGhhdCBjb21taXQgdGhhdCBhZGRlZCB0aGUgV0JJTlZELiBJdCB3
YXMgYSB3aGlsZSANCj4gYWdvLCBidXQgSSByZW1lbWJlciB0aGF0IHRoZXkgd2VyZSBzaW1pbGFy
IHRvIHdoYXQgdGhlIDFmNWU3ZWI3ODY4ZSBjb21taXQgDQo+IGVuZGVkIHVwIGZpeGluZywgd2hp
Y2ggd2FzIGRlYnVnZ2VkIGJlY2F1c2Ugc29tZXRpbWVzIHRoZSBXQklOVkQgd2FzIHN0aWxsIA0K
PiBvY2Nhc2lvbmFsbHkgaXNzdWVkIHJlc3VsdGluZyBpbiB0aGUgZm9sbG93aW5nIHBhdGNoDQo+
IA0KPiAgICA5YjA0MDQ1M2Q0NDQgKCJ4ODYvc21wOiBEb250IGFjY2VzcyBub24tZXhpc3Rpbmcg
Q1BVSUQgbGVhZiIpDQo+IA0KPiBJdCBqdXN0IG1lYW5zIHRoYXQgaWYgd2UgZ28gdG8gYW4gdW5j
b25kaXRpb25hbCBXQklOVkQsIHRoZW4gd2UgbmVlZCB0byBiZSANCj4gY2FyZWZ1bC4NCj4gDQo+
IA0KDQpUaGFua3MgVG9tIGZvciB0aGUgaW5mby4gIFRoYXQgaGVscHMgYSBsb3QuDQoNCkhpIEJv
cmlzLCBEYXZlLA0KDQpJIHRoaW5rIEkgc3RpbGwgcHJlZmVyIHRvIGtlZXBpbmcgdGhlIGV4aXN0
aW5nIFNNRSBrZXhlYyBiZWhhdmlvdXIsIHRoYXQgaXMsIHRvDQpoYXZlIHRoZSBuZXcgQ0NfQVRU
Ul9IT1NUX01FTV9JTkNPSEVSRU5UIGF0dHJpYnV0ZSwgYmVjYXVzZSBpbiB0aGlzIHdheSB0aGVy
ZQ0Kd2lsbCBiZSBubyByaXNrLg0KDQpIb3dldmVyIGJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiBh
Ym92ZSBJIGJlbGlldmUgdGhlIHJpc2sgaXMgc21hbGwgaWYgd2Ugc3dpdGNoDQp0byB1bmNvbmRp
dGlvbmFsIFdCSU5WRCwgaW4gd2hpY2ggd2F5IHdlIGRvbid0IG5lZWQgdGhlIG5ldyBhdHRyaWJ1
dGUgYW5kDQp0aGVyZSdzIGFsc28gbm8gbmV3IGNvZGUgbmVlZGVkIGZvciBURFggdG8gZG8gY2Fj
aGUgZmx1c2guDQoNCkJ0dywgSSB3YW50IHRvIHBvaW50IG91dCBzdG9wX3RoaXNfY3B1KCkgaXMg
bm90IHRoZSBvbmx5IHBsYWNlIHRoYXQgbmVlZHMgdG8gZG8NCldCSU5WRCBmb3IgU01FL1REWCwg
dGhlIHJlbG9jYXRlX2tlcm5lbCgpIGFzc2VtYmx5IGFsc28gbmVlZHMgdG86DQoNCiAgICAgICAg
aW1hZ2UtPnN0YXJ0ID0gcmVsb2NhdGVfa2VybmVsKCh1bnNpZ25lZCBsb25nKWltYWdlLT5oZWFk
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nKXBh
Z2VfbGlzdCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbWFnZS0+c3Rh
cnQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW1hZ2UtPnByZXNlcnZl
X2NvbnRleHQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2NfcGxhdGZv
cm1faGFzKENDX0FUVFJfSE9TVF9NRU1fRU5DUllQVCkpOw0KDQpUaGUgbGFzdCBmdW5jdGlvbiBh
cmd1bWVudCBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9IT1NUX01FTV9FTkNSWVBUKSBpcyBmb3Ig
U01FLg0KVGhlIHJlbG9jYXRlX2tlcm5lbCgpIGFzc2VtYmx5IGNoZWNrcyB0aGUgbGFzdCBhcmd1
bWVudCBhbmQgZG9lcyBXQklOVkQgaWYgaXQgaXMNCnRydWUuICBJZiB3ZSBnbyB3aXRoIHVuY29u
ZGl0aW9uYWwgV0JJTlZELCBJIHRoaW5rIHdlIGNhbiBqdXN0IGNoYW5nZSB0aGUNCmFzc2VtYmx5
IHRvIGRvIHVuY29uZGl0aW9uYWwgV0JJTlZEIGFuZCByZW1vdmUgdGhlIGxhc3QgZnVuY3Rpb24g
cGFyYW1ldGVyLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlPw0KDQo=

