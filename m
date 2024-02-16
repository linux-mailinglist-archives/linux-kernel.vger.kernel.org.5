Return-Path: <linux-kernel+bounces-68199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E2857721
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC9D1C2202C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A451773D;
	Fri, 16 Feb 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcS1wh7A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39F182DD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070246; cv=fail; b=s73E3WGYxLmFatSD2hw3/DNvrqkXJ8SK+u6pv+VVnL1y9D02soJKkRD+hFBujOYvoGxtQqSuagO+QAYC5piCmRRlzI+sVduES8enkk8aI0MqyXPEgBC7gn6tG2XvVmVCdehlrPxo7qmwjyUmUOvOuZrV3SUMgNDqI3KV7rxUInQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070246; c=relaxed/simple;
	bh=cmuh3fBFmDzHfrhFkHBwkPn7hdJBjlKHGor0tazsW1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJdT77JanspOsxpgfYuzX6LUojPKyOR2H1T445/KnkoND/1DU6cYig7I3aOIrApwlWansREruH9NzrsIhptP6yC2XX3z78YDCrRDOW9M0KmxflJD80EQym3GX97kaa1Y9kCAixVvIJN2qH5YC5U+goRokfUkAHjiV3AexkoujFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcS1wh7A; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708070244; x=1739606244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cmuh3fBFmDzHfrhFkHBwkPn7hdJBjlKHGor0tazsW1o=;
  b=WcS1wh7A0jvPhr6rmP1aj3yctQEuOPCfOoUcbUdkp90IdHkv9/uWjO9R
   ZPOIzJj0n6YgUmmM9ym+mmnvwqY/ExdSx95ledL1bz4ADJrmsibP2jRxm
   PiGFvxqYfAxLbOSdnHFXV4DeY7Ww5S/GtUpSSpCgCitYuX1uDwhRqRBmJ
   QKgH31myXo3zP2dkM6mxHdyAEeywpdywq6+YAQd6fPdGfYW02u25blX8/
   u2A2GcP12x43P12JPRhFlHDjUK1ZXDHziMRgV7VEygbiTqbznhGITKMfd
   yfnSVHkxihCA81ruxTrZuGZvg2RWpS0IXSse5dnKStkx2bKOCmJVbM1xP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2326369"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2326369"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 23:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3793692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 23:57:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 23:57:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 23:57:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 23:57:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 23:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm2VXkIMWAzbK7u8jhYjTW3274ZEe6zSFT91MqORydlRjV+Dlre0TV+gnhRJ9UVUnQvJjt/toO8gIW9VzTsOb5d6mZAsqfzU1u6aXyaZq3OFb00CeO5wYUHkDF8/QSarQX8K9KiD7flIBh/AGfsDIlnVlGg+cRmgwHuC9WeqUtxnlrtdqd9URYQB0r6MdHXaZrYsXh36CPLk4uA75bCs0kU6wBLdRehmB6H+AvKWho22RLzLNthKRUzOvfMlxFCg9cA0m1oacqiZUNKv+AuMqaIuFlJ4WahD7O3P6TR6MT7KrAcYn5JXN3wutxAPSmlipbVURKR6CO5HtPheiiHsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmuh3fBFmDzHfrhFkHBwkPn7hdJBjlKHGor0tazsW1o=;
 b=EI3IU+SJQdsTPO3vNGisEYMbbLf5mpCQ2nzkCHUD7r3YUifhhPNiYiMtYTxN44D+OxDQCX4oza1q8RdNYI4MNsSKD7Ii1D0+Tvojelihc0HE91mUyOTj1lky5wC3NtkcY7qxP4+MU0PR/E8UaVfq0jk7J8UDEWhS2+KLQIw17MBAfdbLOzwaarXncqfwnr0+CGa1h4mX8dFwEcnYmQjhC5SJIXFhEvqa4Fr2CHDQ+yI8nt2hpGQUtNxZDVdn04aJbqnfEBCyi34ZS9ILSeVB4/0GTu6XlH3RuKpciDWb/bgv0NimWTq+L39ktxGo0midLAoF2kEaiYY6rXXBrxiHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Fri, 16 Feb 2024 07:57:19 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 07:57:19 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
	=?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Topic: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Index: AQHaX4AnbFohebN8LUyJy3kolvDlzbEK/VhAgABn1ACAATKuMA==
