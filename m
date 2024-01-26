Return-Path: <linux-kernel+bounces-40167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A537883DB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81EB1C225F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA51C29B;
	Fri, 26 Jan 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UK9OLub+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E751C287
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278244; cv=fail; b=ikLVoWGKgtuh0mnpPdnIiAOUVnPlImmqMESAHxRRLBgw3BbayZWXfuEpcZcD5bClWltnuiQNmfE8I4wZJKfwJEuNVdB2DgvqiOOJgvnAt6n+eZ/+7aPaDOlxjH/klknWtrm4yLx0V3Kt3uhaJ7nk1F/G3cmtKOi0bnflSMTO4BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278244; c=relaxed/simple;
	bh=w2xNabLH+9NMKBHy6FPG3DGT06PO0EFnNX0vz/2PWho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E83zGf/XWbgKWTxn+klR1JyG0Fa6fAfaSCB6mLNwEJy+DYflLp8Cw+OqT5+XikqTDNP851WF1CF4erHJ7J2MVIQmYTvEhnnA4w5K8o7g1Xp7TaTcLV4LsCMtxVYlqsKh0p/iQvWaz0uhaXZpBuPJHfXuG1tKszI2VzUEYdN6psU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UK9OLub+; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706278242; x=1737814242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w2xNabLH+9NMKBHy6FPG3DGT06PO0EFnNX0vz/2PWho=;
  b=UK9OLub+Wk7armsh/qMMftSwolipCA1stcqhPJROvjmzxACQunUzrXAY
   ZCDa5UsZKu1IxH+cn53O8ghfVBXqacGPrwpq9Xx0ghiREC/ljEA3V8/zr
   6VSuhhgrku/WO2OplguSgZrL0knCKnIDusu3fRBu1K3WBHuAUF6/rzMZj
   c9Ds9dCDjmoTg00SqGCzzm2M5t7+ng0GBRy/RcBSeVEX2TzJvyZRYQwVL
   NVGzjIQ1ygK1yWO7ZlheGbxomf+CMbRBRra/cp+8wW6k2PD7b7og1WWN6
   B3Mlwfo/dIkMu1s5HVMFIGguxORAZ8jaDciFZhmqfbSivui3K5z9kODeX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="406210597"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="406210597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930378244"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930378244"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 06:10:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 06:10:40 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 06:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvBbAPSIkEeoYZ0FMR8MYu4hocECGIIucI7FO4P0qOhBiqcmlJj0L2f22V7+l1Ulx5U2en7e9nw/TA34OjeJ8YgpvmD3xMiHC4ChnN1mwfuOub2RyVXFQEvmS5IgtK0/i8DzCLohYyQXbqHMEKjLYIOvk7j7K+7oONbcYLBcIK5a6Ah4JyoOQ05Y3b8si6hT4d2hg9p6hxYHzuFFI3EhSkKYnkO3U/dUh8o3Hf2fJVJkXKBhpnQBq61uxJmOK+//84+3j0PL63QVN0FEuEBAFFJUeKzBGRDtkTrYw4hJCraISeOptrMcY22LdnOOQUDhG2GQnQ+e1MjsBmpKfnRPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2xNabLH+9NMKBHy6FPG3DGT06PO0EFnNX0vz/2PWho=;
 b=P2z8MugGHHf0kWDcq3MRvbr6iYQugQM4SzRXLyXjdPKWkDvJqAWQZGn17ZGVl6rmM7GsjDfe9GMmwXwFa9sh4HaasXepPlDi03juMBuzql2sknEPE29W2DjmgDGpkvT1GwhO/4xL+bW0yl0Ry1pUHj3PwAxOFsJ/z3ruC3Y7aoPPOq+cdQcKAAZR03BuRTH8dm+/vcimVOBlW1JuZG50jjx60pZS3M1t26xvtadZG5tpn7v3YA72bqXQAd699w15FPPgWdRgl1JKpJuOLz3plh1tgoe4+gKkEux3qM7C0E8vUC8ljGmk8thyLk3QgTNr+iWOWbYV0n3izfFP3xtJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 14:10:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 14:10:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv6 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Topic: [PATCHv6 15/16] x86/mm: Introduce kernel_ident_mapping_free()
