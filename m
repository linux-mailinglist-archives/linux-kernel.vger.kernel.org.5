Return-Path: <linux-kernel+bounces-62238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD6851D72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F971C2243B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EACF45976;
	Mon, 12 Feb 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xis5EgEU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B954176B;
	Mon, 12 Feb 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764327; cv=fail; b=AE47QhO8OBQma0Q1GZAAnyWaSlO3krtUUkseqer8aTz/dG1CFssu9VRrZ8LEuqys9K7cNdjLPRK33f5HWjqpOjOI2RTCFUaWPrTuiSrSqvtvqJ9JOL0BbEThD4XlfL7BEJ8CpbPuk3tGNLG3Br0AnyhZMVHcCHCM8/WRj5uuMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764327; c=relaxed/simple;
	bh=LieeVqd7C7p79O+kd+wn0nguoT23ySGoCOpMk+0u43I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LE5qwEUO8IGgtGnDgL6cHqDUPYc6ckAsUWLwxOwC6NOJsKRp9GPD9XAnss7WBO43Pg9Mxm6R1PwN9hG4t+HOBu6Pjm1epvBDaihiZVgpTwpZO9URaa8urP6BgKApdevlIvKrYgbK9YlRsgAUYsA2qikDZ+9njR5oZ1cF6F7uEvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xis5EgEU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707764326; x=1739300326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LieeVqd7C7p79O+kd+wn0nguoT23ySGoCOpMk+0u43I=;
  b=Xis5EgEU2lzJSaeaDQHminiCSabmURVgY/Kzdz42fG6s/tkqca7uFBWS
   TwlyWoakfxU9f8Pjrnz4bqGuWb0qFC5Omp62Q8/u5IvjWA5f5qSgpAAbT
   ONOsWO8XG1gWf27FCWB36k5KBmqUP5VE8FMh2gMW1wrGjBnG5DL34aaoQ
   KWeK39KuejOpvJwM13xrkhEom3ztIYvL3BpI03Rz9wXV6gh1xPbrknoTo
   mbNkLC+VFCOT4fd3sEin8QXE2KfFI5X2HqawdAYibp1gTIFVbbrofx7RH
   5N4gd9a95ZDwmbi08zKWYUJt09DJyLNtkXH9Wpu2R0Q8/Li2siGCnIbLp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13137715"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="13137715"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 10:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2625046"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 10:58:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 10:58:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 10:58:44 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 10:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvUH3tjGaVua8fq3okFXixsMakIM+7dTCOciJtfUBZs+rMcK+hwIZsqh3lvacRJv+Trfa4mkpg7cuXQKMdBknVALuix5nSf7+IuRwkoCRrzRriF6tz/9aUhFWw13GRHn0trZ8Y1tMCHtVf5+D29dLZfLv0Xsr48MTbwmJeapc5jrA3ZwAeffYAlDLw0p+CUjrima+US4LrfskHZrPcRgimT5foE7BVcXVtO57WwUTEH3bPvDMjfL04Vs8YFRoTx2V56GORz6dDRMW1aB8Fx+8c9cYupD2YbdV7CNPgAvJ9gp8+ShVoZuZq2K4OYDAzCHL8EBs3SGoYDSqYQyIprXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LieeVqd7C7p79O+kd+wn0nguoT23ySGoCOpMk+0u43I=;
 b=bbId9tWEm98JTnDr9bwWyeMG7NxxIJeIWXCpg2+eh1yKXgby6iDu7zu4Nj+5mmDtutXF3Jv5YfuA/Rl8aRMgr1VWwg5zYZM6RtNWFdadMR3Ku1D8QLWLLYsScgo+UtpykkeVU71TSGtHYBelqvRdfeV24G9n5PYV58XwNi3xvUJQLvlRjN2X9ZyWA6r+tyoY4pRCeUDdUgPR5342emoXogJVd61Uom17Wfr3W31qzM3+n0cybyM/pIBSGwtBcwyOTaH1ZFvD2uD0T3NGhvo0JKOcr0+2F0ADpIHDPUHv0ny4TnCDJmrr2CT1HyBH3Zrohn1yeaXzx2LKHIONViFDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7046.namprd11.prod.outlook.com (2603:10b6:510:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 18:58:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 18:58:36 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	"Naik, Avadhut" <avadnaik@amd.com>
CC: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAhC1AIAAAfPg
Date: Mon, 12 Feb 2024 18:58:36 +0000
Message-ID: <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
In-Reply-To: <b5904910-ed58-405f-9425-566383b48068@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7046:EE_
x-ms-office365-filtering-correlation-id: ffe676bf-5fa5-4062-4d4a-08dc2bfc9e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSOFce39f6QXFl3hMp5MITNoJhJ1oHK9bFm6FNv47rQFYHzZsKCEp+Us8xl658aLQfSh3B2p6hUkUDZPWu5oIDUzq1q9Mf7Zxzu/UX7/32T8W6Xo8QrIppY38FBmA9mC5Y0Eb6E7cOQ8BnFYFDxFucMaVBzJu+L25ObqLMKMiurBUQtqGJh751HbwwkYM4fj+QK6hIX+n8hd00e2rjPnh9KI7hltNEn93XrYYIrvwIqIq2ZJqdkEy+z7KYeMmCoTY/OBeSkPhNEAih0LKoNxFuoR7rS61myRLm2l74l7vsSzU11jKTEpDJbJF53Pq7C4nizj0IgHl46FGHU6xojq3H45ZZuvJLlmOEgDQ02OQumzgq903sOtKqFI2VTBrpiy3fwcFNBREU92Enpuoc7j6FmEMii5KdRlC1CuEVDZLmWRT//zQJV4EuL2V5ebWr8cFs0IFfvBT7CwYLDrZq7e2DIvIlV/+Qy4UO6NaMtQMMjN7Zn/d3ezk1BsMwsbo1Zq52q8ZkNqikSTpeCPVyYFS+yg8LZ2VbEDorwfUiCgkXD1FN46mrzYDfwrsefV85UWXAX/Rfc58Xx5kUFnfWYkUDJQaPWlwT0hzpe+bE0ky++xlhd8ffNCFbGDaaxuojDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(55016003)(9686003)(478600001)(41300700001)(4744005)(4326008)(8936002)(52536014)(8676002)(2906002)(5660300002)(110136005)(76116006)(38070700009)(7696005)(6506007)(71200400001)(66446008)(66556008)(316002)(54906003)(66946007)(64756008)(83380400001)(66476007)(86362001)(26005)(82960400001)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGRkUi9STjF0QWdyZEFyWmE0SkwxN3E4ZDNSTXUxay9aOFpyODVNRHo2ZFFF?=
 =?utf-8?B?MUxsOFNjejYyczlEd2hJMW5RSkUvTkFrTy9WK0RQTEl5UlZQbkdEK1pDY3BI?=
 =?utf-8?B?WjVmaXNHWkliNUR5YWI3Q1pnSkEvSFFsZ2RLbGxKVXpSRXNWamFLTUFPd2dz?=
 =?utf-8?B?N29vSTVhdXhnZ1lKRlFEREpzaTBaNkRRdGlldSsrUk0wV3o2L0Z3UUlVeWZu?=
 =?utf-8?B?ektnNmRzL3RFaU9aOEhzK0FpREd2Ym9KVTllVXBzN1AyZ1YvTTQxNy9Oa0tl?=
 =?utf-8?B?SFdmTHExWHpHYW8rMGpmN3RRRGMyVTZJRVRxN2h5Rk15MHhNQllDR1VydGRE?=
 =?utf-8?B?Nnd0TCtrM3RacjBNcWdCSEQ2bTlKQ3Q1S2Z5b3pDeitsSS84YjRTNE1yOW9t?=
 =?utf-8?B?bS95NWZOaWprN01LcVplYVYyc0dRdVEvWXBHNlJhQkg2Z1ZURWtGVWpNbTk1?=
 =?utf-8?B?YjAwMndWQ0ttOWRkYU9IM2FGbHpZTUI5QlhpY2xEanNGZVhUeUQ5SUZVM3By?=
 =?utf-8?B?SEZFc3RQSzliME5VS2xaZWNFSUFmcS9IT3pFUVVzc05FOGY0bkkwSG9LMktQ?=
 =?utf-8?B?cGcxalFhZWVYZXNtR2daclkyakxXSWdRRHB4RTZoeVRqMFVmeWFTQTlIclVa?=
 =?utf-8?B?Zi9iOWRDODdtdDhJQjRDSUJhR1A0cGZqR2lhL29URk5MVFBabWJnbGNQcGJw?=
 =?utf-8?B?YUl5Ly96cGhYYmJSdk1BdnB4VjNMd1JNZXlSNmpQNlNlZUNrT29HT0pHQ3Nt?=
 =?utf-8?B?Z2hpYnNkT1pJNlZjWmpqcTVkKzhBTS91YWZYcENNMU9UNS9lRkh3Y3hXQi9D?=
 =?utf-8?B?WTFTRmsrczNRUGFNWkV3UHcwTFdlNnFhRXF4bE5wbDdHaCtCZWwxb2U4TzN5?=
 =?utf-8?B?cno4MEUzc0NQMFVmY21EekpaanRsOXJKZlZZS3NMbFU5T0tKbDBjL093cGly?=
 =?utf-8?B?RDZUZ1d4QUxiZW5OcFZnbE9reUlySTZYU0lqdnVldlFvOUc0aHA5SzdxNXAr?=
 =?utf-8?B?cFRTalY1U1F4SUQyN05UT2YvbWFjUHBlV3lKS3BjQlpWSk93NDBXS3UxRkVY?=
 =?utf-8?B?MlBUMnhUZXhXbWlXVVl0dHJoWjBnN3dJTkVtWE9jYjZiUnBiYk03SnFvYnkx?=
 =?utf-8?B?b1Y0VUxwZzNCS01VR0xjMHdHaENKODJkR0V2WkM0dlNocWZraEJSY3ovOGlt?=
 =?utf-8?B?NEg2SThVMXM5VmhEbG5FZTJPMjN1QnV5SWRZRjI3WmtjYjRLem9wZ0p4aXU2?=
 =?utf-8?B?aVJZNXdiZW5HS2ZSSTcxYTcxMm5sK3QyQ3ovSXo5UUZZK0hONVN5UnM4Z014?=
 =?utf-8?B?anBKZEwyY092WEFNNDFXVU5ydUpiU1EycTNyK0NQV3RKUW5ubjdxN09ZelFP?=
 =?utf-8?B?RVE4VVNkTHFRN2o4QVhSZ1p5N0IvN1NsVUt4MGl5ZjUyQ3JvbVdqbXROVWRG?=
 =?utf-8?B?c3VMcXpVVytkandJc1lyMkVPalhpOW1UVEJpcktHYklNUnYxRWhCREVuNFRQ?=
 =?utf-8?B?UTJhSVBIUS9WM2k0N1BNYVlRN0pjdEZOYVBPRFA2N1l0SjBPMjlnQmhxZTFZ?=
 =?utf-8?B?ZU0wbXgzbitNb0FVWngxS2RBOXVIeGNDbkloYWIxKzVoaWw4NWhzMXM4SmN6?=
 =?utf-8?B?MUhjQjFCVmlpUTZEY1M5dWlLMDhXYjdna01wdFZSWngwZ2lMTVV0RXNWN3Rz?=
 =?utf-8?B?U1YwMTI3Q0JreGhiVjlweVh0c1A2QTFia2pDOVhaMnJaYWh0SmtWak1qQjNU?=
 =?utf-8?B?aEdBdXdKb1BERlhuVjR4QlVtYzVQckdxSUtXTEFCRDZIWFczZzh5bTZhLzJK?=
 =?utf-8?B?ZjVlN3haVWpsaFRUM0wrSTlReURyTVpFSEtRWThaalduMHkyNExlMzAvZkIw?=
 =?utf-8?B?a2xwQUVWcHN2SUFBbTEvZEJhWnlEbEV5ZERYQlZDOVFyUzJSWjlvYW51dU5G?=
 =?utf-8?B?WStUNlVaRGxMWkx6eFBhaDlYU291N2VJc3JucE9aaFRkTjMzTS9oRUxJTEpw?=
 =?utf-8?B?RDhoT2Vqd2ZYQk94bm5hdXFPRHNVSDRaWkNtOFljY0V2YmQ5b1JSYTMxQTgr?=
 =?utf-8?B?am5WMmVKdWlYMVNYdEtkMVVDT1Q5R25OdHA4QXpjVzFVZTRkanZlTXFDSit1?=
 =?utf-8?Q?LfCIgNUIT/cwuieTwblqPn09q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe676bf-5fa5-4062-4d4a-08dc2bfc9e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 18:58:36.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2sAR5lzCRihN17r7+ViaUfE4k+jM39oSXI3oI5S/dYTkOpNV6AbqP3uVA6tVMM6xYceZZvZzYO5FmCE23O8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7046
X-OriginatorOrg: intel.com

PiBJIG5lZWQgdG8gbG9vayBtb3JlIGF0IHRoZSBnZW5wb29sIGNvZGUsIGJ1dCBJIHRob3VnaHQg
SSdkIGFzayB0b28uDQoNCllhemVuLA0KDQpnZW5fcG9vbF9hZGRfb3duZXIoKSBpcyB0aGUgY29k
ZSB0aGF0IGFkZHMgYW4gZXh0cmEgY2h1bmsgdG8gYW4gZXhpc3RpbmcgZ2VucG9vbC4NCg0KVGhp
cyBiaXQgZG9lc24ndCBsb29rIG9idmlvdXNseSBzYWZlIGFnYWluc3QgYSAjTUMgYXQgdGhlIHdy
b25nIG1vbWVudCBpbiB0aGUgbWlkZGxlIG9mDQp0aGUgbGlzdF9hZGRfcmN1KCkNCg0KICAgICAg
ICBzcGluX2xvY2soJnBvb2wtPmxvY2spOw0KICAgICAgICBsaXN0X2FkZF9yY3UoJmNodW5rLT5u
ZXh0X2NodW5rLCAmcG9vbC0+Y2h1bmtzKTsNCiAgICAgICAgc3Bpbl91bmxvY2soJnBvb2wtPmxv
Y2spOw0KDQotVG9ueQ0KDQoNCg0KDQo=

