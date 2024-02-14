Return-Path: <linux-kernel+bounces-65403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B30854C72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3463CB25DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200675CDC0;
	Wed, 14 Feb 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8p63oHi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6E5BACE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923886; cv=fail; b=aXHsqNovTvmI7rduVqKCjoY4ZsoxDdsuOWGvJxPxTL5uyT85RT71RsaS6a8pP1fipdPso4WpI9iQYwdv7T32wUVM4NwOtqygJPZfkMeEqIYBffwXqbmHJu6Wo6GcKFgnUrNl4qOSkQEkWhGkHfZIFpXuz+K2cg9+B3Ojx6wYTfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923886; c=relaxed/simple;
	bh=wU39l/5GxUQLI6OaDQAQzIcZBp8z4PGF+gTycszxnsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UBApOJmRZINeIYT2qZl8cefxo76xFPX9Nr5kRlO1zW7khWrAKf1SvVLrRv0J7peGGOlUIHq90AKsWE9OBMHB9c0kANYGMMF9D2i0+Hiye6/pZwKCM011eivTIuvk+52Y0bqKu0RQ/IaOVXCYFrezlTryANOqtx279hGca3ZdaFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8p63oHi; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707923884; x=1739459884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wU39l/5GxUQLI6OaDQAQzIcZBp8z4PGF+gTycszxnsU=;
  b=A8p63oHiz4QM5hCuGwNvx0NVMwzPCAyBN5cbxKkWIVu/Zl1TqPYxfaHm
   /teV2lJKUxoWpx/E55djGfHl+PhMqROWQVVa9wgJg4TR6hO9r+gRlIRMP
   hwfsnP41xhCaiAq4oyb6KmoN2FkxpJxOEs3CX0xNmmOsU2KWZbTOuB/ca
   yf2TjjLu8anEDkFSyZGOIb97yk19ycIjecvfss/HJkg25MxQK+Oy9dDBV
   pW91Ag5HHZmZggyj26cFX/MECi/tA86lT75nia0q8yTDvLUfYGqnW+cvX
   luEO0bQAhoryUr13Hzj+U2yOgb0nyJzmnsHHyY48WhIqZ8NbxXannRpa+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2352336"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2352336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3209559"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 07:18:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 07:18:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 07:18:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 07:18:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av1dK1G7pGCjrmzTqOPf0SI+Tsjq6ka/H216OgsgPlFq0WXDF+ZP6zNYvQFd6kSbHOkqSlaG+bXLMzgmg6FpDHMgnL1WtkzY666i1idZ61Cnb53HtE054NHCBzWe5ywVKvE6IvF63yrI5tVA8f5jQA20TvoOV5KtPsd4BvA5blVVHmLxCnTfwWx9GeKsdQAavOcYQ5pC/VaC5KGmHqnKe/TT71ufGFQrw2mYSemgLmgmK/RynPub62ELJUm0O51ANBGkNTS9ETt0gbHtQNeCI5pvLJTGwT3/HlLIfoOk+0aYmJd/jApShUPa90XMYAKCJis/t/p88iNPLepQ8ldX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU39l/5GxUQLI6OaDQAQzIcZBp8z4PGF+gTycszxnsU=;
 b=RFOQgLlCYLhBYYzs0f9I7ej2nVOLbVDqnF7dM937xmoN4RxKdewJmgCuRy2RuyhPRHzlviHS035yeF5QywtApTBFxD6ugItEN/cJby80ye9pKpRLFb9qasssICcrD22PSfgBWhii222dSmn5KHnLxwas5BuAKrjmHKCZy9cvU/eZOJ0bfAbB3z9UFAs/P91KTsL9Cdc0Z01dXjTRxzGq9oqUypUoJ9BRIpkqs73e+LLBFCZD9+O9dadd0I3GcFoYYE5vTOFBaUz1kw/IMlnBp/BN+5BCeCEio4KVJ5rR9PnI28uikZ64n5CKrPxrSiwXAVqQSuDks/Bulv8D7E4pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Wed, 14 Feb 2024 15:18:00 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 15:18:00 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org"
	<x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+AgBNiW/A=
