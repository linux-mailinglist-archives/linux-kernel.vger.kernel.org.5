Return-Path: <linux-kernel+bounces-18304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA58C825B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213DFB23270
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95935F18;
	Fri,  5 Jan 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDjh3wRb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F3609E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704483535; x=1736019535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M4Yll/84lmCc/E1h+If5AksWXe20NLUcjpNGcBLgFio=;
  b=CDjh3wRbkBy9T6O6fNnsLNmcFEO0lug8QnP37PasQ+DsjXmykxEY4TTt
   TNIZEC/axZ2XXJ1GLSHZRkmvDEr8/HVlhqPgeHpFAVtPa9MntddQaJwvn
   9r/ejyi9s/3HIX0LHLOcPZkcjSiehpDpDkSUCYt9KYR68Ow665zPlu+9M
   M8uz/HQJbw+DtjlLEGvljs7o+DLITE3QYCY5ezNZWdr8GQIYeNsUbK/MF
   Ka2CkfpSGRxT9bktzZV2VL/BOwG/30LmWTbkiPZYIHyPcyIZBDDkQOdgQ
   0stv0oGmeMLO3GMBL+vY5kBRpz5O+v9IANAegQCO4uHZOgHvCFKePMOHf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4339782"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="4339782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 11:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924299856"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="924299856"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 11:38:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 11:38:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 11:38:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 11:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi7dezmaWFr0FlmzveWqMioHfcIghr8lehNCqLPn2wKQ2odouNKrTYaqcfjuLtmr5cazQ3khny5mkOaxL+T2PUx5hLCUeOaKr/CsaTlZ2inNvxzyiZcztz4WDtot9ycP5aiuev7mKwEA9WneubSsdbTOZPLpKFZEO7jUCNb5edKn2xfNntKdTuCMQ9x2HRQ2PXvus3oNM8WTEqqmJ/BSjd5DQvGBzp9z0x+W0rYBPeSG/2HOuEg7nhz9RLZRMXQinzNFEvLmFsNiXnRNdCQqvHpyqm/oMcIj86okD9WVQWod+twCeLGp0hyG13Xt8OnQdxUKZkwiuWXfsWD+XO+KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Yll/84lmCc/E1h+If5AksWXe20NLUcjpNGcBLgFio=;
 b=YZo3Be7huxXqcOq0YhLgdTufLVnROMn+bJAM6+Rv6qwfIYld5b6eHtmZaMf3Hdk8ryCbY0MhthhhozSjt0xpRqxlmkz2EM1oZHjAKvym80n/cBQZo93G4xhqXooQMT7peCec1qGPm/TDlzNrhjQ4zQsHnVhUF4eeXtFrgMhguuh4WpzPNShYpmODaHmXltt2AMSL0bVDsNN9DKk18Vfnpggzni/RMARv6Aq0sfFP27P2LV20KFBbSfSm81cgEBMYTm8N9XzHqA1wQAIVYzgMDxAe9bQnHT9P92lgdQQ07/sxQA5wOJAdWjAVZNIwIUxOasVymcI7CkbU13KDr4ryTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB8042.namprd11.prod.outlook.com (2603:10b6:806:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 19:38:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 19:38:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Huang, Kai" <kai.huang@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"seanjc@google.com" <seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaNTHuuT5wUKCXiEmkO2ibmGVdkrDLszWA
Date: Fri, 5 Jan 2024 19:38:48 +0000
Message-ID: <063a42bfe538710931fca183a8d28c8a3d011608.camel@intel.com>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
	 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB8042:EE_
x-ms-office365-filtering-correlation-id: a8da941a-0b70-43d3-1463-08dc0e25f03d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: If2m6X54zs92AzJsK5WWlLkIZJuFQs/iikPXCiba1r3x8rE+TE2S+Azjpsi/3oS5lixB5KwT39YGPbp9oBREjTr2DffubfxiRmG9vuodHSu/xtzZBPMpxkb2rJeKWxlqU8rVLEHRhy7pCQM5WI4MJ+99WeIHY+Xioh/OtcCnYD1bJ/H5ESXehpYMDWHv09qFww6AL4jmStwBd/muVrP6Clp3fQlCZn6+m7aj8cpED4IS/xt7GFlbiraJAVxlLU4p2KdXtPcZiQqk9DhfS8AdoKs1bnUJ2Q517QwNzJRCMeOko1e7e8EGlpKf5ZAyYGksEi/aT6vXbNdnsnBTspe9m6rsWuDtVVQOpDlXvmG+3juOfpW9bTJQ/FgxnQHYKgpEHpB0ZA/8rb2ERuvG5Tv2V29hqBMHNDICd285v/HyglhRaUnSpOF7KaPNEM8lJnrvpiWcrpVX7v7zHQEfoA9FGpvwJD0u31d6OQRhRbFL1mGpoiidEf3riPxEVGUbO3clJMTJB+lXGB8J3Mq4GDDMaol+6XwKrnpf9v+vbZglTTNePb/l2JxQ/DiElVAHy4O/xYnITbXOFFpah9vAaXOoA4qsqnb6hS5grOpV2P9OCdrfkcfGPGdimFi0H4zzr5UZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(86362001)(91956017)(41300700001)(66946007)(316002)(76116006)(82960400001)(38070700009)(36756003)(2616005)(122000001)(6506007)(38100700002)(26005)(6512007)(6486002)(478600001)(4001150100001)(5660300002)(2906002)(71200400001)(54906003)(66556008)(66476007)(66446008)(110136005)(64756008)(8676002)(8936002)(7416002)(4744005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFZWWW5jMnRDL3FwS2EzNDNBUkxGZ0RjV2ZmQWV1bzBqMGdqODVlaDd0eU41?=
 =?utf-8?B?dGpKT1dtSWhFbkZtbjI0NSszOGEwYUFNdFFFNGxhdGhvaVB0bUdOdDJTYzZF?=
 =?utf-8?B?QVRZd1A5ckwvUmFSWkY0UFJDZUNZektXMmZETlk0R2J3amZIT1RqdnVzUUsy?=
 =?utf-8?B?UHlBS2JYTWJtMkI4Y0RwZTFwcThxVHhwQWh6MjZuTDlwQ0FvbFdZRWZJVTJ4?=
 =?utf-8?B?NEZid2RtM2R2azFZcExTOHN4TFBBU3F0MUlGUkRUbkhtNXQxaDkxVlJLdk1N?=
 =?utf-8?B?S3FhTjJ3ZE1sMGtEVlUySFhHK0MveFQ2dU9TK1ZjbjRGeU1KdElITlN4NjhQ?=
 =?utf-8?B?aVdtTXBxQU1WT1RWaDhJRzZrUGF0RXZlVnNiU3RjQmZOcm5sM0RaR0VCb2di?=
 =?utf-8?B?dnhTSWZYenUzV0tVbnFRdHhkaSttdUxXTkt1bFpEV3RZL1BSYThnaW5JVEth?=
 =?utf-8?B?YVkxK3VJci8vT0ZnZFRsUXFsejJ0Q0NCd04vTWhianBUVXJzMVo1a2N5cE0w?=
 =?utf-8?B?cGd2ZFBhK1RmeFA2QldQNGdBZTBEb1ZXa3NnS2FqcW02TU1kSlQ2RGFyU25r?=
 =?utf-8?B?Rk5rYURZV2owMjBiTWdzWFVTMXlLcjBjZWUrNkFhTHhmRm9qZGMzV29OeVVU?=
 =?utf-8?B?U0UrQkpUd3c0UnVERks2S2tvam1qaENjZUVUUFJwT3FCZGRtYmFYWm1ZWmVx?=
 =?utf-8?B?dFNwUGl5dVhQMjYxNjVrWHNJSkF4azlUblNjNnZ0bGJnTWJXRFoxdjZGRStM?=
 =?utf-8?B?NTRFazlaUThJaTNITStaZnB1VFAvZWh4eUdHYWJuWldWSXVtTjl4YVYwTTlk?=
 =?utf-8?B?QmdoMnc2b1JNVDRZVlhjMGFVYzJDQlYzcHo0ekVyQVdGT2ZNSjFUU3dHRk43?=
 =?utf-8?B?djhjd1hybDMwb0NDM042NVI2eVNFdlR2ZkozbUFYTG5JSDBjYnM0ZzZvbzRs?=
 =?utf-8?B?N3pMQktqWHJ6S3I4bUhjOUtOaGhxS21DR2lPMWpRUDVGOWFQTWJhQTdTOG5H?=
 =?utf-8?B?R3E5dG1mOWlwWTN0SUF6VnZtRkMwUlJKVm56bjRiOW9ONDYwV2h1TEFwWVVD?=
 =?utf-8?B?UncxYUs4KzhyQzI3QUdvbHNWRDdpOHBpSWtNVUVjM29wWVpmOXBWS3pPcFhH?=
 =?utf-8?B?eUhLNFlpS0RLUGdtUmJyd3lDd2htYTcxTkpIQS94cW1hKys3K2h6NDNXbERC?=
 =?utf-8?B?M0x4QUpWeGhkanZzN1FDUDZPTlNjK1RuQ2FKQzgxclpoVEIrcmltUHdscFds?=
 =?utf-8?B?ZVpQMjBiWm1WU1pGUTJOanhxSk9ncENzckFHMTJnSVZUTDI1TXdGTW1PaGtk?=
 =?utf-8?B?eU1WMjRIczlHekh2c3VIbkNZMm93eGV2SGhBeEEzZXlwdjZ1QkwyQUxkSVBt?=
 =?utf-8?B?SC8raU1zaXlORDF2WFNOYmtDVUdFOXp3OHZtd3dneXdpakR1M2MvTzdwNjh0?=
 =?utf-8?B?RXpHTFYrSFR0SEFCbVgrTWxyNWVCUVNjM0FUMVhhMmF0cUFYRkcyYktTZXV6?=
 =?utf-8?B?dWpkRG1CMHRZdWhqb1BxYXNSYVJCMDR5aGJub3FPMzdpRUQ0N2puL3RFWFVx?=
 =?utf-8?B?QkJOVEN3UkZyaVRrZVB0cnZ6eGt2dncxeEp3cnNOK1JXRXd4MDhtU3k3S0sy?=
 =?utf-8?B?SmJmMHNsbFFrWk5BYzFtbUJtTnhQZE42MXYrRks5UHNFZlVyQzUrTzlrV0ZU?=
 =?utf-8?B?WEVCdDhNY3lLai9IRDFidkRLTW1EYzJJbEdrWnpGK09RMGpZdEkwc3lqUE1x?=
 =?utf-8?B?cCt2N3VzMnNrQmtYV2FUcnRRd25DVlpMM3dLRE85Y0dVWjR1d05adDh0MnR1?=
 =?utf-8?B?Qmx4UUZaR3RLMnV1VlJsQWpsZHI1QzZvZ0QzY0xQeTZ0MmlBWC9UNjZCRHdk?=
 =?utf-8?B?bnFpUks0K09iNnNzWHVEM1F0Nk4rMElPdEFrTlkwTDhJNzcvRG5sa1RvQ0NH?=
 =?utf-8?B?aVRMZENPdnpLNDlveXdnOFA1RzNFZUlYRTE4RlEvc2x0dnA0bWJzSGFqTFI1?=
 =?utf-8?B?bFk4MXRraHZPbUxkYjNRL09rV0J2RnM0ajlVdHJodjIyTWw5aW03TFQ1YlNF?=
 =?utf-8?B?NjBOelNEWmpvc0FZUE5FajhHckVPKzNxb3dLTGRhb2xTb0lMVWFzT3ArQTM4?=
 =?utf-8?B?UU85UXlNbHk4YkhDbE8zQ1lCR0pubzl0dmgxUlVBRlhiUlZ5anYrdXpLbWRi?=
 =?utf-8?Q?Qi765CEPql3hQRIRPQ04lZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E08819B029654E8AB40E37E3181F4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8da941a-0b70-43d3-1463-08dc0e25f03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 19:38:48.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YV1Q0wiGULafkZBgjPrFtVLZ2fu9yg9PPTQ+IxU8Uhm02sHWgLC9HxNMH3fVL6aPX9k8oW8nIXMNsKkziVi1z0i9GHfNY5esTNNNDUzSjOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8042
X-OriginatorOrg: intel.com

VGhlIGJyZWFrIGFwYXJ0IGxvb2tzIGdvb2QuCgpPbiBTYXQsIDIwMjMtMTItMjMgYXQgMDI6NTIg
KzAzMDAsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToKPiArwqDCoMKgwqDCoMKgwqB3aGlsZSAo
YWRkciA8IGVuZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBs
b25nIHNpemU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBs
ZXZlbDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHRlX3QgKnB0ZTsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHB0ZSA9IGxvb2t1cF9hZGRyZXNzKGFkZHIs
ICZsZXZlbCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSBwYWdlX2xl
dmVsX3NpemUobGV2ZWwpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHB0ZSAmJiBwdGVfZGVjcnlwdGVkKCpwdGUpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgcGFnZXMgPSBzaXplIC8gUEFHRV9TSVpFOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUb3VjaGluZyBt
ZW1vcnkgd2l0aCBzaGFyZWQgYml0IHNldAo+IHRyaWdnZXJzIGltcGxpY2l0Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBjb252ZXJzaW9uIHRvIHNo
YXJlZC4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBNYWtl
IHN1cmUgbm9ib2R5IHRvdWNoZXMgdGhlIHNoYXJlZCByYW5nZQo+IGZyb20KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG5vdyBvbi4KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2V0X3B0ZShwdGUsIF9fcHRlKDAp
KTsKCkRvZXMgdGhpcyBuZWVkIGEgZnVsbCBzaG9vdGRvd24gYXQgdGhpcyBwb2ludCwgYXQgbGVh
c3QgaW4gdGhlIGNyYXNoCmNhc2U/IEEgbG9jYWwgZmx1c2ggZm9yIHRoZSBub24tY3Jhc2ggY2Fz
ZSBtaWdodCBiZSBuaWNlIHRvby4KCkFsc28sIHByb2JhYmx5IGEgYmFycmllcigpIGJldHdlZW4g
c2V0X3B0ZSgpIGFuZAp0ZHhfZW5jX3N0YXR1c19jaGFuZ2VkKCkuCgo+ICsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghdGR4X2VuY19zdGF0dXNf
Y2hhbmdlZChhZGRyLCBwYWdlcywKPiB0cnVlKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigiRmFpbGVkIHRv
IHVuc2hhcmUgcmFuZ2UgJSNseC0KPiAlI2x4XG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRy
LCBhZGRyICsgc2l6ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9Cgo=