Thread-Index: AQHaTsTx74MyFSJEiEuU67rhNLvRArDsJVKA
Date: Fri, 26 Jan 2024 14:10:37 +0000
Message-ID: <f57921c8de497c36aaf0235679efea3f9844d471.camel@intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
	 <20240124125557.493675-16-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124125557.493675-16-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: 61dd24a2-d5cc-4ec9-83ff-08dc1e78921f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0V2J6JCyo3qq0oTfpaAlQD87Oec0u8rW/jLnZLO9KDiFRg/hLDhFh542RxaZwN31uzsA/KsoIvwhaslvrFW/CJbKx8i7fO/yM5FuaxFkvSwR7tM1iUz+5hUjhLdqxff1pasW340OaTIvv2ndyhT+pLJxt3KDTub7ivaxVoSjKz+NtEeClVf+Li6gAust0+gWTbcVIl/X3O0CDIFnHzvS5b0eMh6Fr8OYGW89VKUl3Ab26UacvzPeKPvgcT/EtJ6slkEwVK6lYWtuWA9VvEI0cJMzSDkXamhtblu70suXsBPazJRKT5i/8MZObhovGa2aHahHLaqIzxEUGfpUlno9S4kUz4olm9IDhVlHOp3bJ5VU6hxE5fXu1hnZygavysLg7TwEuo+r7hnY1xPuGG07oWWppiAWbx68p8+HEc6qiDFLlvSR+x41piFlLspS9SYUU3PGBG/dhox5J93Rhn824yIfbsSta7zfJKYP5A4BXQVgrvGSX5hPYieDWBYdpp6XYBa8TyGXjYcm0kGSNZiU2edBOa54ocCFWyq1zaPGe8rzhLrNv2mbzAnzayeI0vwnqojGo/sCG3rHKemdrG5Azt+8MIioFY+L8ExGBOvVhG7rpVRsGIMOUb2VJavgDVPu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(7416002)(38100700002)(2906002)(122000001)(82960400001)(41300700001)(36756003)(5660300002)(38070700009)(86362001)(6486002)(26005)(478600001)(6512007)(6506007)(2616005)(71200400001)(4326008)(8936002)(8676002)(316002)(66946007)(54906003)(66556008)(66476007)(76116006)(66446008)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXlRN0cveU8rV0RtRThxQzV4RUp3c3N3Uk0wa1dyQ21jK2IyUjU5S2drVnpO?=
 =?utf-8?B?bFNtVktHRllyTTY0NEp2NlhRNEN3Sk5HTmlLYVV2M0s1SkNWMzNyY04vaEtC?=
 =?utf-8?B?dGdsdmRSSEFLTnVkdFZyOTAzK2dibndUZHc3SHgyQk9sMzQ0QnVkMnM2YlZ4?=
 =?utf-8?B?ZHBGL25CR0x3YWJDd2VUSFQxbzZMLzU2ZGNCOTcyUTdkU0xsclFhbDU0aWND?=
 =?utf-8?B?MUJDeEdiN2pHRmtHK2Q1aitvS1JaZVF0RG5ja0E5S1BNQktJRVhXZWhQSTQw?=
 =?utf-8?B?dVphTmorRno5Mk5PbUs3WWFWbGx6eUUvRmVGUTdTcWhsUENVSWJhL1gycUtR?=
 =?utf-8?B?SmlvSHFoV1Fva09hWjFneHNzUVNVKzFQTlQzU3VqM0RWVjdGR2U1bDR1RlZ6?=
 =?utf-8?B?cC9lMmJnY01EeGVrZm9uaytBUnY1U2NmOW5KaEFzSDh0WG9qZXFqUC9jemZ6?=
 =?utf-8?B?WWFhVEpmRXNPc0xqZEM2TUlDeDU4Y0tYWlVxT04rcmkwekNqbFp2WGVvc1Ew?=
 =?utf-8?B?amZJZitQYWFlR0VRYkFEazRrTXZlQWxSN1pLdU9OKzV1UnR6aGJYbHMvZy9H?=
 =?utf-8?B?ZndoSUtZN3o0Mnk1UzZxSWFpWHd1dFN0S2xWME5sRm14TFBlekFybnY2bFN4?=
 =?utf-8?B?RGhmMlQ4ZUtCNUx1QkttZnFFZEhLZU00S3hWbU9EbWthbHcxNjhpTEs1WVh5?=
 =?utf-8?B?TUNtNmZMc0IvM3BNVmMzWFg4dkdwR2VmY3kwOEF0VkgyM1NuOE1aUFBQTFND?=
 =?utf-8?B?MzlEbzQ0Zk1BWjhOMGMrdlRqZ3BvY25yQ2VYZEh6Z1F6bnJhSGNCanR4Tk5V?=
 =?utf-8?B?VGhwK1Jtc09ZeEQ4NHgyV0ZieXk1SzREUTZBNldMSTZmVURtcnZkcmhJMXVv?=
 =?utf-8?B?bmROZnVWQU5mekQ5NFdBVTZpSm9DV2VzdXY2MktEUTJ4bXQzbnBqeWRBanFs?=
 =?utf-8?B?eFlTTE1nbDcvQ3MyWS9pc2Uyeng3bzRhTzFpdzg0aXFIZGNZUDhWVE4vckdD?=
 =?utf-8?B?eXAzbFlPcGZYWG9MWE8xZm5UaUptTUhnZXRGaWhiNUlNTXRWK28yNEJJS1Bw?=
 =?utf-8?B?TkVXNVVqZDA3VDdOelhWNFRrOFlzVVZwVnUvd09ubkZ4OHhDcHBoMmFVL2Vv?=
 =?utf-8?B?ZHZxb2VaU1plTEZiaGJkRHBrS2NtcEpmL09mVk55U2JUMzI4c2lVQXhjc1lG?=
 =?utf-8?B?MWVJSDFhN1hLcmlLVWZkYWVMdm9yT0t1Z1E5ZG1uNjREVWgycmE0QXMwQlRt?=
 =?utf-8?B?eWJ5MzM0Y2lqV2JQRTRjOFdmb1hTR1hUcnFPcUxtNUxGRW1FR1AvbW9jQWNw?=
 =?utf-8?B?MDh3OXc3bHBLUlFzdHZTSW9YVG13bitEVXdsLzBDWXJqNEdXa1JBdSsvZGFr?=
 =?utf-8?B?MDBqNm43YkZXeEcxSXRrZ01vcEZZcmxwenBxY1AvUHBUQUd2S2NLTFg3YmVl?=
 =?utf-8?B?QVhRV09lbVRFY3YvMjZPVHBCMnB2cFpMazBqaEo3SXY1b01JMktXNStMRFkr?=
 =?utf-8?B?ekdqcHVEb3htaWpkMGtHOXJTZkp1bWMrUTZMNnFFeHJ4M2FSdytGQnVxZ2NT?=
 =?utf-8?B?Q1hZdHJvTXdYeWZ0ZzMzZTdjcHd3ZXpINFVWOW03eUpHVW5paXlLcTdBRFZZ?=
 =?utf-8?B?Q3BSTThGT0NlVkhDbW1waHdnbEJkMlphOS9za2o1djBwS1F4VGtWZWdyVWdO?=
 =?utf-8?B?a2JXQ3hiVEVTazdQeGlkSXlYVzZueHFmanQxMm9ERnhTVVpQRkRuUlIzTGwx?=
 =?utf-8?B?Z1dSYUFydForNDAzWlNSTUp6NHZBOGpkVXlGMmRDNGdkV1dseHU2eENaKzAw?=
 =?utf-8?B?RW96eXRrYWt0ZUVEQjJmTEFNK1hpbUpWTW00MkUwVURlSzNiZDRFcHFCb3VU?=
 =?utf-8?B?VE5mdVVlWG1ia0tFdjh6YzlPTUhUeHJFQWtHTHFBUnBhdFFUbUhSWDlJTm0y?=
 =?utf-8?B?NWJnZ09RMitCOG1SQjlzNkRYWWQzbnBXUFpDVy82Q0kwNENES2lSdXJESFNE?=
 =?utf-8?B?MEhZTHJoT2FKenh0aHVtVGRSVlV3K1hmMFRHczMyUk15NFpXZVpRN2pzRThC?=
 =?utf-8?B?SzBVRVhDSlQyQWxIUmg2Unc2dHRDQmdmUys4ekxiOEpRV0R4M1NBbFFJejdK?=
 =?utf-8?B?bmtKUUlwYU9XZGczYm9EWWErcHNCZkJaK2NoWlhhRkFDaEpVRGIvZmR5Zk5F?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E155BA1184E51941A8041FBFBA6A8F37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd24a2-d5cc-4ec9-83ff-08dc1e78921f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 14:10:37.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9hk8UWvf7AWx0/PLKUFhTYCMLiZXJsKxTzjVjED6pX96Jgb3r7zFDWGox1aFFnXYcOAY9vWu/3QQ0TqG9gqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE0OjU1ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBoZWxwZXIgY29tcGxlbWVudHMga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdCgp
