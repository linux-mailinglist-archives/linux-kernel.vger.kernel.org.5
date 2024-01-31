Return-Path: <linux-kernel+bounces-45980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2F884389C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9F9B260AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523BE5812F;
	Wed, 31 Jan 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLrod+71"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AE58135
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689024; cv=fail; b=O54iQmUSQ4CYZBa9gYopplxWTioIKqeRWMYyQL+AYuR9FR840aa2PxMVpAZ9Gs34gChVWzIM8uJO7SM/N5esvhkKm0imSWiS6AM9hmApk7f+AnXGtzLPxrPrEY5OdJ9LwNCoAkpUjRXxT47Iee+5GS0cGUghxgbyXzuowJCgOlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689024; c=relaxed/simple;
	bh=Lb5L++ekJygTWuO6OXoz0Jt/Iv2vvtiKY/zqVtqxJ2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ctygAAUjCl7zj9Au+VGj9QZaF4/LxzVwJOMc44apbyvPjClm7b1X/GHeCqdIAxqsUOQF4WnmZjzQdn5yhO5W72wXuzFuAkFgBe1mzFu8jYbnekIBMxpJW9kxkLkQrLB1wR29sfI+gzN1fbMbdgOH0Gc+TAOhSSIur9UQPqg4SnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLrod+71; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689022; x=1738225022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lb5L++ekJygTWuO6OXoz0Jt/Iv2vvtiKY/zqVtqxJ2s=;
  b=TLrod+71GECMvLkhXY7tVADKMPPd5cucrsW13miVQF0aY39LBtSevj8t
   dLNBHeWJxSapMmsKZZUyIIahwcJUCv+M3ecmSHIEOclQaahkAWdAFJqYt
   bs6XZT61SNibiVqsgXSS/fMhlioqvpiY5gkrLc+zoy1Hc0XoSZXvuiiX7
   eQJrBkkdbj51yBxgrKNtNdWXF7+QzEBuqpE4lPE+9bS4IZxn3p0ZkLBKM
   sK6wVTs+u1P2H4Noa5soqCWeZJMu2LNJ6in331LC5mg+bKALB3tHYJFgZ
   05+R5Q02qgO7Oqh7A7q9rFKoOm3L2HwvsxLKdP4iWsq8+G/kVoDd1Xj9D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10911756"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10911756"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961541765"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="961541765"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 00:17:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 00:17:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 00:16:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 00:16:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 00:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APqFfeU2ppHY17vT0e29xrHmen+vuNy8+D3IVhaqMNIDsRGq7P2UEky2hbdLHjOJ+l4fdZTpYL+P+SnCIB9RTjZuPDsImiSENIrO1erMs1a5bIaRIUVSvBnYZQa+qs1dObjaYAAc9hgrEClPeKsvDXl2tInrnE3PaCrgVs3LkRkqqIqZaWw37nIxWVHKAb9ZP0fnzpkwv+cfRqeNj2ITIg2qolMrVjNSFpO14lP0bX1OxkNFlwvTfo8WKRHUiNAG1zeHsuDw8HvhTUc74AT9xM9cggNNdWv20OnUAYE7ulvZMC1mEWMqWh+qU6NsnRQZIzZkNZiY3Mk3HCRfm+Xa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb5L++ekJygTWuO6OXoz0Jt/Iv2vvtiKY/zqVtqxJ2s=;
 b=cKpM5NEJwOebeZMori3xwVTMWniMZk1wEOVawO/M8vQJhbS6LkvPzqIbwIW+nUm/8h0mWlwviLovNq2RyHiW2XcRGWHRTJ4oixto54pJEGbYxjbnedBAIdiuuWud/A0cCRpCO3Kj5+clgrBW1NxAsUtT2qqjAXQDKkwuR0AQJRumUMFn22m+UDUfBY9n/X0ZPijVEcHV7BO9GCrHyXNyZU9OpVEwn9rWN/+F2dlOD78o6yz+6s6Znd86/d+Jtqh7CS25lrWL7Aeg8uYpW3FvKeCxnAiVVcRFN2Z9/zxmUx615hjN0vkrffIvuqOgy5z9E3vshT3TuBw4nmZQCDsxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 31 Jan 2024 08:16:56 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 08:16:56 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Kirill A. Shutemov"
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
Thread-Index: AQHaU1aXalf71JpekEOiHH1k7Csdk7DyS4oAgAAJSVCAAEjrgIAABNyAgAAErYCAAOk00A==
Date: Wed, 31 Jan 2024 08:16:56 +0000
Message-ID: <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
In-Reply-To: <Zbk6h0ogqeInLa_1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: f30f70a7-407a-41e7-0fde-08dc2234fd94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVol+YT2KWxLhgTLStAJ/BFT35y4Shy/rRS9fQD/Fa2FamAHsM6aSsQxxkUOIcm4rbmWZmSFr/793jQ3y07NADkwy4gOi0iXGH9ZOXvfE9iss4KuBuHqYl0Y91yh6lHnZ9PlujAqqC3Z/4feqbV1/j17UfPVYR8CVpv3tyv9GWaIlc9Oitgu4WQWkM61NwkNkxtLzkd8CmCt/pcE45GoPZsEJhm7JuU6k6Q9lJ6l54JMxWkKBlRcHCUIWNtSICRQk0qweIVaYKQjFHqJhvNiG2+rk75Ke/vap985lLow+bG9IlGsMANUIUZBJmJ4nSSzfmdazeeJhoFnSNdXhq/1e+POGvQXxIn8sc7Bm3VWVVonuGhUhjxKk422eBSk+YWsmFH1jGbkqys7ypyoIwonNz4v1vzpvWN96diHkpCEN3hb8n31T6v3ANui2MI3WNUWgUgMi4Ogcu+I6yX9vP9mpNWV3/cs8kBcUVA1FHykmQGUNTEyNoNQXlQLw7e/tYAh3ZoakPT0ETjGtl6hZOSGsh9jNu8Lw+48PuparL+Y0ZfG9BBdkmkeV8kvMP0X16U/dcoFbOKf9yL/qoUkJAKfbJmNSmbGN/moz3AfDZsv0GA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(26005)(38100700002)(122000001)(41300700001)(52536014)(8676002)(4326008)(5660300002)(8936002)(7416002)(2906002)(478600001)(966005)(6506007)(7696005)(53546011)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(110136005)(76116006)(82960400001)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU1sVmxHRkdTN3Z4Wk5Ia09FL0FaOWRBZGN1SllQTDNsbzB2YkMxS2ZwYlVJ?=
 =?utf-8?B?MURjQnlzdUZ2RXdhT2NFS0dMNGFtRkFzdlEreEF2aVlCZFI3RWdUOHFKQmxC?=
 =?utf-8?B?bElOQjQySlpBWlFlU1BNVEhwYXRLeUV4bDE2eWtUY1JIUkozT3NqbEdFTmVB?=
 =?utf-8?B?ZldBWlM1Q3FrOW5OVGVPQ0Q2TFpMb2hLeFEzakJoQlRtendnRkdXc2g5aUdo?=
 =?utf-8?B?dkUxSkI4RDFlSkNMY0RPa0J6OUdEV2Z5M1dPYWIyd2FkU2FOWlA1Q2FRM3Iw?=
 =?utf-8?B?M2lOdmpVNHBhdUZZYlNrb1R3V0NZaGtGT0FlUkt1OHJCZER0d3lkcFB5c0Ns?=
 =?utf-8?B?b2JLbk1TYXd2RFd5VDZRSnJUS2dnQU1UL0pObnZ2ZXBUN2NGVHZoNThQb0tU?=
 =?utf-8?B?R2hBSktxWlBRY3JpTEVSazZxQ1VZZElKeE8xNWVLa3pIL2pQaXlDdXNmOVRo?=
 =?utf-8?B?bFQ3RHA2cE1kUGZ5eU54ZFJwcEFVUWJ1Ni8zdnVsSUoxTXNyS1JNamtiZWpI?=
 =?utf-8?B?cndNN1EvdFNrL2g3bDFITDdUd3RHcXorMC83S1NTTFdMZnU1VG5RTE90RmlW?=
 =?utf-8?B?Yy9nSzk2VTdvS05OZXp4QVJ2Um1SU0FKOGx5ZjM3Ykc3ZGhVUmFubElISG1G?=
 =?utf-8?B?Q25GcFZKNng2bm1zWUFFOXh1WiszcjdmdlVvQ3l5WkozdEdoZll4N29oQlpi?=
 =?utf-8?B?RW05SkdFeHdKYndjVnFZUTFJeDRWanp2UGJpMzJ1dXRodGhSQTA4SVpSZndK?=
 =?utf-8?B?YWM5TWZsM3VDN0k0K3QwMGdyRHpjbzVvQlByOGtacjkwVTlUR3FORTZtSGYw?=
 =?utf-8?B?Qi9NSVhOdmxlelVQeHcyNnpZY09KbnNacGVPTWVZalFGSnRRN1Y4R3JJekZW?=
 =?utf-8?B?MGdOTUJmdVRValF2RmwxU2RKbklVMjMxSExLczJDL2h4VWQ4V2d6ZTJiWXkx?=
 =?utf-8?B?Vy9JWTd1R1EzYUMzd1I5UkxiblFoZkREMG5oQ2FieEd5QldIVndLY0lCS29W?=
 =?utf-8?B?WFR2Y2FwaWhXT2swTVhqRzhDb2VwYTVUcmJmVC9YdlE5SGI2Q1lWbmNVcW9l?=
 =?utf-8?B?Nm1jeFBRRVBPek1HT2RQcmxVajNyNThVS3F1WWhEaDE3cUZ5TG9EVWZkYVZx?=
 =?utf-8?B?dFZxR3ljaWd2d0ppZzVrY1JmdDhKeE5xeWszVFJVNnJyTk9HWllqSEEwNHZy?=
 =?utf-8?B?cS94L2x5dmtjZWI1MHNLanNFREt6ZXZ2NmhkWTRlUkMrZEZlUUcwT0tpRmp4?=
 =?utf-8?B?MmExbWlKanozaHplZDdCZE5BUXV0MXRiU09tTXpuUWF0b25rMnl4WXl2dHFS?=
 =?utf-8?B?TU9vVHRWT1ZtYkxUZ3BMb1ZiaWFXTmFhamRSOG9jY3FUMm9Ib1ZkQkVid3pL?=
 =?utf-8?B?M2Q2SEc1bzEya3lzRUFka1ZDaGxKWGx1YnVaRWQ1bUQ5djJKVUxrNFVNZXZT?=
 =?utf-8?B?SzNOYWo1dk5BdlNIMkw2MXNZbmt5Y01kYWdGdDZxb2JPKyt2cXJPTGVNOUlL?=
 =?utf-8?B?NTFDSVM1TXF6REdmdGhsbDB5N01kNmxnNUhqcDFpR2luTzlvdzVJSE1NY2Ry?=
 =?utf-8?B?eVd3bzBhMVpVMHdRQ21BTmV2V1E5Uk5lM2tING4rTjRqODBJYXcvUFp5TVJY?=
 =?utf-8?B?VjI3R1lqTGE4UHZ3d2xMaHFwS1pWUnpKNU1HdkljRHR3N0ZwVWVTY1FHOGIz?=
 =?utf-8?B?OUpsamZTT2tYQlRjMHAxRTBsNG9LbEJvblF2YysrN05kRFh0THUybG1NZmhS?=
 =?utf-8?B?aDZnL2pnK2QrS0M4RzB2TEJPMjg0QUEwb2VzZzQ5aGRYbjdWWjBaaVR3MXdr?=
 =?utf-8?B?UHQxaWtwblVweEU0R2NVS3JNak0yRUFZUkNOQ2NqVzdiWmV0Vnl5aHF4anZM?=
 =?utf-8?B?UGorcXZqeFMwYkZxbGkwRnVWVnJpM0xsMnozTmk1blNrR1dUMFpXZVdrb2Fu?=
 =?utf-8?B?b0NqR1VZMWdVbXNERFBZV3pQSFZOTlRjbTVXeEJIdnBObmJHM3ZQeHg3bnlj?=
 =?utf-8?B?V0hmdVEwbnFGWFp5QStGMHNqR3lEeHoxdk9DYWJXTkJ0N1NObGVrM0NXZW05?=
 =?utf-8?B?UFpXYmhhcjEyRFByNFVlTWlNR2puT0tkZWV3K0pIbzh5M1lSdC84VG43bDF0?=
 =?utf-8?Q?uZqBtGcUqdkm593E5/fidYZeG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f70a7-407a-41e7-0fde-08dc2234fd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 08:16:56.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHzOuNLXy185VlZiDASbh/74pzrTNF0AGMjq27royzRaDuz7Y6q+LCDvfmdXvzEVGooKnPsMJcuqL0ltwDnioVYu70KcmWYWer97UXGRD1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com