Date: Wed, 14 Feb 2024 15:18:00 +0000
Message-ID: <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB7097:EE_
x-ms-office365-filtering-correlation-id: c8a5a1f9-e233-45f2-6f93-08dc2d7021e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cp0KghrdLTaMkwHrpljicKB5doOwAr3fRB7U8XZaUDpYEWDD0biBAJdFIv9KADk44+OpjJLFKZwk34+2eNLzR4DP0e6UIaTA5PZlMBZ63B++S9p/yvp7h9Cx1f6WS5xPczwKdppFMrSKgOA3dAY9Yg4TGVHW93bWa4dGXtMYzbYRuxtldnBEdQDTmmV4zfk2XIP1sMhIxSXob4pqqxH0/aF42Y+hz0alXqmbxI4uA+dpQEZp0st1YQIhomFAMYVgmo/fhkMHUCIeb3dORi0k8/7ZuRCyTpOYw9gGasmghiU/kIsEn3M2vqv0FQr1caPRQNvBUiUOFpLmq07esLurtyFk0u3uUoked6Yk4/BevEFEfmWzGxm0+V/G8B6RfGxVFr6XU4HD3wuQKVnfojjsvvlLTYGVDdFQqxNpfyhUAzwTvkOutqN/af+Va+5M0edxr3o1mfrUoVxReWbGpdmERMeHZW92KnfSxrStjxFd4Qf/jRhJOIw3qQ1N0C2/UvaA1w0VpJWFmJgujnH/w3V54/05GxiSYuJtDW+KBPRcsP5AHoIZwIkNzaTyh8+Xcw6tQ6UFq3lFC8E6lNzNr5GZGAj5zvSSwmjzpdjlDN0GcJU17bJwnouYbba8fiPGmXjy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(8676002)(8936002)(5660300002)(7416002)(66476007)(52536014)(64756008)(66446008)(76116006)(66556008)(66946007)(2906002)(83380400001)(38070700009)(26005)(82960400001)(122000001)(33656002)(38100700002)(86362001)(71200400001)(54906003)(110136005)(316002)(6506007)(41300700001)(9686003)(478600001)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlFKNGoxWEUxK1FkeFNYQWd1eXMzTEdkUDVicUxPNjVqYTRCL1FxQ3k4Y3hV?=
 =?utf-8?B?OUQveXpEQ3RiWTk5MDk3OU1BSnY0S0ZKc0srTERUZWhDL3Q1dVd5U1dHaGxZ?=
 =?utf-8?B?cE5pOFE5ZDdVQ2lvYTh3Z2owaTByS0tGbFpKaWhxaysrd3MxcThvT01Gck9n?=
 =?utf-8?B?emt6ZVNIMklXU1krZjMvS0h2RWlXWk9qMjhaUHJGMmJMVi9lcitDU1k1YXZ1?=
 =?utf-8?B?NUp1NEpIZjc2cFFQSmhCNnc4WTJSUTNhVCtQellLRk9sdUZ2MFdDajlEWDB1?=
 =?utf-8?B?NEl4SmlnSVZQMGpybk1vczZtVU50RHZ2VmxSK2hFQkJydVFycUUvOHpubG5Z?=
 =?utf-8?B?UE5RUXdRdnJQVFVYc0Z6QjVOY1dOdWJ5RElXbWZJK1IwbGZiNVdPdENFelVl?=
 =?utf-8?B?VUFuM2lkTkFwUnM0WllKcFJJZUNXKzFFdzBkQUtxVEtKSjhKRkdwbUNGazQ5?=
 =?utf-8?B?QloxMnlFR2xnSmFMQWJZTXUvZ015K2NDWlQxVzMyMkN5ZTB4Q3MrbnRKZ2tz?=
 =?utf-8?B?RjdvN2orVDR0b2s1NkFLSUlYb3cxRlVScVFtRWVzOXlJYi85UnNaWlI1OW5k?=
 =?utf-8?B?ZjIwZXZrRlIyWE42QUlOcWYybnpCWkRCUkJmQ0o0WTQ1OWxRdjhYSkRoay9t?=
 =?utf-8?B?RHVRTnJCanE3K3A2YndFOXlweU04UTEyaUhxTlpJUTdWTE1xc1JYR0N1b01E?=
 =?utf-8?B?eCs1Tk12cXRZdmc4bU1SRFBWTi9CRWU3M1o4Z1JSMGZZa3pXZmg1NDI4OHRX?=
 =?utf-8?B?cmhQT1p0SFlkdm1nN1NRNVVFNXZGSEFFeWRNOGkxa05nazlPRkpxV2ZvQnJF?=
 =?utf-8?B?WldZV25IaGJraHQxZGs5MVZlT1N0OEo1R29icFo4Rm5LSlVmWXh1L0ZsMFpC?=
 =?utf-8?B?bHRGQlZGTEt4b3d4eWcyQzRMcVF2RFZERXNpWWR2cmdoSG1GMWUwbHZSN0VL?=
 =?utf-8?B?d2JDTU5mQ25DbW9VdzQyU3l4cTI0ajhBSDBDQjB6cW93bnBJWnlBYU8zQ3FK?=
 =?utf-8?B?YjYwOGNaTFhuMzVQS2VhNzZ1VnYvb1dtZHRrMUZicUZ4ZGRMc0tPUmpVejdy?=
 =?utf-8?B?blRPbkRUVklRT3RObUlMQlZyREpUMFVPeDcyM3NZU2xoKzM4eE5xNjc5Wmtn?=
 =?utf-8?B?NFhlR1ZEamIwaGVMYmRtNmwzR0wwdUU5NncybXNDSFI4Z1BWalpPTGc0aFlp?=
 =?utf-8?B?R1RHWENJZjVXd3F5d1pBTloydVlVRnYvTHVZZEdyLzZGZ2dEbzRyb2NlTG9o?=
 =?utf-8?B?WFhYTHBwRHlGbHB4MU1ZQXhVMjF1RlQ0RmdNcUpWUytMOHVObWRXa0tlUlBX?=
 =?utf-8?B?Qzk1aGs0RXVFbFI4TCs4dVFVdUgzcUxGdzBLb0NRdVd1V3lxR05oNmRXRnFK?=
 =?utf-8?B?c1VwN0pDTkVJSVd5enYvUTkyTzJ1RTBnYkJYVERMbVFuU0g5ZlV4RDZJZDBx?=
 =?utf-8?B?YUNiTHl4ajZFVFBjQlpTQkNHajlyRzdSUG8rQ01pVGZWTitQbS92Rmp0cTBM?=
 =?utf-8?B?QVNmcFE5ZXF0TjFWMkJrdGlOSmozTDd3K1BmdFErRXNQa0szZDlXTzdaRUtz?=
 =?utf-8?B?Uno3N2RWL2VUNXpqY1ZuUmdqSlBRNWNxNnBMQ0JVdXlTMmErdHJYek1uazFF?=
 =?utf-8?B?ZHFvMzdkcm1PdStCMFQyM2FXYURRTjk4SUUxVVpwSVpha3VTMDhJQi91andZ?=
 =?utf-8?B?OVo0RFd2T1czWU1YdDdkM2hFN0Robk5IbXQ2cFVPWEl6YVRsbTZ3TlltcjZX?=
 =?utf-8?B?ci90eHp6OWRwazBlTFdyNTZNSEZVTFRMbzRWcTdYNVRCczFpVENnMnlXazM4?=
 =?utf-8?B?d1MxVXc5L1NyR1pTSk13TGVnem5vekExQnNaWXU0ZDczeGNVMmUrcU9TSGMw?=
 =?utf-8?B?UGZqd1JRTFZFT3RIallhUWc1RUQ3RnlYdSsxb1FLdVZBUEl2V0JIZ1RyZ0F6?=
 =?utf-8?B?OHdGRTYyazZQMTVqcDlMSU8wNDJYNW1BbXFsYWRZMTlEdWRHVUtMRzZ2cE82?=
 =?utf-8?B?RW1jN0lGQmc1TWpHdCs2R1dEZW03MkU3anNob0kvZGd2ZkdycmdKeHdoMUVO?=
 =?utf-8?B?R0Q3aitHS2p6NHNDczVPUWYyVUVSS0kzN3REc2dub3puSTJSVVFJaUZWamNa?=
 =?utf-8?Q?URVPJ3SUNE+eiHvRBo5Grnl6b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a5a1f9-e233-45f2-6f93-08dc2d7021e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 15:18:00.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gqx0ECbmKEUZOh8lT1Jd37ILM3OfAd5nrv1yLy1UKpsOpabsaN5Lt1wmsSjeg6k5yiBKrUk2my5cOQNunmBHSQSs15LQv6ObSEGmWmNKdOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com