Date: Fri, 16 Feb 2024 07:57:19 +0000
Message-ID: <DM8PR11MB57503009DDA05C9F0CD683E7E74C2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240214195744.8332-1-Jason@zx2c4.com>
 <20240214195744.8332-3-Jason@zx2c4.com>
 <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc4QMAnrMiiCwkmX@zx2c4.com>
In-Reply-To: <Zc4QMAnrMiiCwkmX@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM4PR11MB6287:EE_
x-ms-office365-filtering-correlation-id: 14053950-513a-4e64-4843-08dc2ec4e68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NDFoYWFr7Mc6fbYJ3OwLYv+/5Ah2rNBVhtLNQCGI3e/pAGOj73fLl1OV5W11ix7xxC33nzwaS8OyIW1189DBTYX2qgCTm4/N9Zznl/pFKxHmIxmu0Y77SoJAP/n+Oq7l7dsJ++gxB7Wg1JlCfNDFrzDE+V9WTLKHlEtxKrDn2rpmetvstDTd5DJqTOs80gXwo0nIsELPwuH9G9RkZFSgoR5jcS7YkwWylUAghuA49SdApzRgu8ZQ+qTf+E25adHZPExUwMXyHi89ihFRFtBAT/lmCbAuPgHgldk/qDPrPYlRFmgJp2psfVFTGsBMmxTMJuR0HOJXzH0iq/QYB6FUbhvdTrau4Bnra/v/NOphTVtTiY/K/mRwhuC0tryPHRINuoiqfPHgO84Rx83MlYjJRP3NJ2RArzowYgcV8dHah845ao+yYvd4bC4TDVYIQd51P+1b1neY3AYdgxlgfo6c24MgwfXh6CJPyXrRF4B4YM6coAWltHBEHX1LBBlobLWDYENUqTgCgt+bpp2VAZvOgn9o4xupKgvg3yXhSUPCl5HJCnPI/7qHxmhkGROKn2ldZhjxDbYMxgeaOoYg+zQkwnk+rjEAuwE5DRUT2yr6JaRJwuJjcDhRg5jj2f2Nt4p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(38100700002)(5660300002)(7416002)(38070700009)(41300700001)(33656002)(6506007)(9686003)(478600001)(7696005)(83380400001)(86362001)(66446008)(26005)(4326008)(8936002)(54906003)(66476007)(8676002)(52536014)(66556008)(64756008)(6916009)(76116006)(316002)(71200400001)(66946007)(82960400001)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3lXK2tjRUwzcG51aCtGUnN4SWwvT2lOaHpWczZtMnZHaWRQQ2ZTOFI3bjdn?=
 =?utf-8?B?d0hZZHNXaXh2Tk5WOGVIMkNiSmEwKzdyTUxDRmVSTEVFdVlFYkZYY2VEbU45?=
 =?utf-8?B?VEhZWDNiZVhrV0t3cmt4eHU4VnU0SFRVVGlpbEdUWkEvTnNrclhpQjhvZ3Ra?=
 =?utf-8?B?bFpmc1AzL21TOWhudUlEWnNwSFZZQVFYamh2NE9JU1ZFNVAzM2JUSlJLOHJ5?=
 =?utf-8?B?N2ZtZ1Rzb0wycllwZFQydGVPZk5kM2lweWVid0hzQzRUME0xZkhtTDAySWo5?=
 =?utf-8?B?ZzJhT0NXQWtMdExQOGYwb0RJK3F5elBxQUFHbnNvTmp4Ni9SS2pwZEhEamta?=
 =?utf-8?B?L0F3WFF3RFc4UjdUdTRnSVJOc1pvdWdEQ1hUbEREVWFud0VkUUt0NFozd2xH?=
 =?utf-8?B?T2dZQTF0U1hrVW1XOVM5TFBhQUw3dEpiL2tnb1Vpd2xJOFU0ci9kVlRMNGVu?=
 =?utf-8?B?c3BGQSt5RG5oMkdWNXdITnI5V1hwRVhXNllZbTJxS0hNZkg5VEhEZkZIc3NY?=
 =?utf-8?B?czY0NjZzdzFGRjJDOXhCeHk1cS96bGNVREZuOWp5UWpPVlJmWEJJckQ0VEFy?=
 =?utf-8?B?SWExVGxYZEc5c29ZVzE1NXgrcE1IbEhrNW5YVWJ4cEo1Yy9pV0tlb2E5ZHV4?=
 =?utf-8?B?c1RFU2hvbS9Ed0tGUmpMRy95cUlGTEorSkQ5aEZBY29EM2JKN0s4d3VNak0x?=
 =?utf-8?B?YW9zaGhmdXZpRi9iZ0hjN29KNUZmVWRCZ0ZWZXpmSi90U0hXZHdkR3hTQ1lS?=
 =?utf-8?B?NWN4T2o2NnUzSktlV0J0ZzFSK24yTTBNODdXTThVdklpYXBVNkJxZmtkUmsr?=
 =?utf-8?B?ODFtSmRIVE8yNDQ0NkN0Z1Fvd0ZwakZBY21HNnRuSm9KK0NuNk9kWmJpd001?=
 =?utf-8?B?amQvd1lWOFJpUGNmU0xodkk5bnhpdzcrcVF0Qzc5ZEk5RG9tNkNkdGlJOHV5?=
 =?utf-8?B?WGRsUEt0ak9VWlpwSW9yOXd6elhuMVJCVWxtSTByL2xENFdhbFczWUpWSWFX?=
 =?utf-8?B?VmFGZDZsTk1RN090T25zYzh0eTVHclVBbXpPM1ZwQ1I3SUMxTjYzQkVZSWoy?=
 =?utf-8?B?SHpjcS90ekxCOC8vaC9VN1Q1aWV0cmVRb1U1d2tSeDNwbGZ4d0RXRGRJNjVD?=
 =?utf-8?B?eEI1VUVZTFZKZHRjNyt6a3NKT3pMeTBPaDd4UFE3Rk9oMnBqWDJnbEViZDFB?=
 =?utf-8?B?Y3pXQW45WGo0RlNWWWg4U2IzUFpMVFBFb0FCOHNZMmVYeDdpVy9SbkVSYldX?=
 =?utf-8?B?bGZWaEZSTUt4aUZ6WCtYeUNJKzh1amNJNEhBUmVyYjYrcE9ubzZnTTJZTmtO?=
 =?utf-8?B?Zk9WTTROUWpURTFtODdNWVk2T1ZTcHFSaXhuWHRmRGZ2Tm1sWUxXREFEQVZV?=
 =?utf-8?B?NlNtckZKak55WS9RQm9Nb0poN2xMMVQ1ZDdlNU5CS1lJNEswcU5KMmU2UUc2?=
 =?utf-8?B?aFFtNURiV0hUZ3NXL21iMHVyL1NLajJYSjlVT3Rhd2UxV05KRytXQko5REp1?=
 =?utf-8?B?N2o0aTlvNWZnYjloWS9sWldUcDZVOTVQMDJ2QjlSWFFTeVQ1UGxQSUFoS3hp?=
 =?utf-8?B?RTVVZ2puVU5NM3AvWWpBbWNheDVtbDVHbzJXK2FmdkFWQ05Bb2hZY3daZ0c3?=
 =?utf-8?B?RVdQRzQwMXBBa3p5U1BFQTZhTThEa3lyeE92Vzc1cDlwRkVJbnNMenFvZ3Nw?=
 =?utf-8?B?azUzdEpWZ3lnVDhDZ3BnT0p1dmtDSzR6aGJHUUVaeDFIOU9qN09kWmExVTQ1?=
 =?utf-8?B?Y3pTWHFvemJWZnRENThVclpQVTFoSWlUYmp2ZUc4VGlJWkhzNDFzWi9FRjRk?=
 =?utf-8?B?cUVWZVhGbEwyQ0hoNmJWSFdTVjFZaU9pOEt3T3Z4cXBDYWhlUjZaRjl3cDZk?=
 =?utf-8?B?SHNCKzU3a1hDNUoxS3ZoVXk5c2FNdkFEbnArQ3gwWFBYRXVKMzRPSFNTVisw?=
 =?utf-8?B?NkRaMmRudDRNSHhNeUljSzRmZXBYN1lQWTI0eUtZYmk1NW8rV3l6K21RMk5O?=
 =?utf-8?B?YS9udlRqcEMwTFpkNm9jREFNdGZ6ZWJvSjAvSk4yWm95b2pkTU9nOTBQaklH?=
 =?utf-8?B?Y2xZV3BRMnpKMjhGT3ZCd241TkZDekgwNDZ6YnRXTlhaeWh1bjJ0ZHJUVlFs?=
 =?utf-8?Q?QzMCDSN/QPyGqYVrSiH28tqmC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14053950-513a-4e64-4843-08dc2ec4e68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 07:57:19.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCsZUUyeKIzlNVEZTG8Nxsxs7i9UPFA9xRKhk5FsxCKL71+Cq0eU0I9cTsLGgPzNEzpExWNPXJtqQZO3j//25YyOqZ/GrB+bnD8mJY+3EOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com