PiBPbiBUdWUsIEphbiAzMCwgMjAyNCBhdCAwNjo0OToxNVBNICswMTAwLCBKYXNvbiBBLiBEb25l
bmZlbGQgd3JvdGU6DQo+ID4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgNjozMuKAr1BNIERhdmUg
SGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIDEv
MzAvMjQgMDU6NDUsIFJlc2hldG92YSwgRWxlbmEgd3JvdGU6DQo+ID4gPiA+PiBZb3UncmUgdGhl
IEludGVsIGVtcGxveWVlIHNvIHlvdSBjYW4gZmluZCBvdXQgYWJvdXQgdGhpcyB3aXRoIG11Y2gN
Cj4gPiA+ID4+IG1vcmUgYXNzdXJhbmNlIHRoYW4gbWUsIGJ1dCBJIHVuZGVyc3RhbmQgdGhlIHNl
bnRlbmNlIGFib3ZlIHRvIGJlIF93YXkNCj4gPiA+ID4+IG1vcmVfIHRydWUgZm9yIFJEUkFORCB0
aGFuIGZvciBSRFNFRUQuIElmIHlvdXIgaW5mb3JtZWQgb3BpbmlvbiBpcywNCj4gPiA+ID4+ICJS
RFJBTkQgZmFpbGluZyBjYW4gb25seSBiZSBkdWUgdG8gdG90YWxseSBicm9rZW4gaGFyZHdhcmUi
DQo+ID4gPiA+IE5vLCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBwZXIgSW50ZWwgU0RNLiBJIHRoaW5r
IHdlIGNhbiBsaXZlIHVuZGVyIGEgc2ltcGxlDQo+ID4gPiA+IGFzc3VtcHRpb24gdGhhdCBib3Ro
IG9mIHRoZXNlIGluc3RydWN0aW9ucyBjYW4gZmFpbCBub3QganVzdCBkdWUgdG8gYnJva2VuDQo+
ID4gPiA+IEhXLCBidXQgYWxzbyBkdWUgdG8gZW5vdWdoIHByZXNzdXJlIHB1dCBpbnRvIHRoZSB3
aG9sZSBEUkJHIGNvbnN0cnVjdGlvbg0KPiA+ID4gPiB0aGF0IHN1cHBsaWVzIHJhbmRvbSBudW1i
ZXJzIHZpYSBSRFJBTkQvUkRTRUVELg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgdGhlIFNE
TSBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gbG9vayBhdCBmb3IgZ3VpZGFuY2UgaGVyZS4NCj4gPiA+
DQo+ID4gPiBEZXNwaXRlIHRoZSBTRE0gYWxsb3dpbmcgaXQsIHdlIChzb2Z0d2FyZSkgbmVlZCBS
RFJBTkQvUkRTRUVEIGZhaWx1cmVzDQo+ID4gPiB0byBiZSBleGNlZWRpbmdseSByYXJlIGJ5IGRl
c2lnbi4gIElmIHRoZXkncmUgbm90LCB3ZSdyZSBnb2luZyB0byBnZXQNCj4gPiA+IG91ciB0cnVz
dHkgdG9yY2hlcyBhbmQgcGl0Y2hmb3JrcyBhbmQgZ28gYWZ0ZXIgdGhlIGZvbGtzIHdobyBidWls
dCB0aGUNCj4gPiA+IGJyb2tlbiBoYXJkd2FyZS4NCj4gPiA+DQo+ID4gPiBSZXBlYXQgYWZ0ZXIg
bWU6DQo+ID4gPg0KPiA+ID4gICAgICAgICBSZWd1bGFyIFJEUkFORC9SRFNFRUQgZmFpbHVyZXMg
b25seSBvY2N1ciBvbiBicm9rZW4gaGFyZHdhcmUNCj4gPiA+DQo+ID4gPiBJZiBpdCdzIG5pY2Ug
aGFyZHdhcmUgdGhhdCdzIGdvbmUgYmFkLCB0aGVuIHdlIFdBUk4oKSBhbmQgdHJ5IHRvIG1ha2UN
Cj4gPiA+IHRoZSBiZXN0IG9mIGl0LiAgSWYgaXQgdHVybnMgb3V0IHRoYXQgV0FSTigpIHdhcyBi
ZWNhdXNlIG9mIGEgYnJva2VuDQo+ID4gPiBoYXJkd2FyZSBfZGVzaWduXyB0aGVuIHdlIGdvIHNo
YXJwZW4gdGhlIHBpdGNoZm9ya3MuDQo+ID4gPg0KPiA+ID4gQW55Ym9keSBkaXNhZ3JlZT8NCj4g
Pg0KPiA+IFllcywgSSBkaXNhZ3JlZS4gSSBtYWRlIGEgdHJpdmlhbCB0ZXN0IHRoYXQgc2hvd3Mg
UkRTRUVEIGJyZWFrcyBlYXNpbHkNCj4gPiBpbiBhIGJ1c3kgbG9vcC4gU28gYXQgdGhlIHZlcnkg
bGVhc3QsIHlvdXIgc3RhdGVtZW50IGhvbGRzIHRydWUgb25seQ0KPiA+IGZvciBSRFJBTkQuDQo+
ID4NCj4gPiBCdXQsIGFueXdheSwgaWYgdGhlIHN0YXRlbWVudCAiUkRSQU5EIGZhaWx1cmVzIG9u
bHkgb2NjdXIgb24gYnJva2VuDQo+ID4gaGFyZHdhcmUiIGlzIHRydWUsIHRoZW4gYSBXQVJOKCkg
aW4gdGhlIGZhaWx1cmUgcGF0aCB0aGVyZSBwcmVzZW50cyBubw0KPiA+IERvUyBwb3RlbnRpYWwg
b2YgYW55IGtpbmQsIGFuZCBzbyB0aGF0J3MgYSBzdHJhaWdodGZvcndhcmQgY29uY2x1c2lvbg0K
PiA+IHRvIHRoaXMgZGlzY3Vzc2lvbi4gSG93ZXZlciwgdGhhdCByZWFsbHkgaGluZ2VzIG9uICAi
UkRSQU5EIGZhaWx1cmVzDQo+ID4gb25seSBvY2N1ciBvbiBicm9rZW4gaGFyZHdhcmUiIGJlaW5n
IGEgdHJ1ZSBzdGF0ZW1lbnQuDQo+IA0KPiBUaGVyZSdzIGEgdXNlZnVsIGNvbW1lbnQgaGVyZSBm
cm9tIGFuIEludGVsIGVuZ2luZWVyDQo+IA0KPiBodHRwczovL3dlYi5hcmNoaXZlLm9yZy93ZWIv
MjAxOTAyMTkwNzQ2NDIvaHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vZW4tDQo+IHVzL2Jsb2dz
LzIwMTIvMTEvMTcvdGhlLWRpZmZlcmVuY2UtYmV0d2Vlbi1yZHJhbmQtYW5kLXJkc2VlZA0KPiAN
Cj4gICAiUkRSQU5EIGlzLCBpbmRlZWQsIGZhc3RlciB0aGFuIFJEU0VFRCBiZWNhdXNlIGl0IGNv
bWVzDQo+ICAgIGZyb20gYSBoYXJkd2FyZS1iYXNlZCBwc2V1ZG9yYW5kb20gbnVtYmVyIGdlbmVy
YXRvci4NCj4gICAgT25lIHNlZWQgdmFsdWUgKGVmZmVjdGl2ZWx5LCB0aGUgb3V0cHV0IGZyb20g
b25lIFJEU0VFRA0KPiAgICBjb21tYW5kKSBjYW4gcHJvdmlkZSB1cCB0byA1MTEgMTI4LWJpdCBy
YW5kb20gdmFsdWVzDQo+ICAgIGJlZm9yZSBmb3JjaW5nIGEgcmVzZWVkIg0KPiANCj4gV2Uga25v
dyB3ZSBjYW4gZXhoYXVzdCBSRFNFRUQgZGlyZWN0bHkgcHJldHR5IHRyaXZpYWxseS4gTWFraW5n
IHlvdXINCj4gdGVzdCBwcm9ncmFtIHJ1biBpbiBwYXJhbGxlbCBhY3Jvc3MgMjAgY3B1cywgSSBn
b3QgYSBtZXJlIDMlIHN1Y2Nlc3MNCj4gcmF0ZSBmcm9tIFJEU0VFRC4NCj4gDQo+IElmIFJEUkFO
RCBpcyByZXNlZWRpbmcgZXZlcnkgNTExIHZhbHVlcywgUkRSQU5EIG91dHB1dCB3b3VsZCBoYXZl
DQo+IHRvIGJlIGNvbnN1bWVkIHNpZ25pZmljYW50bHkgZmFzdGVyIHRoYW4gUkRTRUVEIGluIG9y
ZGVyIHRoYXQgdGhlDQo+IHJlc2VlZCB3aWxsIGhhcHBlbiBmcmVxdWVudGx5IGVub3VnaCB0byBl
eGhhdXN0IHRoZSBzZWVkcy4NCj4gDQo+IFRoaXMgbG9va3MgcHJldHR5IGhhcmQsIGJ1dCBtYXli
ZSB3aXRoIGEgbGFyZ2UgZW5vdWdoIENQVSBjb3VudA0KPiB0aGlzIHdpbGwgYmUgcG9zc2libGUg
aW4gZXh0cmVtZSBsb2FkID8NCj4gDQo+IFNvIEknbSBub3QgY29udmluY2VkIHdlIGNhbiBibGlu
ZGx5IHdhdmUgYXdheSBSRFJBTkQgZmFpbHVyZXMgYXMNCj4gZ3VhcmFudGVlZCB0byBtZWFuIGJy
b2tlbiBoYXJkd2FyZS4NCg0KVGhpcyBtYXRjaGVzIGJvdGggbXkgdW5kZXJzdGFuZGluZyAoSSBk
byBoYXZlIGNyeXB0b2dyYXBoeSBiYWNrZ3JvdW5kDQphbmQgdW5kZXJzdGFuZGluZyBob3cgY3J5
cHRvZ3JhcGhpYyBSTkdzIHdvcmspDQphbmQgb2ZmaWNpYWwgcHVibGljIGRvY3MgdGhhdCBJbnRl
bCBwdWJsaXNoZWQgb24gdGhpcyBtYXR0ZXIuIA0KR2l2ZW4gdGhhdCB0aGUgcGh5c2ljYWwgZW50
cm9weSBzb3VyY2UgaXMgbGltaXRlZCBhbnlob3csIGFuZCBieSBnaXZpbmcNCmVub3VnaCBwcmVz
c3VyZSBvbiB0aGUgd2hvbGUgY29uc3RydWN0aW9uIHlvdSBzaG91bGQgYmUgYWJsZSB0bw0KbWFr
ZSBSRFJBTkQgZmFpbCBiZWNhdXNlIGlmIHRoZSBpbnRlcm1lZGlhdGUgQUVTLUNCQyBNQUMgZXh0
cmFjdG9yLw0KY29uZGl0aW9uZXIgaXMgbm90IGdldHRpbmcgaXRzIG1pbiBlbnRyb3B5IGlucHV0
IHJhdGUsIGl0IHdvbnQNCnByb2R1Y2UgYSBwcm9wZXIgc2VlZCBmb3IgQUVTIENUUiBEUkJHLiAN
Ck9mIGNvdXJzZSBleGFjdCBkZXRhaWxzL251bWJlcnMgY2FuIHdhcnkgYmV0d2VlbiBkaWZmZXJl
bnQgZ2VuZXJhdGlvbnMgb2YgDQpJbnRlbCBEUk5HIGltcGxlbWVudGF0aW9uLCBhbmQgdGhlIHBs
YXRmb3JtcyB3aGVyZSBpdCBpcyBydW5uaW5nIG9uLA0Kc28gYmUgY2FyZWZ1bCB0byBzdGlja2lu
ZyB0byBjb25jcmV0ZSBudW1iZXJzLiANCg0KVGhhdCBzYWlkLCBJIGhhdmUgdGFrZW4gYW4gQVIg
dG8gZm9sbG93IHVwIGludGVybmFsbHkgb24gd2hhdCBjYW4gYmUgZG9uZQ0KdG8gaW1wcm92ZSBv
dXIgc2l0dWF0aW9uIHdpdGggUkRSQU5EL1JEU0VFRC4gQnV0IEkgd291bGQgc3RpbGwgbGlrZSB0
bw0KZmluaXNoIHRoZSBkaXNjdXNzaW9uIG9uIHdoYXQgcGVvcGxlIHRoaW5rIHNob3VsZCBiZSBk
b25lIGluIHRoZQ0KbWVhbndoaWxlIGtlZXBpbmcgaW4gbWluZCB0aGF0IHRoZSBwcm9ibGVtIGlz
IG5vdCBpbnRlbCBzcGVjaWZpYywgZGVzcGl0ZSB1cw0KaW50ZWwgcGVvcGxlIGJyaW5naW5nIGl0
IGZvciBwdWJsaWMgZGlzY3Vzc2lvbiBmaXJzdC4gVGhlIG9sZCBzYXlpbmcgaXMgc3RpbGwgaGVy
ZToNCiJQbGVhc2UgZG9u4oCZdCBzaG9vdCB0aGUgbWVzc2VuZ2VyIiApKSBXZSBhcmUgYWN0dWFs
bHkgdHJ5aW5nIHRvIGJlIG9wZW4gDQphYm91dCB0aGVzZSB0aGluZ3MgYW5kIGNyZWF0ZSBhIHB1
YmxpYyBkaXNjdXNzaW9uLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuIA0KDQo+IA0KPiBXaXRo
IHJlZ2FyZHMsDQo+IERhbmllbA0KPiAtLQ0KPiB8OiBodHRwczovL2JlcnJhbmdlLmNvbSAgICAg
IC1vLSAgICBodHRwczovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UgOnwNCj4gfDog
aHR0cHM6Ly9saWJ2aXJ0Lm9yZyAgICAgICAgIC1vLSAgICAgICAgICAgIGh0dHBzOi8vZnN0b3Ax
MzguYmVycmFuZ2UuY29tIDp8DQo+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgIC1v
LSAgICBodHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fA0KDQo=