IA0KPiBUaGlzIGlzIGEgZ3JlYXQgc3VtbWFyeSBvZiBvcHRpb25zLCB0aGFuayB5b3UgSmFzb24h
DQo+IE15IHByb3Bvc2FsIHdvdWxkIGJlIHRvIHdhaXQgb24gcmVzdWx0IG9mIG91ciBpbnRlcm5h
bCBpbnZlc3RpZ2F0aW9uDQo+IGJlZm9yZSBwcm9jZWVkaW5nIHRvIGNob29zZSB0aGUgYXBwcm9h
Y2guDQoNCkhpIGV2ZXJ5b25lLCANCg0KSSBhbSBmaW5hbGx5IGFibGUgdG8gc2hhcmUgdGhlIHJl
c3VsdCBvZiBteSBBUiBhbmQgaGVyZSBpcyB0aGUgc3RhdGVtZW50DQphYm91dCByZHJhbmQvcmRz
ZWVkIG9uIEludGVsIHBsYXRmb3JtczoNCg0KIlRoZSBSZFJhbmQgaW4gYSBub24tZGVmZWN0aXZl
IGRldmljZSBpcyBkZXNpZ25lZCB0byBiZSBmYXN0ZXIgdGhhbiB0aGUgYnVzLA0Kc28gd2hlbiBh
IGNvcmUgYWNjZXNzZXMgdGhlIG91dHB1dCBmcm9tIHRoZSBEUk5HLCBpdCB3aWxsIGFsd2F5cyBn
ZXQgYQ0KcmFuZG9tIG51bWJlci4NCkFzIGEgcmVzdWx0LCBpdCBpcyBoYXJkIHRvIGVudmlzaW9u
IGEgc2NlbmFyaW8gd2hlcmUgdGhlIFJkUmFuZCwgb24gYSBmdWxseQ0KZnVuY3Rpb25hbCBkZXZp
Y2UsIHdpbGwgdW5kZXJmbG93Lg0KVGhlIGNhcnJ5IGZsYWcgYWZ0ZXIgUmRSYW5kIHNpZ25hbHMg
YW4gdW5kZXJmbG93IHNvIGluIHRoZSBjYXNlIG9mIGEgZGVmZWN0aXZlIGNoaXAsDQp0aGlzIHdp
bGwgcHJldmVudCB0aGUgY29kZSB0aGlua2luZyBpdCBoYXMgYSByYW5kb20gbnVtYmVyIHdoZW4g
aXQgZG9lcyBub3QuDQoNClJkU2VlZCBob3dldmVyIGlzIGxpbWl0ZWQgYnkgdGhlIHNwZWVkIG9m
IHRoZSBub2lzZSBzb3VyY2UuIFNvIGl0IGlzIG5vdCBmYXN0ZXINCnRoYW4gdGhlIGJ1cyBhbmQg
dGhlcmUgbWF5IGJlIGFuIHVuZGVyZmxvdyBzaWduYWxlZCBieSB0aGUgY2FycnkgZmxhZy4gDQpX
aGVuIHJlYWRpbmcgZm9yIG11bHRpcGxlIHZhbHVlcywgdGhlIHRvdGFsIHRocm91Z2hwdXQgb2Yg
UmRTZWVkIHJhbmRvbQ0KbnVtYmVycyB2YXJpZXMgb3ZlciBkaWZmZXJlbnQgcHJvZHVjdHMgZHVl
IHRvIHZhcmlhdGlvbiBpbiB0aGUgc2lsaWNvbiBwcm9jZXNzZXMsDQpvcGVyYXRpbmcgdm9sdGFn
ZSBhbmQgc3BlZWQgdnMgcG93ZXIgdHJhZGVvZmZzLg0KVGhlIHRocm91Z2hwdXQgaXMgc2hhcmVk
IGJldHdlZW4gdGhlIGNvcmVzIg0KDQpJbiBhZGRpdGlvbiB0aGVyZSBpcyBhIHBsYW4gdG8gcHVi
bGlzaCBhIHdoaXRlcGFwZXIgYW5kIGFkZCBjbGFyaWZpY2F0aW9ucyB0bw0KSW50ZWwgb2ZmaWNp
YWwgZG9jdW1lbnRhdGlvbiBvbiB0aGlzIHRvcGljLCBidXQgdGhpcyB3b3VsZCBvYnZpb3VzbHkg
dGFrZSBsb25nZXIuIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==