PiBIaSBFbGVuYSwNCj4gDQo+IE9uIFRodSwgRmViIDE1LCAyMDI0IGF0IDA3OjMwOjMyQU0gKzAw
MDAsIFJlc2hldG92YSwgRWxlbmEgd3JvdGU6DQo+ID4gU2hvdWxkIHdlIGp1c3QgZ28gYmFjayB0
byB0aGUgYXBwcm9hY2ggdG8gYWRkIG9uZSBtb3JlIGNoZWNrIGluDQo+IHJhbmRvbV9pbml0X2Vh
cmx5KCkNCj4gPiB0byBwYW5pYyBpbiB0aGUgQ29DbyBjYXNlIGlmIGJvdGggcmRzZWVkIGFuZCBy
ZHJhbmQgZmFpbHMgdG8gZ2l2ZSB1cyBhbnl0aGluZz8NCj4gDQo+IFllYSwgbm8sIGRlZmluaXRl
bHkgbm90LiBUaGF0IGlzLCBpbiBteSBvcGluaW9uLCBjb21wbGV0ZWx5IGJhY2t3YXJkcw0KPiBh
bmQgbGVhZHMgdG8gaW1wb3NzaWJsZSBtYWludGFpbmFiaWxpdHkuIENvQ28gaXMgbm90IHNvbWUg
c3BlY2lhbA0KPiBzbm93Zmxha2UgdGhhdCBnZXRzIHRvIHNwcmlua2xlIHJhbmRvbSBjb25kaXRp
b25hbHMgaW4gZ2VuZXJpYyBjb2RlLg0KPiANCj4gRmlyc3QsIGNvbnNpZGVyIHRoZSBtb3RpdmF0
aW9uIGZvciBkb2luZyB0aGlzOg0KPiAtIFRoaXMgaXMgdG8gYWJvcnQgb24gYSBwaHlzaWNhbCBk
ZWZlY3RpdmUgQ1BVIGJ1ZyAtLSBwcmVzdW1hYmx5IGENCj4gICBoaWdobHkgaW1wbGF1c2libGUg
dGhpbmcgdG8gZXZlciBoYXBwZW4uDQo+IC0gVGhpcyBpcyBmb3IgYSB0aHJlYXQgbW9kZWwgdGhh
dCBmZXcgcGVvcGxlIGFyZSByZWFsbHkgY29tcGVsbGVkIGJ5DQo+ICAgYW55d2F5LCBlLmcuIGl0
J3Mgd2hhY2stYS1tb2xlIHNlYXNvbiB3aXRoIGhvc3QtPmd1ZXN0IHZlY3RvcnMuDQo+IC0gVGhp
cyBpcyBmb3IgYSBzaW5nbGUgc29tZXdoYXQgb2JzY3VyZSBjb25maWd1cmF0aW9uIG9mIGEgc2lu
Z2xlDQo+ICAgYXJjaGl0ZWN0dXJlIHdpdGggYSBmZWF0dXJlIG9ubHkgYXZhaWxhYmxlIG9uIGNl
cnRhaW4gY2hpcHNldHMuDQo+IC0gVGhpcyBpcyBub3QgYW4gImludHJpbnNpYyIgcHJvYmxlbSB0
aGF0IG5lY2Vzc2l0YXRlcyBwbHVtYmluZyBjb21wbGV4DQo+ICAgcG9saWN5IGxvZ2ljIGFsbCBv
dmVyIHRoZSBwbGFjZSwgYnV0IGZvciBhIHZlcnkgc3BlY2lhbA0KPiAgIGRyaXZlci1zcGVjaWZp
YyBjYXNlLg0KPiANCj4gUmF0aGVyLCB3aGF0IHRoaXMgcGF0Y2ggZG9lcyBpcy4uLg0KPiANCj4g
PiBOb3cgd2l0aCB0aGlzIHBhdGNoLCB0aGUgbG9naWMgYmVjb21lcw0KPiANCj4gWW91ciBkZXNj
cmlwdGlvbiBhY3R1YWxseSB3YXNuJ3QgcXVpdGUgYWNjdXJhdGUgc28gSSdsbCB3cml0ZSBpdCBv
dXQNCj4gKGFuZCBJJ2xsIGNsYXJpZnkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlL2NvbW1lbnRzIGZv
ciB2MyAtIG15IGZhdWx0IGZvcg0KPiBiZWluZyB2YWd1ZSk6DQo+IA0KPiAxLiBBdCBlYXJseSBi
b290LCB4ODYvQ29DbyBpcyBpbml0aWFsaXplZC4gQXMgcGFydCBvZiB0aGF0DQo+ICAgIGluaXRp
YWxpemF0aW9uLCBpdCBtYWtlcyBzdXJlIGl0IGNhbiBnZXQgMjU2IGJpdHMgb2YgUkRSQU5EIG91
dHB1dA0KPiAgICBhbmQgYWRkcyBpdCB0byB0aGUgcG9vbCwgaW4gZXhhY3RseSB0aGUgc2FtZSB3
YXkgdGhhdCB0aGUgU0QgY2FyZA0KPiAgICBkcml2ZXIgYWRkcyBpbnNlcnRlZCBtZW1vcnkgY2Fy
ZCBzZXJpYWwgbnVtYmVycyB0byB0aGUgcG9vbC4gDQoNClllcywgbXkgbWVudGFsIHBpY3R1cmUg
dGhhdCByYW5kb21faW5pdF9lYXJseSgpIGlzIGNhbGxlZCBiZWZvcmUgDQpzZXR1cF9hcmNoKCkg
d2FzIG9idmlvdXNseSB3cm9uZywgSSBzaG91bGQgaGF2ZSBjaGVja2VkIGl0IGV4cGxpY2l0bHku
DQpTbywgeWVzLCBjb2NvX3JhbmRvbV9pbml0KCkgaGFwcGVucyBmaXJzdCwgd2hpY2ggYWN0dWFs
bHkgbm93IGhhcyBhIG5pY2UNCnNpZGUtZWZmZWN0IHRoYXQgb24gY29jbyBwbGF0Zm9ybXMgd2Ug
ZHJvcCBIVyBDUFUgb3V0cHV0IGV2ZW4gZWFybGllcg0KaW4gdGhlIGVudHJvcHkgcG9vbCAoWWF5
ISkuDQpXaGljaCBhdCB0aGlzIHBvaW50IHdvdWxkIGJlIGFsbW9zdCBwZXJmZWN0LCAqaWYqIHdl
IGNvdWxkIGFsc28NCmNvdW50IHRoaXMgZW50cm9weSBkcm9wIGFuZCBhbGxvdyBDaGFDaGEgc2Vl
ZGluZyB0byBiZW5lZml0IHN0cmFpZ2h0IGZyb20NCnRoaXMgZWFybHkgZHJvcCBvZiBlbnRyb3B5
LiANCg0KSG93IGFib3V0IGNoYW5naW5nIHRoaXMgdG8gdXNlIGFkZF9od2dlbmVyYXRvcl9yYW5k
b21uZXNzKCk/IA0KQW5kIGFkanVzdCBjY19yYW5kb21faW5pdCgpIHRvIHRyeSByZHNlZWQgZmly
c3QgYW5kIG9ubHkgZmFsbGJhY2sgdG8gcmRyYW5kDQppZiBpdCBmYWlscz8gDQpJIGVudmlzaW9u
IHRoYXQgYSBjb3VudGVyIGFyZ3VtZW50IHRvIHRoaXMgd291bGQgYmUgIndlIG9ubHkgY291bnQN
CmVudHJvcHkgZnJvbSBIVyBDUFUgUk5HLCBpZiB3ZSB0cnVzdCBDUFUgUk5HIiwgYnV0IGluIENv
Q28gY2FzZQ0Kd2UgKmRvIHRydXN0IENQVSogYW5kIHRoaXMgaXMgdGhlIG91dHB1dCBvZiB0cnVl
IEhXIFJORyB0aGF0IHdlIGFyZQ0KbWl4aW5nIGluIHRoZSBwb29sIHBlciBkZWZpbml0aW9uLiAN
Cg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuIA0KIA0KDQo=