OiBpdCBmcmVlcyB0aGUNCj4gaWRlbnRpdHkgbWFwcGluZyB0aGF0IHdhcyBwcmV2aW91c2x5IGFs
bG9jYXRlZC4gSXQgd2lsbCBiZSB1c2VkIGluIHRoZQ0KPiBlcnJvciBwYXRoIHRvIGZyZWUgYSBw
YXJ0aWFsbHkgYWxsb2NhdGVkIG1hcHBpbmcgb3IgaWYgdGhlIG1hcHBpbmcgaXMgbm8NCj4gbG9u
Z2VyIG5lZWRlZC4NCj4gDQo+IFRoZSBjYWxsZXIgcHJvdmlkZXMgYSBzdHJ1Y3QgeDg2X21hcHBp
bmdfaW5mbyB3aXRoIHRoZSBmcmVlX3BnZF9wYWdlKCkNCj4gY2FsbGJhY2sgaG9va2VkIHVwIGFu
ZCB0aGUgcGdkX3QgdG8gZnJlZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCg0KRldJVzoNCg0KQWNrZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2luaXQuaCB8ICAzICsrDQo+ICBhcmNoL3g4Ni9tbS9pZGVudF9tYXAuYyAg
ICAgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9pbml0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmgNCj4gaW5kZXgg
Y2M5Y2NmNjFiNmJkLi4xNGQ3MjcyN2Q3ZWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2luaXQuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pbml0LmgNCj4gQEAg
LTYsNiArNiw3IEBADQo+ICANCj4gIHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvIHsNCj4gIAl2b2lk
ICooKmFsbG9jX3BndF9wYWdlKSh2b2lkICopOyAvKiBhbGxvY2F0ZSBidWYgZm9yIHBhZ2UgdGFi
bGUgKi8NCj4gKwl2b2lkICgqZnJlZV9wZ3RfcGFnZSkodm9pZCAqLCB2b2lkICopOyAvKiBmcmVl
IGJ1ZiBmb3IgcGFnZSB0YWJsZSAqLw0KPiAgCXZvaWQgKmNvbnRleHQ7CQkJIC8qIGNvbnRleHQg
Zm9yIGFsbG9jX3BndF9wYWdlICovDQo+ICAJdW5zaWduZWQgbG9uZyBwYWdlX2ZsYWc7CSAvKiBw
YWdlIGZsYWcgZm9yIFBNRCBvciBQVUQgZW50cnkgKi8NCj4gIAl1bnNpZ25lZCBsb25nIG9mZnNl
dDsJCSAvKiBpZGVudCBtYXBwaW5nIG9mZnNldCAqLw0KPiBAQCAtMTYsNCArMTcsNiBAQCBzdHJ1
Y3QgeDg2X21hcHBpbmdfaW5mbyB7DQo+ICBpbnQga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdChz
dHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcGdkX3QgKnBnZF9wYWdlLA0KPiAgCQkJCXVu
c2lnbmVkIGxvbmcgcHN0YXJ0LCB1bnNpZ25lZCBsb25nIHBlbmQpOw0KPiAgDQo+ICt2b2lkIGtl
cm5lbF9pZGVudF9tYXBwaW5nX2ZyZWUoc3RydWN0IHg4Nl9tYXBwaW5nX2luZm8gKmluZm8sIHBn
ZF90ICpwZ2QpOw0KPiArDQo+ICAjZW5kaWYgLyogX0FTTV9YODZfSU5JVF9IICovDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9tbS9pZGVudF9tYXAuYyBiL2FyY2gveDg2L21tL2lkZW50X21hcC5j
DQo+IGluZGV4IDk2OGQ3MDA1ZjRhNy4uMzk5NmFmN2I0YWJmIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9tbS9pZGVudF9tYXAuYw0KPiArKysgYi9hcmNoL3g4Ni9tbS9pZGVudF9tYXAuYw0KPiBA
QCAtNCw2ICs0LDc5IEBADQo+ICAgKiBpbmNsdWRlZCBieSBib3RoIHRoZSBjb21wcmVzc2VkIGtl
cm5lbCBhbmQgdGhlIHJlZ3VsYXIga2VybmVsLg0KPiAgICovDQo+ICANCj4gK3N0YXRpYyB2b2lk
IGZyZWVfcHRlKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBwbWRfdCAqcG1kKQ0KPiAr
ew0KPiArCXB0ZV90ICpwdGUgPSBwdGVfb2Zmc2V0X2tlcm5lbChwbWQsIDApOw0KPiArDQo+ICsJ
aW5mby0+ZnJlZV9wZ3RfcGFnZShwdGUsIGluZm8tPmNvbnRleHQpOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgdm9pZCBmcmVlX3BtZChzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcHVkX3Qg
KnB1ZCkNCj4gK3sNCj4gKwlwbWRfdCAqcG1kID0gcG1kX29mZnNldChwdWQsIDApOw0KPiArCWlu
dCBpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IFBUUlNfUEVSX1BNRDsgaSsrKSB7DQo+ICsJ
CWlmICghcG1kX3ByZXNlbnQocG1kW2ldKSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWlm
IChwbWRfbGVhZihwbWRbaV0pKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJZnJlZV9wdGUo
aW5mbywgJnBtZFtpXSk7DQo+ICsJfQ0KPiArDQo+ICsJaW5mby0+ZnJlZV9wZ3RfcGFnZShwbWQs
IGluZm8tPmNvbnRleHQpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBmcmVlX3B1ZChzdHJ1
Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcDRkX3QgKnA0ZCkNCj4gK3sNCj4gKwlwdWRfdCAq
cHVkID0gcHVkX29mZnNldChwNGQsIDApOw0KPiArCWludCBpOw0KPiArDQo+ICsJZm9yIChpID0g
MDsgaSA8IFBUUlNfUEVSX1BVRDsgaSsrKSB7DQo+ICsJCWlmICghcHVkX3ByZXNlbnQocHVkW2ld
KSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWlmIChwdWRfbGVhZihwdWRbaV0pKQ0KPiAr
CQkJY29udGludWU7DQo+ICsNCj4gKwkJZnJlZV9wbWQoaW5mbywgJnB1ZFtpXSk7DQo+ICsJfQ0K
PiArDQo+ICsJaW5mby0+ZnJlZV9wZ3RfcGFnZShwdWQsIGluZm8tPmNvbnRleHQpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgdm9pZCBmcmVlX3A0ZChzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5m
bywgcGdkX3QgKnBnZCkNCj4gK3sNCj4gKwlwNGRfdCAqcDRkID0gcDRkX29mZnNldChwZ2QsIDAp
Ow0KPiArCWludCBpOw0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IFBUUlNfUEVSX1A0RDsgaSsr
KSB7DQo+ICsJCWlmICghcDRkX3ByZXNlbnQocDRkW2ldKSkNCj4gKwkJCWNvbnRpbnVlOw0KPiAr
DQo+ICsJCWZyZWVfcHVkKGluZm8sICZwNGRbaV0pOw0KPiArCX0NCj4gKw0KPiArCWlmIChwZ3Rh
YmxlX2w1X2VuYWJsZWQoKSkNCj4gKwkJaW5mby0+ZnJlZV9wZ3RfcGFnZShwZ2QsIGluZm8tPmNv
bnRleHQpOw0KPiArfQ0KPiArDQo+ICt2b2lkIGtlcm5lbF9pZGVudF9tYXBwaW5nX2ZyZWUoc3Ry
dWN0IHg4Nl9tYXBwaW5nX2luZm8gKmluZm8sIHBnZF90ICpwZ2QpDQo+ICt7DQo+ICsJaW50IGk7
DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgUFRSU19QRVJfUEdEOyBpKyspIHsNCj4gKwkJaWYg
KCFwZ2RfcHJlc2VudChwZ2RbaV0pKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJZnJlZV9w
NGQoaW5mbywgJnBnZFtpXSk7DQo+ICsJfQ0KPiArDQo+ICsJaW5mby0+ZnJlZV9wZ3RfcGFnZShw
Z2QsIGluZm8tPmNvbnRleHQpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBpZGVudF9wbWRf
aW5pdChzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcG1kX3QgKnBtZF9wYWdlLA0KPiAg
CQkJICAgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCkNCj4gIHsNCg0K

